extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_customer() -> void:
	var customer = load('res://customer.tscn').instantiate()
	var ypos
	var speed_mult
	if randi() % 2:
		ypos = 0
		speed_mult = 1
	else:
		ypos = 600
		speed_mult = -1
		
	customer.position = Vector2(400 + randi() % 200, ypos)
	customer.scale = Vector2(0.2, 0.2)
	customer.speed = (randi() % 5 + 1) * speed_mult
	add_child(customer)
