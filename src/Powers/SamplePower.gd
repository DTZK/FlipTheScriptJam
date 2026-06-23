extends PowerEffect

func invoke(player: Player):
	for card:Card in player.Hand:
		if card.score >= 10:
			player.score += 5
