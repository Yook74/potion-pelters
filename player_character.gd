extends CharacterBody2D

var speed = 400

@export var keybind_prefix: String

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(keybind_prefix + "move_right"):
		velocity.x += 1
	if Input.is_action_pressed(keybind_prefix + "move_left"):
		velocity.x -= 1
	if Input.is_action_pressed(keybind_prefix + "move_down"):
		velocity.y += 1
	if Input.is_action_pressed(keybind_prefix + "move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	#position += velocity * delta
	move_and_collide(velocity * delta)
