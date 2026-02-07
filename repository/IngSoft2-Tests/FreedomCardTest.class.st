Class {
	#name : 'FreedomCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aBlueShip',
		'aBlackShip',
		'aRedShip',
		'expectedCards',
		'aProbabilityOfOne',
		'sideToRoll',
		'aWormHole',
		'aLoadedDice',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aFreedomCard',
		'aFreedomCardProbabilisticEvent',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent',
		'someShips',
		'someDices',
		'aGameBuilder',
		'aNullCard',
		'aSetCardManagerWithFreedomCards'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
FreedomCardTest >> setUp [

	super setUp.

	twentySquares := 20.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aRedShip := Ship called: 'RedShip'.
	expectedCards := OrderedCollection new.
	aProbabilityOfOne := 1.

	sideToRoll := #( 1 1 2) asOrderedCollection.

	aWormHole := WormHole between: 18 and: 19.
	aLoadedDice := LoadedDice toRoll: sideToRoll.


	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aSetCardManagerWithFreedomCards := ProbablisiticEventsManager new.

	aFreedomCard := FreedomCard new.
	aFreedomCardProbabilisticEvent := ProbabilisticEvent
		                                for: aFreedomCard
		                                with: aProbabilityOfOne.
	aSetCardManagerWithFreedomCards add: aFreedomCardProbabilisticEvent.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.


	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aSetCardManagerWithFreedomCards.

	aNullCard := NullCard new
]

{ #category : 'tests' }
FreedomCardTest >> testWhenAShipFallIntoAJailSquareAndUseAFreedomCardThenItCanMoves [

	| expectedPosition aGame aSetJailSquare aSetJailSquareProbabilisticEvent aBoard aDistributionManager aDistribution|
	aSetJailSquare := JailSquare initializeWith: someDices.
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

	aGameBuilder setBoard: aBoard.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame
		play: aFreedomCard
		by: aBlueShip
		affecting: anAccelerationCard
		and: aBlackShip.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
