extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var resume_button: Button = find_child("Button_Resume")
@onready var options_button: Button = find_child("Button_Options")
@onready var menuquit_button: Button = find_child("Button_QuitMenu")
@onready var desktopquit_button: Button = find_child("Button_QuitDesktop")
@onready var options_menu: options_menu = $Options
func _ready():
	handle_connecting_calls()
	
func handle_connecting_calls():
	resume_button.pressed.connect(unpause)
	options_button.pressed.connect(options_menu_pressed)
	desktopquit_button.pressed.connect(get_tree().quit)
	menuquit_button.pressed.connect(menuquit)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	
func unpause():
	animator.play("unpause")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func pause():
	animator.play("pause")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func menuquit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")

func options_menu_pressed():
	set_process(false)
	options_menu.visible = true
	options_menu.set_process(true)
	
func on_exit_options_menu():
	options_menu.set_process(false)
	options_menu.visible = false
	set_process(true)
