class_name Player extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var SPEED = 300.0
var JUMP_POWER = 1.7
var JUMP_CHARGE_DUR = 0
var JUMP_VELOCITY = -650.0
var SHAPE = CollisionShape2D.shape
var OFFSET_AMOUNT = 50

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if Input.is_action_pressed(".down"):
		animated_sprite_2d.animation = "crouch"
		SHAPE.size.y -= OFFSET_AMOUNT
		CollisionShape2D.position.y += OFFSET_AMOUNT/2
		AnimatedSprite2D.position.y += OFFSET_AMOUNT/2

	if Input.is_action_just_released(".down"):
		animated_sprite_2d.animation = "idle"
		SHAPE.size.y += OFFSET_AMOUNT
		CollisionShape2D.position.y -= OFFSET_AMOUNT/2
		AnimatedSprite2D.position.y -= OFFSET_AMOUNT/2
	
	if (velocity.x > 1 or velocity.x <-1) :
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jump"
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
			
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

func player_die():
	get_tree().reload_current_scene()
	
	
