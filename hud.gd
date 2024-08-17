extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_score(score: int) -> void:
	$ScoreLabel.text = "Score: " + str(score)

func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over() -> void:
	show_message("Game Over")

	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps"
	$Message.show()

	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()


func _on_player_hit() -> void:
	show_game_over()
