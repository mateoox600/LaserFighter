extends KinematicBody2D

onready var sprite = $Sprite
onready var collider = $CollisionShape2D
onready var camera = $Camera2D

export var health:float = 250.00
export var texture:Texture = null
export var speed:int = 200
export var is_currect_camera:bool = true

func _ready():
	camera.current = is_currect_camera
	sprite.texture = texture
	collider.shape.set_extents(Vector2(float(texture.get_width()), float(texture.get_height())))

func _physics_process(delta):
	if camera.current != is_currect_camera:
		camera.current = is_currect_camera
	if sprite.texture != texture:
		sprite.texture = texture
		collider.shape.set_extents(Vector2(float(texture.get_width()), float(texture.get_height())))
	
	var dir = Vector2(int(Input.is_action_pressed("right"))-int(Input.is_action_pressed("left")), 
	int(Input.is_action_pressed("down"))-int(Input.is_action_pressed("up"))).normalized()*speed
	
	move_and_slide(dir)

func damage(hit_damage:int):
	if health <= 0:
		queue_free()
	else:
		health-= hit_damage
