extends CharacterBody2D
class_name Player

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var health_component = $HealthComponent

enum PlayerStates {MOVE, ATTACK, HURT, DEAD}
var current_state = PlayerStates.MOVE
var speed = 120.0
var gravity = 20.0
var jump_speed = 400
var jump_remained = 2
var last_movement = 1.0


func _ready():
	health_component.health_decreased.connect(on_health_decreased)
	health_component.died.connect(on_died)
	Globals.player_lives = health_component.max_health


func _physics_process(delta):
	match current_state:
		PlayerStates.MOVE:
			move(delta)
		PlayerStates.ATTACK:
			attack(delta)
		PlayerStates.DEAD:
			dead()
			return
	
	velocity.y += gravity
	move_and_slide()


func move(delta: float) -> void:
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement != 0.0:
		if movement > 0.0:
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100, speed)
			animation_player.play("Walk")
		
		if movement < 0.0:
			velocity.x -= speed * delta
			velocity.x = clamp(speed, -100, -speed)
			animation_player.play("Walk")
		
		if last_movement * movement < 0:
			scale.x = -1
	
		last_movement = movement
	
	if movement == 0.0:
		velocity.x = 0.0
		animation_player.play("Idle")
	
	if is_on_floor() && Input.is_action_just_pressed("ui_jump"):
		jump()
		jump_remained -= 1
	elif !is_on_floor() && Input.is_action_just_pressed("ui_jump") && jump_remained >= 1:
		jump()
		jump_remained -= 1
	elif is_on_floor():
		jump_remained = 2
	
	if !is_on_floor():
		if velocity.y > 10:
			animation_player.play("Fall")
		else:
			animation_player.play("Jump")
	
	if Input.is_action_just_pressed("ui_sword"):
		current_state = PlayerStates.ATTACK


func jump():
	velocity.y = -jump_speed


func attack(delta: float):
	velocity.x = lerp(velocity.x, 0.0, 10 * delta)
	animation_player.play("Sword")


func dead():
	animation_player.play("Death")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	Globals.player_lives = health_component.max_health
	on_state_finished()


func on_state_finished():
	current_state = PlayerStates.MOVE


func on_health_decreased(diff: float):
	Globals.player_damage(-diff)


func on_died():
	current_state = PlayerStates.DEAD
