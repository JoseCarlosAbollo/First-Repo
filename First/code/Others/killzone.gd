extends Area2D

@onready var timer: Timer = $Timer

signal player_damaged

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	pass
	#Engine.time_scale = 0.3
	#timer.start()

func _on_timer_timeout():
	pass
	#Engine.time_scale = 1
	#get_tree().reload_current_scene();
