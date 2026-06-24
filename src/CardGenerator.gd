extends Node
class_name CardGenerator

# the card details
var json_data = {
  "cards": [
	{
	  "name": "Test 2",
	  "type": "creature",
	  "cost": 5,
	  "power": 0,
	  "trigger": "end of turn",
	  "effect": "+5 power "
	},
	{
	  "name": "Squirrel",
	  "type": "creature",
	  "cost": 1,
	  "power": 1,
	  "trigger": "none",
	  "effect": "none"
	},
	{
	  "name": "Storm",
	  "type": "creature",
	  "cost": 3,
	  "power": 2,
	  "trigger": "discarded",
	  "effect": "+1 power to all cards in hand"
	},
	{
	  "name": "S 2",
	  "type": "creature",
	  "cost": 2,
	  "power": 1,
	  "trigger": "drawn",
	  "effect": "+2 power"
	},
	{
	  "name": "Goblin",
	  "type": "creature",
	  "cost": 3,
	  "power": 0,
	  "trigger": "end of turn",
	  "effect": "-1 power"
	}
  ]
}

##Holds all card data loaded from JSON file
##Each entry is in a dict
var cards:Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_cards()

## Populates `cards` from the json_data dictionary above.
func load_cards()->void:
	cards.clear()
	for card_dict in json_data["cards"]:
		cards.append(Card.create_from_dict(card_dict))
	print("CardGenerator: Loaded ", cards.size(), " cards.")

func draw_card()-> Array[Card]:
	return draw_n(2)

func draw_n(n:int)-> Array[Card]:
	var drawn: Array = []
	for i in range(n):
		var index := randi() % cards.size()
		var original: Card = cards[index]
		drawn.append(original.duplicate(true))
	return drawn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
