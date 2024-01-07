extends EnemyBullet
class_name Fireball

func _physics_process(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta
	position += (Globals.player.position - position).normalized() * 0.8

func _on_visible_on_screen_notifier_screen_exited() -> void:
	pass
