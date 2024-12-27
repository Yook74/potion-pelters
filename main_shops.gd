extends Node2D

const Potion = preload("res://potion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LDesk/PotionStation.player = $Ellie

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_customer() -> void:
	var customer = load('res://tebi.tscn').instantiate()
	var ypos
	var speed_mult
	if randi() % 2:
		ypos = 0
		speed_mult = 1
	else:
		ypos = 1080
		speed_mult = -1
		
	customer.position = Vector2(1000 + randi() % 200, ypos)
	customer.speed = (randi() % 5 + 1) * speed_mult
	customer.wants_potion = Potion.instantiate()
	customer.gold_reward = randi() % 5 + 1
	
	add_child(customer)
