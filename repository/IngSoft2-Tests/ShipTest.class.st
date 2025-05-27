Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipMakesOneMoveOfTwoSquaresThenItsPositionIsTwo [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder aDefaultDistribution |
	twentySquares := 20.
	aWormHole := WormHole between: 3 and: 10.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDefaultDistribution.
	aShip := Ship called: 'BlueShip'.
	sideToRoll := 2.
	aSetDice := LoadedDice toRoll: sideToRoll.
	aShip move: aSetDice roll.
	self assert: aShip currentSquare equals: 2
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMakesTwoMovesOfOneSquareThenItsPositionIsTwo [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	twentySquares := 20.
	aWormHole := WormHole between: 3 and: 10.
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
	sideToRoll := 1.
	aSetDice := LoadedDice toRoll: sideToRoll.
	aShip move: aSetDice roll.
	aShip move: aSetDice roll.
	self assert: aShip currentSquare equals: 2
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesOneSquareThenItsPositionIsOne [

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
	sideToRoll := 1.
	aSetDice := LoadedDice toRoll: sideToRoll.
	aShip move: aSetDice roll.
	self assert: aShip currentSquare equals: 1
]
