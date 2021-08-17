extends Camera2D

onready var player = get_node("/root/MainScene/Player")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# tracks the player along the X axis
func _process (delta):
	position.x = player.position.x
