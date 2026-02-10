"
This class represent a DoubleRollMode
"
Class {
	#name : 'DoubleRollMode',
	#superclass : 'RollMode',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
DoubleRollMode >> executeOn: aGame for: aShip [

	| firstNumberRolled rolledNumber |
	firstNumberRolled := aGame rollDices.
	rolledNumber := firstNumberRolled + aGame rollDices.
	aGame move: aShip with: rolledNumber
]
