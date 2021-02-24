extends TileMap

var current_event = null

signal mouse_hover
signal mouse_click
signal mouse_release

# Tile object
var Tile: PackedScene = preload("res://resources/tiles/active_tile.tscn")

enum TILE_MODULAE_ENUM {ACTIVE,HOVER}
# Tile type modifiers
var TILE_MODULAE_MODIFIERS = {
	TILE_MODULAE_ENUM.ACTIVE: Color(1.0, 0, 0),
	TILE_MODULAE_ENUM.HOVER: Color(0.5, 0.5, 0)
}

var current_tile = null

func _ready():
	self.connect("mouse_click", self, "_on_mouse_click")
	self.connect("mouse_hover", self, "_on_mouse_hover")
	self.connect("mouse_release", self, "_on_mouse_release")
		
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		emit_signal("mouse_hover", event.position)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("mouse_click", event.position)
		if event.button_index == BUTTON_LEFT and not event.pressed:
			emit_signal("mouse_release", event.position)
		
func _on_mouse_click(click_position):	
	var tile_position = get_tile_position_at(click_position)
	_debug_draw_tile(tile_position, TILE_MODULAE_ENUM.ACTIVE)
	
func _on_mouse_release(mouse_position):
	cleanup()
	emit_signal("mouse_hover", mouse_position)
		
func _on_mouse_hover(hover_position):
	cleanup()
	var tile_position = get_tile_position_at(hover_position)
	_debug_draw_tile(tile_position, TILE_MODULAE_ENUM.HOVER)
	
func get_tile_position_at(vector: Vector2):
	return map_to_world(world_to_map(vector))
	
func cleanup():
	if current_tile is Sprite:
		current_tile.queue_free()
		current_tile = null
	
func _debug_draw_tile(tile_position: Vector2, tile_modifier = TILE_MODULAE_ENUM.HOVER):
	# Make sure to reset any existing tiles
	cleanup()

	# Instantiate a new tile object
	var tile : Sprite = Tile.instance()
	var tile_height = tile.texture.get_height()
	
	# Assign new tile object properties
	tile.position = Vector2(tile_position.x, tile_position.y + tile_height / 2)
	tile.modulate = TILE_MODULAE_MODIFIERS[tile_modifier]
	
	# Add the tile as a child to a world object
	add_child(tile)
	
	# Save reference to a current tile
	current_tile = tile
