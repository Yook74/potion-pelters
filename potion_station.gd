extends Node2D

@export var keybind_prefix: String
@export var player: CharacterBody2D
@export var instruction_offset: Vector2

signal sig

func _ready() -> void:
	$Instruction.position = instruction_offset

func on_approach(body: Node2D) -> void:
	sig.connect(player.give_potion)
	$Instruction.start(keybind_prefix, ["left", "right", "up", "down"], sig)
	
func on_leave(body: Node2D) -> void:
	$Instruction.hide()
