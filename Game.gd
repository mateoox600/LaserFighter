extends Node2D

var is_spawning:bool = false

onready var player = $Player
onready var player_laser = $Player/Laser
onready var gameloop_timer = $GameLoop
#onready var mob_instance = preload("res://mobs/Mob.tscn")

func _ready():
	randomize()

func _physics_process(delta):
	pass
	#var right = Input.is_action_pressed("right")
	#var left = Input.is_action_pressed("left")
	#$Laser.laser_rotation += (int(right)-int(left))*0.01
	#$Player/Laser.laser_rotation = $Player/Laser.position.angle_to_point($Player.position)


func _on_Area2D_body_entered(body):
	if body is Mob:
		player.damage(5)
		body.queue_free()


func _on_GameLoop_timeout():
	var mob_instance = load("res://mobs/Mob.tscn")
	var mob = mob_instance.instance()
	var size_number = randi()%4
	mob.width = 1
	mob.height = size_number
	mob.scale = Vector2(0.5, 0.5)
	var y_spawn = rand_range(64+size_number/2*64*mob.scale.x, 15*64-size_number/2*64*mob.scale.x)
	mob.global_position = Vector2(2048, y_spawn)
	mob.health = size_number*5+10
	player_laser.connect("hit", mob, "hit")
	get_tree().get_root().add_child(mob)
	gameloop_timer.start(rand_range(1, 4))
