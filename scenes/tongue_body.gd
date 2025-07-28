extends Node2D

@onready var collision = $TongueCollision/CollisionShape2D
var distance : float = 190.0
@onready var can_shoot : bool = true
@onready var caught_fly : bool = false
var distance_to_fly : float

signal caught(caught_position, collider)

func interpolate(length : float, duration : float = 0.2):
	var tween_offset = get_tree().create_tween()
	var tween_rect_h = get_tree().create_tween()
	var tween_collision = get_tree().create_tween()
	tween_offset.tween_property($TongueBody, "offset", Vector2(0,length/3.0), duration)
	tween_rect_h.tween_property($TongueBody, "region_rect", Rect2(0,0,2, length), duration)
	tween_collision.tween_property($TongueCollision/CollisionShape2D, "shape:b", Vector2(0,length), duration)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") && can_shoot == true:
		look_at(get_global_mouse_position())
		set_process_input(false)
		if caught_fly == true:
			interpolate(distance_to_fly, 0.5)
			await get_tree().create_timer(0.3).timeout
			await reverse_interpolate()
			$Eating.play()
			set_process_input(true)
			collision.disabled = false
			caught_fly = false
		elif caught_fly == false:
			interpolate(distance, 0.5)
			await get_tree().create_timer(0.3).timeout
			reverse_interpolate()
			await get_tree().create_timer(0.5).timeout
			set_process_input(true)
			collision.disabled = false
	elif event.is_action_pressed("shoot") && can_shoot == false:
		return

func reverse_interpolate():
	collision.disabled = true
	interpolate(0,0.5)
	

func _on_caught(_caught_position: Vector2, collider : CharacterBody2D) -> void:
	if collider.has_method("got_caught"):
		collider.got_caught()


func _on_consume_twist() -> void:
	can_shoot = false

func _on_tongue_collision_body_entered(body: Node2D) -> void:
	var collision_point
	collision.disabled = true
	if body.has_method("got_caught"):
		collision_point = body.global_position
		distance_to_fly = (global_position - collision_point).length()
		caught.emit(collision_point, body)
		caught_fly = true
