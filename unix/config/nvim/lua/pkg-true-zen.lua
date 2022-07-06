require("true-zen").setup({
	ui = {
		bottom = {
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = true,
			cmdheight = 1,
		},
		top = {
			showtabline = 0,
		},
		left = {
			number = true,
			relativenumber = true,
			signcolumn = "yes",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 32,
			right_padding = 32,
			top_padding = 0,
			bottom_padding = 0,
			ideal_writing_area_width = {80, 200},
			just_do_it_for_me = false,
			keep_default_fold_fillchars = true,
			custome_bg = "",
			bg_configuration = true,
			affected_higroups = {NonText = {}, FoldColumn = {}, ColorColumn = {}, VertSplit = {}, StatusLine = {}, StatusLineNC = {}, SignColumn = {}},
      quit = "close"
		},
		focus = {
			margin_of_error = 5,
			focus_method = "experimental"
		},
	},
	integrations = {
		vim_gitgutter = false,
		galaxyline = false,
		tmux = false,
		gitsigns = true,
		nvim_bufferline = false,
		limelight = false,
		vim_airline = false,
		vim_powerline = false,
		vim_signify = false,
		express_line = false,
		lualine = false,
	},
	misc = {
		on_off_commands = true,
		ui_elements_commands = false,
		cursor_by_mode = true,
	}
})

-- Launch TrueZen at startup
vim.cmd("autocmd VimEnter * TZAtaraxis")
