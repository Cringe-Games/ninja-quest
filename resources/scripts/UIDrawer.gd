extends Node

enum TILE_TYPES_ENUM {ACTIVE,HOVER}

var level: Node2D;
var current_tile = get_current_defaults();

# To switch to a different theme, update /tiles/<THEME>/ part here
const TILES = {
	TILE_TYPES_ENUM.HOVER: preload("res://resources/tile_effects/bright_moon/hover_effect.tscn"),
	# TODO: Update reference with a link to a new AnimatedSprite 
	TILE_TYPES_ENUM.ACTIVE: preload("res://resources/tile_effects/bright_moon/hover_effect.tscn")
}

func _init(level_object: Node2D):
	level = level_object

func draw_tile(tile_position: Vector2, tile_type = TILE_TYPES_ENUM.HOVER):
	# If tile position is the same -> skip further execution
	if tile_position == current_tile.position and tile_type == current_tile.type:
		return
		
	# Make sure to reset any existing tiles
	try_reset_current()

	# Instantiate a new tile object
	var tile_object : AnimatedSprite = TILES[tile_type].instance()

	# Assign new tile object properties
	tile_object.position = Vector2(tile_position.x, tile_position.y)

	# Add the tile as a child to a world object
	level.add_child(tile_object)

	# Save reference to a current tile
	current_tile.type = tile_type
	current_tile.object = tile_object
	current_tile.position = tile_position
	
func get_current_defaults():
	return {
		"type": null,
		"object": null,
		"position": Vector2()
	}

func try_reset_current():
	var can_reset = current_tile.object is AnimatedSprite or current_tile.object is Sprite
	
	if can_reset:
		# Free up the current_tile game object
		current_tile.object.queue_free()
		
		# Reset current tile object entries to default
		current_tile = get_current_defaults()
	
	return can_reset
