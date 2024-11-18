class_name Mob extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	#var mob_types := animated_sprite_2d.sprite_frames.get_animation_names() as Array
	#animated_sprite_2d.play(mob_types.pick_random())
	animated_sprite_2d.play("walk")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func spawn(spawn_pos: Vector2, spawn_rot: float) -> void:
	position = spawn_pos
	rotation = spawn_rot
	
	var velocity := Vector2(randf_range(150.0, 250.0), 0.0)
	linear_velocity = velocity.rotated(spawn_rot)
