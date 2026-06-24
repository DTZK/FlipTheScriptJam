extends Resource

## PowerEffect is an abstract class that defines a callback for the behaviour of the PowerCard
class_name PowerEffect

## Called by the Game object whenever the card's trigger occurs. Essentially, this should not handle
## listening for the right trigger.
func invoke(player: Player):
	pass
