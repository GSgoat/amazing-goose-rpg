extends KinematicBody2D


var health = 10
var damage = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.enemys.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	get_tree().current_scene.enemys.erase(self)
	queue_free()
