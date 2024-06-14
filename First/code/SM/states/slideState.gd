extends State
# Export any states that have a transition to/from the new state
@export var land_state: State
@export var fall_state: State
@export var jump_state: State
@export var crouchIdle_state: State

func enter():
	super()
	set_low_profile()

func process_input(event) -> State:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	return null

func process_physics(delta) -> State:
	parent.move_and_slide()
	if !parent.is_on_floor():
		set_high_profile()
		return fall_state
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit(next_state):
	pass

func animation_finished(animation_name) -> State:
	if !isAbleToStand:
		return crouchIdle_state
	else:
		set_high_profile()
		return land_state
