Class {
	#name : #Knight,
	#superclass : #PlayableChessPiece,
	#category : #'Chess-GameLogic'
}

{ #category : #adding }
Knight >> addElement [
	element := KnightElement new model: self
]

{ #category : #testing }
Knight >> canMoveFrom: fromPosition to: toPosition now: now [
	| delta oponentAtToPosition |
	oponentAtToPosition := now ifTrue: [ player oponent allyWithPosition: toPosition ] ifFalse: [ player oponent allyWithNextPosition: toPosition ].
	delta := toPosition - fromPosition.
	((delta x abs == 1 and: [ delta y abs == 2 ]) or: [ delta x abs == 2 and: [ delta y abs == 1 ]]) ifTrue: [
		^ ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove: (oponentAtToPosition
		ifNotNil: [ ChessMove new piece: oponentAtToPosition; from: toPosition; to: nil; associatedMove: nil ])
		].
	^ nil
]
