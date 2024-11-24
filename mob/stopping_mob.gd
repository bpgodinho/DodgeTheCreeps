extends Mob

var velocity :Vector2
var tween

@onready var move_timer: Timer = $MoveTimer

func _ready() -> void:
	animated_sprite_2d.play("fly")


func spawn(spawn_pos: Vector2, spawn_rot: float) -> void:
	position = spawn_pos
	rotation = spawn_rot
	
	linear_velocity = Vector2(randf_range(300.0, 500.0), 0.0).rotated(spawn_rot)
	velocity = linear_velocity


func _on_move_timer_timeout() -> void:
	tween = create_tween()
	if linear_velocity == Vector2.ZERO:
		await tween.tween_property(self, "linear_velocity",velocity, 0.2)
		move_timer.wait_time = randf_range(1,3)
		move_timer.start()
	else:
		await tween.tween_property(self, "linear_velocity",Vector2.ZERO, 0.2)
		move_timer.wait_time = randf_range(0.5,1)
		move_timer.start()
