extends CharacterBody2D

@onready var mouth : Vector2 = get_node("../TongueOrigin").global_position
var caught_speed : float = 300.0
@onready var is_caught : bool = false
@onready var can_move : bool = true
# movement
var move_speed : int = randi_range(100,140)
var target_position: Vector2
@export var hunger_value : int = 10

func _ready() -> void:
	pick_new_target()

func got_caught():
	is_caught = true

func _physics_process(delta: float) -> void:
	if can_move == true:
		global_position = global_position.move_toward(target_position, move_speed * delta)
		if global_position.distance_to(target_position) < 5.0:
			target_position = pick_new_target()
			await get_tree().create_timer(0.3).timeout
	if is_caught == true:
		can_move = false
		await get_tree().create_timer(0.3).timeout
		global_position = global_position.move_toward(mouth, caught_speed * delta)
	

func consumed():
	queue_free()
	return hunger_value

func pick_new_target():
	target_position = Vector2(randi_range(-50, 350), randi_range(-45, 145))
	can_move = true
	return target_position
	
