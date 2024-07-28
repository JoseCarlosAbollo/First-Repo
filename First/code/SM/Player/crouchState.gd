extends PlayerState
# Export any states that have a transition to/from the new state
@export var crouchIdle_state: PlayerState
@export var jump_state: PlayerState
@export var run_state: PlayerState
@export var fall_state: PlayerState
@export var damaged_state: PlayerState

@export var speed_multiplier: float = 0.5
@onready var original_speed: float = baseSpeed

func enter():
	super()
	set_low_profile()
	baseSpeed *= speed_multiplier

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput") and isAbleToStand:
		return run_state
	return null

func process_physics(delta) -> PlayerState:
	player_move(delta)
	if inputSpeed == 0:
		return crouchIdle_state
	if !parent.is_on_floor():
		return fall_state
	return null

func process_frame(delta) -> PlayerState:
	if isHit:
		return damaged_state
	else:
		return null

func exit(next_state):
	if(next_state != crouchIdle_state):
		set_high_profile()
	if(next_state == fall_state):
		isInCoyoteTime = true
		parent.coyote_timer.start()
	baseSpeed = original_speed

func _on_area_to_stand_body_entered(area):
	isAbleToStand = false

func _on_area_to_stand_body_exited(area):
	isAbleToStand = true
