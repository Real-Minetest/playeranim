-- Bone alias
local BODY = "Body"
local HEAD = "Head"
local CAPE = "Cape"
local LARM = "Arm_Left"
local RARM = "Arm_Right"
local LLEG = "Leg_Left"
local RLEG = "Leg_Right"

-- # Version of player model
--
-- ## default_character_v4:
--
-- minetest_game after 4 Nov 2017 (49cc4c7)
-- 3d_armor after 28 Nov 2016 (cc25d6b)
--
local DEFAULT_PLAYER_MODEL_VERSION = "default_character_v4"

local VALID_PLAYER_MODEL_VERSIONS = {
	default_character_v4 = true,
}

local LEGACY_PLAYER_MODEL_VERSIONS = {
	default_character_v1 = true,
	default_character_v2 = true,
	default_character_v3 = true,
}

local BONE_POSITIONS = {
	default_character_v4 = {
		[BODY] = {x = 0,   y = 6.25, z = 0},
		[HEAD] = {x = 0,   y = 6.5,  z = 0},
		[CAPE] = {x = 0,   y = 6.5,  z = 1.2},
		[LARM] = {x = 3,   y = 5.5,  z = 0},
		[RARM] = {x = -3,  y = 5.5,  z = 0},
		[LLEG] = {x = 1,   y = 0,    z = 0},
		[RLEG] = {x = -1,  y = 0,    z = 0},
	}
}

local BONE_ROTATIONS = {
	default_character_v4 = {
		[BODY] = {x = 0, y = 0, z = 0},
		[HEAD] = {x = 0, y = 0, z = 0},
		[CAPE] = {x = 0, y = 0, z = 0},
		[LARM] = {x = 0, y = 0, z = 0},
		[RARM] = {x = 0, y = 0, z = 0},
		[LLEG] = {x = 0, y = 0, z = 0},
		[RLEG] = {x = 0, y = 0, z = 0},
	}
}

local PLAYER_MODEL_VERSION = (function()
	local version = minetest.settings:get("playeranim.model_version")
	if version == nil or version == "" then
		version = DEFAULT_PLAYER_MODEL_VERSION
	end

	if LEGACY_PLAYER_MODEL_VERSIONS[version] then
		error("The model version '" .. version .. "' is no longer suppported")
	elseif not VALID_PLAYER_MODEL_VERSIONS[version] then
		error("Invalid value for playeranim.model_version in minetest.conf: " .. version)
	end

	return version
end)()

local BONE_POSITION = BONE_POSITIONS[PLAYER_MODEL_VERSION]
local BONE_ROTATION = BONE_ROTATIONS[PLAYER_MODEL_VERSION]
if not BONE_POSITION or not BONE_ROTATION then
	error("Internal error: invalid player_model_version: " .. PLAYER_MODEL_VERSION)
end

return BONE_POSITION, BONE_ROTATION
