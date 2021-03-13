extends Resource

class_name ArenaState

enum CHARACTERS  {
	HERO = 1,
	ENEMY = 2
}

var matrix : Array = []
var offset : Vector2 = Vector2(0, 0)
var prevCharsPositions = {CHARACTERS.HERO: {'x': 0, 'y': 0}, CHARACTERS.ENEMY: {'x': 0, 'y': 0}}

func _init(tilemap: TileMap):
	var rects: Rect2 = tilemap.rects
	# Assign offset based on first tile position
	offset = rects.position

	# Assign the default matrix based on tilemap size
	for row in rects.size.x:
		matrix.append([])
		for col in rects.size.y:
			matrix[row].append(0)
			
func map_to_matrix(map_position: Vector2):
	return map_position - offset
	
func assignCharacter(tile_position, type, ref):
	var mapped_position = map_to_matrix(tile_position.map_position)
	matrix[mapped_position.y][mapped_position.x] = type
	
	_moveBody(tile_position.world_position, mapped_position, type, ref)
	_pretty_print()
	
func _moveBody(world_position, mapped_position, type, ref):
	_clearPreviousPosition(prevCharsPositions[type]['x'], prevCharsPositions[type]['y'])
	prevCharsPositions[type]['x'] =  mapped_position.x
	prevCharsPositions[type]['y'] =  mapped_position.y

	ref.position = world_position
		

func _clearPreviousPosition(x, y): 
	matrix[y][x] = 0

func _pretty_print():
	print("Arena matrix")
	for row in matrix:
		print(row)
	print("============")
