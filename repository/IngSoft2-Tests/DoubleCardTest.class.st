Class {
	#name : 'DoubleCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DoubleCardTest >> testWhenADoubleCardIsPlayedTheShipAffectedMovesCorrectly [


	| twentySquares aBlueShip aBlackShip aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aCardManager anDoubleCard anSkipCardProbabilisticEvent someShips aGameBuilder expectedPosition expectedFuel sideToRoll aWormHole aLoadedDice aBoard someDices aNullCard aGame |
	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 0 upTo: 2 in: HasFuelState new.

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
	anDoubleCard := DoubleCard new.
	aNullCard := NullCard new.
	anSkipCardProbabilisticEvent := ProbabilisticEvent
		                                for: anDoubleCard
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
		play: anDoubleCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
DoubleCardTest >> testWhenAShipMovesNoramlThenADoubleCardIsPlayAndTheNextShipMovesCorrectly [

	| twentySquares aBlueShip aBlackShip aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aCardManager anDoubleCard anSkipCardProbabilisticEvent someShips aGameBuilder expectedPosition expectedFuel sideToRoll aWormHole aLoadedDice aBoard someDices aNullCard aGame |
	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 0 upTo: 2 in: HasFuelState new.

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
	anDoubleCard := DoubleCard new.
	aNullCard := NullCard new.
	anSkipCardProbabilisticEvent := ProbabilisticEvent
		                                for: anDoubleCard
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
	aGame nextTurnPlay.
	aGame
		play: anDoubleCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	self assert: (aBlackShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]
