local constants = require("constants")
local settings = require("config.settings")

local popupWidth <const> = settings.dimens.graphics.popup.width + 20

local github = sbar.add("item", constants.items.GITHUB, {
  position = "right",
  icon = {
    string = settings.icons.text.github.logo,
    padding_right = 0,
    font = {
      style = settings.fonts.styles.bold
    },
    label = {
      string = "github",
      padding_right = 0,
    },
  }
})

local githubBracket = sbar.add("bracket", constants.items.GITHUB .. ".bracket", {
  github.name,
}, {
  popup = { align = "center" }
})

-- Make this extensible with nix variables later

local profile = sbar.add("item", {
  align = "center",
  position = "popup." .. githubBracket.name,
  width = popupWidth,
  height = 16,
  icon = {
    string = settings.icons.text.github.profile,

    font = {
      style = settings.fonts.styles.bold
    },
  },
  label = {
    font = {
      style = settings.fonts.styles.bold,
      size = settings.dimens.text.label,
    },
    max_chars = 18,
    string = "Slug-Boi",
  },
})

local function hideDetails()
  githubBracket:set({ popup = { drawing = false } })
end


local function toggleDetails()
  local shouldDrawDetails = githubBracket:query().popup.drawing == "off"

  if shouldDrawDetails then
    githubBracket:set({ popup = { drawing = true } })
  else
    hideDetails()
  end
end

-- local function launch()
--   sbar.exec("open -u https://github.com/Slug-Boi")
-- end


github:subscribe("mouse.clicked", function(env)
  if env.BUTTON == "left" then
    local shouldDrawDetails = githubBracket:query().popup.drawing == "on"

    if shouldDrawDetails then
      hideDetails()
    else
      sbar.exec("open -u https://github.com/Slug-Boi?tab=repositories")
    end
  elseif env.BUTTON == "right" then
    -- Create a nice menu here for cool github features
    toggleDetails()
  end
end)

local function openProfile(env)
  sbar.exec("open -u https://github.com/Slug-Boi")
  hideDetails()
end


profile:subscribe("mouse.clicked", openProfile)

-- doesn't work for some reason
--profile:subscribe("mouse.clicked", launch())
