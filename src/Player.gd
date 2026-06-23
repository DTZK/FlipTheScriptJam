extends Node
class_name Player

@export var MAX_HAND_SIZE:int = 10
@export var hand: Array[Card] = []

@export var discard: Array[Card] = []
@export var score: int

## Stores the power cards in a separate array for ease of access
var _power_cards: Array[PowerCard] = []

## Signalled when the player tries to add the given card to
## their hand if it's full
signal hand_full(card:Card)

## Emitted if the player successfully adds a card to their hand
signal card_added(card:Card)

## Emitted when the player removes a card from their hand
signal card_removed(card:Card)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Removes the given card from their hand. If the card is not previously in their hand then an
## error will be thrown.
## If successful, the card_removed signal is emitted with the Card in question passed in
func remove_card_from_hand(card: Card):
	if card is PowerCard:
		var card_index = _power_cards.find(card)
		if card_index == -1:
			push_error("Unable to remove power card \"%s\"" % card.internal_name)
			return
		_power_cards.remove_at(card_index)
		
	var hand_index = hand.find(card)
	if hand_index == -1:
		push_error("Unable to remove card \"%s\"" % card.internal_name)
		return
		
	hand.remove_at(hand_index)
	card_removed.emit(card)

## Adds the given card to this player's hand. 
## If their hand is full then the given card will not be added and the hand_full signal is emitted.
## If successful, the card_added signal is emitted with the Card given
func add_card_to_hand(card: Card):
	if card is PowerCard:
		_power_cards.append(card)
		
	# If the player tries to add a card to their hand when it's full (or beyond the MAX_HAND_SIZE),
	# signal it and block adding
	if len(hand) >= MAX_HAND_SIZE:
		hand_full.emit(card)
		return
		
	hand.append(card)
	card_added.emit(card)
