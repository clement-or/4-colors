extends KinematicBody2D

const UP = Vector2(0,-1)

var motion = Vector2(0,0)
export var gravity = 20
export var y_speed = 500
export var x_speed = 500

func _ready():
	pass

func _physics_process(delta):
	check_controls()
	apply_gravity()
	
	display(String(motion))
	move_and_slide(motion, UP)
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
	if (Input.is_action_just_released("ui_up")):
		stop_jump()

func jump():
	motion.y = -y_speed

func stop_jump():
	if motion.y < 0.1*y_speed:
		motion.y = -0.5*y_speed

func apply_gravity():
	if (!is_on_floor()):
		motion.y += gravity
		
func display(text):
	$Test.text = text