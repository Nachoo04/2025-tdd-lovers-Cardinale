"
This class represent a TrappedShipState
"
Class {
	#name : 'TrappedShipState',
	#superclass : 'State',
	#instVars : [
		'freedom'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TrappedShipState class >> with: aNumberForFreedom [

	^ self new initializeWith: aNumberForFreedom
]

{ #category : 'instance creation' }
TrappedShipState >> initializeWith: aNumberForFreedom [

	freedom := aNumberForFreedom
]

{ #category : 'instance creation' }
TrappedShipState >> letOut: aShip [

	aShip state: NormalShipState new
]

{ #category : 'accessing' }
TrappedShipState >> move: aShip with: rolledNumber on: aBoard in: aGame [

	rolledNumber = freedom ifFalse: [ ^ self ].
	self letOut: aShip.
	aShip movesWith: rolledNumber on: aBoard in: aGame
]
