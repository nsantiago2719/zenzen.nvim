local M = {}

M.bg_buf = nil
M.zen_buf = nil
M.main_win = nil
M.zen_win = nil

local create_zenzen_config = function()
	local width = vim.o.columns
	local height = vim.o.lines
	local main_width = width / 3

	return {
		background = {
			relative = "editor",
			width = width,
			height = height,
			col = 0,
			row = 0,
			zindex = 1,
			style = "minimal",
			focusable = false,
		},
		zen = {
			relative = "editor",
			width = main_width,
			height = height,
			col = main_width,
			row = 1,
			zindex = 3,
			style = "minimal",
		},
	}
end

M.new = function()
	local window_config = create_zenzen_config()

	local current_buf = vim.api.nvim_get_current_buf()
	M.main_win = vim.api.nvim_get_current_win()
	M.bg_buf = vim.api.nvim_create_buf(false, true)

	M.zen_win = vim.api.nvim_open_win(current_buf, true, window_config.zen)
	M.bg_win = vim.api.nvim_open_win(M.bg_buf, false, window_config.background)
end

M.close = function()
	if M.main_win == M.zen_win then
		vim.api.nvim_win_set_cursor(M.main_win, vim.api.nvim_win_get_cursor(M.main_win))
	end
	if M.zen_win and vim.api.nvim_win_is_valid(M.zen_win) then
		vim.api.nvim_win_close(M.zen_win, { force = true })
		M.zen_buf = nil
		M.zen_win = nil
	end

	if M.bg_win and vim.api.nvim_win_is_valid(M.bg_win) then
		vim.api.nvim_win_close(M.bg_win, { force = true })
		M.bg_win = nil
	end
end

M.toggle = function()
	if M.zen_win then
		M.close()
	else
		M.new()
	end
end

M.setup = function(opts)
	print(opts)
end

return M
