extends Area2D

@onready var hunger = %HungerBar
var flys_consumed : int = 0
signal total_flys_consumed

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("consumed"):
		body.consumed()
		flys_consumed += 1
		hunger.value += 5
	


func _on_hunger_bar_hunger_depleted() -> void:
	total_flys_consumed.emit(flys_consumed)
