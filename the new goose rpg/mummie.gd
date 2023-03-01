extends KinematicBody2D


var health = 10
var damage = 5
var speed = 50

var can_hurt = true

var velocity = Vector2()

var frame = 0

onready var player = get_tree().current_scene.get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.enemys.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()
	if health < 0:
		die()
	velocity = move_and_slide(velocity)
	velocity = Vector2(0, 0)

func die():
	get_tree().current_scene.enemys.erase(self)
	queue_free()

func move():
	if player.position.y > position.y:
		velocity.y += speed
	if player.position.y < position.y:
		velocity.y -= speed
	if player.position.x > position.x:
		velocity.x += speed
	if player.position.x < position.x:
		velocity.y -= speed


func hurt(damage):
	health -= damage
	$"Damage cooldown".start()
	
func _on_Damage_cooldown_timeout():
	can_hurt = true
