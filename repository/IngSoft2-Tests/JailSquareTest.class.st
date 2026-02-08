Class {
	#name : 'JailSquareTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aProbabilityOfOne',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aCardManager',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'someShips',
		'aGameBuilder',
		'aDistributionManager',
		'aNullCard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
JailSquareTest >> setUp [

	super setUp.

	twentySquares := 20.

	aProbabilityOfOne := 1.
	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	aNullCard := NullCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager
]

{ #category : 'tests' }
JailSquareTest >> testWhenAShipFallIntoAJailSquareAndDontRollTheMaximumRollThenItCantMoves [

	| sideToRoll aLoadedDice expectedPosition someDices aGame aSetJailSquare aSetJailSquareProbabilisticEvent aBoard aDistribution |
	sideToRoll := #( 2 1 ) asOrderedCollection.

	aLoadedDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aSetJailSquare := JailSquare with: someDices.
	aSetJailSquareProbabilisticEvent := ProbabilisticEvent
		                                    for: aSetJailSquare
		                                    with: aProbabilityOfOne.

	aDistributionManager := ProbablisiticEventsManager new.
	aDistributionManager add: aSetJailSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	expectedPosition := Position at: 2 in: 1.

	aGameBuilder setDices: someDices.
	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
JailSquareTest >> testWhenAShipFallIntoAJailSquareAndItsFreeButItHasntFuellEnoughtThenItDoesntMove [

	| sideToRoll aLoadedDice expectedPosition someDices aGame aSetJailSquare aSetJailSquareProbabilisticEvent aDistribution aBoard expectedFuel |
	sideToRoll := #( 1 2 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 3 in: 1.
	expectedFuel := Fuel with: 3 upTo: 4 in: HasFuelState new.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aSetJailSquare := JailSquare with: someDices.
	aSetJailSquareProbabilisticEvent := ProbabilisticEvent
		                                    for: aSetJailSquare
		                                    with: aProbabilityOfOne.

	aDistributionManager := ProbablisiticEventsManager new.
	aDistributionManager add: aSetJailSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.


	aGameBuilder setDices: someDices.
	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
]

{ #category : 'tests' }
JailSquareTest >> testWhenAShipFallIntoAJailSquareAndItsFreeButItHasntFuellEnoughtThenItUseItsAllyFuel [

	| sideToRoll aLoadedDice expectedPosition someDices aGame aSetJailSquare aSetJailSquareProbabilisticEvent aDistribution aBoard expectedFuel |
	sideToRoll := #( 1 2 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 5 in: 1.
	expectedFuel := Fuel with: 3 upTo: 4 in: HasFuelState new.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aSetJailSquare := JailSquare with: someDices.
	aSetJailSquareProbabilisticEvent := ProbabilisticEvent
		                                    for: aSetJailSquare
		                                    with: aProbabilityOfOne.

	aDistributionManager add: aSetJailSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setDices: someDices.
	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
JailSquareTest >> testWhenAShipFallIntoAJailSquareAndRollTheMaximumRollThenItCanMoves [

	| sideToRoll aLoadedDice expectedPosition someDices aGame aSetJailSquare aSetJailSquareProbabilisticEvent  aDistribution aBoard |
	sideToRoll := #( 1 1 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 3 in: 1.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aSetJailSquare := JailSquare with: someDices.
	aSetJailSquareProbabilisticEvent := ProbabilisticEvent
		                                    for: aSetJailSquare
		                                    with: aProbabilityOfOne.

	aDistributionManager := ProbablisiticEventsManager new.
	aDistributionManager add: aSetJailSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setDices: someDices.
	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
