extends State
# Export any states that have a transition to/from the new state
@export var damaged_state: State

func enter():
	super()
	# Add the code for ENTER function in the new State

func process_input(event) -> State:
	# Add the code for handling INPUT function in the new State
	return null

func process_physics(delta) -> State:
	if parent.RCright.is_colliding():
		parent.direction = -1
		parent.sprite.flip_h = true
	if parent.RCleft.is_colliding():
		parent.direction = 1
		parent.sprite.flip_h = false
	if parent.hit:
		return damaged_state
	return null

func process_frame(delta) -> State:
	parent.position.x += parent.direction * parent.speed * delta
	return null

func exit(next_state):
	pass

func _on_hitbox_area_area_entered(area):
	if area.is_in_group("playerAttack") :
		parent.hit = true
