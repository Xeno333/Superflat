local stone = core.get_content_id("mapgen_stone")
local bedrock = core.get_content_id("bedrock")

local biomes = {}

for name, v in pairs(core.registered_biomes) do
    local id = core.get_biome_id(name)

    biomes[id] = {}

    if v.node_top then
        biomes[id].node_top = core.get_content_id(v.node_top)
    end
end


core.register_on_generated(function(vm, minp, maxp, seed)
    if minp.y > 0 or maxp.y < -1 then return end

    local emin, emax = vm:get_emerged_area()
    local area = VoxelArea(emin, emax)
    local data = vm:get_data()

    local lx = 0
    for x = minp.x, maxp.x do
        lx = lx + 1
        local lz = 0
        for z = minp.z, maxp.z do
            lz = lz + 1

            local biome = biomes[core.get_biome_data({x=x, y=1, z=z}).biome]

            for y = minp.y, maxp.y do
                if y == 0 then
                    data[area:index(x, 0, z)] = biome.node_top or stone
                elseif y == -1 then
                    data[area:index(x, -1, z)] = bedrock
                end
            end
        end
    end

    vm:set_data(data)
end)
