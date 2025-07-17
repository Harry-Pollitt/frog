extends ProgressBar

@onready var messages = %Messages

var hunger_counter : int = 0
signal hunger_depleted 

func _on_timer_timeout() -> void:
	hunger_counter += 1
	if hunger_counter in range(0,30):
		self.value -= 3
	elif hunger_counter in range(30,60):
		self.value -= 7
	elif hunger_counter > 60:
		self.value -= 10
	if self.value == 0:
		hunger_depleted.emit()

func _process(_delta: float) -> void:
	if hunger_counter == 30:
		messages.visible = true
		messages.text = "I'm getting \nhungier!"
		await get_tree().create_timer(2).timeout
		messages.visible = false
	if hunger_counter == 60:
		messages.visible = true
		messages.text = "Hungry..."
		await get_tree().create_timer(2).timeout
		messages.visible = false
