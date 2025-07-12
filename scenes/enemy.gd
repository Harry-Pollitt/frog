extends CharacterBody2D

@onready var mouth : Vector2 = get_node("../TongueOrigin").global_position
var caught_speed : float = 180.0
var is_caught : bool = false
var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)

# movement
var move_speed : float = 10
var move_direction : Vector2
var wander_time : float

func got_caught():
	print("Got Caught")
	is_caught = true

func _process(delta: float) -> void:
	if is_caught == true:
		await get_tree().create_timer(0.5).timeout
		#tween.tween_property(self, "global_position", mouth, 1)
		global_position = global_position.move_toward(mouth, caught_speed * delta)
	else:
		pass
		#random_movement()

func consumed():
	queue_free()

func random_movement():
	tween.tween_property(self, "global_position", Vector2(randf_range(-50, 350), randf_range(-45, 145)), 3)
