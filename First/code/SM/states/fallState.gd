extends State
# First export any states that have a transition to/from the new state
@export var idle_state: State

func enter():
	super() # You usually want to launch the default state ENTER function to play the correct animation
	# And then you add the code for ENTER function in the new State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("left"):
		isPointingLeft = true
		return self
	elif Input.is_action_just_pressed("right"):
		isPointingLeft = false
		return self
	return null

func process_physics(delta) -> State:
	parent.velocity.y += 2 * gravity * delta
	player_move()
	if parent.is_on_floor():
		return idle_state
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit():
	pass

