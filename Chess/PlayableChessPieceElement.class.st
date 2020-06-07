Class {
	#name : #PlayableChessPieceElement,
	#superclass : #ChessPieceElement,
	#category : #'Chess-GUI'
}

{ #category : #adding }
PlayableChessPieceElement >> addedIn: aView [
	super addedIn: aView.
	self @ ChessPieceInteraction
]

{ #category : #accessing }
PlayableChessPieceElement >> borderColor [
	self model color == #black
		ifTrue: [ ^ Color white ]
		ifFalse: [ ^ Color black ]
]

{ #category : #accessing }
PlayableChessPieceElement >> repositionPiece [
	self translateTo: (self positionInView).
	self signalUpdate
]
