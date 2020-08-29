extends Node2D

onready var line:Line2D = $Line2D
onready var particles:Particles2D = $Particles2D

export var laser_rotation:float = 0
export var laser_color:Color = Color.red
export var enable:bool = true
export var damage:float = 0.5;

signal hit(result, laser)

func _ready() -> void:
	$Line2D.default_color = laser_color

func _physics_process(delta):
	line.clear_points()
	if enable:
		var to:Vector2 = Vector2(1000, 0).rotated(laser_rotation)+global_position
		var result:Dictionary = get_world_2d().direct_space_state.intersect_ray(global_position, to, [get_parent().get_node("Player")])
		if result:
			emit_signal("hit", result, $".")
			to = result.position
			particles.global_position = result.position
			particles.process_material.direction = Vector3(result.normal.x, result.normal.y, 0)
			particles.emitting = true
		else:
			particles.emitting = false
		line.add_point(Vector2(0, 0))
		line.add_point(to-position)
