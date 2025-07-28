extends ProgressBar

# for updating and displaying messags on screen
@onready var messages = %Messages

@export_category("hunger_mechanic")
@export var hunger_rate : int = 1
@export var hunger_rate_phase1 : int = 3
@export var hunger_rate_phase2 : int = 5

# score system
var hunger_counter : int = 0
signal hunger_depleted 

func _on_timer_timeout() -> void:
	self.value -= hunger_rate
	hunger_counter += 1
	if self.value == 0:
		hunger_depleted.emit()

func _process(_delta: float) -> void:
	if hunger_rate == hunger_rate_phase1:
		await _on_consume_growth_phase_1()
		messages.visible = true
		messages.text = "I'm getting \nhungier!"
		await get_tree().create_timer(2).timeout
		messages.visible = false
	if hunger_rate == hunger_rate_phase2:
		await _on_consume_growth_phase_2()
		messages.visible = true
		messages.text = "Hungry..."
		await get_tree().create_timer(2).timeout
		messages.visible = false


func _on_consume_growth_phase_1() -> void:
	hunger_rate = hunger_rate_phase1

func _on_consume_growth_phase_2() -> void:
	hunger_rate = hunger_rate_phase2
