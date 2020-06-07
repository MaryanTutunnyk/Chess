Class {
	#name : #Queen,
	#superclass : #PlayableChessPiece,
	#category : #'Chess-GameLogic'
}

{ #category : #adding }
Queen >> addElement [
	element := QueenElement new model: self
]

{ #category : #testing }
Queen >> canMoveFrom: fromPosition to: toPosition now: now [
	|delta direction oponentAtToPosition |
	oponentAtToPosition := now ifTrue: [ player oponent allyWithPosition: toPosition ] ifFalse: [ player oponent allyWithNextPosition: toPosition ].
	delta := toPosition - fromPosition.
	(delta x abs = (delta y abs)) ifTrue: [
		| currentPosition |
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

		delta y = 0 ifTrue: [ 
		direction := delta x / (delta x abs).
		(fromPosition x + direction) to: (toPosition x - direction) by: direction do: [ :i |
			(now ifTrue: [ player allyWithPosition: (i @ fromPosition y)]
			ifFalse: [ player allyWithNextPosition: (i @ fromPosition y)])
			ifNotNil: [ ^ nil ].
			(now ifTrue: [ player oponent allyWithPosition: (i @ fromPosition y)]
			ifFalse: [ player oponent allyWithNextPosition: (i @ fromPosition y)])
			ifNotNil: [ ^ nil ].
			].
		^ ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove: (oponentAtToPosition
		ifNotNil: [ ChessMove new piece: oponentAtToPosition; from: toPosition; to: nil; associatedMove: nil ])
		].
	delta x = 0 ifTrue: [ 
		direction := delta y / (delta y abs).
		(fromPosition y + direction) to: (toPosition y - direction) by: direction do: [ :i |
			(now ifTrue: [ player allyWithPosition: (fromPosition x @ i)]
			ifFalse: [ player allyWithNextPosition: (fromPosition x @ i)])
			ifNotNil: [ ^ nil ].
			(now ifTrue: [ player oponent allyWithPosition: (fromPosition x @ i)]
			ifFalse: [ player oponent allyWithNextPosition: (fromPosition x @ i)])
			ifNotNil: [ ^ nil ]
			].
		^ ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove: (oponentAtToPosition
		ifNotNil: [ ChessMove new piece: oponentAtToPosition; from: toPosition; to: nil; associatedMove: nil ])
		].
	^ nil
]
