Class {
	#name : 'NormalTurnMode',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
NormalTurnMode >> executeOn: aGame [

	^ aGame rollDices.
]
