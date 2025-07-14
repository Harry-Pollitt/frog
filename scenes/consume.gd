extends Area2D

@onready var messages = %Messages
@onready var frog_sprite = %FrogSprite
@onready var hunger = %HungerBar
@onready var score_label = %Score
var flys_consumed : int = 0
signal total_flys_consumed(flys_consumed : int)
signal twist

func _ready() -> void:
	messages.visible = true
	messages.text = "Consume flies \nto grow!"
	await get_tree().create_timer(2).timeout
	messages.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("consumed"):
		body.consumed()
		flys_consumed += 1
		hunger.value += 5
	
func _process(delta: float) -> void:
	score_label.text = str(flys_consumed)
	if flys_consumed in range(10, 29):
		frog_sprite.scale = Vector2(4,4)
	elif flys_consumed > 30:
		frog_sprite.scale = Vector2(6,6)
	if flys_consumed == 10:
		messages.visible = true
		messages.text = "Keep on growing \nto spawn!"
		await get_tree().create_timer(2).timeout
		messages.visible = false
	if flys_consumed == 30:
		messages.visible = true
		messages.text = "Almost \nthere!"
		await get_tree().create_timer(2).timeout
		messages.visible = false
	if flys_consumed == 45:
		twist.emit()

func _on_hunger_bar_hunger_depleted() -> void:
	print("hunger bar score signal")
	print(flys_consumed)
	total_flys_consumed.emit(flys_consumed)
