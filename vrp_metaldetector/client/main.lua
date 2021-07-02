local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

API = Tunnel.getInterface(GetCurrentResourceName())

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(Config.Locations) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= v[5] then
					timeDistance = 4
					if not API.checkPermissions() then
					 	 API.checkItems(v[4],v[1],v[2],v[3]) 
					end
				else
					API.resetNotify()
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)