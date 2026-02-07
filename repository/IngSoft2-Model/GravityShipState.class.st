Class {
	#name : 'GravityShipState',
	#superclass : 'State',
	#instVars : [
		'gravityPenalty'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
GravityShipState class >> initializeWith: aGravityPenalty [

	^ self new initializeWith: aGravityPenalty
]

{ #category : 'initialization' }
GravityShipState >> initializeWith: aGravityPenalty [

	gravityPenalty := aGravityPenalty
]

{ #category : 'accessing' }
GravityShipState >> move: aShip with: rolledNumber on: aBoard in: aGame [

	rolledNumber >= gravityPenalty ifFalse: [ ^ self ].
	aShip state: NormalShipState new.
	aShip movesWith: rolledNumber on: aBoard in: aGame
]
