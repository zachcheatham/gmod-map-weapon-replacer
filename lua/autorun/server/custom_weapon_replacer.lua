local replacements = {
	["weapon_ttt_glock"] = "weapon_ttt_csgo_glock18",
	["weapon_ttt_m16"] = "weapon_ttt_csgo_m4a4",
	["weapon_zm_mac10"] = {
		"weapon_ttt_csgo_mac10",
		"weapon_ttt_csgo_p90"
	},
	["weapon_zm_pistol"] = "weapon_ttt_csgo_fiveseven",
	["weapon_zm_revolver"] = "weapon_ttt_csgo_deagle",
	["weapon_zm_rifle"] = "weapon_ttt_csgo_scout",
	["weapon_zm_shotgun"] = "weapon_ttt_csgo_nova",
	["weapon_zm_sledge"] = "weapon_ttt_csgo_m249"
}

local function replaceWeapon(ent)
	if string.sub(ent:GetClass(), 1, 6) == "weapon" then
		local weaponReplacement = replacements[ent:GetClass()]
		

		if weaponReplacement then
			local newClass

			if type(weaponReplacement) == "table" then
				newClass = table.Random(weaponReplacement)
			else
				newClass = weaponReplacement
			end

			-- Respawn the weapon!

			ent:SetSolid(SOLID_NONE)

			local newEnt = ents.Create(newClass)
			newEnt:SetPos(ent:GetPos())
			newEnt:SetAngles(ent:GetAngles())

			newEnt:Spawn()
			newEnt:Activate()
			newEnt:PhysWake()

			--print ("Replaced " .. ent:GetClass() .. " with " .. newClass)

			ent:Remove()
		end
	end
end

local function replaceAllWeapons()
	for _, ent in pairs(ents.FindByClass("weapon_*")) do
		replaceWeapon(ent)
	end
end

local function entityCreated(ent)
	return

	/*if string.sub(ent:GetClass(), 1, 6) == "weapon" then
		local weaponReplacement = replacements[ent:GetClass()]
		if weaponReplacement then
			if type(weaponReplacement) == "table" then
				replaceWeapon(ent, table.Random(weaponReplacement))
			else
				replaceWeapon(ent, weaponReplacement)
			end
		end
	end*/
end
hook.Add("OnEntityCreated", "CustomWeaponReplacer", entityCreated)


concommand.Add("fix_ents", replaceAllWeapons)

hook.Add("PostCleanupMap", "CustomWeaponReplacer", function()
	timer.Simple(0.1, replaceAllWeapons)
end)