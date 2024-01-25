extends Area2D
class_name Boss

@export var max_health = 400

var health: float
var explosion_scene = preload("res://particles/explosion.tscn")

func _enter_tree() -> void:
	health = max_health

func _on_area_entered(area: Area2D) -> void:
	if area is PlayerBullet:
		(area as PlayerBullet).queue_free()
		take_damage()

func take_damage():
	flash()

	health -= Globals.player.bullet_damage
	if health < 0: die()

func die():
	Events.boss_defeated.emit()
	var explosion = explosion_scene.instantiate() as CPUParticles2D
	explosion.position = position
	explosion.emitting = true
	Globals.world.add_child(explosion)

	queue_free()

func flash():
	if $Sprite:
		$Sprite.material.set_shader_parameter("enabled", true)
		await Globals.wait(0.2)
		$Sprite.material.set_shader_parameter("enabled", false)
