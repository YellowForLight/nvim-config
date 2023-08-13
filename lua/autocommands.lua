local escGroup = vim.api.nvim_create_augroup("esc-caps", {})
local json = ""
local function getKeys()
	json = ""
	local job = vim.fn.jobstart('hidutil property --get "UserKeyMapping"', {
		on_stdout = function(_, data, _)
			json = json .. table.concat(data, "")
		end
	})
	vim.fn.jobwait({ job })
	json = string.gsub(json, "%(", "")
	json = string.gsub(json, "%)", "")
	json = string.gsub(json, " =", ":")
	json = string.gsub(json, ";", ",")
	json = string.gsub(json, "([A-Za-z]+)", '"%1"')
end
local function setKey(keys)
	local newTable = {}
	for k, v in pairs(keys) do
		table.insert(newTable,
			string.format('{"HIDKeyboardModifierMappingSrc":%s,"HIDKeyboardModifierMappingDst":%s}', k, v))
	end
	vim.fn.jobstart([[hidutil property --set '{"UserKeyMapping":[]] .. table.concat(newTable, ',') .. ',' .. json .. [[]}']])
end

local function clearKey()
	vim.fn.jobstart([[hidutil property --set '{"UserKeyMapping":[]] .. json .. [[]}']])
end

vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter", "VimResume" }, {
	pattern = { "*" },
	group = escGroup,
	callback = function()
		getKeys()
		setKey { ["0x700000029"] = "0x700000039",
			["0x700000039"] = "0x700000029" }
	end
})

vim.api.nvim_create_autocmd({ "FocusLost", "VimLeave", "VimSuspend" }, {
	pattern = { "*" },
	group = escGroup,
	callback = clearKey
})



local relGroup = vim.api.nvim_create_augroup('relative', {})
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = { "*" },
    group = relGroup,
    callback = function()
        vim.o.rnu = false
    end
})
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = { "*" },
    group = relGroup,
    callback = function()
        vim.o.rnu = true
    end
})
