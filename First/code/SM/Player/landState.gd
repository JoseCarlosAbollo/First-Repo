extends PlayerState
# Export any states that have a transition to/from the new state
@export var idle_state: PlayerState
@export var run_state: PlayerState
@export var jump_state: PlayerState
@export var crouchIdle_state: PlayerState
@export var fall_state: PlayerState
@export var attack_state: PlayerState
@export var damaged_state: PlayerState

func enter():
	super()
	isAbleToDoubleJump = true

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput"):
		return crouchIdle_state
	if isAbleToAttack and Input.is_action_just_pressed("attackInput"):
		return attack_state
	return null

func process_physics(delta) -> PlayerState:
	if parent.is_on_floor():
		if is_input_left():
			isPointingLeft = true
			return run_state
		elif is_input_right():
			isPointingLeft = false
			return run_state
	else:
		return fall_state
	player_move(delta)
	return null

func process_frame(delta) -> PlayerState:
	if isHit:
		return damaged_state
	else:
		return null

func exit(next_state):
	if(next_state == fall_state):
		isInCoyoteTime = true
		parent.coyote_timer.start()

func animation_finished(anim: String) -> PlayerState:
	return idle_state
