local BaseScene = class("BaseScene", function ()
    return display.newScene("BaseScene")
end)

function BaseScene:ctor()
    -- ���ڸ���ִ�и���Ĺ���
    if self.__supers then
        for k, v in pairs(self.__supers) do
            v:ctor()
        end
    end
end

return BaseScene