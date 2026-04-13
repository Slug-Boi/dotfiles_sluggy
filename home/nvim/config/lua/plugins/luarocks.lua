return {
  "vhyrro/luarocks.nvim",
  priority = 1000,       -- Must be very high priority
  opts = {
    rocks = { "dkjson" } -- Explicitly include dkjson if needed
  },
}
