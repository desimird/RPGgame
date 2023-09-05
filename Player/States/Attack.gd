extends PlayerState

@export var _animation_player: NodePath
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

var action_pressed = false

func enter(_msg := {}) -> void:
	var angle = deg_to_rad(player.hitbox_pivot.rotation_degrees)
	
	
	#player.hitted = false
	player.get_input_vector()
	animation_player.seek(0)
	animation_player.play("attack")
	player.animated_sprite_2d.position += 2*Vector2(cos(angle),sin(angle))
	action_pressed = false
	player.can_input = false
	
	
	
func physics_update(delta: float) -> void:
	#print(Vector2(cos(angle),sin(angle)))
	
	player.get_input_vector()
	player.velocity = Vector2.ZERO
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	
	if Input.is_action_just_pressed("ui_accept"):
		action_pressed = true
	
	if action_pressed and player.can_input:
		state_machine.transition_to("Attack", {})
	
	if not animation_player.is_playing():
		state_machine.transition_to("Idle", {})
