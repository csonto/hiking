minetest.register_alias("hiking_red_sign", "hiking:red_sign")

local basic_properties = {
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
		wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
		wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
	},
	groups = {snappy=1}, --2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	--sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		--local n = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		if minetest.is_protected(pos, sender:get_player_name()) then
			minetest.record_protection_violation(pos, sender:get_player_name())
			return
		end
		local meta = minetest.get_meta(pos)
		if not fields.text then return end
		minetest.log("action", (sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')
	end,
}

local function merge(a, b)
	local c = {}
	for k, v in pairs(a) do
		c[k] = v
	end
	for k, v in pairs(b) do
		c[k] = v
	end
	return c
end

local illuminated_properties = merge(basic_properties, {
	light_source = 3
})

minetest.register_node("hiking:red_sign", merge(basic_properties, {
	description = "Red hiking sign",
	tiles = {"hiking_red_sign.png"},
	inventory_image = "hiking_red_sign.png",
	wield_image = "hiking_red_sign.png",
}))

minetest.register_node("hiking:illuminated_red_sign", merge(illuminated_properties, {
	description = "Illuminated red hiking sign",
	tiles = {"hiking_red_sign.png"},
	inventory_image = "hiking_illuminated_red_sign.png",
	wield_image = "hiking_illuminated_red_sign.png"
}))

minetest.register_node("hiking:red_arrow_right", merge(basic_properties, {
	description = "Red right arrow sign",
	tiles = {"hiking_red_arrow_right.png"},
	inventory_image = "hiking_red_arrow_right.png",
	wield_image = "hiking_red_arrow_right.png"
}))

minetest.register_node("hiking:illuminated_red_arrow_right", merge(illuminated_properties, {
	description = "Illuminated red right arrow sign",
	tiles = {"hiking_red_arrow_right.png"},
	inventory_image = "hiking_illuminated_red_arrow_right.png",
	wield_image = "hiking_illuminated_red_arrow_right.png"
}))

minetest.register_node("hiking:red_arrow_left", merge(basic_properties, {
	description = "Red left arrow sign",
	tiles = {"hiking_red_arrow_left.png"},
	inventory_image = "hiking_red_arrow_left.png",
	wield_image = "hiking_red_arrow_left.png",
}))

minetest.register_node("hiking:illuminated_red_arrow_left", merge(illuminated_properties, {
	description = "Illuminated red left arrow sign",
	tiles = {"hiking_red_arrow_left.png"},
	inventory_image = "hiking_illuminated_red_arrow_left.png",
	wield_image = "hiking_illuminated_red_arrow_left.png",
}))

minetest.register_craft({
	output = 'hiking:red_sign',
	recipe = {
		{'dye:white'},
		{'dye:red'},
		{'dye:white'}
	}
})

minetest.register_craft({
	output = 'hiking:red_arrow_right',
	recipe = {
		{'hiking:red_sign','dye:red'}
	}
})

minetest.register_craft({
	output = 'hiking:red_arrow_left',
	recipe = {
		{'dye:red','hiking:red_sign'}
	}
})

minetest.register_craft({
	output = 'hiking:illuminated_red_sign',
        type = 'shapeless',
	recipe = { 'default:torch', 'hiking:red_sign' }
})

minetest.register_craft({
	output = 'hiking:illuminated_red_arrow_left',
        type = 'shapeless',
	recipe = { 'default:torch', 'hiking:red_arrow_left' }
})

minetest.register_craft({
	output = 'hiking:illuminated_red_arrow_right',
        type = 'shapeless',
	recipe = { 'default:torch', 'hiking:red_arrow_right' }
})

