
local cursorX = 0.5
local cursorY = 0.5
-- RequestStreamedTextureDict("kgvgame") -- TODO: fix.
RequestStreamedTextureDict( "commonmenu" )
RequestStreamedTextureDict( "desktop_pc" )
rt = RequestScaleformMovie("web_browser")
local startMenuUp = false
local tick = 0

function translateAngle(x1, y1, ang, offset)
  x1 = x1 + math.sin(ang) * offset
  y1 = y1 + math.cos(ang) * offset
  return {x1, y1}
end

--[[

	Task list:
	[x] Icons
	[ ] Windows. Yes.
	[x] Handle input
	[x] Proper way to enter the monitor

]]

dekstopIcons = {
	myComputer = {
		name = "cwOS",
		position = vector2(0.05, 0.1),
		iconDir = "desktop_pc",
		icon = "icon_my_computer",
		programToOpen = nil,
	},
	usb = {
		name = "USB Device",
		position = vector2(0.15, 0.1),
		iconDir = "desktop_pc",
		icon = "usb",
		programToOpen = nil,
	},
	trashBin = {
		name = "Trash Bin",
		position = vector2(0.95, 0.85),
		iconDir = "desktop_pc",
		icon = "bin",
		programToOpen = nil,
	},
	ambiguXfiles = {
		name = "ambiguX\nreports",
		position = vector2(0.05, 0.3),
		iconDir = "desktop_pc",
		icon = "folder",
		programToOpen = nil,
	},
}

windows = {
	welcomeMessage = {
		position = vector2(0.5, 0.5),
		size = vector2(0.5, 0.45),
		content = {
			title = function(posX, posY)	
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.3)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				SetTextCentre(1)
				AddTextComponentString("ambigu~r~X~w~..")
				DrawText(posX, posY-0.18)
			end,
			desc = function(posX, posY)	
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.2)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				SetTextCentre(1)
				AddTextComponentString("..wishes you a great time\nin our new OS!")
				DrawText(posX, posY-0.1)
			end,
			credits = function(posX, posY)	
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.1)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				SetTextCentre(1)
				AddTextComponentString("ambiguX®")
				DrawText(posX, posY+0.17)
			end,
		},
		open = true,
	},
}

