extends Node

class_name Card

@export var score: int
@export var cost: int
@export var trigger: String
@export var effect: String
@export var type: String
## The file-handle name for the card
@export var internal_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Static factory Constructor
static func create_from_dict(data: Dictionary)-> Card:
	var card := Card.new()
	var trigger_str: String = data.get("trigger", "none")
	card.internal_name = data.get("name", "none")
	card.score = data.get("power", 0)
	card.cost = data.get("cost", 0)
	if trigger_str != "none":
		var power_card := PowerCard.new()
		power_card.trigger = _trigger_from_string(trigger_str)
		card = power_card
	card.effect = data.get("effect", "none")
	card.type = data.get("type", "none")
	
	return card
	
static func _trigger_from_string(trigger_str:String)-> PowerCard.POWER_CARD_TRIGGERS:
	match trigger_str:
		"discarded":
			return PowerCard.POWER_CARD_TRIGGERS.ON_DISCARD
		
		"drawn":
			return PowerCard.POWER_CARD_TRIGGERS.ON_DRAW
		
		"end of turn":
			return PowerCard.POWER_CARD_TRIGGERS.ON_TURN_END
		
		_:
			push_warning("Card: unrecognized trigger '%s', defaulting to ON_TURN_END" % trigger_str)
			return PowerCard.POWER_CARD_TRIGGERS.ON_TURN_END
