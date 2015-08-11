
cc.FileUtils:getInstance():setPopupNotify(false)
package.path = package.path .. ";src/"
cc.FileUtils:getInstance():addSearchPath("res/")

help = require "helpfunc"
require "config"
require "cocos.init"
cc.exports.deque = cc.load("container").deque
cc.exports.list = cc.load("container").list


local function main()
    cc.exports.app = require("app.MyApp"):create()
    app:run()

--    local grid = logic:new(5, 5, 6) 
--    grid:print()
--    local road = grid:findPath({x=2, y=3}, {x=3, y=2})
----    local road = grid:findPath({x=1, y=1}, {x=1, y=5})
--    dump(road, "road1")
--    road = grid:findPath({x=1, y=1}, {x=1, y=5})
--    dump(road, "road2")

    local que = deque:new()
    local l = list:new()
    l:push(3)
    l:push(4)
    l:push(5)
    l:push(6)
    for v in l:iter() do
        io.write(v, " ")
    end
    io.write("\n")
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
