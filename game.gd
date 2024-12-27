extends Node2D

var main_shops = null


func _ready() -> void:
	$YouWinScreen.hide()


func _on_start_game() -> void:
	main_shops = load('res://main_shops.tscn').instantiate()
	main_shops.get_node("HUD").Win.connect(on_win)
	add_child(main_shops)
	$StartGameMenu.hide()
	$YouWinScreen.hide()


func on_win(winning_player):
	print("you win!")
	$YouWinScreen/WinnerSprite2D.texture = winning_player.get_node("Sprite2D").texture
	main_shops.hide()
	main_shops.queue_free()
	$YouWinScreen.show()
