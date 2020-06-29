extends Control

signal finished

onready var Enn1 = $"../../Enn1"

func _ready():
	$"VBoxContainer/Attack".connect("pressed", self, "_on_Attack_pressed")

func _on_Attack_pressed():
	if Enn1.death == false:
		Enn1.active_selection += 1
		yield(Enn1, "chosed")
		emit_signal("finished")
