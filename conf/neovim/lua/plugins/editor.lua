local COMMENT = {
  'numToStr/Comment.nvim',
  name = 'Comment',
  opts = {},
--[[
  cmd = { 
    require('Comment.api').toggle.linewise(),
    require('Comment.api').toggle.blockwise(),
  }
]]
}

return { COMMENT }

