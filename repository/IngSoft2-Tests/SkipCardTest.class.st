Class {
	#name : 'SkipCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SkipCardTest >> testWhenASkipCardIsPlayedThenTheActualShipIsSkipped [

	| twentySquares aBlueShip aBlackShip aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aCardManager anSkipCard anSkipCardProbabilisticEvent someShips aGameBuilder expectedPosition expectedFuel sideToRoll aWormHole aLoadedDice aBoard someDices aNullCard aGame |
	expectedPosition := Position at: 0 in: 1.
	expectedFuel := Fuel with: 2 upTo: 2 in: HasFuelState new.

	twentySquares := 20.

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	sideToRoll := #( 1 ) asOrderedCollection.

	aWormHole := WormHole between: 18 and: 19.
	aLoadedDice := LoadedDice toRoll: sideToRoll.


	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anSkipCard := SkipCard new.
	aNullCard := NullCard new.
	anSkipCardProbabilisticEvent := ProbabilisticEvent
		                                for: anSkipCard
		                                with: aProbabilityOfOne.
	aCardManager add: anSkipCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.

	aGame := aGameBuilder build.

	aGame
		play: anSkipCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
SkipCardTest >> testWhenASkipCardWasPlayThenAffectedShipCanPlayAfterAFullRound [

	| twentySquares aBlueShip aBlackShip aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aCardManager anSkipCard anSkipCardProbabilisticEvent someShips aGameBuilder expectedPosition expectedFuel sideToRoll aWormHole aLoadedDice aBoard someDices aNullCard aGame |
	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	twentySquares := 20.

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	sideToRoll := #( 1 ) asOrderedCollection.

	aWormHole := WormHole between: 18 and: 19.
	aLoadedDice := LoadedDice toRoll: sideToRoll.


	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anSkipCard := SkipCard new.
	aNullCard := NullCard new.
	anSkipCardProbabilisticEvent := ProbabilisticEvent
		                                for: anSkipCard
		                                with: aProbabilityOfOne.
	aCardManager add: anSkipCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.

	aGame := aGameBuilder build.

	aGame
		play: anSkipCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]
