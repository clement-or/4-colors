extends Control

func _ready():
	$Overlay.fade_out()
	$Music/Anim.play("fade_in")

func _on_EasterEggTimer_timeout():
	$Text/Label.text = "What are you waiting\n for ? An easter egg ?"
	$Music/Anim.play_backwards("fade_in")
