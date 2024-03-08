extends Area2D
signal die
signal score
var GRAVITY
var screen_size
var velocity= Vector2.ZERO
var MAX_VELOCITY = 10
var LIFT = -5
var flying = false
var dead = false

func _ready():
	flying = false
	GRAVITY = 0
	var screen_size = get_viewport_rect().size
	print(screen_size)
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("fly") && !dead:
		if abs(velocity.y) > MAX_VELOCITY:
			velocity.y = -MAX_VELOCITY
		else:
			velocity.y = LIFT
		flying = true
	if flying:
		GRAVITY = 9
	else: GRAVITY = 0
	
	velocity.y += GRAVITY * delta
	position.y += velocity.y
		
	if position.y > 600:
		position.y = 600
	elif position.y < 0:
		position.y = 0
	#print(position)

	if velocity.y < 0:
		$AnimatedSprite2D.rotation = deg_to_rad(velocity.y*10)
	elif velocity.y > 0 && position.y < 600:
		$AnimatedSprite2D.rotation = deg_to_rad(velocity.y*9)
	
	if position.y < 600 && !dead:
		$AnimatedSprite2D.animation = "default"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

func kill():
	$AnimatedSprite2D.rotation = deg_to_rad(90)
	print("entered")
	die.emit()
	
func music():
	$AudioStreamPlayer.play()

func add_score():
	score.emit()
	print("Scored")
		
func _on_body_entered(body):
	if body.name.begins_with("scorer"):
		score.emit()
	if body.name.begins_with("pipe"):
		$AnimatedSprite2D.animation = "dead"
		$AnimatedSprite2D.play()
		dead =true
		die.emit()
		kill()
		$CPUParticles2D.emitting = true
