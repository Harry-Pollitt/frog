extends Node2D

@onready var twist_path = $CrowPath/PathFollow2D
@onready var frog_path = $TwistPath/PathFollow2D
@onready var crow_call = $CrowCall

func _on_consume_twist() -> void:
	crow_call.play()
	var crow_tween = get_tree().create_tween()
	var frog_tween = get_tree().create_tween()
	crow_tween.tween_property(twist_path, "progress_ratio", 1, 2)
	crow_tween.play()
	frog_tween.tween_interval(0.6)
	frog_tween.tween_property(frog_path, "progress_ratio", 1, 1.7)
	frog_tween.play()
	$UI/GameOver.visible = true
	$UI/GameOver.text = "You grew too big\n and were noticed..."
	$UI/QuitButton.visible = true
	$UI/Restart.visible = true
	$UI/MessagesToPlayer.visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
