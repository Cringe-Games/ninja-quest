extends Node

enum TILE_MODULAE_ENUM {ACTIVE,HOVER}

var level = null
var current_tile = {
	"object": null,
	"position": Vector2(),
	"modifier": null
}

# Tile type modifiers
var TILE_MODULAE_MODIFIERS = {
	TILE_MODULAE_ENUM.ACTIVE: Color(1.0, 0, 0),
	TILE_MODULAE_ENUM.HOVER: Color(0.5, 0.5, 0)
}

var Tile: PackedScene = preload("res://resources/tiles/animated_marks_tile.tscn")

func _init(level_object):
	self.level = level_object

func draw_tile(tile_position: Vector2, tile_modifier = TILE_MODULAE_ENUM.HOVER):
	# If tile position is the same -> skip drawig 
	if tile_position == current_tile.position and tile_modifier == current_tile.modifier:
		return
		
	# Make sure to reset any existing tiles
	cleanup()

	# Instantiate a new tile object
	# var tile : Sprite = Tile.instance()
	var tile : AnimatedSprite = Tile.instance()

	# Assign new tile object properties
	tile.position = Vector2(tile_position.x, tile_position.y)
	tile.modulate = TILE_MODULAE_MODIFIERS[tile_modifier]

	# Add the tile as a child to a world object
	tile.play();
	self.level.add_child(tile)
	

	# Save reference to a current tile
	current_tile.object = tile
	current_tile.position = tile_position
	current_tile.modifier = tile_modifier

func cleanup():
	if current_tile.object is AnimatedSprite or current_tile.object is Sprite:
		current_tile.object.queue_free()
		current_tile.object = null
		current_tile.modifier = null
		current_tile.position = Vector2()
