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
		'aDistribution',
		'aBoard',
		'aSetJailSquare',
		'aSetJailSquareProbabilisticEvent'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
JailSquareTest >> setUp [

	super setUp.

	twentySquares := 20.


	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.


	aDistributionManager := ProbablisiticEventsManager new.
	aSetJailSquare := JailSquare new.
	aProbabilityOfOne := 1.
	aSetJailSquareProbabilisticEvent := ProbabilisticEvent
		                                    for: aSetJailSquare
		                                    with: aProbabilityOfOne.
	aDistributionManager add: aSetJailSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setBoard: aBoard.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager
]

{ #category : 'tests' }
JailSquareTest >> testWhenAShipFallIntoAJailSquareAndDontRollTheMaximumRollThenItCantMoves [

	| sideToRoll aLoadedDice expectedPosition someDices aGame |
	sideToRoll := #( 2 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 2 in: 1.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
