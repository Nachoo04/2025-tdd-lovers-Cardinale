"
This class represent an abstract class of State
"
Class {
	#name : 'State',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
State >> move: aShip with: aRolledNumber on: aBoard in: aGame [

	self subclassResponsibility
]
