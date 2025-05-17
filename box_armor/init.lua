
AddCSLuaFile("shared.lua")
include("shared.lua")

local bronya = {
    "ent_jack_gmod_ezarmor_eaimbss",
    "ent_jack_gmod_ezarmor_cryeavs",
    "ent_jack_gmod_ezarmor_arsarmaa18",
    "ent_jack_gmod_ezarmor_cpcge",
    "ent_jack_gmod_ezarmor_ltorso",
    "ent_jack_gmod_ezarmor_mtorso",
    "ent_jack_gmod_ezarmor_mltorso",
}
local rugsagi = {
    "ent_jack_gmod_ezarmor_dufflebag",
    "ent_jack_gmod_ezarmor_dragonegg",
    "ent_jack_gmod_ezarmor_beta2bp",
    "ent_jack_gmod_ezarmor_mechanismbp",
    "ent_jack_gmod_ezarmor_sfmp",
    "ent_jack_gmod_ezarmor_pillboxbp"
}
local golovach = {
    "ent_jack_gmod_ezarmor_ballisticmask",
    "ent_jack_gmod_ezarmor_airsoftmask",
    "ent_jack_gmod_ezarmor_weldingkill",
    "ent_jack_gmod_ezarmor_gp5",
    "ent_jack_gmod_ezarmor_hockeybrawler",
    "ent_jack_gmod_ezarmor_deathknight",
}
local chlem = {
    "ent_jack_gmod_ezarmor_mhead",
    "ent_jack_gmod_ezarmor_lhead",
    "ent_jack_gmod_ezarmor_rioth",
    "ent_jack_gmod_ezarmor_maska",
}

util.AddNetworkString("inventory")
util.AddNetworkString("ply_take_item")
util.AddNetworkString("update_inventory")

function ENT:Initialize()
    self:SetModel("models/sarma_crates/static_crate_40.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
    
    -- Initialize the Info table with Weapons and Ammo subtables
    self.Info = {
        Weapons = {},
        Ammo = {}
    }
    
    -- Populate the Weapons table with a random weapon from Gunshuy
    local random = math.random(1,10) 
    local randomWeapon = golovach[math.random(1, #golovach)]
    self.Info.Weapons[randomWeapon] = {
        Clip1 =  -2
    }
    print(random)
    if random >= 5 then
        local randomWeaponss = bronya[math.random(1, #bronya)]
        self.Info.Weapons[randomWeaponss] = {
            Clip1 =  -2
        }
    end
    if random >= 7 then
        local randomWeaponsss = rugsagi[math.random(1, #rugsagi)]
        self.Info.Weapons[randomWeaponsss] = {
            Clip1 =  -2
        }
    end
    if random >= 7 then
        local randomWeaponsss = chlem[math.random(1, #chlem)]
        self.Info.Weapons[randomWeaponsss] = {
            Clip1 =  -2
        }
    end


end

function ENT:Use(activator, caller)
    if activator:IsPlayer() then
        if self.Info then
            net.Start("inventory")
            net.WriteEntity(self)
            net.WriteTable(self.Info.Weapons)
            net.WriteTable(self.Info.Ammo)
            net.Send(activator)
        end
    end
end
