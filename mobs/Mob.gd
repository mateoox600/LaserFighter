extends KinematicBody2D

class_name Mob

onready var collider = $CollisionShape2D
onready var texture_rect = $TextureRect

export var health:float = 10.0
export var width:int = 1
export var height:int = 1
export var sprite:Texture = null
export var is_colliding:bool = true

func _ready() -> void:
	if sprite == null:
		collider.shape.set_extents(Vector2(float(32*width-1), float(32*height-1)))
	else:
		texture_rect.texture = sprite
		texture_rect.rect_size = Vector2(sprite.get_width()*width, sprite.get_height()*height)
		texture_rect.rect_position = -Vector2(sprite.get_width()*width, sprite.get_height()*height)
		collider.shape.set_extents(Vector2(float(sprite.get_width()*width-1), float(sprite.get_height()*height-1)))
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
