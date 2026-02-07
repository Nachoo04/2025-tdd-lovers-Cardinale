Class {
	#name : 'FreedomCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
FreedomCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	self applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame
]
