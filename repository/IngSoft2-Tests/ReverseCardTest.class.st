Class {
	#name : 'ReverseCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'aBlueShip',
		'aBlackShip',
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
		'aReverseCard',
		'aSetCardManagerWithReverseCards',
		'aReverseCardProbabilisticEvent',
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

	| twentySquares |
	super setUp.

	twentySquares := 20.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
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

	aSetCardManagerWithReverseCards := ProbablisiticEventsManager new.

	aReverseCard := ReverseCard new.
	aReverseCardProbabilisticEvent := ProbabilisticEvent
		                                  for: aReverseCard
		                                  with: aProbabilityOfOne.
	aSetCardManagerWithReverseCards add: aReverseCardProbabilisticEvent.




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
ReverseCardTest >> testWhenAReverseCardIsPlayedAfterASkipCardThenTheEffectsApplyCorrectly [

	| expectedFuel aGame aSetCardManager blueShipExpectedPosition blackShipExpectedPosition aSkipCard aSkipCardProbabilisticEvent |
	blueShipExpectedPosition := Position at: 0 in: 1.
	blackShipExpectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aSkipCard := SkipCard new.
	aSkipCardProbabilisticEvent := ProbabilisticEvent
		                               for: aSkipCard
		                               with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: aReverseCardProbabilisticEvent.
	aSetCardManager add: aSkipCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.

	aGame := aGameBuilder build.

	aGame
		play: aSkipCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame
		play: aReverseCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	self assert:
		(aBlueShip currentPositionEquals: blueShipExpectedPosition).
	self assert:
		(aBlackShip currentPositionEquals: blackShipExpectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
ReverseCardTest >> testWhenAReverseCardIsPlayedBeforeASkipCardThenTheEffectsApplyCorrectly [

	| expectedFuel aGame aSetCardManager blueShipExpectedPosition blackShipExpectedPosition aSkipCard aSkipCardProbabilisticEvent |
	blueShipExpectedPosition := Position at: 1 in: 1.
	blackShipExpectedPosition := Position at: 0 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aSkipCard := SkipCard new.
	aSkipCardProbabilisticEvent := ProbabilisticEvent
		                               for: aSkipCard
		                               with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: aReverseCardProbabilisticEvent.
	aSetCardManager add: aSkipCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.

	aGame := aGameBuilder build.

	aGame
		play: aReverseCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame
		play: aSkipCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	self assert:
		(aBlueShip currentPositionEquals: blueShipExpectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel).
	self assert:
		(aBlackShip currentPositionEquals: blackShipExpectedPosition)
]

{ #category : 'tests' }
ReverseCardTest >> testWhenAReverseCardIsPlayedThenTheRoundDirectionChange [

	|  expectedPosition expectedFuel  aGame |
	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aGameBuilder setAvailableCards: aSetCardManagerWithReverseCards .

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

	aGameBuilder setAvailableCards: aSetCardManagerWithReverseCards .

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

	| aGame aSetCardManager anAllyCard anAllyCardProbabilisticEvent |
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: aReverseCardProbabilisticEvent.
	aSetCardManager add: anAllyCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	expectedCards add: anAllyCard.

	aGame
		play: aReverseCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
ReverseCardTest >> testWhenAShipTriesToPlayAReverseCardThatIsNotInItsHandThenInvalid [

	| aGame aSetCardManager anAllyCard anAllyCardProbabilisticEvent|
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAllyCardProbabilisticEvent.
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
