extends Mob


func _ready() -> void:
	animated_sprite_2d.play("swim")


func spawn(spawn_pos: Vector2, spawn_rot: float) -> void:
	super(spawn_pos, spawn_rot)
	
	var wait_time := randf_range(1.5, 2)
	await get_tree().create_timer(wait_time).timeout
	
	animated_sprite_2d.rotate(PI/2)
	linear_velocity = linear_velocity.rotated(PI/2)
