extends CanvasLayer

signal Win(player)

func update_score(score, player):
	if player.name == "Ellie":
		$LPlayerScore.text = str(score)
	elif player.name == "Merry":
		$RPlayerScore.text = str(score)
		
	if score >= 20:
		Win.emit(player)
