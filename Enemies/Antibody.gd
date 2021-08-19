extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed : int = 45
var direction : int = 1
var gravity : int = 800
var vel : Vector2 = Vector2()
var starting_pos : Vector2

const RANGE : int = 40
const Player = preload("res://Player.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	starting_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	vel.x = direction * speed
	vel = move_and_slide(vel, Vector2.UP)
	vel.y += gravity * delta
	
	if abs((position - starting_pos).x) >= RANGE:
		direction *= -1
		starting_pos = position
		
	var slide_count = get_slide_count()
	for i in slide_count:
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if collider is Player:
			var player : Player = collider
			player.take_antibody_damage()
	
