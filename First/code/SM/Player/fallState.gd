extends PlayerState
# First export any states that have a transition to/from the new state
@export var land_state: PlayerState
@export var run_state: PlayerState
@export var jump_state: PlayerState

func enter():
	super()
	# Add the code for ENTER function in the new PlayerState

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("jumpInput") and isInCoyoteTime:
		return jump_state
	if Input.is_action_just_pressed("jumpInput") and isAbleToDoubleJump:
		isAbleToDoubleJump = false
		return jump_state
	return null

func process_physics(delta) -> PlayerState:
	player_move(delta)
	if parent.is_on_floor():
		if direction:
			return run_state
		else:
			return land_state
	return null

func process_frame(delta) -> PlayerState:
	return null

func exit(next_state):
	pass

func _on_coyote_timer_timeout():
	isInCoyoteTime = false
