extends Node2D

onready var player = $Player
onready var player_laser = $Player/Laser
onready var gameloop_timer = $GameLoop
onready var life_bar = $LifeBar
onready var walls_sprite = load("res://icon.png")
onready var mob_instance = preload("res://mobs/Mob.tscn")

func _ready():
	randomize()
	life_bar.max_value = player.health
	life_bar.value = player.health

func _physics_process(delta):
	life_bar.value = player.health
	#var right = Input.is_action_pressed("right")
	#var left = Input.is_action_pressed("left")
	#$Laser.laser_rotation += (int(right)-int(left))*0.01
	#$Player/Laser.laser_rotation = $Player/Laser.position.angle_to_point($Player.position)


func _on_Area2D_body_entered(body):
	if body is Mob:
		player.damage(body.health)
		body.queue_free()


func _on_GameLoop_timeout():
	if !player.dead:
		var mob = mob_instance.instance()
		var size_number = randi()%3+1
		mob.width = 1
		mob.height = size_number
		mob.sprite = walls_sprite
		var y_spawn = rand_range(64+size_number/2*64*mob.scale.x, 15*64-size_number/2*64*mob.scale.x)
		mob.global_position = Vector2(2048, y_spawn)
		mob.health = size_number*7.5+10
		player_laser.connect("hit", mob, "hit")
		mob.connect("death", player, "mob_kill")
		get_tree().get_root().add_child(mob)
		gameloop_timer.start(rand_range(1, 4))
