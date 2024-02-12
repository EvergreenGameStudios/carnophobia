extends Control

@export var devroom = false
@onready var play: Button = find_child("Play")
@onready var options: Button = find_child("Options")
@onready var quit: Button = find_child("Quit")
@onready var options_menu: options_menu = $Options
@onready var label: Label = $Label
@onready var vbox: VBoxContainer = $VBoxContainer
@onready var animator: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()
	
func handle_connecting_signals():
	quit.pressed.connect(get_tree().quit)
	play.pressed.connect(play_pressed)
	options.pressed.connect(options_menu_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)	
func play_pressed():
	get_tree().change_scene_to_file("res://Assets/Levels/level_none_DEVROOM.tscn") #change to 1st level when we develop it
	if devroom == true:
		pass

func options_menu_pressed():
	label.visible = false
	vbox.visible = false
	set_process(false)
	animator.play("options_mm_open")
	options_menu.visible = true
	options_menu.set_process(true)
	
func on_exit_options_menu():
	animator.play("options_mm_close")
	options_menu.set_process(false)
	options_menu.visible = false
	label.visible = true
	vbox.visible = true
	set_process(true)
