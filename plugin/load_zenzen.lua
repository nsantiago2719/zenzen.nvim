vim.api.nvim_create_user_command("ZenToggle", function()
	-- Easy Reloading
	package.loaded["present"] = nil

	require("zenzen").toggle()
end, {})
