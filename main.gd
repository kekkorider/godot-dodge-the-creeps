extends Node

@export var mob_scene: PackedScene

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game() -> void:
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.show()
	$Player/CollisionShape2D.set_deferred("disabled", false)
	$Player.position = $StartPosition.position
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	$Music.play()

func _on_mob_timer_timeout() -> void:
	# Create a new instance of the mob scene
	var mob = mob_scene.instantiate()

	# Choose random location
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob direction to be perpendicular to the path
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob position
	mob.position = mob_spawn_location.position

	# Add randomness to the rotation
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Velocity
	var velocity = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn
	add_child(mob)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
