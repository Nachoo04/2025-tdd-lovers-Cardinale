"
This class represent the states of the fuel
"
Class {
	#name : 'FuelState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'penalty' }
FuelState >> applyPenaltyTo: aShip thatStartedFrom: aPosition [

	self subclassResponsibility
]

{ #category : 'borrowing' }
FuelState >> borrowBy: aShip [

	self subclassResponsibility
]
