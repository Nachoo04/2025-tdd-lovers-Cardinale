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
	^ self new with: maximumRoll
]

{ #category : 'effect' }
JailSquare >> applyOn: aShip and: aPosition in: aGame [

	aShip beImpeisonedWith: numberToFreedom.
	^ aPosition
]

{ #category : 'effect' }
JailSquare >> repeatEffectFor: aShip on: aPosition in: aGame [

	^ self applyOn: aShip and: aPosition in: aGame
]

{ #category : 'instance creation' }
JailSquare >> with: maximumRoll [

	numberToFreedom := maximumRoll
]
