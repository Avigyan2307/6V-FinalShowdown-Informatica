class_name SceneManager extends Node

const PLAYER_SCENE = preload("res://Scenes/Non_Levels/player.tscn")

var player: Player

var scene_dir_path = "res://Scenes/Levels/"

func _ready():
	player = PLAYER_SCENE.instantiate()


func change_scene(to_scene_name: String) -> void:
	var full_path = scene_dir_path + to_scene_name + ".tscn"

	print("Changing to:", full_path)

	var err = get_tree().change_scene_to_file(full_path)
	print("Error code:", err)

	await get_tree().process_frame

	var new_scene = get_tree().current_scene

	print("Current scene:", new_scene)
	print("Player:", player)
	print("Player parent:", player.get_parent() if player else "NO PLAYER")

	if new_scene == null:
		push_error("NEW SCENE IS NULL")
		return

	if player == null:
		push_error("PLAYER IS NULL")
		return

	if player.get_parent():
		player.get_parent().remove_child(player)

	new_scene.add_child(player)
	print("Player added successfully")
