Class {
	#name : #Bishop,
	#superclass : #PlayableChessPiece,
	#category : #'Chess-GameLogic'
}

{ #category : #adding }
Bishop >> addElement [
	element := BishopElement new model: self.
]

{ #category : #testing }
Bishop >> canMoveFrom: fromPosition to: toPosition now: now [
	| delta oponentAtToPosition |
	oponentAtToPosition := now ifTrue: [ player oponent allyWithPosition: toPosition ] ifFalse: [ player oponent allyWithNextPosition: toPosition ].
	delta := toPosition - fromPosition.
	(delta x abs = (delta y abs)) ifTrue: [
		| direction currentPosition |
		direction := delta / (delta abs).
		currentPosition := fromPosition + direction.
		[ currentPosition ~= toPosition ] whileTrue: [
			(now ifTrue: [ player allyWithPosition: currentPosition ]
			ifFalse: [ player allyWithNextPosition: currentPosition ])
			ifNotNil: [ ^ nil ].
			(now ifTrue: [ player oponent allyWithPosition: currentPosition ]
			ifFalse: [ player oponent allyWithNextPosition: currentPosition ])
			ifNotNil: [ ^ nil ].
			currentPosition := currentPosition + direction ].
		^ ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove: (oponentAtToPosition
		ifNotNil: [ ChessMove new piece: oponentAtToPosition; from: toPosition; to: nil; associatedMove: nil ])
	].
	^ nil
]
