extends Node

@export var players: Array[Player] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Processes the hand for the given player
func process_hand(player: Player, hand: Array[Card]):
	# Locate all power cards
	pass

static func read_card_from_file(json_file_path:String) -> Card:
	var file: FileAccess = FileAccess.open(json_file_path, FileAccess.READ)
	var json_result = JSON.new()
	var result: Error = json_result.parse(file.get_as_text())
	
	if result == Error.OK:
		var data:Dictionary = json_result.data
		if not data.has("type"):
			push_error("Unable to parse file \"%s\" as card: Missing type field" % json_file_path)
			return null
		
		var type = data.get("type", "card")
		var score = data.get("score", 0)
		var cost = data.get("cost", 1)
		
		if type == "card":
			return Card.new(score, cost)
		
		elif type == "power":
			var effect_path = data.get("effect", "")
			# Parse the trigger into an enum
			var raw_enum = data.get("trigger")
			var trigger_enum: PowerCard.POWER_CARD_TRIGGERS
			match raw_enum:
				"ON_TURN_END": 
					trigger_enum = PowerCard.POWER_CARD_TRIGGERS.ON_TURN_END
				"ON_DRAW":
					trigger_enum = PowerCard.POWER_CARD_TRIGGERS.ON_DRAW
				"ON_DISCARD":
					trigger_enum = PowerCard.POWER_CARD_TRIGGERS.ON_DISCARD
			
			pass
		
	else:
		push_error("Unable to parse file \"%s\" as card" % json_file_path)
		return null
	
