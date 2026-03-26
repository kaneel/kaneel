return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- DAP WAP
		{
			"mfussenegger/nvim-dap",
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "L3MON4D3/LuaSnip" },

		-- Rust (rust-analyzer); do not use rust-tools — deprecated lspconfig path
		{
			"mrcjkb/rustaceanvim",
			version = "^6",
			ft = { "rust" },
			dependencies = {
				"williamboman/mason.nvim",
				"neovim/nvim-lspconfig",
			},
		},
	},
}
