Class {
	#name : 'NormalTurnMode',
	#superclass : 'TurnMode',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
NormalTurnMode >> executeOn: aGame [

	^ aGame rollDices.
]
