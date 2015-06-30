require("cocos.init")

local MainScene = class("MainScene", function ()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    -- add background image
    display.newSprite("#MenuSceneBg.png"):move(display.center):addTo(self)

    -- button
    dump(ccui.TextureResType.plistType, "TextureResType")
    dump(cc.SpriteFrameCache, "Sprite Frame Cache")
    local btn = ccui.Button:create("MenuSceneStartButton.png", nil, nil, ccui.TextureResType.plistType)
    btn:setAnchorPoint(cc.p(0.5, 0.5))
    local size = cc.Director:getInstance():getVisibleSize()
    btn:setPosition(cc.p(size.width/2, 250))
    self:addChild(btn)

end

return MainScene
