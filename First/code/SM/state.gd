class_name State
extends Node

var parent: PlayerClass
@export var animation_name_left: String
@export var animation_name_right: String
static var move_speed: float = 200
static var direction = 0.0
static var isPointingLeft = false
static var isCrouching = false
static var isAbleToStand = true
static var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#static var lookAtMaxTime = 0.2
#static var cameraMaxPan = 64
#static var lookAtTimer = 0.0
#static var panSpeed = 0.08
#static var isLookingUp = false
#static var isLookingDown = false

func enter() -> void:
	#print(self)
	if isPointingLeft:
		parent.animated_sprite.play(animation_name_left)
	else:
		parent.animated_sprite.play(animation_name_right)

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func exit(next_state: State) -> void:
	pass

func finish_animation_signal() -> State:
	return null

func player_move(delta: float) -> void:
	direction = Input.get_axis("leftInput","rightInput") * move_speed
	parent.velocity.y += gravity * delta
	parent.velocity.x = direction
	if direction > 0:
		isPointingLeft = false
	elif direction < 0:
		isPointingLeft = true
	parent.move_and_slide()
func is_input_left() -> bool:
	return Input.is_action_just_pressed("leftInput") or (Input.is_action_pressed("leftInput") and !Input.is_action_pressed("rightInput"))
func is_input_right() -> bool:
	return Input.is_action_just_pressed("rightInput") or (Input.is_action_pressed("rightInput") and !Input.is_action_pressed("leftInput"))
