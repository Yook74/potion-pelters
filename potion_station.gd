extends Node2D

const PlayerCharacter = preload("res://player_character.gd")

@export var keybind_prefix: String
@export var player: CharacterBody2D
@export var instruction_offset: Vector2

signal sig

func _ready() -> void:
	$Instruction.position = instruction_offset

func on_approach(body: Node2D) -> void:
	if body is not PlayerCharacter:
		return
		
	sig.connect(player.give_potion)
	
	var keypress_len = randi() % 5 + 3
	var keypresses = Array()
	var last_keypress = ""
	for i in range(keypress_len):
		var keypress = last_keypress
		while keypress == last_keypress:
			match randi() % 4:
				0:
					keypress = "left"
				1:
					keypress = "right"
				2:
					keypress = "up"
				3:
					keypress = "down"
		last_keypress = keypress
		keypresses.append(keypress)
	
	$Instruction.start(keybind_prefix, keypresses, sig)
	
func on_leave(body: Node2D) -> void:
	$Instruction.hide()
