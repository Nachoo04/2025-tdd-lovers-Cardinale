"
This represent a dice
"
Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfSides',
		'initialSide'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Dice class >> numberOfSidesGreaterThanTwo: numberOfSides [

	numberOfSides < 2 ifTrue: [
		Error signal: 'Dice must have at least two sides.' ]
]

{ #category : 'creation' }
Dice class >> with: numberOfSides [

	self numberOfSidesGreaterThanTwo: numberOfSides.
	^ self new with: numberOfSides
]

{ #category : 'functions' }
Dice >> roll [

	^ (initialSide for: numberOfSides) atRandom
]

{ #category : 'functions' }
Dice >> rollMaximum [

	^ numberOfSides
]

{ #category : 'initialization' }
Dice >> with: sides [

	numberOfSides := sides.
	initialSide := 1
]
