extends Control

func _ready():
	$Overlay.fade_out()
	$Music/Anim.play("fade_in")

func _on_EasterEggTimer_timeout():
	$Music/Anim.play_backwards("fade_in")
	$Text/Label/Anim.play("easter")


func _on_Anim_animation_finished(anim_name):
	$Music2.play()