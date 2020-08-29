extends KinematicBody2D

onready var sprite = $Sprite
onready var collider = $CollisionShape2D
onready var camera = $Camera2D

export var health:float = 250.00

func _ready():
	pass

func _physics_process(delta):
	var rot = get_global_mouse_position().angle_to_point(position)
	$Laser.laser_rotation = rot
	$RotationHelper.rotation = rot

func damage(hit_damage:int):
	health-= hit_damage
	if health <= 0:
		queue_free()
