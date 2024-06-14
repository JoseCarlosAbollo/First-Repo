extends State
# First export any states that have a transition to/from the new state
@export var idle_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var slide_state: State
@export var attack_state: State

func enter():
	super()
	isAbleToDoubleJump = true

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput"):
		if parent.velocity.x != 0:
			return slide_state
		else:
			return crouch_state
	if isAbleToAttack and Input.is_action_just_pressed("attackInput"):
		return attack_state
	return null

func process_physics(delta) -> State:
	player_move(delta)
	if direction == 0:
		return idle_state
	if !parent.is_on_floor():
		return fall_state
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit(next_state):
	if(next_state == fall_state):
		parent.coyote_timer.start()
		isInCoyoteTime = true
