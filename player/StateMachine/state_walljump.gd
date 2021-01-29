extends Node


var stateMachine = null
var p = null


func init():
	pass


func run(_delta):
	p.gravity_on = false
	
	p.velocity_jump = p.approach(p.velocity_jump, p.wallslide_speed, p.gravity)
	
	if p.last_velocity_move_sign != p.input_dir_vector.x or p.input_dir_vector == Vector2.ZERO:
		if p.cooldowns.walljump.value == p.cooldowns.walljump.max_value:
			p.velocity_move = 0
			stateMachine.change_state("Air")
		
	p.floor_jump = false
	
	if p.is_on_floor():
		p.velocity_jump = 0
	
	if p.inputs.input_dash:
		p.cooldowns.dash.value = 0
		stateMachine.change_state("Dash")
	elif p.inputs.input_jump_jp:
		p.velocity_jump = -p.max_jump
		p.velocity_move = p.last_velocity_move_sign * -1 * (p.max_speed * 2)
		p.gravity_on = true
		p.cooldowns.air_momentum.value = 0
		stateMachine.change_state("Air")
	elif p.is_on_floor():
		if p.velocity_move == 0:
			stateMachine.change_state("Idle")
		else:
			stateMachine.change_state("Move")
	elif not p.is_on_wall():
		p.velocity_move == 0
		stateMachine.change_state("Air")