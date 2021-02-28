extends Node2D


# Prefetch external modules
const UIDrawer: Script = preload("res://resources/scripts/UIDrawer.gd")
const InputHandler: Script = preload("res://resources/scripts/InputHandler.gd")

# Initialize extenral modules
onready var uiDrawer = UIDrawer.new(self)
onready var inputHandler = InputHandler.new()

func _ready():
	# Input handler must be assigned on the scene to share signals
	add_child(inputHandler)

	# Subscribe to input handler events
	inputHandler.connect("mouse_click", self, "_on_mouse_click")
	inputHandler.connect("mouse_hover", self, "_on_mouse_hover")
	
	# Invoke any post-initialization inputHandler action
	inputHandler.post_init()

# Mouse click event handler
func _on_mouse_click(click_position):	
	var tile_position = get_tile_position_at(click_position)
	uiDrawer.draw_tile(tile_position, uiDrawer.TILE_TYPES_ENUM.ACTIVE)

# Mouse hover event handler
func _on_mouse_hover(hover_position):
	var tile_position = get_tile_position_at(hover_position)
	uiDrawer.draw_tile(tile_position, uiDrawer.TILE_TYPES_ENUM.HOVER)

# Helper function to transform coordinates using tilemap API
func get_tile_position_at(vector: Vector2):
	return $TileMap.map_to_world($TileMap.world_to_map(vector))
