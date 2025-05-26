Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WormHoleTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
WormHoleTest >> testWhenAShipLandsOnTheBeginningOfAWormHoleThenItEndsUpAtTheEndOfIt [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	twentySquares := 20.
	aWormHole := WormHole between: 2 and: 10.
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
	aBoard := Board with: twentySquares and: aWormHole distributedBy: aDistribution.
	aShip := Ship called: 'BlueShip'.
	sideToRoll := 2.
	aSetDice := LoadedDice toRoll: sideToRoll.
	aShip move: aSetDice roll.
	aShip moveTo: (aBoard moveIfWormHoleAt: aShip currentPosition).
	self assert: aShip currentSquare equals: 10
]

{ #category : 'tests' }
WormHoleTest >> testWhenAShipLandsOnTheEndOfAWormHoleThenItEndsUpAtTheBeginningOfIt [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	twentySquares := 20.
	aWormHole := WormHole between: 2 and: 5.
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
	aBoard := Board with: twentySquares and: aWormHole distributedBy: aDistribution.
	aShip := Ship called: 'BlueShip'.
	sideToRoll := 5.
	aSetDice := LoadedDice toRoll: sideToRoll.
	aShip move: aSetDice roll.
	aShip moveTo: (aBoard moveIfWormHoleAt: aShip currentPosition).
	self assert: aShip currentSquare equals: 2
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithNegativeBeginningThenInvalid [

	self
		should: [ WormHole between: -2 and: 5 ]
		raise: Error
		withMessageText: 'A Worm Hole cannot begin in a negative square'
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithNegativeEndThenInvalid [

	self
		should: [ WormHole between: 2 and: -5 ]
		raise: Error
		withMessageText: 'A Worm Hole cannot end in a negative square'
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithTheBeginningLargerThanTheEndingThenInvalid [

	self
		should: [ WormHole between: 10 and: 5 ]
		raise: Error
		withMessageText:
		'A Worm Hole cannot be created with the beginning larger than the ending'
]
