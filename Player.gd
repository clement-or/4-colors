extends KinematicBody2D

const UP = Vector2(0,-1)

var motion = Vector2(0,0)
export var gravity = 20
export var y_speed = 700
export var x_speed = 500

var is_dead = false

signal color_changed
signal is_dead

enum {RED, GREEN, BLUE, YELLOW}
enum {RUN, IDLE, JUMP, FALL, DIE}
var current_color = RED
var current_state = IDLE

onready var sfx = {
	"jump": $SFX/Jump,
	"change_color": $SFX/ChangeColor,
	"change_level": $SFX/ChangeLevel,
	"lose": $SFX/Lose
	}

func _ready():
	pass

func _physics_process(delta):
	if !is_dead:
		check_controls()
	set_animation()
	apply_gravity()
	motion = move_and_slide(motion, UP)
	pass

func check_controls():
	# Horizontal input
	if is_on_floor(): current_state = IDLE
	if (Input.is_action_pressed("ui_right")):
		motion.x += x_speed/3
		$AnimatedSprite.flip_h = false
		if is_on_floor(): current_state = RUN
	elif (Input.is_action_pressed("ui_left")):
		motion.x -= x_speed/3
		$AnimatedSprite.flip_h = true
		if is_on_floor(): current_state = RUN
	elif motion.x != 0 && !(Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left")):
		if motion.x > 0: motion.x -= x_speed/10
		else: motion.x += x_speed/10
	motion.x = clamp(motion.x, -x_speed, x_speed)
	
	# Vertical input
	if (Input.is_action_pressed("ui_up") && is_on_floor()):
		jump()
		play_sound("jump")
	if (Input.is_action_just_released("ui_up")):
		stop_jump()
		
	# Color change
	if (Input.is_action_just_pressed("ui_select")):
		current_color = (current_color+1)%4
		play_sound("change_color")
		emit_signal("color_changed")
	
	# States and tweaks
	if motion.y > 100:
		current_state = FALL 
	if Input.is_action_just_released("ui_left") || Input.is_action_just_released("ui_right"):
		current_state = IDLE

func jump():
	current_state = JUMP
	motion.y = -y_speed

func stop_jump():
	if motion.y < 0:
		motion.y += -0.5*motion.y
		current_state = FALL

func apply_gravity():
	motion.y += gravity
	
func die():
	current_state = DIE
	is_dead = true
	motion = Vector2(0,0)
	play_sound("lose")
	$RestartTimer.start()
	
func play_sound(sound):
	sfx[sound].play()

func restart_level():
	emit_signal("is_dead")

func set_animation():
	if current_state == DIE:
		$AnimatedSprite.animation = "die"
		
	elif current_color == RED:
		if current_state == IDLE:
			$AnimatedSprite.animation = "r_idle"
		elif current_state == RUN:
			$AnimatedSprite.animation = "r_run"
		elif current_state == JUMP:
			$AnimatedSprite.animation = "r_jump"
		elif current_state == FALL:
			$AnimatedSprite.animation = "r_fall"
			
	elif current_color == GREEN:
		if current_state == IDLE:
			$AnimatedSprite.animation = "g_idle"
		elif current_state == RUN:
			$AnimatedSprite.animation = "g_run"
		elif current_state == JUMP:
			$AnimatedSprite.animation = "g_jump"
		elif current_state == FALL:
			$AnimatedSprite.animation = "g_fall"
			
	elif current_color == BLUE:
		if current_state == IDLE:
			$AnimatedSprite.animation = "b_idle"
		elif current_state == RUN:
			$AnimatedSprite.animation = "b_run"
		elif current_state == JUMP:
			$AnimatedSprite.animation = "b_jump"
		elif current_state == FALL:
			$AnimatedSprite.animation = "b_fall"
			
	elif current_color == YELLOW:
		if current_state == IDLE:
			$AnimatedSprite.animation = "y_idle"
		elif current_state == RUN:
			$AnimatedSprite.animation = "y_run"
		elif current_state == JUMP:
			$AnimatedSprite.animation = "y_jump"
		elif current_state == FALL:
			$AnimatedSprite.animation = "y_fall"