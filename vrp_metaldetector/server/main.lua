local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

API = {}
Tunnel.bindInterface(GetCurrentResourceName(),API)


function listItems()
    if Config.RequireItems ~= nil then
        for k,v in pairs(Config.RequireItems) do
            return v    
        end
    end
end

function listPerms()
    if Config.IgnoredPerms ~= nil then
        for k,v in pairs(Config.IgnoredPerms) do
            return v
        end
    end
end

local NotifyShow = false

function API.resetNotify()
    NotifyShow = false     
end

function API.checkItems(machineName,x,y,z)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
	    local data = vRP.getInventory(user_id)
        if data then
            for k,v in pairs(data) do
                if v.item == listItems() then
                    if not NotifyShow then
                        for k,v in pairs(Config.WarningMessages) do
                            TriggerClientEvent('Notify',source,'negado',v,3500)
                        end
                        if Config.UseCreativeV3 then
                            local cops = vRP.numPermission(Config.PolicePerm)
                            for k,v in pairs(cops) do
                                async(function()
                                    TriggerClientEvent("NotifyPush",v,{ code = 20, title = 'Sitema burlado', x = x, y = y, z = z, criminal = 'Detecção de metal burlado em: '..machineName, rgba = {51,56,72} })
                                end)
                            end
                        else
                            local cops = vRP.getUsersByPermission(Config.PolicePerm)
                            for k,v in pairs(cops) do
                                async(function()
                                    TriggerClientEvent("NotifyPush",v,{ code = 20, title = 'Sitema burlado', x = x, y = y, z = z, criminal = 'Detecção de metal burlado em: '..machineName, rgba = {51,56,72} })
                                end)
                            end
                        end
                        NotifyShow = true
                    end
                end
            end
        end
    end
end

function API.checkPermissions()
    local source = source
    local user_id = vRP.getUserId(source)
    local perms = listPerms()
    if user_id then
        if vRP.hasPermission(user_id, perms) then
            return true
        else
            return false
        end
    end
end