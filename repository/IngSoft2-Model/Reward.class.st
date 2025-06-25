"
This class represents a reward
"
Class {
	#name : 'Reward',
	#superclass : 'Object',
	#instVars : [
		'magnitude'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
Reward >> applyTo: aShip [

	self subclassResponsibility.
]
