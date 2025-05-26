Class {
	#name : 'ShipFuelTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipDecideToPassThenItsFuellsToppedUp [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedFuelLeft plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	fiveSquares := 10.
	sideToRoll := 1.
	oneLap := 1.
	expectedFuelLeft := 2.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
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
	aBoard := Board with: fiveSquares and: aWormHole distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.

	self assert: aBlueShip fuelLeft equals: expectedFuelLeft
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipIsNoLongerPenalisedThenItsFuelIsToppedUp [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedFuelLeft plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	fiveSquares := 10.
	sideToRoll := 1.
	oneLap := 1.
	expectedFuelLeft := 2.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
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
	aBoard := Board with: fiveSquares and: aWormHole distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aBlueShip fuelLeft equals: expectedFuelLeft 
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipMovesAfterPassItsTurnMovesAccordingly [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedPosition plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	fiveSquares := 10.
	sideToRoll := 1.
	oneLap := 1.
	expectedPosition := Position at: 3 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
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
	aBoard := Board with: fiveSquares and: aWormHole distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPosition equals: expectedPosition) 
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipMovesOneSquareThenItsFuelDecreasesAccordingly [

| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedFuelLeft plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	fiveSquares := 5.
	sideToRoll := 1.
	oneLap := 1.
	expectedFuelLeft := 1.

	aWormHole := WormHole between: 0 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
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
	aBoard := Board with: fiveSquares and: aWormHole distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.

	self assert: aBlueShip fuelLeft equals: expectedFuelLeft
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipMovesThroughAWormHoleThenItsFuelDecreasesAccordingly [

| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedFuelLeft plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	fiveSquares := 5.
	sideToRoll := 1.
	oneLap := 1.
	expectedFuelLeft := 1.

	aWormHole := WormHole between: 1 and: 2.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
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
	aBoard := Board with: fiveSquares and: aWormHole distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.

	self assert: aBlueShip fuelLeft equals: expectedFuelLeft
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipTriesToMoveMoreSquaresThanItsRemainingFuelThenItDoesNotMove [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedPosition plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	fiveSquares := 5.
	sideToRoll := 1.
	oneLap := 1.
	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 3 and: 4.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
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
	aBoard := Board with: fiveSquares and: aWormHole distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPosition equals: expectedPosition) 
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipTriesToMoveMoreSquaresThanItsRemainingFuelThenLosesTwoTurns [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedPosition plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility aDistribution |
	fiveSquares := 10.
	sideToRoll := 1.
	oneLap := 1.
	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
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
	aBoard := Board with: fiveSquares and: aWormHole distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPosition equals: expectedPosition) 
]
