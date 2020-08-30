extends KinematicBody2D

class_name Mob

onready var collider = $CollisionShape2D
onready var texture_rect = $TextureRect

export var health:float = 10.0
export var width:int = 1
export var height:int = 1
export var is_colliding:bool = true

func _ready() -> void:
	collider.shape.set_extents(Vector2(float(32*width-1), float(32*height-1)))
	collider.disabled = !is_colliding

func _physics_process(delta):
	move_and_slide(Vector2(-1, 0)*150)

func laser_hit(laser, laser_collider):
	if health <= 0:
		destroy()
	else:
		health-=laser.damage

func destroy():
	queue_free()

func hit(result, laser):
	if result.collider == self:
		laser_hit(laser, result.collider)
