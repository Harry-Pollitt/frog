extends ProgressBar

@onready var frog_sprite = %FrogSprite

var hunger_counter : int = 0
signal hunger_depleted 

func _on_timer_timeout() -> void:
	hunger_counter += 1
	if hunger_counter in range(0,30):
		self.value -= 3
	elif hunger_counter in range(30,60):
		self.value -= 5
		frog_sprite.scale = Vector2(4,4)
	elif hunger_counter > 60:
		self.value -= 7
		frog_sprite.scale = Vector2(6,6)
	elif self.value == 0:
		hunger_depleted.emit()
