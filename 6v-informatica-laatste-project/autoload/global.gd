extends Node

var current_level = 0
var level_scenes = [
	"res://Levels/main.tscn",
]
	
func next_level():
	current_level += 1
	if current_level < level_scenes.size():
		get_tree().change_scene_to_file(level_scenes[current_level])
	else:
		get_tree().change_scene_to_file("res://Levels/Main_menu.tscn")
