"
This class represent a counter clock wise direction to roll the dices
"
Class {
	#name : 'CounterClockwiseDirection',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
CounterClockwiseDirection >> applySkipPenaltyFor: someShips [

	| affectedShip |
	affectedShip := someShips removeLast.
	affectedShip turnSkipped.
	someShips add: affectedShip
]

{ #category : 'accessing' }
CounterClockwiseDirection >> for: someShips in: aGame by: aShipManager [

	| shipToMove |
	shipToMove := someShips removeLast.
	aShipManager executeMoveFor: shipToMove in: aGame
]

{ #category : 'applying' }
CounterClockwiseDirection >> passFor: someShips by: aShipManager [

	| shipToMove |
	shipToMove := someShips removeLast.
	aShipManager applyPassTurnFor: shipToMove
]

{ #category : 'accessing' }
CounterClockwiseDirection >> queue: aShip to: someShips [

	someShips addFirst: aShip
]

{ #category : 'highlighting' }
CounterClockwiseDirection >> reverse [

	^ ClockwiseDirection new
]
