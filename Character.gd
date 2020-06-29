extends KinematicBody2D

var velocity = Vector2(0, 0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.name == "StaticChar":
			_collided()
	if Input.is_action_pressed("ui_page_down"):
		velocity = Vector2(-1000, 0)
	pass

func _collided():
	$Icon.texture = null
