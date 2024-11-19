extends Mob

var velocity :Vector2

func _ready() -> void:
	animated_sprite_2d.play("fly")


func spawn(spawn_pos: Vector2, spawn_rot: float) -> void:
	super(spawn_pos, spawn_rot)
	velocity = linear_velocity


func _on_move_timer_timeout() -> void:
	if linear_velocity == Vector2.ZERO:
		linear_velocity = velocity
	else:
		linear_velocity = Vector2.ZERO
