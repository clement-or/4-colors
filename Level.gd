extends Node

# Nodes
onready var bg = $Background
onready var fg = $Foreground
onready var c = get_node("/root/Constants")

signal level_finished
signal level_restarted

func _ready():
	$Player.connect("is_dead", self, "restart")
	c.color_index=3
	change_bg_color()

# Connected to color_changed signal
func change_bg_color():
	# Color change
	c.color_index = (c.color_index+1)%4
	bg.color = c.COLORS[c.color_index]
	$Player/Sprite.get_material().set_shader_param("c_background", bg.color)
	$Player/AnimatedSprite.get_material().set_shader_param("c_background", bg.color)

func end_level(body):
	if body.get_name() == "Player":
		$LevelContent/LevelEnd/Audio.play()
		emit_signal("level_finished")

func restart():
	emit_signal("level_restarted")