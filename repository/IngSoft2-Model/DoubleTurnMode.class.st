Class {
	#name : 'DoubleTurnMode',
	#superclass : 'TurnMode',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
DoubleTurnMode >> executeOn: aGame [

	| firstNumberRolled |
	firstNumberRolled := aGame rollDices.
	^ firstNumberRolled + aGame rollDices
]
