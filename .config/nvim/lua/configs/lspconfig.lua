-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require 'lspconfig.util'

local omnisharp_bin = "/nix/store/z957pdpfgvrs0iq5q8p5633k127ps5q9-omnisharp-roslyn-1.39.11/bin/OmniSharp";

-- EXAMPLE
local servers = { 
  "html", 
  "cssls", 
  "nixd", 
  "rust_analyzer", 
  "hyprls", 
  "rubocop", 
  "csharp_ls",
  "denols",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  if lsp == "csharp_ls" then
    goto continue
  end

  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  ::continue::
end

lspconfig.csharp_ls.setup {
  init_options = {
      AutomaticWorkspaceInit = true,
  },
  root_dir = function(fname)
      return util.root_pattern '*.csproj'(fname)
  end,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--

--local pid = vim.fn.getpid()
--lspconfig.omnisharp.setup {
--  cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
--  on_attach = nvlsp.on_attach,
--  on_init = nvlsp.on_init,
--  capabilities = nvlsp.capabilities,
--}
