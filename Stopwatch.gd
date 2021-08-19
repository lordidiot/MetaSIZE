extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var seconds : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	seconds += delta
	var time_string = "%02d:%02d" % [int(seconds) / 60, int(seconds) % 60]
	text = time_string
