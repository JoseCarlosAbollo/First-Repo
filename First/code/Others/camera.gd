extends Camera2D

var maxOffset: int = 100
var offsetIncrement: int = 200
var offsetRecover: int = 600
var isMoveLocked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isMoveLocked:
		if(is_input_left()):
			if(position.x > 0):
				position.x -= offsetRecover * delta
			else:
				position.x -= offsetIncrement * delta
			if(position.x < -maxOffset):
				position.x = -maxOffset 
		elif(is_input_right()):
			if(position.x < 0):
				position.x += offsetRecover * delta
			else:
				position.x += offsetIncrement * delta
			if(position.x > maxOffset):
				position.x = maxOffset 
		elif(position.x != 0):
			if(position.x > 0):
				position.x -= offsetIncrement * delta
			else:
				position.x += offsetIncrement * delta
		else:
			pass

func is_input_left() -> bool:
	return Input.is_action_just_pressed("leftInput") or (Input.is_action_pressed("leftInput") and !Input.is_action_pressed("rightInput"))
func is_input_right() -> bool:
	return Input.is_action_just_pressed("rightInput") or (Input.is_action_pressed("rightInput") and !Input.is_action_pressed("leftInput"))

func _on_player_is_move_locked():
	isMoveLocked = true

func _on_player_is_move_un_locked():
	isMoveLocked = false
