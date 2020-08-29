extends KinematicBody2D

onready var laser = $Laser
onready var rotation_helper = $RotationHelper
onready var death_label = $Label

export var health:float = 250.00

func _ready():
	pass

func _physics_process(delta):
	var rot = get_global_mouse_position().angle_to_point(position)
	laser.laser_rotation = rot
	rotation_helper.rotation = rot

func damage(hit_damage:int):
	health-= hit_damage
	if health <= 0:
		death_label.visible = true
