if vim.loader then
  vim.loader.enable()
end

require("config.early")
require("config.lazy")
