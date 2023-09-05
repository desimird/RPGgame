class_name Player
extends CharacterBody2D

@export var MAX_SPEED = 100.0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sword_anim = $HitboxPivot/SwordAnim
@onready var hitbox_pivot = $HitboxPivot
@onready var player_hurtbox = $PlayerHurtbox


var input_vector = Vector2.ZERO
var can_input = true
var old_pivot_angle = 0
var facing_dir = Vector2.RIGHT

func _ready():
	player_hurtbox.connect("hitted",Callable(self, "_on_hitted"))
func _process(delta):
	animated_sprite_2d.position = animated_sprite_2d.position.lerp(Vector2(1,-4), 0.1)
	

func get_input_vector():
	if not can_input:
		input_vector = Vector2.ZERO
		return
	input_vector.x= Input.get_action_strength("ui_right")- Input.get_action_strength("ui_left")
	input_vector.y= Input.get_action_strength("ui_down")- Input.get_action_strength("ui_up")
	input_vector= input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		hitbox_pivot.rotation_degrees = rad_to_deg(input_vector.angle())
	else:
		hitbox_pivot.rotation_degrees = rad_to_deg(facing_dir.angle())
	
	if input_vector.x > 0:
		facing_dir = Vector2.RIGHT
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.offset.x = 0
	if input_vector.x < 0:
		facing_dir = Vector2.LEFT
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.offset.x = -2

func _on_can_input():
	can_input = true

func _on_hitted():
	PlayerStats.set_health(PlayerStats.health - 1)
	print(PlayerStats.health)
