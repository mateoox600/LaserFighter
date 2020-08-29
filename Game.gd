extends Node2D

var is_spawning:bool = false

onready var player = $Player
onready var player_laser = $Player/Laser
onready var gameloop_timer = $GameLoop
onready var walls_sprite = load("res://icon.png")
onready var platform = preload("res://platform/Platform.tscn")

func _ready():
	randomize()

func _physics_process(delta):
	pass
	#var right = Input.is_action_pressed("right")
	#var left = Input.is_action_pressed("left")
	#$Laser.laser_rotation += (int(right)-int(left))*0.01
	#$Player/Laser.laser_rotation = $Player/Laser.position.angle_to_point($Player.position)


func _on_Area2D_body_entered(body):
	if body is KinematicBody2D and body.get_filename() == platform.get_path():
		player.damage(5)
		body.queue_free()


func _on_GameLoop_timeout():
	var wall = platform.instance()
	var y_spawn = randi()%14*64+32
	wall.width = 1
	wall.height = 1
	wall.sprite = walls_sprite
	wall.global_position = Vector2(get_viewport().size.x+wall.width*64, y_spawn)
	wall.scale = Vector2(0.5, 0.5)
	player_laser.connect("hit", wall, "hit")
	get_tree().get_root().add_child(wall)
	gameloop_timer.start(randi()%2+2)