function ProcessDesktop()
	if HasStreamedTextureDictLoaded("commonmenu") then		
		DrawSprite("commonmenu", "interaction_bgd", 0.5, 0.5, 1.0, 1.0, 0, 240, 25, 63, 255, 0)
	end
	DrawRect(0.0, 1.0, 2.0, 0.1, 100, 100, 255, 100) -- TASKBAR
	DrawRect(0.0, 1.0, 0.2, 0.1, 255, 100, 100, 255) -- CWOS BUTTON
	-- DrawSprite("desktop_pc", "arrow", cursorX, cursorY, 1.0, 1.0, 240, 25, 63, 255, 0)
	
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.225)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(0)
	AddTextComponentString("~r~cw~w~OS")
	DrawText(0.01, 0.935)
	
	if cursorX < 0.1 and cursorY > 1.0-0.05 then
		DrawRect(0.0, 1.0, 0.2, 0.1, 100, 100, 255, 100)
		if IsControlJustPressed(0, 176) then
			startMenuUp = not startMenuUp
		end
	end
	
	for i,v in pairs(windows) do
		if v.open == true then
			local wx, wy = table.unpack(v.position)
			local sx, sy = table.unpack(v.size)
			DrawRect(wx, wy, sx, sy, 255, 250, 250, 150)
			DrawRect(wx, wy-(sy/2)+(0.04/2), sx, 0.04, 255, 150, 150, 150)
			DrawRect(wx+(sx/2)-(0.04/2), wy-(sy/2)+(0.04/2), 0.04, 0.04, 255, 50, 50, 150)
			if cursorX > wx-(sx/2) and cursorY > wy-(sy/2) and cursorX < wx+(sx/2) and cursorY < wy-(sy/2)+(0.04) then
				if IsControlPressed(0, 176) then
					if IsControlJustPressed(0, 176) then
						tick = 0
					end
					if tick > 5 then
						local tempVector = vector2(cursorX, cursorY+(sx/2)-(0.04))
						v.position = tempVector
					end
				end
				-- DrawRect(0.5, 0.5, 0.1, 0.1, 255, 15, 15, 255) -- DEBUG RECT, LEAVE IT!
			end
			if cursorX < wx+(sx/2)+(0.04/4) and cursorY > wy-(sy/2) and cursorX > wx+(sx/2)-(0.04) and cursorY < wy-(sy/2)+(0.04) then
				if IsControlJustPressed(0, 176) then
					v.open = not v.open
					-- DrawRect(0.5, 0.5, 0.1, 0.1, 255, 15, 15, 255) -- DEBUG RECT, LEAVE IT!
				end
				DrawRect(wx+(sx/2)-(0.04/2), wy-(sy/2)+(0.04/2), 0.04, 0.04, 255, 50, 50, 150)
			end
			for i,b in pairs(v.content) do
				if type(b) == "function" then
					b(wx, wy)
				end
			end
		end
	end
	
	for i,v in pairs(dekstopIcons) do
		-- DrawSprite("desktop_pc", "bin", 0.5, 0.5, 0.1/2, 0.1, 0, 255, 255, 255, 255, 0)
		local ix, iy = table.unpack(v.position)
		if cursorX > ix-(0.1/2) and cursorY > iy-(0.1) and
           cursorX < ix+(0.1/2) and cursorY < iy+(0.1) then
			r,g,b = 100, 100, 255
		else
			r,g,b = 255, 255, 255
		end
		
		if IsControlPressed(0, 176) then
			if IsControlJustPressed(0, 176) then
				tick = 0
			end
			if tick > 5 then
				if cursorX > ix-(0.1/2) and cursorY > iy-(0.1) and
				   cursorX < ix+(0.1/2) and cursorY < iy+(0.1) then
					local tempVector = vector2(cursorX, cursorY)
					v.position = tempVector
				end
			else
				if v.programToOpen then
					-- TODO: open a window here
				end
			end
		end
		
		DrawSprite(v.iconDir, v.icon, v.position, 0.1/2, 0.1, 0, r, g, b, 255, 0)
		-- local r,g,b = 255,255,255
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.15)
		SetTextColour(r, g, b, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		-- SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(v.name)
		DrawText(ix, iy+0.04)
	end
	
	if startMenuUp == true then
		DrawRect(0.25/2, 1.0-0.3, 0.25, 0.5, 100, 100, 255, 255)
		DrawRect(0.0, 1.0-0.527, 0.5, 0.07, 150, 150, 255, 255)
		
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.2)
		SetTextColour(9, 74, 165, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		-- SetTextEdge(2, 255, 255, 255, 150)
		SetTextDropShadow()
		-- SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(0)
		-- AddTextComponentString(GetPlayerName(PlayerId()))
		AddTextComponentString("cwos_public_display")
		DrawText(0.0, 0.435)
		
		if IsControlJustPressed(0, 176) then
			if cursorX > 0.25 or cursorY < 1.0-0.55 then
				startMenuUp = not startMenuUp
			end
		end
	end
	
	-- WARNING: MUST ALWAYS DRAW/PROCESS LAST.
	if IsCamRendering(pcview) then 
		HideHudAndRadarThisFrame() 
		
		local mouseX = GetControlNormal(0, 1) / 10
		local mouseY = GetControlNormal(0, 2) / 10
		cursorX = cursorX + mouseX
		cursorY = cursorY + mouseY
		
		if cursorX > 1.0 then cursorX = 1.0 end
		if cursorX < 0.0 then cursorX = 0.0 end
		if cursorY > 1.0 then cursorY = 1.0 end
		if cursorY < 0.0 then cursorY = 0.0 end
	end	
	DrawSprite("desktop_pc", "arrow", cursorX+0.01, cursorY+0.02, 0.05/2.5, 0.05, 0, 255, 255, 255, 255)
end

Citizen.CreateThread(function()
	pcview=CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(pcview, -1372.4, -464.4, 72.4)
	SetCamRot(pcview, -10.0, 0.0, -173.0)
	SetCamFov(pcview, 45.0)
	
	while true do
		if IsControlJustPressed(0, 244) then
			-- SetPlayerControl(PlayerPedId(), not IsCamRendering(pcview), 0)
			if IsCamRendering(pcview) == false then
				TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
			else
				ClearPedTasks(PlayerPedId())
			end
			RenderScriptCams(not IsCamRendering(pcview), 1, 1000,  true,  true)
		end
		
		iVar0 = 743064848
		if (not IsNamedRendertargetRegistered("prop_ex_computer_screen")) then
			RegisterNamedRendertarget("prop_ex_computer_screen", 0)
			LinkNamedRendertarget(iVar0)
			if (not IsNamedRendertargetLinked(iVar0)) then
				-- ReleaseNamedRendertarget("prop_ex_computer_screen")
				-- return false
			end
		end
		iLocal_186 = GetNamedRendertargetRenderId("prop_ex_computer_screen")
		SetTextRenderId(iLocal_186)
		ProcessDesktop()
		SetTextRenderId(GetDefaultScriptRendertargetRenderId())
		tick = tick+1
		Citizen.Wait(0)
	end
end)