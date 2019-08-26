extends StaticBody2D

# Nodes
onready var c = get_node("/root/Constants")
onready var hitbox = $CollisionShape2D

export(int, "RED", "GREEN", "BLUE", "YELLOW") var color

enum {
	ENABLED,
	DISABLED,
	OVERLAPPED,
}
var current_state

func _ready():
	
	if !color: color = 0
	$ColorRect.color = c.COLORS[color]
	
	if is_bg_color():
		disable()
	else: enable()

func _physics_process(delta):
	if current_state == ENABLED:
		if is_bg_color(): disable()
	elif current_state == DISABLED:
		if !is_bg_color(): enable()
	elif current_state == OVERLAPPED:
		overlap()

func is_bg_color():
	return c.COLORS[color] == c.COLORS[c.color_index]

func disable():
	if current_state != DISABLED:
		hitbox.set_deferred("disabled",true)
		$ColorRect.hide()
		current_state = DISABLED

func enable():
	if current_state != ENABLED:
		hitbox.set_deferred("disabled",false)
		current_state = ENABLED
		$ColorRect.show()

func overlap():
	if current_state == OVERLAPPED:
		hitbox.set_deferred("disabled",true)
		current_state = OVERLAPPED
		$ColorRect.show()

func _on_overlap(body):
	if body.get_name() == "Player":
		current_state = OVERLAPPED

func _on_stop_overlap(body):
	disable()
