extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var ray_cast_x = $RayCastX
@onready var ray_cast_y = $RayCastY
@onready var health_component = $HealthComponent
@onready var hurtbox_component = $HurtboxComponent
@onready var audio_stream_player = $AudioStreamPlayer

var moving_left = true
var speed = 15
var gravity = 30


func _ready():
	health_component.died.connect(on_died)
	hurtbox_component.hit.connect(on_hit)


func _physics_process(delta):
	if health_component.is_died():
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


func on_hit(_hitbox: HitboxComponent):
	audio_stream_player.playing = true


func on_died():
	animation_player.play("Dead")
	await animation_player.animation_finished
	queue_free()
