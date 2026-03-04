class_name Player extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
var JUMP_POWER = 1.7
var JUMP_CHARGE_DUR = 0
const JUMP_VELOCITY = -650.0

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
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if velocity.x > 1 or velocity.x <-1:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jump"
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		while Input.is_action_pressed("jump"):
			JUMP_CHARGE_DUR += 1
			print(JUMP_CHARGE_DUR)
			
	if JUMP_CHARGE_DUR != 0 and is_on_floor():
		print(" I Work")
		if JUMP_CHARGE_DUR >= 50:
			velocity.y = JUMP_VELOCITY * JUMP_POWER
			JUMP_CHARGE_DUR = 0
			print("I work too")
		else:
			velocity.y = JUMP_VELOCITY
			JUMP_CHARGE_DUR = 0
			print("Me too")
	# Get the input direction and handle the movement/deceleration.

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true

func die():
	get_tree().reload_current_scene()
	
	
