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

{ #category : 'penalty' }
ShipsManager >> applyRollModifier: aPenalty [

	ships do: [ :aShip | aShip applyRollModifier: aPenalty ]
]

{ #category : 'action' }
ShipsManager >> applySkipPenalty [

	turnDirection applySkipPenaltyFor: ships
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

{ #category : 'accessing' }
ShipsManager >> nextShip [

	^ turnDirection for: ships
]

{ #category : 'action' }
ShipsManager >> passNextShip [

	| shipToMove |
	shipToMove := turnDirection for: ships.
	shipToMove restoreFuel.
	self queue: shipToMove
]

{ #category : 'accessing' }
ShipsManager >> playNextShipIn: aGame [

	| shipToMove |
	shipToMove := turnDirection for: ships.
	aGame executeRollFor: shipToMove.
	self queue: shipToMove
]

{ #category : 'accessing' }
ShipsManager >> queue: aShip [

	turnDirection queue: aShip to: ships 
]

{ #category : 'action' }
ShipsManager >> reverseOrder [

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
ShipsManager >> validateShip [

	^ ships first
]
