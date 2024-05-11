extends Node2D

@onready var camera = %Camera2D

var offset

# Called when the node enters the scene tree for the first time.
func _ready():
	offset = camera.position - position;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = camera.position + offset;
	print("pos: ", position, "\noffset: ", offset)
