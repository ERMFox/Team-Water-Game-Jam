extends Control

@export var scroll_speed: float = 10.0
@export var main_menu_scene: PackedScene  # Assign this in the editor

var credits_container: VBoxContainer
var scroll_container: ScrollContainer
var tween

func _ready() -> void:
	scroll_container = $ScrollContainer
	credits_container = $ScrollContainer/CreditsContainer

	create_dynamic_credits()
	start_credits_roll()

func create_dynamic_credits() -> void:
	var credits = [
		"--- TEAM ---",
		"-- Game Designers --",
		"ERMFox",
		"--",
		"-- Game Programmers --",
		"ERMFox",
		"--",
		"--- MUSIC ---",
		"---",
		"Dark Horse 2 - Centurion of War",
		"(OpenGameArt.org)",
		"Licensed under CC0 (Public Domain)",
		"---",
	]

	for line in credits:
		var label := Label.new()
		label.text = line
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		credits_container.add_child(label)


func start_credits_roll() -> void:
	await get_tree().process_frame  # Ensure layout is calculated
	var start_y := scroll_container.size.y
	var end_y := -credits_container.size.y

	credits_container.position.y = start_y

	tween = create_tween()
	tween.tween_property(credits_container, "position:y", end_y, scroll_speed)
	tween.finished.connect(_on_credits_finished)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept"):
		# Skip credits immediately
		if tween and tween.is_running():
			tween.kill()
		_on_credits_finished()

func _on_credits_finished() -> void:
	if main_menu_scene:
		get_tree().change_scene_to_packed(main_menu_scene)
	else:
		print("Main menu scene not assigned.")
