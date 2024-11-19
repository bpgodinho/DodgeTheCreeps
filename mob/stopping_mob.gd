extends Mob

var velocity :Vector2
var tween

@onready var move_timer: Timer = $MoveTimer

func _ready() -> void:
	animated_sprite_2d.play("fly")


func spawn(spawn_pos: Vector2, spawn_rot: float) -> void:
	super(spawn_pos, spawn_rot)
	velocity = linear_velocity


func _on_move_timer_timeout() -> void:
	tween = create_tween()
	if linear_velocity == Vector2.ZERO:
		await tween.tween_property(self, "linear_velocity",velocity, 0.4)
		move_timer.wait_time = randf_range(1,3)
		move_timer.start()
	else:
		await tween.tween_property(self, "linear_velocity",Vector2.ZERO, 0.4)
		move_timer.wait_time = randf_range(0.5,1)
		move_timer.start()
