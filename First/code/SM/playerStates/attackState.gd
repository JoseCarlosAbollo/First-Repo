extends State
# Export any states that have a transition to/from the new state
@export var idle_state: State

func enter():
	#print("enter attack")
	isAbleToAttack = false
	var animation_name
	if(isPointingLeft):
		animation_name = animation_name_left + '1'
		#animation_name = animation_name_left + str(attackComboNumber)
		parent.animation_player.play(animation_name)
	else:
		animation_name = animation_name_right + '1'
		#animation_name = animation_name_right + str(attackComboNumber)
		parent.animation_player.play(animation_name)

func process_input(event) -> State:
	if isAbleToAttack and Input.is_action_just_pressed("attackInput"):
		print("again")
		return self
	return null

func process_physics(delta) -> State:
	# Add the code for handling PHYSICS in the new State
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func ableToAttack():
	#print("IS ABLE")
	isAbleToAttack = true

func exit(next_state: State) -> void:
	#if(attackComboNumber == 1 and next_state == self):
		#attackComboNumber += 1
	#else:
		#attackComboNumber = 1
	print(isAbleToAttack)
	isAbleToAttack = true

func animation_finished(anim_name: String) -> State:
	#print("finished")
	return idle_state
