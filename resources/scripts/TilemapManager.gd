extends Resource

var cells : Array = []
var tilemap : TileMap = null

func _init(tilemapToManage: TileMap):
	tilemap = tilemapToManage
	cells = tilemap.get_used_cells()

func _exists(tile_position: Vector2):
	return cells.find(tile_position) != -1

# Helper function to transform coordinates using tilemap API
func get_tile_position_at(world_position: Vector2):
	var requested_position: Vector2 = tilemap.world_to_map(world_position)
	
	# Return if tile doesn't exist on the tilemap
	if not _exists(requested_position):
		return null
	
	# Otherwise, calculate and return tile position in the world
	return tilemap.map_to_world(requested_position)
