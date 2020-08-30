extends KinematicBody2D

class_name Mob

onready var collider = $CollisionShape2D
onready var texture_rect = $TextureRect
onready var life_bar = $TextureProgress

export var health:float = 10.0
export var width:int = 1
export var height:int = 1
export var sprite:Texture = null

signal death(mob)

func _ready() -> void:
	if sprite:
		texture_rect.texture = sprite
	
	texture_rect.rect_size = Vector2(64*width, 64*height)
	collider.shape.set_extents(Vector2(32*width, 32*height))
	collider.position = Vector2(32*width, 32*height)
	life_bar.rect_position = Vector2(0, 64*height)
	life_bar.max_value = health
	life_bar.value = health

func _physics_process(delta):
	move_and_slide(Vector2(-1, 0)*150)
	life_bar.value = health

func laser_hit(laser, laser_collider):
	if health <= 0:
		destroy()
	else:
		health-=laser.damage

func destroy():
	queue_free()
	emit_signal("death", self)

func hit(result, laser):
	if result.collider == self:
		laser_hit(laser, result.collider)
