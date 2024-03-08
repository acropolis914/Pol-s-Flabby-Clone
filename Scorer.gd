extends StaticBody2D
var scroll_speed = 30
var dead = false

func ready():
	pass
	
func _physics_process(delta):
	if dead && scroll_speed > 0:
		queue_free()
		scroll_speed -= 10*delta
		position.x -= (scroll_speed)/(delta*800)
		return
	position.x -= (scroll_speed)/(delta*800)
	
func stop():
	dead = true
	

	



