
--local MainScene = class("MainScene", function ()
--    return display.newScene("MainScene")
--end)

local MainScene = class("MainScene", cc.load("mvc").BaseScene)

function MainScene:ctor()
    dump(self, "main scene")
    -- add background image
    display.newSprite("background-hd.jpg"):move(display.center):addTo(self)
    -- 其他背景元素
    local cloud = display.newSprite("#background_cloud_1-hd.png")
    cloud:move(display.cx, 485):addTo(self)

    local sea = display.newSprite("#beach_adornment-hd.png")
    local size = sea:getContentSize()
    sea:move(display.cx, size.height/2):addTo(self)

    self:initBoat()
    self:initSeagull()

    -- button
    local btn = ccui.Button:create("btn_play.png", nil, nil, ccui.TextureResType.plistType)
    btn:setAnchorPoint(cc.p(0.5, 0.5))
    btn:setScale(0.6)
    local size = cc.Director:getInstance():getVisibleSize()
    btn:setPosition(cc.p(size.width/2, 180))
    self:addChild(btn)
    -- 设置enable状态
    --btn:setTouchEnabled(false)
    -- 取消button动画, 必须设置按下图片
--    btn:setPressedActionEnabled(false)
    btn:addTouchEventListener(handler(self, self.OnBtnClicked))

    -- 监听返回键
    local keyListener = cc.EventListenerKeyboard:create()
    keyListener:registerScriptHandler(handler(self, self.OnClose), cc.Handler.EVENT_KEYBOARD_PRESSED)
    local eventDispatch = self:getEventDispatcher()
    eventDispatch:addEventListenerWithSceneGraphPriority(keyListener, self)
end

function MainScene:OnBtnClicked(ref, type)
    if type == ccui.TouchEventType.began then
        dump(ref, "touch began")
    elseif type == ccui.TouchEventType.ended then
        dump(app, "touch ended")
        app:enterChooseLevelScene()
    end
end

function MainScene:initSeagull()
    local seagullFrames = display.newFrames("seagull%d.png", 1, 3)
    local seagullAni, seagull = display.newAnimation(seagullFrames, 0.2)
    local ani = cc.RepeatForever:create(cc.Animate:create(seagullAni))
    seagull:addTo(self)
    local size = seagull:getContentSize()
    seagull:setPosition(100, 443)
    seagull:runAction(ani)
end


function MainScene:initBoat()
    local boatFrames = display.newFrames("sailing_boat%d.png", 1, 3)
    local boatAni, boat = display.newAnimation(boatFrames, 0.2)
    local ani = cc.RepeatForever:create(cc.Animate:create(boatAni))
    boat:addTo(self)
    local size = boat:getContentSize()
    boat:setPosition(display.width+size.width/2, 360)
    boat:runAction(ani)
    local moveTo = cc.MoveTo:create(10, cc.p(0-size.width/2, 360))
    local place = cc.Place:create(cc.p(display.width+size.width/2, 360))
    local seq = cc.Sequence:create(moveTo, place)
    ani = cc.RepeatForever:create(seq)
    boat:runAction(ani)
end

function MainScene:OnClose(keycode)
    if "KEY_ESCAPE" == cc.KeyCodeKey[keycode+1] then
        print("escape")
    end
end

function MainScene:UnpackPlist(plist, png)
    -- 注意必须retain或者加到场景中, 注意保存位置
    cc.SpriteFrameCache:getInstance():addSpriteFrames(plist)                       -- 加载图片进内存
    local vectormap = cc.FileUtils:getInstance():getValueMapFromFile(plist)    -- 读取plist
    local frames = vectormap.frames
--    local writablePath = cc.FileUtils:getInstance():getWritablePath()
--    writablePath = "d:/test/"

    for key, value in pairs(frames) do
        local str = key
        -- 获得plist内的图片名
        local spr = cc.Sprite:createWithSpriteFrameName(str)
        spr:retain()
        local size = spr:getContentSize()
        local render = cc.RenderTexture:create(size.width, size.height)
        render:retain()
        spr:setPosition(cc.p(size.width / 2, size.height / 2))
        render:begin()
        spr:visit()
        render:endToLua()
        local test = render:saveToFile(str, cc.IMAGE_FORMAT_PNG)
--        render:saveToFile(writablePath .. str)
        spr:release()
        render:release()
        -- 写到文件
        if test then
            print("save " .. str .. " to " .. str)
        end
    end
end

return MainScene
