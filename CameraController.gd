extends Camera2D

onready var player = get_parent()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# tracks the player along the X axis
func _process (delta):
	pass
	#position.x = player.position.x


func _on_Player_health_change(health):
	$HUD/HealthProgress.value = health
	pass # Replace with function body.
