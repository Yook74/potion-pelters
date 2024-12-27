extends CharacterBody2D

var speed = 400
var potion = false
var is_yeeting = false
var abs_yeet_pos: Vector2
var yeet_rot: float
var yeet_scale: Vector2
var initial_yeet_pos: Vector2
var initial_yeet_scale: Vector2

@export var score: int
@export var keybind_prefix: String

signal score_update(new_score)

func _ready() -> void:
	initial_yeet_pos = $Yeet.position
	initial_yeet_scale = $Yeet.scale

func give_potion():
	potion = true
	$Yeet/Path2D/PathFollow2D.progress_ratio = 1
	$Yeet/Path2D/PathFollow2D/HeldPotion.show()
	$Yeet.show()

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(keybind_prefix + "move_right"):
		velocity.x += 1
		if $Yeet.scale.x < .7:
			$Yeet.scale.x += 0.005
			$Yeet.position.x += 5
	if Input.is_action_pressed(keybind_prefix + "move_left"):
		velocity.x -= 1
		if $Yeet.scale.x > .3:
			$Yeet.scale.x -= 0.005
			$Yeet.position.x -= 5
	if Input.is_action_pressed(keybind_prefix + "move_down"):
		velocity.y += 1
		if $Yeet.rotation < .3:
			$Yeet.rotation += .01
			$Yeet.position.y += 3.5
	if Input.is_action_pressed(keybind_prefix + "move_up"):
		velocity.y -= 1
		if $Yeet.rotation > -0.3:
			$Yeet.rotation -= .01
			$Yeet.position.y -= 3.5

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	move_and_collide(velocity * delta)
	
	if potion and Input.is_action_pressed(keybind_prefix + "yeet"):
		yeet()
	
	if is_yeeting:
		$Yeet.global_position = abs_yeet_pos
		$Yeet.rotation = yeet_rot
		$Yeet.scale = yeet_scale
		
		$Yeet/Path2D/PathFollow2D.progress_ratio -= 0.007 / yeet_scale.x
		$Yeet/Path2D/PathFollow2D/HeldPotion.rotation += 0.3
		if $Yeet/Path2D/PathFollow2D.progress_ratio == 0:
			on_potion_land()

func yeet():
	is_yeeting = true
	abs_yeet_pos = $Yeet.global_position
	yeet_rot = $Yeet.rotation
	yeet_scale = $Yeet.scale


func on_potion_land():
	is_yeeting = false
	$Yeet.hide()
	$Yeet.position = initial_yeet_pos
	$Yeet.rotation = 0
	$Yeet.scale = initial_yeet_scale
	
	for entity in $Yeet/Area2D.get_overlapping_bodies():
		if "gold_reward" in entity:
			score += entity.gold_reward
			entity.satisfy()
			
	score_update.emit(score)
	
	
