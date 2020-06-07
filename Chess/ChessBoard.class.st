Class {
	#name : #ChessBoard,
	#superclass : #Object,
	#instVars : [
		'pieces'
	],
	#category : #'Chess-GameLogic'
}

{ #category : #initialization }
ChessBoard >> addPieces: aView [
	pieces := OrderedCollection new.
	1 to: 8 do: [ :i |
		1 to: 8 do: [:j |
			|chessPiece|
			chessPiece := (i + j) % 2 = 0
				ifTrue: [ ChessPiece new color: #black ]
				ifFalse: [ ChessPiece new color: #white ].
			chessPiece position: i @ j.
			pieces add: chessPiece.
			aView addElementToView: chessPiece element
			]
		]
]

{ #category : #accessing }
ChessBoard >> at: aPosition [
	^ pieces at: ((aPosition x - 1) * 8 + aPosition y)
]

{ #category : #highlighting }
ChessBoard >> highlightAcceptableTurns: acceptableTurns [
	acceptableTurns do: [ :t |
		(self at: t) element addHighlight: (Color yellow); pushFront]
]

{ #category : #highlighting }
ChessBoard >> highlightCheck: kingPosition [
	(self at: kingPosition) element addHighlight: (Color red); pushFront
]

{ #category : #highlighting }
ChessBoard >> removeHighlightAcceptableTurns: acceptableTurns [
	acceptableTurns do: [ :t | (self at: t) element removeHighlight ]
]

{ #category : #highlighting }
ChessBoard >> removeHighlightCheck: kingPosition [
	(self at: kingPosition) element removeHighlight
]
