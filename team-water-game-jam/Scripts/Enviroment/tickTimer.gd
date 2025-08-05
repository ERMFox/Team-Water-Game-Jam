extends Timer

signal tick

func _ready() -> void:
	wait_time = 0.5
	autostart = true
	one_shot = false
	self.connect("timeout", Callable(self, "_on_timeout"))

func _on_timeout() -> void:
	emit_signal("tick")
