extends Node2D

var is_spawning:bool = false

onready var platform = preload("res://platform/Platform.tscn")

func _ready():
	randomize()

func _physics_process(delta):
	spawn_wall()
	#var right = Input.is_action_pressed("right")
	#var left = Input.is_action_pressed("left")
	#$Laser.laser_rotation += (int(right)-int(left))*0.01
	#$Player/Laser.laser_rotation = $Player/Laser.position.angle_to_point($Player.position)
	

func spawn_wall():
	if !is_spawning:
		is_spawning = true
		yield(get_tree().create_timer(randi()%2+2), "timeout")
		var wall = platform.instance()
		var y_spawn = randi()%14*64+32
		wall.width = 1
		wall.height = 1
		wall.sprite = load("res://icon.png")
		wall.global_position = Vector2(3900, y_spawn)
		wall.scale = Vector2(0.5, 0.5)
		$Player/Laser.connect("hit", wall, "hit")
		get_tree().get_root().add_child(wall)
		is_spawning = false


func _on_Area2D_body_entered(body):
	if body is KinematicBody2D and body.get_filename() == platform.get_path():
		$Player.damage(5)
		body.queue_free()
