Class {
	#name : 'TurnSequencer',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'turnDirection'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TurnSequencer class >> with: someShips [

	^ self new initializeWith: someShips
]

{ #category : 'penalty' }
TurnSequencer >> applyRollModifier: aPenalty [

	ships do: [ :aShip | aShip applyRollModifier: aPenalty ]
]

{ #category : 'as yet unclassified' }
TurnSequencer >> applySkipPenalty [

	turnDirection applySkipPenaltyFor: ships
]

{ #category : 'initialization' }
TurnSequencer >> initializeWith: someShips [

	ships:= someShips.
	turnDirection := ClockwiseDirection new.
]

{ #category : 'as yet unclassified' }
TurnSequencer >> nextShip [

	^ turnDirection to: ships
]

{ #category : 'accessing' }
TurnSequencer >> queue: aShip [

	turnDirection queue: aShip to: ships 
]

{ #category : 'as yet unclassified' }
TurnSequencer >> reverseOrder [

	turnDirection := turnDirection reverse
]

{ #category : 'as yet unclassified' }
TurnSequencer >> validateShip [

	^ ships first
]
