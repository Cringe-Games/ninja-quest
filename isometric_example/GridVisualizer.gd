extends Node2D

onready var grid = get_parent()

const LINE_WIDTH = 2
const LINE_COLOR = Color(255, 255, 255)

const CIRCLE_RADIUS = 3
const CIRCLE_COLOR = Color(255, 255, 255)
const CIRCLE_MODULATE = Color(1, 0.2, 0, 0.2)

func _ready():
	modulate = CIRCLE_MODULATE

func draw_tile_center_at(circle_position: Vector2):
	var circle_coordinates = grid.map_to_world(circle_position)
	draw_circle(circle_coordinates, CIRCLE_RADIUS, CIRCLE_COLOR)
	
func get_rotational_transformation(degree: int = 0):
	var rad = deg2rad(degree)
	var rotational_transformation: Transform2D = Transform2D()
	
	rotational_transformation.x.x = cos(rad)
	rotational_transformation.y.y = cos(rad)
	rotational_transformation.x.y = sin(rad)
	rotational_transformation.y.x = -sin(rad)
	
	return rotational_transformation;
	
func get_move_transformation(move: Vector2 = Vector2()):
	var translation_transformation: Transform2D = Transform2D()
	
	translation_transformation.origin = Vector2(move.x * grid.cell_size.x, move.y * grid.cell_size.y);
	
	return translation_transformation
	
func get_shearing_transformation(shear_degree: int):
	var shearing_transformation: Transform2D = Transform2D()
	
	shearing_transformation.y = Vector2(cos(deg2rad(shear_degree)), sin(deg2rad(shear_degree)))
	
	return shearing_transformation
	
func apply_transformations(origin: Vector2, transformations: Array):
	var result = Vector2(origin)
	
	for transformation in transformations:
		result = transformation.xform(result)
		
	return result
	

func _draw():
	draw_tile_center_at(grid.cartesian_to_isometric(Vector2(1, 1)))
	
	return
	
	var rotate = get_rotational_transformation(45)
	var shear = get_shearing_transformation(45)
	var move = get_move_transformation(Vector2(6, -10))
	var transformations = []

	# Drawing columns
	for x in range(grid.cell_quadrant_size + 1):
		var col_pos = x * grid.cell_size.x
		var limit = grid.grid_size.y * grid.cell_size.y
		
		var from = Vector2(col_pos, 0)
		var to = Vector2(col_pos, limit)
		
		from = apply_transformations(from, transformations)
		to = apply_transformations(to, transformations)
		
		draw_line(from, to, LINE_COLOR, LINE_WIDTH)
		
	# Drawing rows
	for y in range(grid.cell_quadrant_size + 1):
		var row_pos = y * grid.cell_size.y
		var limit = grid.grid_size.x * grid.cell_size.x
		
		var from = Vector2(0, row_pos)
		var to = Vector2(limit, row_pos)
		
		from = apply_transformations(from, transformations)
		to = apply_transformations(to, transformations)
		
		draw_line(from, to, LINE_COLOR, LINE_WIDTH)
