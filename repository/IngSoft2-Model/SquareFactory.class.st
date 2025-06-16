Class {
	#name : 'SquareFactory',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creating' }
SquareFactory class >> with: aLength and: aWormHole and: aDistribution [

	| generatedSquares |
	generatedSquares := (0 to: aLength - 1) collect: [ :aSquare |
		                    (aWormHole hasEndAt: aSquare)
			                    ifTrue: [ PlainSquare new ]
			                    ifFalse: [
				                    (aDistribution
					                     atRandom: Random new
					                     weighting: [ :aSquareProbability |
					                     aSquareProbability value ]) key value ] ].

	^ generatedSquares asOrderedCollection
]
