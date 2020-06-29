extends KinematicBody2D

var velocity = Vector2(0, 0)
signal stop_waiting
signal target_reached

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.name == "StaticEnn":
			_collided()
		if collision.collider.name == "StaticBody2D":
			emit_signal("stop_waiting")
		if collision.collider.is_in_group("projectile"):
			emit_signal("target_reached")
	if Input.is_action_pressed("ui_page_down"):
		velocity = Vector2(1000, 0)
	pass

func _collided():
	$Icon.texture = null
