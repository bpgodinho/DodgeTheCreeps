extends BasePowerup


# Called when the node enters the scene tree for the first time.
func effect() -> void:
	get_tree().call_group("mob", "queue_free")
	self.queue_free()
