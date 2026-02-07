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
TrappedShipState class >> initializeWith: aNumberForFreedom [

	^ self new initializeWith: aNumberForFreedom
]

{ #category : 'instance creation' }
TrappedShipState >> initializeWith: aNumberForFreedom [

	freedom := aNumberForFreedom
]

{ #category : 'accessing' }
TrappedShipState >> move: aShip with: rolledNumber on: aBoard in: aGame [

	rolledNumber = freedom ifFalse: [ ^ self ].
	aShip state: NormalShipState new.
	aShip movesWith: rolledNumber on: aBoard in: aGame
]
