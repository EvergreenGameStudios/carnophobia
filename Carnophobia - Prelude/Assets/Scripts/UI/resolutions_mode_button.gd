extends Control

@onready var option_button: OptionButton = $HBoxContainer/OptionButton

const RESOLUTION_DICTIONARY: Dictionary = {
	"1152 x 648": Vector2i(1152,648),
	"1280 x 720": Vector2i(1280,720),
	"1280 x 768": Vector2i(1280,768),
	"1920 x 1080": Vector2i(1920,1080)
}
var RESOLUTION_DICTIONARY_KEYS : Array = RESOLUTION_DICTIONARY.keys()
# Called when the node enters the scene tree for the first time.
func _ready():
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()
	select_current_window_mode()
	select_current_display_resolution()
func add_resolution_items():
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)
func on_resolution_selected(index:int):
	match index:
		0: #1152 x 648
			DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[0])
		1: #1280 x 720
			DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[1])
		2: #1280 x 768
			DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[2])
		3: #1920 x 1080
			DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[3])
func select_current_window_mode() -> void:
	var mode = DisplayServer.window_get_mode()
	var borderless = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	match mode:
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			if borderless:
				option_button.select(3)
			else:
				option_button.select(0)
		DisplayServer.WINDOW_MODE_WINDOWED:
			if borderless:
				option_button.select(2)
			else:
				option_button.select(1)
		_:
			pass
func select_current_display_resolution():
	var current_resolution = DisplayServer.window_get_size()
	var current_resolution_string = str(current_resolution.x) + "x" + str(current_resolution.y)
	var index = RESOLUTION_DICTIONARY_KEYS.find(current_resolution_string)
	option_button.select(index)
