
local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
    math.randomseed(os.time())
end

function MyApp:run()
    -- load plist
    display.loadSpriteFrames(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)

    -- load sounds
    for k, v in pairs(GAME_SFX) do
        audio.preloadSound(v)
    end

    self:enterMainScene()
end

function MyApp:enterMainScene()
    self:enterScene("MainScene", nil, "fade", 0.6, display.COLOR_WHITE)
end

return MyApp
