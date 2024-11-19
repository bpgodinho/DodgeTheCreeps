extends BasePowerup

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func effect() -> void:
	print("entered")
	collision_shape_2d.set_deferred("disabled", true)
	modulate = Color(1,1,1,0)
	get_tree().get_root().get_child(0).increment += 1
	print(get_tree().get_root().get_child(0).increment)
	await get_tree().create_timer(10).timeout
	print("time out")
	get_tree().get_root().get_child(0).increment -= 1
	self.queue_free()
