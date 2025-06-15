core.register_node(":bedrock", {
    tiles = {"bedrock.png"},
    diggable = false
})

core.register_mapgen_script(core.get_modpath("superflat") .. "/mapgen.lua")