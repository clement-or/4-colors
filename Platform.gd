extends StaticBody2D

# Nodes
onready var c = get_node("/root/Constants")
onready var hitbox = $CollisionShape2D

export(int, "RED", "GREEN", "BLUE", "YELLOW") var color

enum STATES {
	ENABLED
	DISABLED
	OVERLAPPED
}
var current_state = ENABLED

func _ready():
	if !color: 
		color = 0
	$ColorRect.color = c.COLORS[color]
	
	if c.COLORS[color] == c.COLORS[c.color_index]:
		disable()

func _physics_process(delta):
	if current_state == ENABLED:
		if is_bg_color(): disable()
	elif current_state == DISABLED:
		if !is_bg_color(): enable()
	elif current_state == OVERLAPPED:
		disable()
	print(current_state)

func is_bg_color():
	return c.COLORS[color] == c.COLORS[c.color_index]

func disable():
	if current_state == ENABLED:
		hitbox.disabled = true
		current_state = DISABLED

func enable():
	if current_state == DISABLED:
		hitbox.disabled = false
		current_state = ENABLED

func _on_overlap(body):
	current_state = OVERLAPPED

func _on_stop_overlap(body):
	current_state = DISABLED
