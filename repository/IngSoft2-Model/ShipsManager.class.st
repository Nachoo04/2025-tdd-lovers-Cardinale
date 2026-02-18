"
This class represent a manager for the ships
"
Class {
	#name : 'ShipsManager',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'turnDirection'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ShipsManager class >> with: someShips [

	^ self new initializeWith: someShips
]

{ #category : 'action' }
ShipsManager >> applyPassTurnFor: aShip [

	aShip restoreFuel.
	self queue: aShip
]

{ #category : 'penalty' }
ShipsManager >> applyRollModifier: aPenalty [

	ships do: [ :aShip | aShip applyRollModifier: aPenalty ]
]

{ #category : 'action' }
ShipsManager >> executeMoveFor: aShip in: aGame [

	aGame executeRollFor: aShip.
	self queue: aShip
]

{ #category : 'initialization' }
ShipsManager >> initializeWith: someShips [

	ships:= someShips.
	turnDirection := ClockwiseDirection new.
]

{ #category : 'action' }
ShipsManager >> moveShipsBackwards: aMagnitude in: aBoard [

	ships do: [ :aShip | aShip moveBackwards: aMagnitude in: aBoard ]
]

{ #category : 'action' }
ShipsManager >> moveShipsToSquareZero [
	
	ships do: [ :aShip | aShip moveTo: (aShip currentPosition adjustSquare: 0) ]
]

{ #category : 'action' }
ShipsManager >> passNextShip [

	turnDirection passFor: ships by: self.

]

{ #category : 'accessing' }
ShipsManager >> playNextShipIn: aGame [

	turnDirection for: ships in: aGame by: self
]

{ #category : 'accessing' }
ShipsManager >> queue: aShip [

	turnDirection queue: aShip to: ships 
]

{ #category : 'action' }
ShipsManager >> reverseRoundOrder [

	turnDirection := turnDirection reverse
]

{ #category : 'action' }
ShipsManager >> shipsScoreOn: aBoard [

	| positions sortedPositions |
	sortedPositions := ships sorted: [ :aShip |
			                   aBoard
				                   calculateDistanceBetween:
				                   (Position at: 0 in: 1)
				                   and: aShip currentPosition ] descending.
	positions := String cr join:
		             (sortedPositions collect: [ :aShip | aShip details ]).

	^ positions
]

{ #category : 'action' }
ShipsManager >> skipNextShip [

	turnDirection applySkipPenaltyFor: ships
]

{ #category : 'action' }
ShipsManager >> validateShip [

	^ ships first
]
