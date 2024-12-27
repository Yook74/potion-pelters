extends Area2D

const Potion = preload("res://potion.tscn")

@export var speed: float
@export var gold_reward: int
@export var wants_potion: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Wants.texture = wants_potion.texture
	$Wants.scale = Vector2(.06, .06)
	$RewardAmount.text = str(gold_reward)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(0, speed)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
