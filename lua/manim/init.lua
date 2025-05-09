---@alias QualityFlag "-pqh" | "-pql" | "-pqk"
---@alias BoolString "true" | "false"

---@class ManimOpts
---@field manim_flags QualityFlag
---@field open_preview BoolString
---@field manim string
---@field previewer string

---@class _ManimPlugin
local M = {}

---@type ManimOpts
M.opts = {
	manim_flags = "-pqh",
	open_preview = "true",
	manim = "manim",
	previewer = "vlc",
}

---@param user_opts ManimOpts
function M.setup(user_opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, user_opts or {})
	M._make_cmds()
end

function M._make_cmds()
	vim.api.nvim_create_user_command("ManimRender", function()
		local file = vim.fn.expand("%:p")
		local scene = vim.fn.input("Scene: ")
		local cmd = string.format("%s %s %s %s", M.opts.manim, M.opts.manim_flags, vim.fn.shellescape(file), scene)
		M._make_terminal(cmd)
	end, {})

	vim.api.nvim_create_user_command("ManimOpenPreview", function()
		local file = vim.fn.expand("%:p")
		local scene = vim.fn.input("Scene: ")
		local cmd = string.format("%s %s %s %s", M.opts.manim, M.opts.manim_flags, vim.fn.shellescape(file), scene)

		local quality = nil

		if M.opts.manim_flags == "-pqh" then
			quality = "1080p60"
		elseif M.opts.manim_flags == "-pql" then
			quality = "480p15"
		elseif M.opts.manim_flags == "-pqk" then
			quality = "2160p60"
		end
		local abs_video_path = vim.fn.fnamemodify(file, ":p"):match("(.+)%..+$")
			.. "/media/videos/"
			.. quality
			.. "/"
			.. scene
			.. ".mp4"
		local preview_extra = " && " .. M.opts.previewer .. " " .. vim.fn.shellescape(abs_video_path)

		M._make_terminal(cmd .. preview_extra)
	end, {})
end

---@param cmd string
function M._make_terminal(cmd)
	vim.cmd("split")
	vim.cmd("resize 25")
	local buffer = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(0, buffer)

	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.cursorline = false

	vim.fn.termopen(cmd, {
		on_exit = function(_, code, _)
			vim.schedule(function()
				print("Manim render Finished with code: ", code)
			end)
		end,
	})

	vim.cmd.startinsert()
end

return M
