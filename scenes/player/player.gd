extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var speed = 200.0
var gravity = 20.0
var jump_speed = 400


func _physics_process(delta):
	move(delta)
	
	velocity.y += gravity
	move_and_slide()


func move(delta: float) -> void:
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement != 0.0:
		if movement > 0.0:
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100, speed)
			sprite_2d.flip_h = false
			animation_player.play("Walk")
		
		if movement < 0.0:
			velocity.x -= speed * delta
			velocity.x = clamp(speed, -100, -speed)
			sprite_2d.flip_h = true
			animation_player.play("Walk")
	
	if movement == 0.0:
		velocity.x = 0.0
		animation_player.play("Idle")
	
	
	if is_on_floor() && Input.is_action_just_pressed("ui_jump"):
		jump()
	
	if !is_on_floor():
		if velocity.y > 10:
			animation_player.play("Fall")
		else:
			animation_player.play("Jump")


func jump():
	velocity.y = -jump_speed
