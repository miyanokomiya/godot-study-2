extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var ray_cast_x = $RayCastX
@onready var ray_cast_y = $RayCastY

var moving_left = true
var speed = 15
var gravity = 30
var health = 2


func _physics_process(delta):
	if health <= 0:
		return
	
	move()
	floor_detect()


func move():
	velocity.y = gravity
	if moving_left:
		velocity.x = speed
	else:
		velocity.x = -speed
	
	move_and_slide()


func floor_detect():
	if !ray_cast_y.is_colliding() && is_on_floor():
		moving_left = !moving_left
		scale.x *= -1
	elif ray_cast_x.is_colliding() && is_on_wall():
		moving_left = !moving_left
		scale.x *= -1


func _on_hitbox_area_entered(area):
	if area.name == "Sword":
		health -= 1
	
	if health <= 0:
		animation_player.play("Dead")
		await animation_player.animation_finished
		queue_free()
