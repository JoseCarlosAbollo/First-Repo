extends State
# Export any states that have a transition to/from the new state
@export var idle_state: State

func enter():
	animation_name_right += str(attackComboNumber)
	if(isPointingLeft):
		parent.animation_player.play(animation_name_left)
	else:
		parent.animation_player.play(animation_name_right)
	parent.animated_sprite.visible = false
	parent.animation_player.play("AttackRight1")
	isAbleToAttack = false
	print(isAbleToAttack)

func process_input(event) -> State:
	# Add the code for handling INPUT function in the new State
	return null

func process_physics(delta) -> State:
	# Add the code for handling PHYSICS in the new State
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func ableToAttack():
	isAbleToAttack = true
	print(isAbleToAttack)

func exit(next_state: State) -> void:
	parent.animated_sprite.visible = true
	if(next_state == self):
		attackComboNumber += 1
	else:
		attackComboNumber = 1

func animation_finished(anim_name: String) -> State:
	return idle_state
