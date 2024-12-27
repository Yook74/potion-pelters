extends CanvasLayer

signal Win

func update_score(score):
	$LPlayerScore.text = str(score)
	if score >= 15:
		Win.emit()
