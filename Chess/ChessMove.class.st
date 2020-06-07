Class {
	#name : #ChessMove,
	#superclass : #Object,
	#instVars : [
		'piece',
		'from',
		'to',
		'associatedMove'
	],
	#category : #'Chess-GameLogic'
}

{ #category : #accessing }
ChessMove >> associatedMove [
	^ associatedMove
]

{ #category : #accessing }
ChessMove >> associatedMove: aMove [
	associatedMove := aMove
]

{ #category : #accessing }
ChessMove >> from [
	^ from
]

{ #category : #accessing }
ChessMove >> from: aPosition [
	from := aPosition
]

{ #category : #accessing }
ChessMove >> piece [
	^ piece
]

{ #category : #accessing }
ChessMove >> piece: aPiece [
	piece := aPiece
]

{ #category : #accessing }
ChessMove >> to [
	^ to
]

{ #category : #accessing }
ChessMove >> to: aPosition [
	to := aPosition
]
