extends MenuButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if Input.is_action_just_pressed("menu"):
		Input.MOUSE_MODE_VISIBLE # Replace with function body.
