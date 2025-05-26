Class {
	#name : 'SquareEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SquareEffectTest >> testWhenAllTheSquaresDoNotHaveAnEffectThenTheGameIsPlayedRegularly [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedPosition aDistribution plainSquarePossibility blackHoleSquarePossibility moonWalkSquarePossibility hyperGravitySquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility |
	fiveSquares := 5.
	sideToRoll := 4.
	oneLap := 1.
	"plainSquarePossibility := 0,4.
	blackHoleSquarePossibility := 0,2.
	hyperGravitySquarePossibility := 0,2.
	moonWalkSquarePossibility := 0,1.
	hyperJumpSquarePossibility := 0,08.
	atomicBombSquarePossibility := 0,02."

	plainSquarePossibility := 1.
	blackHoleSquarePossibility := 0.
	hyperGravitySquarePossibility := 0.
	moonWalkSquarePossibility := 0.
	hyperJumpSquarePossibility := 0.
	atomicBombSquarePossibility := 0.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
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
		
	expectedPosition := Position at: 4 in: 1.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPosition equals: expectedPosition)
]
