extends Card

class_name PowerCard

## The mode of trigger for this power card
@export var trigger: POWER_CARD_TRIGGERS

## The static path to the script that contains the code to run the power card
@export var effect: String

## Stores the static list of triggers for power cards
enum POWER_CARD_TRIGGERS {
	## The power card's code is invoked when the player removes a card from their hand
	ON_DISCARD,
	
	## The power card's code is invoked when the player adds a card to their hand
	ON_DRAW,
	
	## The power card's code is invoked when the turn is over
	ON_TURN_END,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
