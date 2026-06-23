extends Node

class_name Card

@export var score: int
@export var cost: int

## The file-handle name for the card
@export var internal_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Constructor
func _init(score:int, cost:int):
	self.score = score
	self.cost = cost
