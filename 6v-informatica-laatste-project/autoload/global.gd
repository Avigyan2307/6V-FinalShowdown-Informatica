extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
