Class {
	#name : #ChessPlayer,
	#superclass : #Object,
	#instVars : [
		'color',
		'pieces',
		'oponent',
		'game',
		'canDragPieces',
		'board',
		'king',
		'furtherRook',
		'closerRook',
		'enPassant'
	],
	#category : #'Chess-GameLogic'
}

{ #category : #adding }
ChessPlayer >> addPieces: aView piecesYPosition: piecesYPosition pawnDirection: pawnDirection [
	| chessPiece |
	pieces := OrderedCollection new.
	1 to: 8 do: [ :i |
		chessPiece := Pawn new player: self; color: color; direction: pawnDirection;
		position: i @ (piecesYPosition + pawnDirection);
		nextPosition: i @ (piecesYPosition + pawnDirection).
		aView addElementToView: chessPiece element.
		pieces add: chessPiece
		].
	chessPiece := Rook new player: self; color: color;
	position: 1 @ piecesYPosition; nextPosition: 1 @ piecesYPosition.
	aView addElementToView: chessPiece element.
	pieces add: chessPiece.
	furtherRook := chessPiece.
	chessPiece := Knight new player: self; color: color;
	position: 2 @ piecesYPosition; nextPosition: 2 @ piecesYPosition.
	aView addElementToView: chessPiece element.
	pieces add: chessPiece.
	chessPiece := Bishop new player: self; color: color;
	position: 3 @ piecesYPosition; nextPosition: 3 @ piecesYPosition.
	aView addElementToView: chessPiece element.
	pieces add: chessPiece.
	chessPiece := Queen new player: self; color: color;
	position: 4 @ piecesYPosition; nextPosition: 4 @ piecesYPosition.
	aView addElementToView: chessPiece element.
	pieces add: chessPiece.
	chessPiece := King new player: self; color: color;
	position: 5 @ piecesYPosition; nextPosition: 5 @ piecesYPosition.
	aView addElementToView: chessPiece element.
	pieces add: chessPiece.
	king := chessPiece.
	chessPiece := Bishop new player: self; color: color;
	position: 6 @ piecesYPosition; nextPosition: 6 @ piecesYPosition.
	aView addElementToView: chessPiece element.
	pieces add: chessPiece.
	chessPiece := Knight new player: self; color: color;
	position: 7 @ piecesYPosition; nextPosition: 7 @ piecesYPosition.
	aView addElementToView: chessPiece element.
	pieces add: chessPiece.
	chessPiece := Rook new player: self; color: color;
	position: 8 @ piecesYPosition; nextPosition: 8 @ piecesYPosition.
	aView addElementToView: chessPiece element.
	pieces add: chessPiece.
	closerRook := chessPiece
]

{ #category : #turning }
ChessPlayer >> afterTurn [
	canDragPieces := false.
	game endTurn
]

{ #category : #accessing }
ChessPlayer >> allyWithNextPosition: aPosition [
	| piece |
	piece := pieces detect: [ :p | p shouldDie not and: [ p nextPosition = aPosition ]]
	ifNone: nil.
	^ piece
]

{ #category : #accessing }
ChessPlayer >> allyWithPosition: aPosition [
	| piece |
	piece := pieces detect: [ :p | p shouldDie not and: [ p position = aPosition ]]
	ifNone: nil.
	^ piece
]

{ #category : #turning }
ChessPlayer >> beforeTurn [
	| isGameEnd isCheck |
	enPassant := nil.
	isGameEnd := true.
	pieces do: [ :p |
		p updateAcceptableTurns.
		isGameEnd := isGameEnd and: p acceptableTurns isEmpty ].
	isCheck := self isCheck.
	isCheck ifTrue: [ self highlightCheck ].
	isGameEnd
	ifTrue: [ isCheck ifTrue: [ game win: oponent ] ifFalse: [ game win: nil ]]
	ifFalse: [
		game drawIndicator: (color first uppercase asString, (color allButFirst), ' moves').
		canDragPieces := true ]
]

{ #category : #accessing }
ChessPlayer >> board: aBoard [
	board := aBoard
]

{ #category : #accessing }
ChessPlayer >> canDragPieces [
	^ canDragPieces
]

{ #category : #accessing }
ChessPlayer >> capture: aPiece [
	oponent captured: aPiece
]

{ #category : #accessing }
ChessPlayer >> captured: aPiece [
	aPiece element remove.
	pieces remove: aPiece
]

{ #category : #accessing }
ChessPlayer >> closerRook [
	^ closerRook
]

{ #category : #accessing }
ChessPlayer >> color: aColor [
	color := aColor
]

{ #category : #accessing }
ChessPlayer >> enPassant [
	^ enPassant
]

{ #category : #accessing }
ChessPlayer >> enPassant: aPawn [
	enPassant := aPawn
]

{ #category : #accessing }
ChessPlayer >> furtherRook [
	^ furtherRook
]

{ #category : #accessing }
ChessPlayer >> game: aGame [
	game := aGame
]

{ #category : #highlighting }
ChessPlayer >> highlightAcceptableTurns: aAcceptableTurns [
	board highlightAcceptableTurns: aAcceptableTurns.
	self pushPiecesToFront.
	oponent pushPiecesToFront
]

{ #category : #highlighting }
ChessPlayer >> highlightCheck [
	board highlightCheck: king position.
	self pushPiecesToFront.
	oponent pushPiecesToFront
]

{ #category : #initialization }
ChessPlayer >> initialize [
	canDragPieces := false
]

{ #category : #testing }
ChessPlayer >> isCheck [
	^ self oponent pieces anySatisfy: [ :p |
		p shouldDie not and: [ (p canMoveFrom: p nextPosition to: king nextPosition now: false) isNotNil ]]
]

{ #category : #accessing }
ChessPlayer >> king [
	^ king
]

{ #category : #accessing }
ChessPlayer >> oponent [
	^ oponent
]

{ #category : #accessing }
ChessPlayer >> oponent: aOponent [
	oponent := aOponent
]

{ #category : #accessing }
ChessPlayer >> pieces [
	^ pieces
]

{ #category : #highlighting }
ChessPlayer >> pushPiecesToFront [
	pieces do: [ :i | i element pushFront ]
]

{ #category : #highlighting }
ChessPlayer >> removeHighlightAcceptableTurns: acceptableTurns [
	board removeHighlightAcceptableTurns: acceptableTurns
]

{ #category : #highlighting }
ChessPlayer >> removeHighlightCheck [
	board removeHighlightCheck: king position
]
