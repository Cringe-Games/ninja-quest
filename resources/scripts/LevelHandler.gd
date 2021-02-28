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
	if tile_position == null:
		uiDrawer.try_reset_current()
	else:
		uiDrawer.draw_tile(tile_position, uiDrawer.TILE_TYPES_ENUM.ACTIVE)

# Mouse hover event handler
func _on_mouse_hover(hover_position):
	var tile_position = get_tile_position_at(hover_position)
	if tile_position == null:
		uiDrawer.try_reset_current()
	else:
		uiDrawer.draw_tile(tile_position, uiDrawer.TILE_TYPES_ENUM.HOVER)

# Helper function to transform coordinates using tilemap API
func get_tile_position_at(vector: Vector2):
	var tile_map_position: Vector2 = $TileMap.world_to_map(vector)
	
	# TODO: Optimize! 
	# With the current implementation the following validation logic
	# will be calculated on each function call (each user input)
	var tile_exists = $TileMap.get_used_cells().find(tile_map_position) != -1
	# Return if tile doesn't exist on the tilemap
	if (!tile_exists):
		return null
	
	# Otherwise, calculate and return tile position in the world
	return $TileMap.map_to_world(tile_map_position)
