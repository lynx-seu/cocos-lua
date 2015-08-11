local BaseScene = class("BaseScene", function ()
    return display.newScene("BaseScene")
end)

function BaseScene:ctor()
    -- ע��touch�¼�
--    self:RegisterTouch()
    -- �������ؼ�
    local keyListener = cc.EventListenerKeyboard:create()
    keyListener:registerScriptHandler(handler(self, self.OnKeyDown), cc.Handler.EVENT_KEYBOARD_PRESSED)
    local eventDispatch = self:getEventDispatcher()
    eventDispatch:addEventListenerWithSceneGraphPriority(keyListener, self)
    -- ����ִ�г�ʼ��
    self:init()
end

function BaseScene:OnKeyDown(keycode)
    if "KEY_ESCAPE" == cc.KeyCodeKey[keycode+1] then
        self:OnClose()
    end
end

function BaseScene:RegisterTouch()
	--ע�ᴥ������
    local listener = cc.EventListenerTouchOneByOne:create()
    --local listener = cc.EventListenerTouchAllAtOnce:create() ���
    listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(handler(self, self.onTouchMoved), cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(handler(self, self.onTouchCancelled), cc.Handler.EVENT_TOUCH_CANCELLED)
    local eventDispatch = self:getEventDispatcher()
    eventDispatch:addEventListenerWithSceneGraphPriority(listener, self)
end

function BaseScene:onTouchBegan(touch, event)
    local pt = touch:getLocation()
--    local pos = self:convertToWorldSpace(pt)
    dump(pt, "touch began")
    return true
end

function BaseScene:onTouchMoved(touch, event)
    local pt = touch:getLocation()
    dump(pt, "touch moved")
end

function BaseScene:onTouchEnded(touch, event)
    local pt = touch:getLocation()
    dump(pt, "touch ended")
end

function BaseScene:onTouchCancelled(touch, event)
    dump({touch, event, x, y}, "touch cancelled")
end

function BaseScene:OnClose()
end

function BaseScene:init()
end

function BaseScene:AddBg()
    display.newSprite("background-hd.jpg"):move(display.center):addTo(self)
    -- ��������Ԫ��
    local cloud = display.newSprite("#background_cloud_1-hd.png")
    local size = cloud:getContentSize()
    cloud:move(display.cx, display.height-size.height/2):addTo(self)

    local sea = display.newSprite("#beach_adornment-hd.png")
    size = sea:getContentSize()
    sea:move(display.cx, size.height/2):addTo(self)

    display.newSprite("#island-hd.png"):move(900, 521):addTo(self)
end

function BaseScene:AddBtn(normal, selected, disable, callback, texType)
    local btn
    if texType == nil then
        btn = ccui.Button:create(normal, selected, disable, ccui.TextureResType.plistType)
    else
        btn = ccui.Button:create(normal, selected, disable, ccui.TextureResType.localType)
    end
    btn:addTouchEventListener(callback)
    self:addChild(btn)
    btn:setAnchorPoint(cc.p(0.5, 0.5))
    -- ����enable״̬
    --btn:setTouchEnabled(false)
    -- ȡ��button����, �������ð���ͼƬ
--    btn:setPressedActionEnabled(false)
    return btn
end

return BaseScene