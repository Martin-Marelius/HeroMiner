tool
extends TileSet

const DARKDIRT = 6
const GRASS = 5
const STONE = 7
const DIRT = 4
const CRYSTAL = 8

var binds = {
	GRASS: [DIRT],
	DIRT: [GRASS, DARKDIRT],
	DARKDIRT: [DIRT, STONE],
	STONE: [DARKDIRT, CRYSTAL],
	CRYSTAL: [STONE]
}

func _is_tile_bound(drawn_id, neighbor_id):
	if drawn_id in binds:
		return neighbor_id in binds[drawn_id]
	return false
