Class {
	#name : #ChessGame,
	#superclass : #Object,
	#instVars : [
		'view',
		'board',
		'whitePlayer',
		'blackPlayer',
		'playerToMove',
		'indicator'
	],
	#category : #'Chess-GameLogic'
}

{ #category : #turning }
ChessGame >> drawIndicator: aText [
	indicator ifNotNil: [ indicator remove ].
	indicator := RTElement new
		addShape: (RTLabel new text: aText);
		translateTo: (4.5 @ 9) * 45.
	view add: indicator.
]

{ #category : #turning }
ChessGame >> endTurn [
	playerToMove := playerToMove == whitePlayer
	ifTrue: [ blackPlayer ]
	ifFalse: [ whitePlayer ].
	playerToMove beforeTurn
]

{ #category : #initialization }
ChessGame >> initialize [
	super initialize.
	view := ChessGameView new.
	board := ChessBoard new addPieces: view.
	whitePlayer := ChessPlayer new color: #white;
	addPieces: view piecesYPosition: 1 pawnDirection: 1.
	blackPlayer := ChessPlayer new color: #black;
	addPieces: view piecesYPosition: 8 pawnDirection: -1.
	whitePlayer oponent: blackPlayer; game: self; board: board.
	blackPlayer oponent: whitePlayer; game: self; board: board.
	playerToMove := whitePlayer.
	playerToMove beforeTurn
]

{ #category : #accessing }
ChessGame >> view [
	^ view
]

{ #category : #turning }
ChessGame >> win: aPlayer [
	aPlayer == whitePlayer ifTrue: [ self drawIndicator: 'White wins' ].
	aPlayer == blackPlayer ifTrue: [ self drawIndicator: 'Black wins' ].
	aPlayer ifNil: [ self drawIndicator: 'Draw' ]
]
