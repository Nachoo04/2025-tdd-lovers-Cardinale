"
This class represent a ReverseCard
"
Class {
	#name : 'ReverseCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
ReverseCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	aGame reverseRound.
	aGame lastPlayedCard: self
]

{ #category : 'playing' }
ReverseCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [ 
	
	self applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame.
	aPlayingShip remove: self
]

{ #category : 'comparing' }
ReverseCard >> compare: aShip and: anotherShip [

	^ false
]
