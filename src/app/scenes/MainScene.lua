
local MainScene = class("MainScene", cc.load("mvc").BaseScene)

function MainScene:init()
    -- add background image
    self:AddBg()

    self:initBoat()
    self:initSeagull()

    -- button
    local btn = self:AddBtn("btn_play.png", nil, nil, handler(self, self.OnPlay))
    btn:setScale(0.6)
    btn:setPosition(display.cx, 180)
end

function MainScene:OnPlay(ref, type)
    if type == ccui.TouchEventType.ended then
        app:enterPlayScene()
    end
end

function MainScene:initSeagull()
    local seagullFrames = display.newFrames("seagull%d.png", 1, 3)
    local seagullAni, seagull = display.newAnimation(seagullFrames, 0.2)
    local ani = cc.RepeatForever:create(cc.Animate:create(seagullAni))
    seagull:addTo(self)
    local size = seagull:getContentSize()
    seagull:setPosition(150, 540)
    seagull:runAction(ani)
end


function MainScene:initBoat()
    local boatFrames = display.newFrames("sailing_boat%d.png", 1, 3)
    local boatAni, boat = display.newAnimation(boatFrames, 0.2)
    local ani = cc.RepeatForever:create(cc.Animate:create(boatAni))
    boat:addTo(self)
    local size = boat:getContentSize()
    boat:setPosition(display.width+size.width/2, 480)
    boat:runAction(ani)
    local moveTo = cc.MoveTo:create(10, cc.p(0-size.width/2, 360))
    local place = cc.Place:create(cc.p(display.width+size.width/2, 360))
    local seq = cc.Sequence:create(moveTo, place)
    ani = cc.RepeatForever:create(seq)
    boat:runAction(ani)
end

function MainScene:OnClose(keycode)
    print("escape")
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
