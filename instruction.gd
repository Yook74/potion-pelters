extends Sprite2D

var sequence = []
var keybind_prefix = ""
var counter = 0
var active = false
var on_success: Signal

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not active:
		return
	
	if Input.is_action_pressed(keybind_prefix + "move_" + sequence[counter]):
		counter += 1
	elif Input.is_anything_pressed():
		pass # TODO
		
	if counter == len(sequence):
		self.hide()
		active = false
		on_success.emit()
	else:
		texture = load('res://' + sequence[counter] + '_arrow.png')
		

func start(keybind_prefix: String, sequence: Array, on_success: Signal) -> void:
	self.keybind_prefix = keybind_prefix
	self.sequence = sequence
	self.on_success = on_success
	texture = load('res://' + sequence[0] + '_arrow.png')
	counter = 0
	active = true
	show()
