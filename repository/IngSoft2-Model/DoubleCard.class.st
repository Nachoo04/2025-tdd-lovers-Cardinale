"
This class represent a DoubleCard
"
Class {
	#name : 'DoubleCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
DoubleCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	aGame changeTurnModeTo: DoubleRollMode new.
	aGame lastPlayedCard: self.

]

{ #category : 'playing' }
DoubleCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAffectedShip
		in: aGame.
	aPlayingShip remove: self
]

{ #category : 'comparing' }
DoubleCard >> compare: aShip and: anotherShip [

	^ false
]
