Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedAndEndsBeforeTheEndingOfItsWormHoleThenInvalid [

	| twentySquares aWormHole aDistributionBuilder aDefaultDistribution |
	twentySquares := 20.
	aWormHole := WormHole between: 15 and: 30.
	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	self
		should: [ Board with: twentySquares and: aWormHole distributedBy: aDefaultDistribution]
		raise: Error
		withMessageText:
		'A Board cannot end before the ending of its Worm Hole'
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedAndTheWormHoleFallsOutsideOfTheDimentionThenInvalid [

	| twentySquares aWormHole plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	twentySquares := 20.
	aWormHole := WormHole between: 25 and: 30.
	plainSquarePossibility := 1.
	blackHoleSquarePossibility := 0.
	hyperGravitySquarePossibility := 0.
	moonWalkSquarePossibility := 0.
	hyperJumpSquarePossibility := 0.
	atomicBombSquarePossibility := 0.
	aDistribution := {
		                 ([ PlainSquare new ] -> plainSquarePossibility).
		                 ([ BlackHoleSquare new ]
		                  -> blackHoleSquarePossibility).
		                 ([ HyperGravitySquare new ]
		                  -> hyperGravitySquarePossibility).
		                 ([ MoonWalkSquare new ]
		                  -> moonWalkSquarePossibility).
		                 ([ HyperJumpSquare new ]
		                  -> hyperJumpSquarePossibility).
		                 ([ AtomicBombSquare new ]
		                  -> atomicBombSquarePossibility) }.
	self
		should: [ Board with: twentySquares and: aWormHole distributedBy: aDistribution]
		raise: Error
		withMessageText:
		'A Worm Hole cannot fall outside of its Boards length'
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedWithACertainDistributionThenTheSquaresWhereThereIsAWormHoleIsAPlainSquare [

	| aWormHole plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution fiveSquares aBoard expectedDistribution |
	fiveSquares := 5.
	aWormHole := WormHole between: 1 and: 2.
	expectedDistribution := 'a BlackHoleSquare' , String cr
	                        , 'a PlainSquare' , String cr
	                        , 'a PlainSquare' , String cr
	                        , 'a BlackHoleSquare' , String cr
	                        , 'a BlackHoleSquare'.
	plainSquarePossibility := 0.
	blackHoleSquarePossibility := 1.
	hyperGravitySquarePossibility := 0.
	moonWalkSquarePossibility := 0.
	hyperJumpSquarePossibility := 0.
	atomicBombSquarePossibility := 0.
	aDistribution := {
		                 ([ PlainSquare new ] -> plainSquarePossibility).
		                 ([ BlackHoleSquare new ]
		                  -> blackHoleSquarePossibility).
		                 ([ HyperGravitySquare new ]
		                  -> hyperGravitySquarePossibility).
		                 ([ MoonWalkSquare new ]
		                  -> moonWalkSquarePossibility).
		                 ([ HyperJumpSquare new ]
		                  -> hyperJumpSquarePossibility).
		                 ([ AtomicBombSquare new ]
		                  -> atomicBombSquarePossibility) }.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.
	self assert: aBoard showDistribution equals: expectedDistribution
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedWithLessThanTwoSquaresThenInvalid [

	| aLength aWormHole plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	aLength := -1.
	aWormHole := WormHole between: 1 and: 2.
	plainSquarePossibility := 1.
	blackHoleSquarePossibility := 0.
	hyperGravitySquarePossibility := 0.
	moonWalkSquarePossibility := 0.
	hyperJumpSquarePossibility := 0.
	atomicBombSquarePossibility := 0.
	aDistribution := {
		                 ([ PlainSquare new ] -> plainSquarePossibility).
		                 ([ BlackHoleSquare new ]
		                  -> blackHoleSquarePossibility).
		                 ([ HyperGravitySquare new ]
		                  -> hyperGravitySquarePossibility).
		                 ([ MoonWalkSquare new ]
		                  -> moonWalkSquarePossibility).
		                 ([ HyperJumpSquare new ]
		                  -> hyperJumpSquarePossibility).
		                 ([ AtomicBombSquare new ]
		                  -> atomicBombSquarePossibility) }.
	self
		should: [ Board with: aLength and: aWormHole distributedBy: aDistribution]
		raise: Error
		withMessageText: 'Board must have at least two squares'
]
