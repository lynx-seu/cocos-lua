
cc.FileUtils:getInstance():setPopupNotify(false)
package.path = package.path .. ";src/"
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"


local function main()
    cc.exports.app = require("app.MyApp"):create()
    app:run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
