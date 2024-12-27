extends Sprite2D

var jump_position_delta = -100


func _on_jump_timer_timeout() -> void:
	position += Vector2(0, jump_position_delta)
	jump_position_delta = -jump_position_delta
