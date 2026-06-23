extends Node

@export var players: Arrays[Player] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Processes the hand for the given player
func process_hand(player: Player, hand: Array[Card]):
	# Locate all power cards

