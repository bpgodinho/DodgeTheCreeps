extends Node

@export var mob_scene: Array[PackedScene]
@export var powerup_scene: Array[PackedScene]

var score: int = 0
var increment: int = 1

@onready var mob_timer: Timer = %MobTimer
@onready var score_timer: Timer = %ScoreTimer
@onready var start_timer: Timer = %StartTimer
@onready var powerup_timer: Timer = %PowerupTimer
@onready var start_position: Marker2D = %StartPosition
@onready var player: Area2D = %Player
@onready var mob_spawn_location: PathFollow2D = %MobSpawnLocation
@onready var hud: HUD = %HUD
@onready var background_music: AudioStreamPlayer = %BackgroundMusic
@onready var game_over_music: AudioStreamPlayer = %GameOverMusic
@onready var pause_menu: CanvasLayer = %PauseMenu
@onready var sfx: AudioStreamPlayer = %Sfx

var playing: bool = false

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_P) && playing:
		pause_menu.show()
		get_tree().paused = true


func mute_sfx() -> void:
	sfx.volume_db = -80 if sfx.volume_db == 0 else 0


func mute_music() -> void:
	background_music.volume_db = -80 if background_music.volume_db == 0 else 0


func _on_player_hit() -> void:
	# Game Over
	game_over_music.play()
	hud.show_game_over()
	playing = false
	mob_timer.stop()
	score_timer.stop()
	powerup_timer.stop()
	background_music.stop()
	player.hide()
	player.collision_shape_2d.set_deferred("disabled", true)


func restart() -> void:
	playing = false
	mob_timer.stop()
	score_timer.stop()
	powerup_timer.stop()
	background_music.stop()
	player.hide()
	player.collision_shape_2d.set_deferred("disabled", true)
	new_game()

func new_game() -> void:
	playing = true
	score = 0
	player.start(start_position.position)
	start_timer.start()
	hud.update_score(score)
	hud.show_message("Get Ready")
	get_tree().call_group("mob", "queue_free")
	get_tree().call_group("powerup", "queue_free")
	background_music.play()


func _on_start_timer_timeout() -> void:
	mob_timer.start()
	score_timer.start()
	powerup_timer.start()


# Spawning Mobs
func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene
	var mob := mob_scene.pick_random().instantiate() as Mob
	
	# Choose a random location on Path2D
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the path direction
	var direction := mob_spawn_location.rotation_degrees + 90
	
	# Add the mob to the scene
	add_child(mob)
	mob.spawn(mob_spawn_location.position, direction)


func _on_score_timer_timeout() -> void:
	score += increment
	hud.update_score(score)


func _on_powerup_timer_timeout() -> void:
	#Create a new instance of the Powerup scene
	var powerup := powerup_scene.pick_random().instantiate() as BasePowerup
	add_child(powerup)
	powerup.spawn(Vector2(randf_range(64,416),randf_range(64,656)))


func _on_pause_menu_resume() -> void:
	playing = true
