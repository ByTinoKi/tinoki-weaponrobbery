Config = {}

Config.WeaponAsItem = true --Set to True if you're using Weapon as Item, Set to False if not.

Config.MinPolice = 0
Config.AmmunationDoor = { coords = vector3(811.82934570313,-2147.4426269531,28.496097564697), heading = 180.0 } -- Position of the Ammunation Door
Config.AmmunationDoorParticle = { coords = vector3(811.79943847656,-2147.0200195313,29.459037780762)} --Position of the Particle Effect 

Config.BlipReward1 = { coords = vector3(812.64813232422,-2153.3312988281,28.619010925293), heading = 270.0 } --Position of Blip 1 robbery in an ammunation
Config.BlipReward2 = { coords = vector3(812.22821044922,-2157.7661132813,28.619010925293), heading = 180.0 } --Position of Blip 2 robbery in an ammunation
Config.BlipReward3 = { coords = vector3(808.72503662109,-2155.1552734375,28.619010925293), heading = 145.0 } --Position of Blip 3 robbery in an ammunation

Config.StealTime = 10000

Config.DoorItem = "explosive" --Flames Item to Break the Door 
Config.BasicItem = "spring-part" --Spring Item Name 
Config.Part1 = "pistol-body" --Pistol Body Item Name
Config.Part2 = "smg-body" --SMG Body Item Name
Config.Part3 = "rifle-body" --Assault Rifle Body Item Name

Config.Weapon1 = "weapon_pistol_mk2" --Pistol Item Name if WeaponAsItem is True/Using Weapon as Item
Config.Weapon2 = "weapon_microsmg" --SMG Item Name if WeaponAsItem is True/Using Weapon as Item
Config.Weapon3 = "weapon_assaultrifle" --Assault Rifle Item Name if WeaponAsItem is True/Using Weapon as Item

Config.Part1Amount = 1 --Amount of Pistol Body from the single Blip Robbery
Config.Part2Amount = 1 --Amount of SMG Body from the single Blip Robbery
Config.Part3Amount = 1 --Amount of Assault Body from the single Blip Robbery

Config.minSpring = 1 --Min. Spring to get from the single Blip Robbery
Config.maxSpring = 1 --Max. Spring to get from the single Blip Robbery

Config.PistolSpring = 1 --How many spring to craft Pistol?
Config.SMGSpring = 1 --How many spring to craft SMG?
Config.AssaultSpring = 1 --How many spring to craft Assault Rifle?

--Notification
Config.Notification1 = "Press E to break the door."
Config.Notification2 = "You start the Weapon Store Robbery!"
Config.Notification3 = "You do not have the item to break this door!" 
Config.Notification4 = "Press E to Take the Parts."

Config.Notification5 = "Pistol Added."
Config.Notification6 = "SMG Added."
Config.Notification7 = "Assault Rifle Added."
Config.Notification8 = "Success!"
Config.Notification9 = "You do not have enough Spring!"
Config.Notification10 = "Place explosive!"
Config.Notification11 = "Steal weapon part!"
Config.Notification12 = "Not enough Police to start the Robbery!"

Config.Notification13 = "ROBBERY ALERT: Someone is robbing the Ammunation! Go respond immediately!" 
Config.Notification14 = "Crafting weapon!"