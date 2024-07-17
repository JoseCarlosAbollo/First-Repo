extends PlayerState
# Export any states that have a transition to/from the new state
@export var idle_state: PlayerState
@export var jump_state: PlayerState
@export var crouch_state: PlayerState
@export var fall_state: PlayerState

func enter():
	super()
	set_low_profile()

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput") and isAbleToStand:
		return idle_state
	return null

func process_physics(delta) -> PlayerState:
	if parent.is_on_floor():
		if is_input_left():
			isPointingLeft = true
			return crouch_state
		elif is_input_right():
			isPointingLeft = false
			return crouch_state
	else:
		return fall_state
	player_move(delta)
	return null

func process_frame(delta) -> PlayerState:
	# Add the code for handling FRAME UPDATES in the new PlayerState
	return null

func exit(next_state):
	if(next_state != crouch_state):
		set_high_profile()
	if(next_state == fall_state):
		isInCoyoteTime = true
		parent.coyote_timer.start()

func _on_area_to_stand_body_entered(area):
	isAbleToStand = false

func _on_area_to_stand_body_exited(area):
	isAbleToStand = true
