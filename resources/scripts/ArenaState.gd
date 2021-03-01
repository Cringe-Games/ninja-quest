extends Resource

class_name ArenaState

var matrix : Array = []
var offset : Vector2 = Vector2(0, 0)

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

func _pretty_print():
	print("Arena matrix")
	for row in matrix:
		print(row)
	print("============")
