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
var speed : int = 200
var jumpForce: int = 220
var gravity : int = 800
var vel : Vector2 = Vector2()
var grounded : bool = false

var damage_timer : float = 0

const STARTING_POS : Vector2 = Vector2(50, 75)
const SPEED_TINY : int = 200
const SPEED_MEDIUM : int = 140
const SPEED_BIG : int = 80

const DAMAGE_LASER : int = 10
const DAMAGE_ANTIBODY : int = 10
const DAMAGE_CHEMO : int = 5
const DAMAGE_COOLDOWN : int = 2


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

	if position.y > 250:
		position = STARTING_POS

	if damage_timer > 0:
		damage_timer -= delta
	if damage_timer < 0:
		damage_timer = 0

func change_stage(stage):
	sprite.visible = false
	collider.disabled = true
	if stage == 0:
		sprite = $Small
		collider = $SmallCollision
		speed = SPEED_TINY
	elif stage == 1:
		sprite = $Medium
		collider = $MediumCollision
		speed = SPEED_MEDIUM
	else:
		sprite = $Large
		collider = $LargeCollision
		speed = SPEED_BIG
	sprite.visible = true
	collider.disabled = false

func take_damage(damage):
	if health == 0:
		return

	if damage_timer <= 0:
		change_health(-damage)
		damage_timer = DAMAGE_COOLDOWN

func take_antibody_damage():
	take_damage(DAMAGE_ANTIBODY)

func take_laser_damage():
	take_damage(DAMAGE_LASER)

func take_chemo_damage():
	var taken_damage : bool = damage_timer <= 0
	take_damage(DAMAGE_CHEMO)
	return taken_damage

func change_health(delta):
	health += delta
	if health < 0:
		health = 0
	if health > 100:
		health = 100

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

func _on_Laser_area_entered(area):
	take_laser_damage()
	print("entered")


func _on_Laser_body_entered(body):
	pass # Replace with function body.
