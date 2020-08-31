extends KinematicBody2D

var mobs_killed = 0
var total_mob_killed = 0
var dead = false

onready var laser = $Laser
onready var rotation_helper = $RotationHelper
onready var death_label = $DeathLabel
onready var collider = $CollisionShape2D

export var health:float = 250.00

func _ready():
	pass

func _physics_process(delta):
	if !dead:
		var rot = get_global_mouse_position().angle_to_point(position)
		laser.laser_rotation = rot
		rotation_helper.rotation = rot
		collider.rotation = rot

func damage(hit_damage:int):
	health-= hit_damage
	if health <= 0:
		death_label.visible = true
		dead = true
		$Laser.enable = false
		$Laser/Particles2D.emitting = false

func mob_kill(mob):
	if !mob.wave_mob:
		mobs_killed+=1
		total_mob_killed+=1
