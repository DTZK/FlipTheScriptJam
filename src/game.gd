extends Node
@export var players: Array[Player] = []
@export var card_generator: CardGenerator
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
func process_hand(player: Player):
	# Locate all power cards
	for card in player._power_cards:
		if card.trigger == PowerCard.POWER_CARD_TRIGGERS.ON_TURN_END:
			apply_effect_to_card(card, card.effect)

func draw_phase()-> void:
	for player in players:
		_draw_n(player, cards_drawn_per_turn)

## Draws up to `needed` cards, stopping early if the player's hand is full.
func _draw_n(player: Player, needed: int)-> void:
	for i in range(needed):
		if player.hand.size() >= player.MAX_HAND_SIZE:
			break
		var drawn := card_generator.draw_n(1)
		player.add_card_to_hand(drawn[0])

## Has a chance to swap player 0 and player 1's hands.
func swap_hands()-> void:
	if randf() > 0.5:
		print("No swap this time.")
		return
		
	var temp := players[0].hand
	players[0].hand = players[1].hand
	players[1].hand = temp
	
	print("Hands swapped")

func end_of_turn_phase()->void:
	for player in players:
		process_hand(player)

func discard_phase()-> void:
	for player in players:
		var candidates := find_discardable_cards(player)
		##auto skips if no cards or all cards are unplayable
		if candidates.is_empty():
			continue
		
		var card := _choose_discard_card(player, candidates)
		player.remove_card_from_hand(card)
		player.discard.append(card)
		print("%s discarded %s" % [player.name, card.internal_name])
		handle_discard_triggers(player, card)
		
## Finds all cards in the player's hand whose cost equals the current turn.
func find_discardable_cards(player: Player) -> Array[Card]:
	var candidates: Array[Card] = []
	for card in player.hand:
		if card.cost == current_turn:
			candidates.append(card)
	return candidates

func _choose_discard_card(player: Player, candidates: Array[Card]) -> Card:
	return candidates[0]

func handle_discard_triggers(player: Player, card: Card)->void:
	if card is PowerCard and card.trigger == PowerCard.POWER_CARD_TRIGGERS.ON_DISCARD:
		apply_effect_to_hand(player, card.effect)

func apply_effect_to_card(card: Card, effect: String) -> void:
	var amount := parse_power(effect)
	if amount == 0:
		return
	card.score += amount
	print("%s effect triggered: score is now %d" % [card.internal_name, card.score])
	
func apply_effect_to_hand(player:Player, effect: String)->void:
	var amount := parse_power(effect)
	if amount==0:
		return
	
	for card in player.hand:
		card.score+=amount
		
## Parses strings like "+5 power", "-1 power", "+2 power" into a signed int.
## Returns 0 for "none" or anything it can't parse.
func parse_power(effect:String)-> int:
	if effect == "none" or effect.is_empty():
		return 0
	
	var cleaned := effect.strip_edges().replace(" ", "")
	
	var signed:=1
	if cleaned.begins_with("-"):
		signed = -1
	cleaned = cleaned.lstrip("+-")
	
	var num_str:=""
	for c in cleaned:
		if c.is_valid_int():
			num_str += c
		else:
			break
	
	if num_str =="":
		return 0
	
	return signed * int(num_str)