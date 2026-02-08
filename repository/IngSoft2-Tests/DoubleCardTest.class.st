Class {
	#name : 'DoubleCardTest',
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
		'aCardManager',
		'zeroRewardRewardProbabilisticEvent',
		'anDoubleCard',
		'anDoubleCardProbabilisticEvent',
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
DoubleCardTest >> setUp [

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

	aCardManager := ProbablisiticEventsManager new.


	anDoubleCard := DoubleCard new.
	anDoubleCardProbabilisticEvent := ProbabilisticEvent
		                                  for: anDoubleCard
		                                  with: aProbabilityOfOne.
	aCardManager add: anDoubleCardProbabilisticEvent.

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
DoubleCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
DoubleCardTest >> testWhenADoubleCardIsPlayedTheShipAffectedMovesCorrectly [


	| expectedPosition expectedFuel  aGame |
	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 0 upTo: 2 in: HasFuelState new.

	
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

	|  expectedPosition expectedFuel  aGame |
	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 0 upTo: 2 in: HasFuelState new.


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

{ #category : 'tests' }
DoubleCardTest >> testWhenAShipPlaysADoubleCardThenItIsNoLongerInItsHand [

	| aGame aSetCardManager |
	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anDoubleCardProbabilisticEvent .
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	expectedCards add: anAccelerationCard.

	aGame
		play: anDoubleCard 
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
DoubleCardTest >> testWhenAShipTriesToPlayAnAllyCardThatIsNotInItsHandThenInvalid [

	| aGame aSetCardManager |
	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	self
		should: [
				aGame
					play: anDoubleCard
					by: aBlueShip
					affecting: aNullCard
					and: aBlackShip ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]
