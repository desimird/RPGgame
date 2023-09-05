extends PlayerState

@export var _animation_player: NodePath
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	player.get_input_vector()
	animation_player.play("run")


func physics_update(delta: float) -> void:
	player.get_input_vector()
	if Input.is_action_just_pressed("ui_accept") and player.can_input:
		state_machine.transition_to("Attack", {})
	
	if player.input_vector != Vector2.ZERO:
		player.velocity = player.input_vector * player.MAX_SPEED
	else:
		#if player.combo_count == 0:
		player.velocity = Vector2.ZERO
		state_machine.transition_to("Idle", {})
			
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
