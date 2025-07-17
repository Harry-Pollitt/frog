extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_options_toggled(_toggled_on: bool) -> void:
	$VBoxContainer/Options/Audio.visible = !$VBoxContainer/Options/Audio.visible 

func _on_quit_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	$VBoxContainer/Options/Audio/VBoxContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$VBoxContainer/Options/Audio/VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$VBoxContainer/Options/Audio/VBoxContainer/EffectsSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_master_slider_mouse_exited() -> void:
	release_focus()

func _on_music_slider_mouse_exited() -> void:
	release_focus()

func _on_effects_slider_mouse_exited() -> void:
	release_focus()

func _on_apply_audio_settings_pressed() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($VBoxContainer/Options/Audio/VBoxContainer/MasterSlider.value))
	AudioServer.set_bus_volume_db(1, linear_to_db($VBoxContainer/Options/Audio/VBoxContainer/MusicSlider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db($VBoxContainer/Options/Audio/VBoxContainer/EffectsSlider.value))
	$VBoxContainer/Options/Audio.visible = false

func _on_effects_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db($VBoxContainer/Options/Audio/VBoxContainer/EffectsSlider.value))
	

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db($VBoxContainer/Options/Audio/VBoxContainer/MusicSlider.value))


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($VBoxContainer/Options/Audio/VBoxContainer/MasterSlider.value))


func _on_effects_slider_drag_started() -> void:
	$VBoxContainer/Options/Audio/VBoxContainer/EffectsSlider/SFX.play()


func _on_effects_slider_drag_ended(_value_changed: bool) -> void:
	$VBoxContainer/Options/Audio/VBoxContainer/EffectsSlider/SFX.play()
