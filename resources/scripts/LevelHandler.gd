extends Node2D

# Dependencies
var InputHandler: Script = preload("res://resources/scripts/InputHandler.gd")
var UIDrawer: Script = preload("res://resources/scripts/UIDrawer.gd")

onready var uiDrawer = UIDrawer.new(self)
onready var inputHandler = InputHandler.new()

func _ready():
	add_child(inputHandler)

	inputHandler.connect("mouse_click", self, "_on_mouse_click")
	inputHandler.connect("mouse_hover", self, "_on_mouse_hover")

func _on_mouse_click(click_position):	
	var tile_position = get_tile_position_at(click_position)
	self.uiDrawer.draw_tile(tile_position, self.uiDrawer.TILE_MODULAE_ENUM.ACTIVE)

func _on_mouse_hover(hover_position):
	var tile_position = get_tile_position_at(hover_position)
	self.uiDrawer.draw_tile(tile_position, self.uiDrawer.TILE_MODULAE_ENUM.HOVER)

func get_tile_position_at(vector: Vector2):
	return $TileMap.map_to_world($TileMap.world_to_map(vector))
