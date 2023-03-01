extends Node2D


onready var doors = [$Door1]


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(load("res://NPC.tscn").instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
