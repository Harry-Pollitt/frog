extends Sprite2D
@onready var ray_cast = $RayCast2D
var distance : float = 160.0

signal caught(caught_position, collider)

func interpolate(length : float, duration : float = 0.2):
	var tween_offset = get_tree().create_tween()
	var tween_rect_h = get_tree().create_tween()
	
	tween_offset.tween_property(self, "offset", Vector2(0,length/2.0), duration)
	tween_rect_h.tween_property(self, "region_rect", Rect2(0,0,2, length), duration)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		interpolate(await check_collision(), 1.0)
		await get_tree().create_timer(0.5).timeout
		reverse_interpolate()

func reverse_interpolate():
	interpolate(0,0.75)

func check_collision():
	await get_tree().create_timer(0.1).timeout
	var collision_point
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		collision_point = ray_cast.get_collision_point()
		distance = (global_position - collision_point).length()
		caught.emit(collision_point, collider)
	else:
		distance = 160.0
	return distance


func _on_caught(caught_position: Vector2, collider : CharacterBody2D) -> void:
	if collider.has_method("got_caught"):
		collider.got_caught()
