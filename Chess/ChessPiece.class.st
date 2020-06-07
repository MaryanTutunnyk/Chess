Class {
	#name : #ChessPiece,
	#superclass : #Object,
	#instVars : [
		'position',
		'color',
		'element'
	],
	#category : #'Chess-GameLogic'
}

{ #category : #initialization }
ChessPiece >> addElement [
	element := ChessPieceElement new model: self
]

{ #category : #accessing }
ChessPiece >> color [
	^ color
]

{ #category : #accessing }
ChessPiece >> color: aColor [
	color := aColor
]

{ #category : #accessing }
ChessPiece >> element [
	^ element
]

{ #category : #initialization }
ChessPiece >> initialize [
	super initialize.
	self addElement
]

{ #category : #accessing }
ChessPiece >> position [
	^ position
]

{ #category : #accessing }
ChessPiece >> position: aPosition [
	position := aPosition
]
