"
This class represents a state

"
Class {
	#name : 'DoesntHaveFuelState',
	#superclass : 'FuelState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'borrowing' }
DoesntHaveFuelState >> amountOfFuelNeededBy: someFuel [

	^ someFuel amountNeeded
]

{ #category : 'penalty' }
DoesntHaveFuelState >> applyPenaltyTo: aShip thatStartedFrom: aPosition [

	aShip penalizeAndReturnTo: aPosition.
]

{ #category : 'borrowing' }
DoesntHaveFuelState >> borrowBy: aShip [

	aShip borrowFuelFromAllies
]
