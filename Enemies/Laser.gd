extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const Player = preload("res://Player.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Laser_body_entered(body):
	if body is Player:
		body.take_laser_damage()
