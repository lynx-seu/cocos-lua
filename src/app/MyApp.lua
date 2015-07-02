
local MyApp = class("MyApp", cc.load("mvc").BaseApp)

function MyApp:onCreate()
    math.randomseed(os.time())
end

function MyApp:run()
    -- 资源加载放到加载资源的场景执行
--    -- load plist
--    display.loadSpriteFrames(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)
    display.loadSpriteFrames("loading.plist", "loading.png")

    -- load sounds
    for k, v in pairs(GAME_SFX) do
        audio.preloadSound(v)
    end

    --self:enterChooseLevelScene()
    self:enterLoadScene()
end

function MyApp:enterLoadScene()
    self:enterScene("LoadScene", nil, "fade", 0.6, display.COLOR_WHITE)
end

function MyApp:enterMainScene()
    self:enterScene("MainScene", nil, "fade", 0.6, display.COLOR_WHITE)
end

function MyApp:enterChooseLevelScene()
    self:enterScene("ChooseLevelScene", nil, "fade", 0.6, display.COLOR_WHITE)
end

return MyApp
