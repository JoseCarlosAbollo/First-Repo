extends CharacterBody2D

@onready var RCright = $RCright
@onready var RCleft = $RCleft
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var spawnArea = $spawnArea
@onready var state_machine = $StateMachine

const speed = 50
var direction = 1
var hit = false
var health = 3

func _ready():
	state_machine.init(self)

func _unhandled_input(event):
	state_machine.process_input(event)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func _on_animation_player_animation_finished(anim_name):
	state_machine.animation_finished(anim_name)
