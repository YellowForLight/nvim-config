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

local group = vim.api.nvim_create_augroup("myLsp", {})

vim.lsp.config("*", require("coq").lsp_ensure_capabilities())

vim.lsp.config("denols", {
    single_file_support = false
})

-- vim.lsp.config("haskell-tools", {
--     cmd = { "haskell-language-server-wrapper", "--lsp" }
-- })
--
-- vim.lsp.config("jdtls", {
--     cmd = { 'jdtls' },
--     root_dir = vim.fs.dirname(vim.fs.find({"build.gradle", "pom.xml"}, {upward = true})[1])
-- })

mconf = {
    on_attach = function()
        require("metals").setup_dap()
        vim.keymap.set("n", "<localleader>wh", function()
            require("metals").hover_worksheet()
        end, { desc = "[w]orksheet [h]over" })
        vim.keymap.set("n", "<localleader><cr>", function()
            require("telescope").extensions.metals.commands()
        end, { desc = "metal commands" })
    end,
    settings = {
        autoImportBuild = "all",
        inlayHints = {
            byNameParameters = {enabled = true},
            hintsInPatternMatch = {enabled = true},
            implicitArguments = {enabled = true},
            implicitConversions = {enabled = true},
            inferredTypes = {enabled = true},
            typeParameters = {enabled = true}
        }
    }
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "mill" },
    group = group,
    callback = function() require("metals").initialize_or_attach(mconf) end
})
