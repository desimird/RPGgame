extends Node


@export var max_health = 4: set = set_max_health
var health = max_health: set = set_health

func _process(delta):
	Global.player_health = health
	if health <= 0:
		emit_signal("no_health")
signal no_health
signal health_changed(value)
signal max_health_changed(value)
#
func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed")

func set_health(value):
	health = value
	#Global.player_health = health
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func _ready():
	self.health=max_health
