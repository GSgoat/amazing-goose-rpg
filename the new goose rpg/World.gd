extends Node2D


onready var level = load("res://levels/Level1.tscn")
onready var level_instance = level.instance()

var enemys = []

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(level_instance)
	load_level(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_level(level):
	"""All level scenes must be title: Level'number' ie: Level1, Level2. The functions perameter is what level the game will load."""
	level_instance.queue_free()
	level = load("res://levels/Level"+str(level)+".tscn")
	level_instance = level.instance()
	add_child(level_instance)
