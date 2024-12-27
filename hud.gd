extends CanvasLayer

@export var players: Array[Node2D]

func update_score(score):
	$LPlayerScore.text = str(score)
