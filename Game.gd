extends Node2D

var wave = false
var wave_mobs = 0

onready var player = $Player
onready var player_laser = $Player/Laser
onready var gameloop_timer = $GameLoop
onready var life_bar = $LifeBar
onready var mob_killed_label = $MobKilled
onready var walls_sprite = load("res://icon.png")
onready var mob_instance = preload("res://mobs/Mob.tscn")

func _ready():
	randomize()
	life_bar.max_value = player.health
	life_bar.value = player.health

func _physics_process(delta):
	life_bar.value = player.health
	mob_killed_label.text = "Mob Killed: " + str(player.total_mob_killed)
	


func _on_Area2D_body_entered(body):
	if body is Mob:
		player.damage(body.health)
		body.queue_free()


func _on_GameLoop_timeout():
	if !player.dead:
		if !wave:
			if player.mobs_killed > 10:
				if int(rand_range(0, 10)) > 7:
					wave = true
					wave_mobs = randi()%30+20
		
		if !wave:
			summon_mob(1, 1)
			gameloop_timer.start(rand_range(0.5, 2.5))
		else:
			wave_mobs-=1
			summon_mob(0.5, 1.50)
			if wave_mobs < 1:
				wave = false
				player.mobs_killed = 0
			gameloop_timer.start(rand_range(0, 0.75))

func summon_mob(health_multiplier, speed_multiplier):
	var mob = mob_instance.instance()
	var size_number = randi()%3+1
	mob.wave_mob = wave
	mob.width = 1
	mob.height = size_number
	mob.sprite = walls_sprite
	var y_spawn = rand_range(64, 15*64-size_number/2*64*mob.scale.x)
	mob.global_position = Vector2(2048, y_spawn)
	mob.health = (size_number*5+10)*health_multiplier
	mob.speed = (150 + -(size_number-1)*25)*speed_multiplier
	player_laser.connect("hit", mob, "hit")
	mob.connect("death", player, "mob_death")
	self.add_child(mob)
