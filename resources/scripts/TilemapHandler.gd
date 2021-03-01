extends TileMap

class_name TilemapHandler

# Internal fields
var cells : Array = []
var rects : Rect2 = Rect2()

func _init():
	# Initialize internal fields
	cells = get_used_cells()
	rects = get_used_rect()

func _exists(tile_position: Vector2):
	return cells.find(tile_position) != -1

# Helper function to transform coordinates using tilemap API
func get_tile_position_at(world_position: Vector2):
	var tile_map_position: Vector2 = world_to_map(world_position)

	# Return if tile doesn't exist on the tilemap
	if not _exists(tile_map_position):
		return null
		
	var tile_world_position = map_to_world(tile_map_position)

	# Otherwise, calculate and return tile position in the world
	return { "map_position": tile_map_position, "world_position": tile_world_position }
