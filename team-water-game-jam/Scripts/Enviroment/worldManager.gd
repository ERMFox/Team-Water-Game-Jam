extends Node2D

const TILE_SIZE = 64
@onready var building_scene = preload("res://Scenes/Buildings/Building.tscn")
@onready var preview_sprite = $PlacementPreview


var occupied_tiles: = {}

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var grid_pos = get_mouse_grid_pos()
		if is_occupied(grid_pos):
			return
		
		var world_pos = grid_to_world(grid_pos)
		
		var building = building_scene.instantiate()
		building.position = world_pos
		add_child(building)
		
		mark_tile(grid_pos)

func get_mouse_grid_pos() -> Vector2i:
	var mouse_pos = get_global_mouse_position()
	return Vector2i(mouse_pos / TILE_SIZE)

func grid_to_world(grid_pos: Vector2i) -> Vector2:
	return Vector2(grid_pos) * TILE_SIZE + Vector2(TILE_SIZE / 2, TILE_SIZE / 2)

func is_occupied(grid_pos: Vector2i) -> bool:
	return occupied_tiles.has(grid_pos)

func mark_tile(grid_pos: Vector2i) -> void:
	occupied_tiles[grid_pos] = true

func _draw() -> void:
	# Optional: Draw the grid overlay
	var view_size = get_viewport_rect().size
	for x in range(0, view_size.x, TILE_SIZE):
		for y in range(0, view_size.y, TILE_SIZE):
			draw_rect(Rect2(Vector2(x, y), Vector2(TILE_SIZE, TILE_SIZE)), Color(1, 1, 1, 0.1), false)

func _process(delta: float) -> void:
	var grid_pos = get_mouse_grid_pos()
	var temp_building = building_scene.instantiate()
	var sprite_node = temp_building.get_node("Sprite2D")
	preview_sprite.texture = sprite_node.texture
	temp_building.queue_free() # Clean up the temp instance

	preview_sprite.position = grid_to_world(grid_pos)
	queue_redraw() # Keep grid drawing updated
