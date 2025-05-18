extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@export var tempo=20
@export var reibung=0.9

func _ready() -> void:
	animated_sprite.play()

func _physics_process(delta: float) -> void:
	var bewegungsrichtung= Input.get_vector("left","right","up","down")
	velocity += bewegungsrichtung*tempo
	velocity *= reibung
	move_and_slide()
	if bewegungsrichtung.x<0 :
		animated_sprite.animation = "run_left"
		animated_sprite.flip_h = false      
	elif bewegungsrichtung.x>0:
		animated_sprite.animation = "run_left"
		animated_sprite.flip_h = true 
	else:
		if bewegungsrichtung.y<0 :
			animated_sprite.animation = "run_up"
		elif bewegungsrichtung.y>0:
			animated_sprite.animation = "run_down"
		else: 
			animated_sprite.animation = "idle"          
