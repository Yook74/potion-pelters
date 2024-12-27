extends Node2D

const Potion = preload("res://potion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LDesk/PotionStation.player = $Ellie

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_customer() -> void:
	var ypos
	var speed_mult
	if randi() % 2:
		ypos = 0
		speed_mult = 1
	else:
		ypos = 1080
		speed_mult = -1
		
	var customer = null
	match randi() % 5:
		0,1:
			customer = load('res://tebi.tscn').instantiate()
			customer.speed = (randi() % 3 + 1) * speed_mult
			customer.gold_reward = randi() % 5 + 1
		2,3:
			customer = load('res://nate.tscn').instantiate()
			customer.speed = (randi() % 2 + 5) * speed_mult
			customer.gold_reward = randi() % 5 + 3
		4:
			customer = load('res://capy.tscn').instantiate()
			customer.speed = 1 * speed_mult
			customer.gold_reward = 1
	
	customer.position = Vector2(1000 + randi() % 200, ypos)
	customer.wants_potion = Potion.instantiate()
	add_child(customer)
