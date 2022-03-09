local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    enable_check_bracket_line = false, -- If next character is a close pairs and it doesn't have an open pairs in
                                       -- same line then don't add a close pairs

    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      hightlight = 'Search'
    },

    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

require('nvim-treesitter.configs').setup {
    autopairs = {enable = true}
}

local ts_conds = require('nvim-autopairs.ts-conds')

-- press % => %% is only inside comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})

require("nvim-autopairs.completion.compe").setup({
  map_cr = true,       -- Map <CR> on insert mode
  map_complete = true, -- Auto insert `(` after select function or method item
})
