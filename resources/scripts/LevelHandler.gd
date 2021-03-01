extends Node2D

# Prefetch external modules
const UIDrawer: Script = preload("res://resources/scripts/UIDrawer.gd")
const InputHandler: Script = preload("res://resources/scripts/InputHandler.gd")
const ArenaState: Script = preload("res://resources/scripts/ArenaState.gd")

# Initialize extenral modules
onready var uiDrawer = UIDrawer.new(self)
onready var inputHandler = InputHandler.new()
onready var arenaState: ArenaState = ArenaState.new($TileMap)

func _ready():
	# Input handler must be assigned on the scene to share signals
	add_child(inputHandler)

	# Subscribe to input handler events
	inputHandler.connect("mouse_click", self, "_on_mouse_click")
	inputHandler.connect("mouse_hover", self, "_on_mouse_hover")

	# Invoke post-initialization inputHandler action
	inputHandler.post_init()
	
	# Debug arena matrix
	arenaState._pretty_print()

func try_handle_interaction(interaction_position, effect_type):
	var tile_position = $TileMap.get_tile_position_at(interaction_position)
	
	# If action happend on invalid tile
	if tile_position == null:
		# Remove any existing objects
		uiDrawer.try_reset_current()
		return false
		
	if effect_type == uiDrawer.EFFECT_TYPES.CLICK:
		print(tile_position, arenaState.map_to_matrix(tile_position.map_position))

	# Otherwise, draw the object based on the received tile world position
	uiDrawer.draw_tile_effect(tile_position.world_position, effect_type)

	return true

# Mouse click event handler
func _on_mouse_click(click_position):	
	try_handle_interaction(click_position, uiDrawer.EFFECT_TYPES.CLICK)

# Mouse hover event handler
func _on_mouse_hover(hover_position):
	try_handle_interaction(hover_position, uiDrawer.EFFECT_TYPES.HOVER)
