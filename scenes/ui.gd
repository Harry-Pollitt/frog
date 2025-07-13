extends Control

var score : int = 0

func _on_hunger_bar_hunger_depleted() -> void:
	visible = true
	$GameOver.text = "Game Over! \n You consumed " + str(score)
	get_tree().paused = true


func _on_consume_total_flys_consumed(total_flys_consumed) -> void:
	score += total_flys_consumed
