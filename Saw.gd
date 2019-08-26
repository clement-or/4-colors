extends Area2D

# Nodes
onready var c = get_node("/root/Constants")
onready var hitbox = $Hitbox

export(int, "RED", "GREEN", "BLUE", "YELLOW", "WHITE") var color
enum {RED, GREEN, BLUE, YELLOW, WHITE}

enum {
	ENABLED
	DISABLED
}
var current_state = ENABLED

func _ready():
	if !color: color = RED
	set_color(color)
	if is_bg_color():
		disable()

func _physics_process(delta):
	if current_state == ENABLED:
		if is_bg_color(): disable()
	elif current_state == DISABLED:
		if !is_bg_color(): enable()

func is_bg_color():
	if color == 4: return false
	return c.COLORS[color] == c.COLORS[c.color_index]

func disable():
	if current_state == ENABLED:
		hitbox.disabled = true
		current_state = DISABLED

func enable():
	if current_state == DISABLED:
		hitbox.disabled = false
		current_state = ENABLED

func _on_Saw_body_entered(body):
	if body.get_name() == "Player" && !body.is_dead:
		$Audio.play()
		body.die()

func set_color(c):
	color = c
	$AnimatedSprite.animation = String(c)
