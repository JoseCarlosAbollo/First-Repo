class_name PlayerClass
extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var camera_2d = $Camera2D

func _ready():
	state_machine.init(self)

func _unhandled_input(event):
	state_machine.process_input(event)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func _on_animated_sprite_2d_animation_finished():
	state_machine.finish_animation_signal()
