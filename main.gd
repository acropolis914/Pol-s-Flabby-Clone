extends Node2D

@export var pipes : PackedScene
@export var pipe_floor : PackedScene
@export var score_collision : PackedScene

var pipe_time = 2
var screen_size
var pipe_space= 150
var score = 0
var time = 0
var frequency = 5
var amplitude = 20
var default_pos = 300
var pipe_spawn_center = 0
var scroll_speed = 300
var dead = false

func _ready():
	$PlayButton.show
	$Score.show()
	$Bird.position= $Marker2D.position
	
func new_game():
	$PipeTimer.start(pipe_time)
	$Bird.position= $Marker2D.position
	$Score.text = str(score)
	$Bird.flying = false
	for n in get_children():
			if n.name.begins_with("pipe") || n.name.begins_with("scorer"):
				n.queue_free()
	

func _process(delta):
	time += delta * frequency
	if dead:
		for n in get_children():
			if n.name.begins_with("pipe") || n.name.begins_with("scorer"):
				n.stop()
	
	
	#print(time)
	#var  sintime= sin(time)
	#print(sintime)
	#print(pipe_spawn_center)
	
func _on_pipe_timer_timeout():
	amplitude += 1
	pipe_spawn_center = (default_pos + (sin(time)* amplitude))
	#print(pipe_time)
	#print(pipe_space)
	pipe_space= pipe_space-0.5
	pipe_time = (pipe_time + 0.1)
	var upper_pipe = pipes.instantiate()
	var lower_pipe = pipe_floor.instantiate()
	var scorer = score_collision.instantiate()
	print(pipe_spawn_center)
	var upper_pipe_pos_y = (pipe_spawn_center - (pipe_space/2))
	var upper_pipe_pos = Vector2(900, upper_pipe_pos_y)
	var lower_pipe_pos = Vector2(upper_pipe_pos.x, pipe_spawn_center + (pipe_space/2))
	scorer.position = Vector2(upper_pipe_pos.x,pipe_spawn_center)
	upper_pipe.position = upper_pipe_pos
	lower_pipe.position = lower_pipe_pos
	add_child(scorer)
	add_child(upper_pipe)
	add_child(lower_pipe)
	upper_pipe.name = "pipe"
	lower_pipe.name = "pipe"
	scorer.name = "scorer"
	

func game_over():
	$Background2/Background.stop()
	score = 0
	$PlayButton.show()

func _on_bird_die():
	game_over()
	dead =true
	$SpawnEnder.start()

func _on_bird_score():
	score += 1
	print(score)
	$Score.text = str(score)
	
func _on_spawn_ender_timeout():
	$PipeTimer.stop()

func _on_play_button_pressed():
	$PlayButton.hide()
	new_game()
