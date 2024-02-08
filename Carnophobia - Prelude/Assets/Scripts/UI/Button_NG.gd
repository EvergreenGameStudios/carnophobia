extends Button

@export var devroom = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_tree().change_scene_to_file("res://Assets/Levels/level0-1.tscn")
	
	if devroom == 1:
		get_tree().change_scene_to_file("res://Assets/Levels/level_none_DEVROOM.tscn")
	
