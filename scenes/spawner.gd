extends Node2D

var fly_scene := preload("res://scenes/enemies/Enemy.tscn")
var firefly_scene := preload("res://scenes/enemies/fire_fly.tscn")
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
	


func _on_fire_fly_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var fire_fly = firefly_scene.instantiate()
	fire_fly.position = spawn.position
	get_parent().add_child(fire_fly)
