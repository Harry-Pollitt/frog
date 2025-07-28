extends Area2D

@onready var messages = %Messages
@onready var frog_sprite = %FrogSprite
@onready var hunger = %HungerBar
@onready var score_label = %Score

var flys_consumed : int = 0
var hunger_value : int
signal total_flys_consumed(flys_consumed : int)
signal twist
# attached to hunger bar
signal growth_phase1
signal growth_phase2
signal phase1_msg
signal phase2_msg

func _ready() -> void:
	messages.visible = true
	messages.text = "Consume flies \nto grow and lay eggs!"
	await get_tree().create_timer(2).timeout
	messages.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("consumed"):
		$Eat.pitch_scale = randf_range(0.9, 1.1)
		$Eat.play()
		hunger_value = body.consumed()
		flys_consumed += 1
		hunger.value += hunger_value
	
func _process(_delta: float) -> void:
	score_label.text = str(flys_consumed)
		
	if flys_consumed == 10:
		messages.visible = true
		messages.text = "Keep on eating \nto get ready\n to spawn!"
		await get_tree().create_timer(2).timeout
		messages.visible = false
		frog_sprite.scale = Vector2(1,1)
		#tongue_sprite.scale = Vector2(3,2)
		growth_phase1.emit()
		
	if flys_consumed == 30:
		messages.visible = true
		messages.text = "Almost \nthere!"
		await get_tree().create_timer(2).timeout
		messages.visible = false
		frog_sprite.scale = Vector2(2,2)
		#tongue_sprite.scale = Vector2(4,2)
		growth_phase2.emit()
	if flys_consumed == 40:
		twist.emit()
		self.set_process(false)

func _on_hunger_bar_hunger_depleted() -> void:
	total_flys_consumed.emit(flys_consumed)
