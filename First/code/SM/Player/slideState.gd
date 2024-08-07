extends PlayerState
# Export any states that have a transition to/from the new state
@export var land_state: PlayerState
@export var fall_state: PlayerState
@export var jump_state: PlayerState
@export var crouchIdle_state: PlayerState
@export var damaged_state: PlayerState

func enter():
	super()
	set_low_profile()
	isAbleToMove = false

func process_input(event) -> PlayerState:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	return null

func process_physics(delta) -> PlayerState:
	player_move(delta)
	if !parent.is_on_floor():
		set_high_profile()
		return fall_state
	return null

func process_frame(delta) -> PlayerState:
	if isHit:
		return damaged_state
	else:
		return null

func exit(next_state):
	isAbleToMove = true
	pass

func animation_finished(anim) -> PlayerState:
	if !isAbleToStand:
		return crouchIdle_state
	else:
		set_high_profile()
		return land_state
