
local LoadScene = class("LoadScene", function ()
    return display.newScene("LoadScene")
end)

----------------------------------------------------
-- 属性
-- progress   进度条
-- count      所有待加载资源的数量 [0, n)
----------------------------------------------------

function LoadScene:ctor()
    local layer = cc.LayerColor:create(cc.c4b(255, 255, 255, 255), display.width, display.height)
    self:addChild(layer)

    display.newSprite("#loading.png"):move(display.cx, display.height-100):addTo(self)

    local sp = display.newSprite("#progress.png")
    self.progress_ = cc.ProgressTimer:create(sp)
    self.progress_:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    self.progress_:setPercentage(0)
    self.progress_:move(display.cx, 100)
    self:addChild(self.progress_)

    self.count_ = 0 
    dump(#GAME_TEXTURE, "Total Count")
    for k, v in pairs(GAME_TEXTURE) do
        local textureCache = cc.Director:getInstance():getTextureCache()
        textureCache:addImageAsync(v[2], handler(self, self.onPlistAsyncCallback))
    end
end

function LoadScene:onPlistAsyncCallback()
    self.count_ = self.count_ + 1
    local percent = self.count_ * 100 / #GAME_TEXTURE
    self.progress_:setPercentage(percent)
    if self.count_ == #GAME_TEXTURE then
        -- 加载完所有图片，加载plist
        self:loadAllPlist()

        app:enterMainScene()
    end
end

function LoadScene:loadAllPlist()
    for k, v in pairs(GAME_TEXTURE) do
        cc.SpriteFrameCache:getInstance():addSpriteFrames(v[1])
    end
end

return LoadScene