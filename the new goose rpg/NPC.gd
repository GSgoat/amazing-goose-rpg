extends KinematicBody2D


var diolauge = "HIYA"

onready var image = load("res://icon.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().current_scene.get_node("Player/Collision").overlaps_area($popup):
		$attention.visible = true
	else:
		$attention.visible = false
	
	if get_tree().current_scene.get_node("Player/Collision").overlaps_area($Chat):
		get_tree().current_scene.get_node("UI/NPCdiolauge").show_diolauge(diolauge, image)
		
		
	if not get_tree().current_scene.get_node("Player/Collision").overlaps_area($popup):
		get_tree().current_scene.get_node("UI/NPCdiolauge").visible = false
		

		
