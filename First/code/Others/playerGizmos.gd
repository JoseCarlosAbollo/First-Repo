extends Node2D

@onready var parent = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func _draw():
	draw_line(Vector2.ZERO, parent.moveDirectionGizmo * 100, Color.AQUA,2)
	draw_line(Vector2.ZERO, parent.floorNormalGizmo * 100, Color.CHOCOLATE,2)
