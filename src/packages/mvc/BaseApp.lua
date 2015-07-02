local BaseApp = class("BaseApp")

BaseApp.APP_ENTER_BACKGROUND_EVENT = "APP_ENTER_BACKGROUND_EVENT"
BaseApp.APP_ENTER_FOREGROUND_EVENT = "APP_ENTER_FOREGROUND_EVENT"
--BaseApp.sceneRoot_ = "app.scenes"

function BaseApp:ctor(sceneRoot)
    self.sceneRoot_ = sceneRoot or "app.scenes"

    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end

    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    local customListenerBg = cc.EventListenerCustom:create(BaseApp.APP_ENTER_BACKGROUND_EVENT,
                                handler(self, self.onEnterBackground))
    eventDispatcher:addEventListenerWithFixedPriority(customListenerBg, 1)
    local customListenerFg = cc.EventListenerCustom:create(BaseApp.APP_ENTER_FOREGROUND_EVENT,
                                handler(self, self.onEnterForeground))
    eventDispatcher:addEventListenerWithFixedPriority(customListenerFg, 1)

    -- event
    self:onCreate()
end

function BaseApp:exit()
    cc.Director:getInstance():endToLua()
    if device.platform == "windows" or device.platform == "mac" then
        os.exit()
    end
end

function BaseApp:run(initSceneName)
    initSceneName = initSceneName or self.configs_.defaultSceneName
    self:enterScene(initSceneName)
end

function BaseApp:enterScene(sceneName, args, transition, time, more)
    local scenePackageName = self.sceneRoot_ .. "." .. sceneName
    local sceneClass = require(scenePackageName)
    local scene = sceneClass.new(unpack(checktable(args)))
    display.runScene(scene, transitionType, time, more)
end

function BaseApp:createView(name)
    for _, root in ipairs(self.configs_.viewsRoot) do
        local packageName = string.format("%s.%s", root, name)
        local status, view = xpcall(function()
                return require(packageName)
            end, function(msg)
            if not string.find(msg, string.format("'%s' not found:", packageName)) then
                print("load view error: ", msg)
            end
        end)
        local t = type(view)
        if status and (t == "table" or t == "userdata") then
            return view:create(self, name)
        end
    end
    error(string.format("BaseApp:createView() - not found view \"%s\" in search paths \"%s\"",
        name, table.concat(self.configs_.viewsRoot, ",")), 0)
end

function BaseApp:onEnterBackground()
    self:dispatchEvent({name = BaseApp.APP_ENTER_BACKGROUND_EVENT})
end

function BaseApp:onEnterForeground()
    self:dispatchEvent({name = BaseApp.APP_ENTER_FOREGROUND_EVENT})
end

function BaseApp:onCreate()
end

return BaseApp
