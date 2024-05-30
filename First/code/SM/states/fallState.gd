extends State
# First export any states that have a transition to/from the new state
@export var land_state: State
@export var run_state: State
@export var jump_state: State

func enter():
	super()
	# Add the code for ENTER function in the new State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jumpInput") and isInCoyoteTime:
		print("coyote")
		return jump_state
	if Input.is_action_just_pressed("jumpInput") and isAbleToDoubleJump:
		print("double")
		isAbleToDoubleJump = false
		return jump_state
	return null

func process_physics(delta) -> State:
	player_move(delta)
	if parent.is_on_floor():
		if direction:
			return run_state
		else:
			return land_state
	return null

func process_frame(delta) -> State:
	return null

func exit(next_state):
	pass



func _on_coyote_timer_timeout():
	isInCoyoteTime = false
