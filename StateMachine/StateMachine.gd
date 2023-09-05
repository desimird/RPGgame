class_name StateMachine
extends Node

# Signal when transitioned in new state
signal transitioned(state_name)

@export var initial_state := NodePath()

@onready var state: State = get_node(initial_state)

func _ready() -> void:
	await owner.ready
	
	for child in get_children():
		child.state_machine = self
	state.enter()
	
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)
	
func _process(delta):
	state.update(delta)
	
func _physics_process(delta):
	state.physics_update(delta)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return
		
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
