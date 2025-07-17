extends Control

var score : int = 0

func _on_consume_total_flys_consumed(total_flys_consumed) -> void:
	score += total_flys_consumed
	$GameOver.visible = true
	$GameOver.text = "Game Over! \n You consumed " + str(score) + " flies"
	get_tree().paused = true
	$QuitButton.visible = true
	$Restart.visible = true
