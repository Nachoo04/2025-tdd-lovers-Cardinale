Class {
	#name : 'JailSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
JailSquare >> applyOn: aShip and: aPosition in: aGame [

	aShip beImpeisoned.
	^ aPosition
]
