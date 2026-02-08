Class {
	#name : 'CounterClockwiseDirection',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CounterClockwiseDirection >> queue: aShip to: someShips [

	someShips addFirst: aShip
]

{ #category : 'highlighting' }
CounterClockwiseDirection >> reverse [

	^ ClockwiseDirection new
]

{ #category : 'accessing' }
CounterClockwiseDirection >> to: someShips [

	| shipToMove |
	shipToMove := someShips removeLast.
	^ shipToMove
]
