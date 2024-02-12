class_name HotkeyRebindButton
extends Control

@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button

@export var action_name: String = "left"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	
func set_action_name():
	label.text = "Unassigned"
	
	match action_name:
		"left":
			label.text = "Strafe Left"
		"right":
			label.text = "Strafe Right"
		"jump":
			label.text = "Jump"
		"forward":
			label.text = "Move Forwards"
		"backward":
			label.text = "Move Backwards"
			
func set_text_for_key():
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode


func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press A Key"
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
				
		set_text_for_key() # Replace with function body.

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false
	
func rebind_action_key(event):

	var is_duplicate=false
	var action_event=event
	var action_keycode=OS.get_keycode_string(action_event.physical_keycode)
	for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name!=self.action_name:
				if i.button.text=="%s" %action_keycode:
					is_duplicate=true
					break
	if not is_duplicate:
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name,event)

		set_process_unhandled_key_input(false)
		set_text_for_key()
		set_action_name()
