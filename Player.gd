extends KinematicBody2D

const UP = Vector2(0,-1)

var motion = Vector2(0,0)
export var gravity = 20
export var y_speed = 600
export var x_speed = 500

var is_dead = false

signal color_changed

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
	apply_gravity()
	motion = move_and_slide(motion, UP)
	pass

func check_controls():
	# Horizontal input
	if (Input.is_action_pressed("ui_right")):
		motion.x += x_speed/3
	elif (Input.is_action_pressed("ui_left")):
		motion.x -= x_speed/3
	elif (Input.is_action_just_released("ui_left") || Input.is_action_just_released("ui_right")):
		motion.x = 0
	motion.x = clamp(motion.x, -x_speed, x_speed)
	
	# Vertical input
	if (Input.is_action_pressed("ui_up") && is_on_floor()):
		jump()
		play_sound("jump")
	if (Input.is_action_just_released("ui_up")):
		stop_jump()
		
	# Color change
	if (Input.is_action_just_pressed("ui_select")):
		play_sound("change_color")
		emit_signal("color_changed")

func jump():
	motion.y = -y_speed

func stop_jump():
	if motion.y < 0.2*y_speed:
		motion.y = -0.2*y_speed

func apply_gravity():
	motion.y += gravity
	
func die():
	is_dead = true
	play_sound("lose")
	$RestartTimer.start()
	

func play_sound(sound):
	sfx[sound].play()

func restart_level():
	get_tree().reload_current_scene()
