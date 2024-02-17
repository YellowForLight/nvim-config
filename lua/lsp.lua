local lspconfig = require('lspconfig')
local masonLspconfig = require("mason-lspconfig")
require("mason").setup()
masonLspconfig.setup()

local function trouble(str, opt)
    return function()
        require("trouble")[str or "open"](opt)
    end
end

local options = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, options)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, options)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, options)
vim.keymap.set('n', '<leader>ld', trouble(nil, "loclist"), options)
vim.keymap.set('n', '<leader>qd', trouble(nil, "quickfix"), options)
vim.keymap.set('n', '<leader>wd', trouble(nil, "workspace_diagnostics"), options)
vim.keymap.set('n', '<leader>dd', trouble(nil, "document_diagnostics"), options)

local function telescope(method, opts)
	return function()
		require("telescope.builtin")[method](opts)
	end
end


vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = event.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', telescope("lsp_definitions"), bufopts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gI', telescope("lsp_implementations"), bufopts)
        vim.keymap.set('n', '<leader>D', telescope("lsp_type_definitions"), bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set('n', '<leader>ws', telescope("lsp_workspace_symbols"), bufopts)
		vim.keymap.set('n', '<leader>Ws', telescope("lsp_dynamic_workspace_symbols"), bufopts)
		vim.keymap.set('n', '<leader>ds', telescope("lsp_document_symbols"), bufopts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, bufopts)
		vim.keymap.set('n', 'gr', telescope("lsp_references"), bufopts)
		vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
	end
})

local group = vim.api.nvim_create_augroup("lazyLsp", {})

masonLspconfig.setup_handlers {
	function(lspName)
		lspconfig[lspName].setup(require('coq').lsp_ensure_capabilities {
		})
	end,
	['tsserver'] = function()
		lspconfig['tsserver'].setup(require('coq').lsp_ensure_capabilities {
			root_dir = lspconfig.util.root_pattern("package.json"),
			single_file_support = false
		})
	end,
	['denols'] = function()
		lspconfig['denols'].setup(require('coq').lsp_ensure_capabilities {
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
		})
	end,
	['lua_ls'] = function()
		require("neodev").setup({})
		lspconfig['lua_ls'].setup(require('coq').lsp_ensure_capabilities {
		})
	end,
	['jdtls'] = function()
		vim.api.nvim_create_autocmd("filetype", {
			pattern = { 'java' },
			group = vim.api.nvim_create_augroup("lspconfig", { clear = false }),
			callback = function()
				local opts = require('coq').lsp_ensure_capabilities {
					cmd = { require('mason-core.path').bin_prefix('jdtls') },
					root_dir = vim.fs.dirname(vim.fs.find({"build.gradle", "pom.xml"}, {upward = true})[1])
				}
				require('jdtls').start_or_attach(opts)
			end

		})
	end,
    ['hls'] = function()
    end
}

do
	local opts = require('coq').lsp_ensure_capabilities {
		on_attach = function()
            require("metals").setup_dap()
			vim.keymap.set("n", "<leader>wh", function()
				require("metals").hover_worksheet()
			end, { desc = "[W]orksheet [H]over" })
			vim.keymap.set("n", "<leader><CR>", function()
				require("telescope").extensions.metals.commands()
			end, { desc = "Metal Commands" })
		end,
		settings = {
			showImplicitArguments = true,
            showInferredType = true,
            showImplicitConversionsAndClasses = true
		}
	}
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "scala", "sbt" },
		group = vim.api.nvim_create_augroup("nvim-metals", {}),
		callback = function() require("metals").initialize_or_attach(opts) end
	})
end
