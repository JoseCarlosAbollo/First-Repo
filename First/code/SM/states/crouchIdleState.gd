extends State
# Export any states that have a transition to/from the new state
@export var idle_state: State
@export var jump_state: State
@export var crouch_state: State
@export var fall_state: State

func enter():
	super()
	if !isCrouching:
		parent.collision_capsule_standing.disabled = true
		parent.collision_capsule_crouching.disabled = false
		parent.area_to_stand.get_child(0).disabled = false
	isCrouching = true

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput") and isAbleToStand:
		return idle_state
	return null

func process_physics(delta) -> State:
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

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit(next_state):
	if(next_state != crouch_state):
		isCrouching = false
		parent.collision_capsule_standing.disabled = false
		parent.collision_capsule_crouching.disabled = true
		parent.area_to_stand.get_child(0).disabled = true
	if(next_state == fall_state):
		isInCoyoteTime = true
		parent.coyote_timer.start()


func _on_area_to_stand_body_entered(area):
	isAbleToStand = false

func _on_area_to_stand_body_exited(area):
	isAbleToStand = true
