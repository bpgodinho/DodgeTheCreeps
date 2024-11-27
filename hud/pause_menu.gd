extends CanvasLayer

signal restart
signal resume
signal mute_music
signal mute_audio

@onready var countdown_control: Control = $CountdownControl
@onready var countdown: Label = $CountdownControl/Countdown
@onready var control: Control = $Control

var tween: Tween

func _on_resume_pressed() -> void:
	control.hide()
	countdown_control.show()
	for i in range(3,0,-1):
		tween = create_tween()
		countdown.text = str(i)
		tween.tween_property(countdown_control,"scale",Vector2(1,1),1).from(Vector2(0,0))
		tween.parallel().tween_property(countdown_control,"modulate",Color(1,1,1,0),1).from(Color(1,1,1,1))
		await get_tree().create_timer(1).timeout
	get_tree().paused = false
	countdown_control.hide()
	control.show()
	self.hide()



func _on_restart_pressed() -> void:
	get_tree().paused = false
	self.hide()
	restart.emit()



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_music_pressed() -> void:
	mute_music.emit()


func _on_sfx_pressed() -> void:
	mute_audio.emit()
