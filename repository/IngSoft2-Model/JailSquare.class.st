"
This class represent a JailSquare
"
Class {
	#name : 'JailSquare',
	#superclass : 'Square',
	#instVars : [
		'numberToFreedom'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
JailSquare class >> with: someDices [

	| maximumRoll |
	maximumRoll := someDices sum: [ :aDice | aDice rollMaximum ].
	^ self new initializeWith: maximumRoll
]

{ #category : 'effect' }
JailSquare >> applyOn: aShip and: aPosition in: aGame [

	aShip beImpeisonedWith: numberToFreedom.
	^ aPosition
]

{ #category : 'instance creation' }
JailSquare >> initializeWith: maximumRoll [

	numberToFreedom := maximumRoll
]

{ #category : 'effect' }
JailSquare >> repeatEffectFor: aShip on: aPosition in: aGame [

	^ self applyOn: aShip and: aPosition in: aGame
]
