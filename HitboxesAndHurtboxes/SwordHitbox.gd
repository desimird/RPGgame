extends Area2D
class_name Sword


var knockback_vector = Vector2.ZERO


func _on_SwordHitbox_area_entered(area):
	pass
#	if area.get_parent() is WalkingEnemy:
#		owner.did_hit = true
#		emit_signal("did_hit")
#		if Global.hard_hit:
#			area.knock = knockback_vector * 1.3
#			area.emit_signal("hitted_hard")
#		else:
#			area.knock = knockback_vector * 0 
#			area.emit_signal("hitted") 
	#area.get_parent().queue_free()
	#print("hitted")
	#if area.get_parent() is WalkingEnemy:
	#	SoundPlayer.play_sound(SoundPlayer.HIT_ENEMY)
		#area.emit_signal("hitted")
