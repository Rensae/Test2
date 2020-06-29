extends KinematicBody2D


var velocity = Vector2(0, 0)

func _ready():
	$Sprite.texture = load("res://Spells/Bullet.png")
	add_to_group("projectile")

func _physics_process(_delta):
	var _collision = move_and_slide(velocity)
	pass
