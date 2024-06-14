extends State
# Export any states that have a transition to/from the new state
@export var idle_state: State

func enter():
	print(self)
	var animation_name
	if(isPointingLeft):
		animation_name = animation_name_left + str(attackComboNumber)
		parent.animation_player.play(animation_name)
	else:
		animation_name = animation_name_right + str(attackComboNumber)
		parent.animation_player.play(animation_name)
	isAbleToAttack = false

func process_input(event) -> State:
	if isAbleToAttack and Input.is_action_just_pressed("attackInput"):
		return self
	return null

func process_physics(delta) -> State:
	# Add the code for handling PHYSICS in the new State
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func ableToAttack():
	isAbleToAttack = true

func exit(next_state: State) -> void:
	if(attackComboNumber == 1 and next_state == self):
		attackComboNumber += 1
	else:
		attackComboNumber = 1

func animation_finished(anim_name: String) -> State:
	return idle_state
