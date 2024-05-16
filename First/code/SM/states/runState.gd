extends State
# First export any states that have a transition to/from the new state
@export var idle_state: State
@export var jump_state: State
@export var fall_state: State

func enter():
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	return null

func process_physics(delta) -> State:
	parent.velocity.y += gravity * delta # You usually want to apply gravity to the player 
	player_move()
	if direction == 0:
		return idle_state
	if !parent.is_on_floor():
		return fall_state
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit():
	pass
