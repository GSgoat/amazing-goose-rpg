extends Camera2D


var follow_player = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if follow_player:
		position = get_parent().get_node("Player").position
	else:
		position = Vector2.ZERO
