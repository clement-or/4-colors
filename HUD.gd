extends Control

func _ready():
	pass

func set_level_counter(current, the_max):
	$LevelCounter.text = String(current) + "/" + String(the_max)
