"
""This class represents a Game""
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'dices',
		'finished',
		'winner',
		'laps',
		'rewards',
		'cards',
		'lastEffect',
		'lastPlayedCard',
		'activePermanentCards',
		'raceGoal',
		'rollMode',
		'shipsManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Game class >> assignCardsTo: someShips from: aCardsManager [

	| someCards |
	someCards := aCardsManager generateFor: 2.
	someShips do: [ :aShip | aShip addCards: someCards ]
]

{ #category : 'creation' }
Game class >> fuel: someShips with: aFuelQuantity [

	someShips do: [ :aShip | aShip fuel: aFuelQuantity ]
]

{ #category : 'validation' }
Game class >> hasDices: someDices [

	someDices size < 1 ifTrue: [
		Error signal: 'The Game needs at least one dice to start.' ]
]

{ #category : 'validation' }
Game class >> hasLaps: someLaps [

	someLaps < 1 ifTrue: [
		Error signal: 'The Game needs at least one lap to start.' ]
]

{ #category : 'validation' }
Game class >> hasShips: someShips [

	someShips size < 2 ifTrue: [
		Error signal: 'The Game needs at least two ship to start.' ]
]

{ #category : 'accessing' }
Game class >> maximumRoll: someDices [

	^ someDices sum: [ :aDice | aDice rollMaximum ]
]

{ #category : 'validation' }
Game class >> validateSquaresFrom: aBoard with: someDices [

	aBoard validateSquaresWith: (self maximumRoll: someDices)
]

{ #category : 'creation' }
Game class >> with: aBoard for: someLaps and: someShips and: someDices and: aFuelQuantity and: aRewardManager and: aCardsManager [

	self hasDices: someDices.
	self hasShips: someShips.
	self hasLaps: someLaps.
	self fuel: someShips with: aFuelQuantity.
	self assignCardsTo: someShips from: aCardsManager.
	self validateSquaresFrom: aBoard with: someDices.
	^ self new
		  initializeWith: aBoard
		  for: someLaps
		  and: someShips
		  and: someDices
		  and: aRewardManager
			and: aCardsManager
]

{ #category : 'accessing' }
Game >> addActiveCard: aCard [

	activePermanentCards add: aCard
]

{ #category : 'action' }
Game >> applyLastEffectTo: aShip [

	| shipInitialPosition shipPositionAfterEffect |
	shipInitialPosition := aShip currentPosition.

	shipPositionAfterEffect := lastEffect
		                           repeatEffectFor: aShip
		                           on: shipInitialPosition
		                           in: self.

	aShip performMovementFrom: shipInitialPosition to: shipPositionAfterEffect on: board
]

{ #category : 'action' }
Game >> applyRewardTo: aShip for: aRolledNumber [

	aRolledNumber = self maximumRoll ifTrue: [
		rewards generateOne applyTo: aShip ]
]

{ #category : 'action' }
Game >> applyRollModifier: aPenalty [

	shipsManager applyRollModifier: aPenalty 
]

{ #category : 'action' }
Game >> calculateDistanceBetween: aPosition and: anotherPosition [

	^ board calculateDistanceBetween: aPosition and: anotherPosition
]

{ #category : 'validation' }
Game >> canStillPlay [

	finished ifTrue: [ Error signal: 'The game has finished.' ]
]

{ #category : 'action' }
Game >> changeRollModeTo: aTurnMode [

	rollMode := aTurnMode
]

{ #category : 'action' }
Game >> executeRollFor: aShip [

	rollMode executeOn: self for: aShip.

	
]

{ #category : 'changing state' }
Game >> finish [

	finished := true
]

{ #category : 'action' }
Game >> generateCard [

	^ cards generateFor: 1.
]

{ #category : 'action' }
Game >> goBackFourSquares: aShip from: aPosition [ 
	
	^ board goBackFourSquares: aShip from: aPosition 
]

{ #category : 'validation' }
Game >> hasFinished [

	^ finished
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard for: someLaps and: someShips and: someDices and: aRewardManager and: aCardMaganer [

	board := aBoard.
	dices := someDices.
	laps := someLaps.
	finished := false.
	rewards := aRewardManager.
	cards := aCardMaganer.
	lastEffect := PlainSquare new.
	winner := NullShip new.
	lastPlayedCard := NullCard new.
	raceGoal := Position at: 0 in: someLaps.
	activePermanentCards := OrderedCollection new.
	rollMode := NormalRollMode new.
	shipsManager := ShipsManager with: someShips 
]

{ #category : 'action' }
Game >> jump: squaresToJump from: aPosition [ 
	
	^ board jump: squaresToJump from: aPosition 
]

{ #category : 'accessing' }
Game >> lastEffect: anEffect [

	lastEffect := anEffect
]

{ #category : 'accessing' }
Game >> lastPlayedCard: aCard [

	lastPlayedCard := aCard
]

{ #category : 'accessing' }
Game >> maximumRoll [

	^ dices sum: [ :aDice | aDice rollMaximum ]
]

{ #category : 'action' }
Game >> move: aShip backwardsBy: aMagnitude [

	^ aShip moveBackwards: aMagnitude in: board.
]

{ #category : 'action' }
Game >> move: aShip with: rolledNumber [

	self applyRewardTo: aShip for: rolledNumber.
	aShip playTurnWith: rolledNumber on: board in: self.
	aShip currentPosition > raceGoal ifFalse: [ ^ self ].
	self finish.
	winner := aShip
]

{ #category : 'action' }
Game >> moveShipsBackwards: aMagnitude [

	shipsManager moveShipsBackwards: aMagnitude in: board.
]

{ #category : 'action' }
Game >> moveShipsToSquareZero [
	
	shipsManager moveShipsToSquareZero.
]

{ #category : 'action' }
Game >> nextTurnPass [

	self canStillPlay.
	shipsManager passNextShip
]

{ #category : 'action' }
Game >> nextTurnPlay [


	self canStillPlay.

	shipsManager playNextShipIn: self.


	self changeRollModeTo: NormalRollMode new
]

{ #category : 'action' }
Game >> play: aPlayedCard by: aPlayingShip affecting: anAffectedCard and: anAfectedShip [

	aPlayingShip validateCard: aPlayedCard.

	aPlayedCard
		bePlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAfectedShip
		in: self
]

{ #category : 'action' }
Game >> playLastCardBy: aPlayingShip affecting: anAffectedCard and: aTargetShip [

	lastPlayedCard
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: aTargetShip
		in: self.
]

{ #category : 'printing' }
Game >> printBoard [

	| winnerShip shipsScore results |
	winnerShip := 'Winner: ' , winner name , String cr.
	shipsScore := shipsManager shipsScoreOn: board.
	results := winnerShip , shipsScore.
	^ results
]

{ #category : 'removing' }
Game >> remove: anAffectedCard playedBy: aShip [

	self validateIsActive: anAffectedCard.
	activePermanentCards remove: anAffectedCard.
	anAffectedCard cancelEffectIn: self
]

{ #category : 'action' }
Game >> reverseRound [

	shipsManager reverseRoundOrder.
]

{ #category : 'action' }
Game >> rollDices [

	| rolledNumber |
	rolledNumber := dices sumNumbers: [ :aDice | aDice roll ].

	^ rolledNumber
]

{ #category : 'action' }
Game >> skipNextPlayer [

	shipsManager skipNextShip.
]

{ #category : 'validation' }
Game >> validateIsActive: aCard [

	(activePermanentCards includes: aCard) ifFalse: [
		Error signal: 'The card is not active.' ]
]

{ #category : 'validation' }
Game >> validateNextPlayer: aShip [


	((shipsManager validateShip) equals: aShip) ifFalse: [
		Error signal:
			'A permanent card cannot be played when it is not your turn.' ]
]
