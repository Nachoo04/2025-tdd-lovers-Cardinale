"
This class represent a SkipCard
"
Class {
	#name : 'SkipCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
SkipCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	aGame applySkipPenalty.
	aGame lastPlayedCard: self.

]

{ #category : 'playing' }
SkipCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: aTargetShip in: aGame [ 
	
	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: aTargetShip
		in: aGame.
	aPlayingShip remove: self
	
]

{ #category : 'comparing' }
SkipCard >> compare: aShip and: anotherShip [

	^ false
]
