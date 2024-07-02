vim.cmd("colorscheme base16-toft-colors")
local function hi(hl_group,options)
	local guifg = options.guifg == nil and '' or 'guifg=' .. options.guifg
	local guibg = options.guibg == nil and '' or 'guibg=' .. options.guibg
	local ctermfg = options.ctermfg == nil and '' or 'ctermfg=' .. options.ctermfg
	local ctermbg = options.ctermbg == nil and '' or 'ctermbg=' .. options.ctermbg
	vim.cmd(string.format('hi %s %s %s %s %s',hl_group,guifg,guibg,ctermfg,ctermbg))
end

local highlights ={
	["LineNr"]={ guifg="#787878",guibg="NONE", ctermfg="240", ctermbg="0"},
	["CursorLineNr"]={ gui="bold", guifg="#b8b8b8", guibg="#282828", ctermfg="250", ctermbg="235"},
	["Visual"]={ guibg="#383838", ctermbg="240" },
	["SignColumn"]     ={ guifg="#585858", guibg="NONE", ctermfg="240", ctermbg="0"},
	["GitGutterAdd"]   ={ guibg="NONE", ctermbg="0"},
	["GitGutterChange"]={ guibg="NONE", ctermbg="0"},
	["GitGutterDelete"]={ guibg="NONE", ctermbg="0"},
	["Normal"]={ guifg="#d8d8d8", guibg="NONE", ctermfg="15", ctermbg="0"},
	["User1"]={ guifg="#181818", guibg="#5066C6", ctermfg="15", ctermbg="237"},
	["User2"]={ guifg="#f8f8f8", guibg="#383838", ctermfg="15", ctermbg="237"},
	["User3"]={ guifg="#70CCAD", guibg="#383838", ctermfg="79", ctermbg="237"},
	["User4"]={ guifg="#f8f8f8", guibg="#383838", ctermfg="15", ctermbg="237"},
	["User5"]={ guifg="#181818", guibg="#BF72AD", ctermfg="234", ctermbg="133"},
	["User6"]={ guifg="#181818", guibg="#6ab544", ctermfg="234", ctermbg="71"},
	["ColorColumn"]={ guifg="#787878",guibg="#383838", ctermfg="240", ctermbg="0"},
}

for a,b in pairs(highlights) do
	hi(a,b)
end
