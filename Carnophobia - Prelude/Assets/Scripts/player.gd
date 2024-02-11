extends CharacterBody3D


@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@onready var anim_player = $AnimationPlayer	
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera = $Camera3D
@onready var hitbox = $Camera3D/weapon_pivot/weapon_mesh/Hitbox

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
		camera.rotate_x(-event.relative.y * 0.005)
		camera.rotation.x = clamp(camera.rotation.x, -(PI/4), (PI/4))
	if event.is_action_pressed("menu"):
		$pause_menu.pause()
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
func _process(delta):
	if Input.is_action_just_pressed("attack") and not anim_player.current_animation == "bs_attack":
		anim_player.stop()
		anim_player.play("bs_attack")
		hitbox.monitoring = true
		
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "bs_attack":
		anim_player.play("bs_idle")
		hitbox.monitoring = false


func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		print("HIT")
