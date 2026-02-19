"
This class represent a NormalRollMode
"
Class {
	#name : 'NormalRollMode',
	#superclass : 'RollMode',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
NormalRollMode >> executeOn: aGame for: aShip [

	| rolledNumber |
	rolledNumber := aGame rollDices.
	aGame move: aShip with: rolledNumber
]
