class_name State
extends Node

var parent: PlayerClass
@export var animation_name_left: String
@export var animation_name_right: String
@export var move_speed: float = 200
@export var jump_speed: float = -300
@export var crouchSpeed = 1.0
@export var lookAtMaxTime = 0.2
@export var cameraMaxPan = 64
static var direction = 0.0
static var isPointingLeft = false
static var isCrouching = false
static var lookAtTimer = 0.0
static var panSpeed = 0.08
static var isLookingUp = false
static var isLookingDown = false
static var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter() -> void:
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

func exit() -> void:
	pass

func player_move() -> void:
	direction = Input.get_axis("left","right") * move_speed
	parent.velocity.x = direction
	parent.move_and_slide()
func is_input_left(event: InputEvent) -> bool:
	return event.is_action("left") or Input.is_action_just_pressed("left") or (Input.is_action_pressed("left") and Input.is_action_just_released("right"))
func is_input_right(event: InputEvent) -> bool:
	return event.is_action("right") or Input.is_action_just_pressed("right") or (Input.is_action_pressed("right") and Input.is_action_just_released("left"))
