Class {
	#name : 'ClockwiseDirection',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ClockwiseDirection >> applySkipPenaltyFor: someShips [

	| affectedShip |
	affectedShip := someShips removeFirst.
	affectedShip turnSkipped.
	someShips addFirst: affectedShip
]

{ #category : 'as yet unclassified' }
ClockwiseDirection >> queue: aShip to: someShips [

	someShips add: aShip .
]

{ #category : 'highlighting' }
ClockwiseDirection >> reverse [

	^ CounterClockwiseDirection new
]

{ #category : 'accessing' }
ClockwiseDirection >> to: someShips [

	| shipToMove |
	shipToMove := someShips removeFirst.
	^ shipToMove
]
