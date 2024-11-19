class_name Powerup extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func effect() -> void:
	self.queue_free()


func spawn(spawn_pos: Vector2) -> void:
	position = spawn_pos
