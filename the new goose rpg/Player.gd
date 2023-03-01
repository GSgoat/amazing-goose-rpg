extends KinematicBody2D


var velocity = Vector2()
var speed = 25000
var health = 40
var max_health = 40
var strength = 4
var dash_time = 20

var dashing = false
var can_hurt = true
var can_use_item = true

onready var selected_item = $"AnimatedSprite/Arm joint/Sprite/Sword"
var facing = "right"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inputs()
	player_UI()
	new_level()
	hurt()
	regen(0.01)
	animation()
	use_item()

	velocity = move_and_slide(velocity*delta)
	velocity = Vector2(0, 0)
	
func inputs():
	if Input.is_action_pressed("up"):
		velocity.y -= speed
	if Input.is_action_pressed("down"):
		velocity.y += speed
	if Input.is_action_pressed("left"):
		facing = "left"
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		facing = "right"
		velocity.x += speed
		
func player_UI():
	$Healthbar/health.rect_size.x = health


func new_level():
	for door in get_parent().level_instance.doors:
		if $Collision.overlaps_area(door):
			get_parent().load_level(door.trans_data["Level"])
			position = door.trans_data["position"]


func hurt():
	if can_hurt:
		for enemy in get_parent().enemys:
			if $Collision.overlaps_body(enemy):
				can_hurt = false
				$"Damage cooldown".start()
				health -= enemy.damage
			if $"AnimatedSprite/Arm joint/Sprite/Sword/Area2D".overlaps_body(enemy) and enemy.can_hurt:
				enemy.hurt(strength)
				
	
				
				
	if health < 0:
		game_over()
				

func animation():
	$"AnimatedSprite/Arm joint".look_at(get_global_mouse_position())
	if facing == "right":
		$AnimatedSprite.flip_h = false
		$"AnimatedSprite/Arm joint/Sprite".flip_v = true
		$"AnimatedSprite/Arm joint/Sprite".flip_h = false
		$"AnimatedSprite/Arm joint".position = Vector2(48, -6)
		$"AnimatedSprite/Arm joint/Sprite/Sword".position.y = 180
	else:
		$AnimatedSprite.flip_h = true
		$"AnimatedSprite/Arm joint/Sprite".flip_v = false
		$"AnimatedSprite/Arm joint/Sprite".flip_h = false
		$"AnimatedSprite/Arm joint".position = Vector2(-48, -6)
		$"AnimatedSprite/Arm joint/Sprite/Sword".position.y = 0
	if not velocity.x == 0 or not velocity.y == 0:
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("default")
	
func regen(regen_rate):
	if health < max_health:
		health += regen_rate
	if health > max_health:
		health = max_health	
			
			
func use_item():
	if Input.is_action_just_pressed("select") and can_use_item:
		can_use_item = false
		selected_item.visible = true
		$"Item use time".start()
		
	
func game_over():
	print("Game over >:D")
	
func _on_Damage_cooldown_timeout():
	can_hurt = true



func _on_Item_cooldown_timeout():
	can_use_item = true
	$"Item cooldown".stop()


func _on_Item_use_time_timeout():
	selected_item.visible = false
	$"Item cooldown".start()
	$"Item use time".stop()
