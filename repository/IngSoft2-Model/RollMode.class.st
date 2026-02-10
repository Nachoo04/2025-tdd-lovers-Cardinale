"
This class represent an abstract class for the roll mode
"
Class {
	#name : 'RollMode',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
RollMode >> executeOn: aGame for: aShip [

	self subclassResponsibility
]
