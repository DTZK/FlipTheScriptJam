extends Node

@export var players: Array[Player] = []

@export var starting_hand_size: int = 5
@export var max_hand_size: int = 10
@export var cards_drawn_per_turn: int = 2
@export var max_turns: int = 6
@export var swap_turn: int = 3          
# Called when the node enters the scene tree for the first time.
var current_turn:int = 0 
func _ready():
	start_game()
		
func start_game()->void:
	for player in players:
		_draw_n(player, starting_hand_size)
	
	for turn in range(1, max_turns+1):
		current_turn=turn
		print("This is the current turn: %d" % turn)
		
		draw_phase()
		
		if turn == swap_turn:
			swap_hands()
		discard_phase()
		end_of_turn_phase()
	
	print("Game over after %d turns." % max_turns)
		
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
	
