extends KinematicBody2D

# components
onready var sprite = $Small
onready var collider = $SmallCollision

# signals
signal health_change(health)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health : int = 20
var stage : int = 0
var score : int = 0
var speed : int = 120
var jumpForce: int = 220
var gravity : int = 800
var vel : Vector2 = Vector2()
var grounded : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.visible = true
	collider.disabled = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	vel.x = 0
	
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
		
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		
	vel = move_and_slide(vel, Vector2.UP)
	vel.y += gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
		
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false

func change_stage(stage):
	sprite.visible = false
	collider.disabled = true
	if stage == 0:
		sprite = $Small
		collider = $SmallCollision
	elif stage == 1:
		sprite = $Medium
		collider = $MediumCollision
	else:
		sprite = $Large
		collider = $LargeCollision
	sprite.visible = true
	collider.disabled = false
		

func change_health(delta):
	health += delta
	var new_stage = -1
	if health < 33:
		new_stage = 0
	elif health < 66:
		new_stage = 1
	else:
		new_stage = 2
		
	if new_stage != stage:
		stage = new_stage
		change_stage(new_stage)
	
	if delta:
		emit_signal("health_change", health)
	
	

func _on_HealthTimer_timeout():
	change_health(1)
	pass # Replace with function body.
