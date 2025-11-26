local dap = require("dap")

local mason_path = vim.fn.stdpath("data") .. "\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg"

local netcoredbg_adapter = {
  type = "executable",
  command = mason_path,
  args = { "--interpreter=vscode" },
}

dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
dap.adapters.coreclr = netcoredbg_adapter    -- needed for unit test debugging

-- Function to find and parse .csproj files
local function parse_csproj(csproj_path)
  local file = io.open(csproj_path, "r")
  if not file then
    return nil, nil
  end

  local target_framework = nil
  local output_type = "Exe"
  local content = file:read("*all")
  file:close()

  target_framework = content:match("<TargetFramework>(.-)</TargetFramework>")
  output_type = content:match("<OutputType>(.-)</OutputType>") or "Exe"

  return target_framework, output_type
end

-- Function to find startup project from .sln file
local function get_startup_project_from_sln(sln_path)
  local file = io.open(sln_path, "r")
  if not file then
    return nil
  end

  local content = file:read("*all")
  file:close()

  -- Extract project paths
  local projects = {}
  for project_path in content:gmatch('Project%("{.-}"%)%s*=%s*"[^"]*"%s*"[^"]*"%s*"([^"]*)"') do
    table.insert(projects, project_path)
  end

  -- Return first project (simplified approach)
  return projects[1]
end

-- Function to automatically detect DLL path
local function get_dll_path()
  local cwd = vim.fn.getcwd()

  -- First try to find solution file in current directory and parent
  local sln_file = nil
  local sln_dir = cwd

  -- Check current directory
  local sln_files = vim.fn.glob(cwd .. "\\*.sln", false, true)
  if #sln_files > 0 then
    sln_file = sln_files[1]
  else
    -- Check parent directory
    local parent_dir = vim.fn.fnamemodify(cwd, ":h")
    sln_files = vim.fn.glob(parent_dir .. "\\*.sln", false, true)
    if #sln_files > 0 then
      sln_file = sln_files[1]
      sln_dir = parent_dir
    end
  end

  -- If we found a solution file, try to use it
  if sln_file then
    local startup_project = get_startup_project_from_sln(sln_file)
    if startup_project then
      local csproj_path = sln_dir .. "\\" .. startup_project:gsub("/", "\\")

      if vim.fn.filereadable(csproj_path) == 1 then
        local target_framework, output_type = parse_csproj(csproj_path)

        if target_framework then
          local project_dir = vim.fn.fnamemodify(csproj_path, ":h")
          local project_name = vim.fn.fnamemodify(csproj_path, ":t:r")

          -- Try Debug first
          local dll_path = project_dir .. "\\bin\\Debug\\" .. target_framework .. "\\" .. project_name .. ".dll"
          if vim.fn.filereadable(dll_path) == 1 then
            return dll_path
          end

          -- Try Release
          dll_path = project_dir .. "\\bin\\Release\\" .. target_framework .. "\\" .. project_name .. ".dll"
          if vim.fn.filereadable(dll_path) == 1 then
            return dll_path
          end
        end
      end
    end
  end

  -- Fallback: look for .csproj files in current directory and parent
  local search_dirs = { cwd }
  local parent_dir = vim.fn.fnamemodify(cwd, ":h")
  if parent_dir ~= cwd then
    table.insert(search_dirs, parent_dir)
  end

  for _, search_dir in ipairs(search_dirs) do
    local csproj_files = vim.fn.glob(search_dir .. "\\*.csproj", false, true)

    for _, csproj_path in ipairs(csproj_files) do
      local target_framework, output_type = parse_csproj(csproj_path)

      if target_framework and output_type == "Exe" then
        local project_dir = vim.fn.fnamemodify(csproj_path, ":h")
        local project_name = vim.fn.fnamemodify(csproj_path, ":t:r")

        -- Try Debug first
        local dll_path = project_dir .. "\\bin\\Debug\\" .. target_framework .. "\\" .. project_name .. ".dll"
        if vim.fn.filereadable(dll_path) == 1 then
          return dll_path
        end

        -- Try Release
        dll_path = project_dir .. "\\bin\\Release\\" .. target_framework .. "\\" .. project_name .. ".dll"
        if vim.fn.filereadable(dll_path) == 1 then
          return dll_path
        end
      end
    end
  end

  -- Final fallback - ask user
  return vim.fn.input("Path to dll: ", cwd .. "\\bin\\Debug\\net8.0\\", "file")
end



dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Auto-detect and launch",
    request = "launch",
    program = get_dll_path,
    console = "integratedTerminal"
  },
  {
    type = "coreclr",
    name = "launch - netcoredbg (manual)",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "\\bin\\Debug\\net10.0\\", "file")
    end,
    console = "integratedTerminal"
  }
}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
map("n", "<F6>", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", opts)
map("n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
map("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
map("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
map("n", "<F8>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
-- map("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
map("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
map("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)
map("n", "<leader>dt", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
  { noremap = true, silent = true, desc = 'debug nearest test' })
map("n", "<leader>du", "<Cmd>lua require('dapui').toggle()<CR>",
  { noremap = true, silent = true, desc = 'toggle dap ui' })
