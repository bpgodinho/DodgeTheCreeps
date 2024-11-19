extends Mob

@onready var fade_timer: Timer = $FadeTimer

var tween
var alpha := 1

func _ready() -> void:
	animated_sprite_2d.play("fly")



func _on_fade_timer_timeout() -> void:
	tween = create_tween()
	await tween.tween_property(animated_sprite_2d, "self_modulate", Color(1,1,1,!alpha), 0.2)
	alpha = !alpha
	fade_timer.wait_time = randf_range(0.4,0.8)
	fade_timer.start()
