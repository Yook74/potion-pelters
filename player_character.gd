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
@export var aiming_scale: int
@export var keybind_prefix: String

signal score_update(new_score, player)

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
		$Yeet.scale.x = clip($Yeet.scale.x + 0.005, .3, .7, true)

	if Input.is_action_pressed(keybind_prefix + "move_left"):
		velocity.x -= 1
		$Yeet.scale.x = clip($Yeet.scale.x - 0.005, .3, .7, true)

	if Input.is_action_pressed(keybind_prefix + "move_down"):
		velocity.y += 1
		$Yeet.rotation = clip($Yeet.rotation + 0.01 * aiming_scale, -0.3, 0.3)

	if Input.is_action_pressed(keybind_prefix + "move_up"):
		velocity.y -= 1
		$Yeet.rotation = clip($Yeet.rotation - 0.01 * aiming_scale, -0.3, 0.3)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	move_and_collide(velocity * delta)
	
	if potion and Input.is_action_pressed(keybind_prefix + "yeet"):
		yeet()
	
	if is_yeeting:
		$Yeet.global_position = abs_yeet_pos
		$Yeet.rotation = yeet_rot
		$Yeet.scale = yeet_scale
		
		$Yeet/Path2D/PathFollow2D.progress_ratio -= 0.007 / abs(yeet_scale.x)
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
		elif entity.has_method("get_potioned"):
			entity.get_potioned()
			
	score_update.emit(score, self)


func get_potioned():
	speed = 100
	$PotionedTimer.start()


func get_unpotioned() -> void:
	speed = 400

func clip(value: float, lower_limit: float, upper_limit: float, absolute_limits = false):
	var compare_value = value
	var out_multiplier = 1
	if absolute_limits:
		compare_value = abs(value)
		if value < 0:
			out_multiplier = -1
	
	if compare_value < lower_limit:
		value = lower_limit * out_multiplier
	
	if compare_value > upper_limit:
		value = upper_limit * out_multiplier
	
	return value
