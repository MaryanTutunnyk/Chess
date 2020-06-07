Class {
	#name : #Rook,
	#superclass : #PlayableChessPiece,
	#category : #'Chess-GameLogic'
}

{ #category : #adding }
Rook >> addElement [
	element := RookElement new model: self
]

{ #category : #testing }
Rook >> canMoveFrom: fromPosition to: toPosition now: now [
	| delta direction oponentAtToPosition |
	oponentAtToPosition := now ifTrue: [ player oponent allyWithPosition: toPosition ] ifFalse: [ player oponent allyWithNextPosition: toPosition ].
	delta := toPosition - fromPosition.
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
