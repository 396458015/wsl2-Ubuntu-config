-- plugin
-- starship.yazi
require("starship"):setup()


-- searchjump.yazi
require("searchjump"):setup {
	unmatch_fg = "#9ca0b0",
    match_str_fg = "#000000",
    match_str_bg = "#84c443",
    first_match_str_fg = "#000000",
    first_match_str_bg = "#84c443",
    label_fg = "#eeeeee",
    label_bg = "#b34607",
    only_current = false, -- only search the current window
    show_search_in_statusbar = true,
    auto_exit_when_unmatch = false,
    enable_capital_label = false,
	mapdata = require("sjch").data,
	search_patterns = ({"hell[dk]d","%d+.1080p","第%d+集","第%d+话","%.E%d+","S%d+E%d+",})
    -- search_patterns = {}  -- demo:{"%.e%d+","s%d+e%d+"}
}


-- smart-enter.yazi
require("smart-enter"):setup {
	open_multi = true,
}


-- git.yazi
require("git"):setup({
    show_branch = true
})


-- mime-ext.yazi
require("mime-ext.local"):setup {
	-- Expand the existing filename database (lowercase), for example:
	with_files = {
		makefile = "text/makefile",
	},
	with_exts = {
        m    = "text/m",
        org  = "text/plain",
        norg = "text/plain",
        ps1  = "text/plain",
        tex  = "text/plain",
        bib  = "text/plain",
	},
	fallback_file1 = false,
}


