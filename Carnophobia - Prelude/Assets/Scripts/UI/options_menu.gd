class_name options_menu
extends Control



@onready var Button_Exit: Button = find_child("Button_Exit")

signal exit_options_menu
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	handle_signal_calls()

func handle_signal_calls():
	Button_Exit.pressed.connect(Button_Exit_Pressed)

func Button_Exit_Pressed():
	exit_options_menu.emit()
	set_process(false)
