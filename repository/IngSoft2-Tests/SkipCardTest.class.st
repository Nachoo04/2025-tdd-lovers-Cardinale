Class {
	#name : 'SkipCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aBlueShip',
		'aBlackShip',
		'aRedShip',
		'expectedCards',
		'aDistributionManager',
		'aPlainSquare',
		'aProbabilityOfOne',
		'aPlainSquareProbabilisticEvent',
		'sideToRoll',
		'aWormHole',
		'aLoadedDice',
		'aDistribution',
		'aBoard',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'anSkipCard',
		'anSkipCardProbabilisticEvent',
		'aSetCardManagerWithSkipCards',
		'someShips',
		'someDices',
		'aGameBuilder',
		'aNullCard',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
SkipCardTest >> setUp [

	super setUp.

	twentySquares := 20.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aRedShip := Ship called: 'RedShip'.
	expectedCards := OrderedCollection new.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.

	sideToRoll := #( 1 ) asOrderedCollection.

	aWormHole := WormHole between: 18 and: 19.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
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

	aSetCardManagerWithSkipCards := ProbablisiticEventsManager new.

	anSkipCard := SkipCard new.
	anSkipCardProbabilisticEvent := ProbabilisticEvent
		                                for: anSkipCard
		                                with: aProbabilityOfOne.
	aSetCardManagerWithSkipCards add: anSkipCardProbabilisticEvent.

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
	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.

	aNullCard := NullCard new
]

{ #category : 'tests' }
SkipCardTest >> testWhenAShipPlaysAnSkipCardThenItIsNoLongerInItsHand [

	| aGame aSetCardManager |
	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anSkipCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	expectedCards add: anAccelerationCard.

	aGame
		play: anSkipCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
SkipCardTest >> testWhenASkipCardIsPlayedThenTheActualShipIsSkipped [

	|  expectedPosition expectedFuel  aGame |
	expectedPosition := Position at: 0 in: 1.
	expectedFuel := Fuel with: 2 upTo: 2 in: HasFuelState new.

	aGameBuilder setAvailableCards: aSetCardManagerWithSkipCards .

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

	|  expectedPosition expectedFuel  aGame |
	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.


	aGameBuilder setAvailableCards: aSetCardManagerWithSkipCards .

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
