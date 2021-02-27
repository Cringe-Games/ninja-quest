extends Node

enum TILE_MODULAE_ENUM {ACTIVE,HOVER}

var level = null
var current_tile = null

# Tile type modifiers
var TILE_MODULAE_MODIFIERS = {
	TILE_MODULAE_ENUM.ACTIVE: Color(1.0, 0, 0),
	TILE_MODULAE_ENUM.HOVER: Color(0.5, 0.5, 0)
}

var Tile: PackedScene = preload("res://resources/tiles/active_tile.tscn")

func _init(level_object):
	self.level = level_object

func draw_tile(tile_position: Vector2, tile_modifier = TILE_MODULAE_ENUM.HOVER):
	# Make sure to reset any existing tiles
	cleanup()

	# Instantiate a new tile object
	var tile : Sprite = Tile.instance()
	var tile_height = tile.texture.get_height()

	# Assign new tile object properties
	tile.position = Vector2(tile_position.x, tile_position.y + tile_height / 2)
	tile.modulate = TILE_MODULAE_MODIFIERS[tile_modifier]

	# Add the tile as a child to a world object
	self.level.add_child(tile)

	# Save reference to a current tile
	current_tile = tile

func cleanup():
	if current_tile is Sprite:
		current_tile.queue_free()
		current_tile = null
