Class {
	#name : 'TrappedShipState',
	#superclass : 'Object',
	#instVars : [
		'freedom'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TrappedShipState class >> with: aNumberForFreedom [

	^ self new with: aNumberForFreedom
]

{ #category : 'accessing' }
TrappedShipState >> move: aShip with: rolledNumber on: aBoard in: aGame [

	rolledNumber = freedom ifFalse: [ ^ self ].
	aShip state: NormalShipState new.
	aShip movesWith: rolledNumber on: aBoard in: aGame
]

{ #category : 'instance creation' }
TrappedShipState >> with: aNumberForFreedom [

	freedom := aNumberForFreedom
]
