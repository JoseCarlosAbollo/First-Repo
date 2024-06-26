extends State
# Export any states that have a transition to/from the new state
@export var crouchIdle_state: State
@export var jump_state: State
@export var run_state: State
@export var fall_state: State

@export var speed_multiplier: float = 0.5
@onready var original_speed: float = move_speed

func enter():
	super()
	set_low_profile()
	move_speed *= speed_multiplier

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput") and isAbleToStand:
		return run_state
	return null

func process_physics(delta) -> State:
	player_move(delta)
	if direction == 0:
		return crouchIdle_state
	if !parent.is_on_floor():
		return fall_state	
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit(next_state):
	if(next_state != crouchIdle_state):
		set_high_profile()
	if(next_state == fall_state):
		isInCoyoteTime = true
		parent.coyote_timer.start()
	move_speed = original_speed

func _on_area_to_stand_body_entered(area):
	isAbleToStand = false

func _on_area_to_stand_body_exited(area):
	isAbleToStand = true
