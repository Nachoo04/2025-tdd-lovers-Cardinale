Class {
	#name : 'NormalShipState',
	#superclass : 'State',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
NormalShipState >> move: aShip with: aRolledNumber on: aBoard in: aGame [

	aShip movesWith: aRolledNumber on: aBoard in: aGame
]
