"
This class represent a clock wise direction to roll the dices.
"
Class {
	#name : 'ClockwiseDirection',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
ClockwiseDirection >> applySkipPenaltyFor: someShips [

	| affectedShip |
	affectedShip := someShips removeFirst.
	affectedShip turnSkipped.
	someShips addFirst: affectedShip
]

{ #category : 'accessing' }
ClockwiseDirection >> for: someShips in: aGame by: aShipManager [

	| shipToMove |
	shipToMove := someShips removeFirst.
	aShipManager executeMoveFor: shipToMove in: aGame
]

{ #category : 'applying' }
ClockwiseDirection >> passFor: someShips by: aShipManager [

	| shipToMove |
	shipToMove := someShips removeFirst.
	aShipManager applyPassTurnFor: shipToMove
]

{ #category : 'accessing' }
ClockwiseDirection >> queue: aShip to: someShips [

	someShips add: aShip .
]

{ #category : 'highlighting' }
ClockwiseDirection >> reverse [

	^ CounterClockwiseDirection new
]
