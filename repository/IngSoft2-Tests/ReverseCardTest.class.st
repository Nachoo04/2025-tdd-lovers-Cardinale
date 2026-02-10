Class {
	#name : 'ReverseCardTest',
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
		'aSetCardManagerWithSkipCards',
		'aReverseCard',
		'aReverseCardProbabilisticEvent',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent',
		'someShips',
		'someDices',
		'aGameBuilder',
		'aNullCard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ReverseCardTest >> setUp [

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

	aReverseCard := ReverseCard new.
	aReverseCardProbabilisticEvent := ProbabilisticEvent
		                                for: aReverseCard
		                                with: aProbabilityOfOne.
	aSetCardManagerWithSkipCards add: aReverseCardProbabilisticEvent.

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

{ #category : 'asserting' }
ReverseCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
ReverseCardTest >> testWhenAReverseCardIsPlayedThenTheRoundDirectionChange [

	|  expectedPosition expectedFuel  aGame |
	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aGameBuilder setAvailableCards: aSetCardManagerWithSkipCards .

	aGame := aGameBuilder build.

	aGame
		play: aReverseCard 
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	self assert: (aBlackShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
ReverseCardTest >> testWhenAReverseCardIsPlayedTwiseThenTheRoundDirectionReturnToHisNormalDirection [

	| expectedPosition expectedFuel aGame |
	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aGameBuilder setAvailableCards: aSetCardManagerWithSkipCards.

	aGame := aGameBuilder build.

	aGame
		play: aReverseCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame
		play: aReverseCard
		by: aBlackShip 
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPlay.
	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
ReverseCardTest >> testWhenAShipPlaysAnSkipCardThenItIsNoLongerInItsHand [

	| aGame aSetCardManager |
	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: aReverseCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	expectedCards add: anAccelerationCard.

	aGame
		play: aReverseCard 
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
ReverseCardTest >> testWhenAShipTriesToPlayAReverseCardThatIsNotInItsHandThenInvalid [

	| aGame aSetCardManager |
	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	self
		should: [
				aGame
					play: aReverseCard 
					by: aBlueShip
					affecting: aNullCard
					and: aBlackShip ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]
