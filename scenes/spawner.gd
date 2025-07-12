extends Node2D

var fly_scene := preload("res://scenes/Enemy.tscn")
var spawn_points : Array = []

func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var fly = fly_scene.instantiate()
	fly.position = spawn.position
	get_parent().add_child(fly)
