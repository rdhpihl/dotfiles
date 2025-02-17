return {
	 {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "gopls",
      },
    },
    config = function()
      require("mason").setup()
    end,
  },
 {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
 {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities()
      )

      local util = require("lspconfig/util")
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
	capabilities = capabilities
      })
	lspconfig.gopls.setup({
  	settings = {
    	  gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
--	capabilities = capabilities,
        root_dir = util.root_pattern("go.work", "go.mod", ".git")
      })



      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
		end,
	},
}
