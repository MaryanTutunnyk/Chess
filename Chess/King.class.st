Class {
	#name : #King,
	#superclass : #PlayableChessPiece,
	#category : #'Chess-GameLogic'
}

{ #category : #adding }
King >> addElement [
	element := KingElement new model: self
]

{ #category : #testing }
King >> canCastling: aRook [
	| move |
	(player king hasMoved not and: [ aRook isNotNil ifTrue: [ aRook hasMoved not ]]) ifTrue: [
	| delta direction |
	delta := aRook position x - player king position x.
	direction := delta / (delta abs).
	(player king position x + direction) to: (aRook position x - direction) by: direction do: [ :i |
		(player allyWithPosition: (i @ player king position y)) ifNotNil: [ ^ nil ].
		(player oponent allyWithPosition: (i @ player king position y)) ifNotNil: [ ^ nil ].
		].
	player king nextPosition: player king position.
	player isCheck ifFalse: [
		player king nextPosition: (player king nextPosition + (direction @ 0)).
		player isCheck ifFalse: [
			player king nextPosition: (player king nextPosition + (direction @ 0)).
			player isCheck ifFalse: [
				move := ChessMove new piece: player king; from: player king position; to: player king nextPosition; associatedMove:
				(ChessMove new piece: aRook; from: aRook position; to: (player king position + (direction @ 0)); associatedMove: nil).
				]
			]
		]
	].
	^ move
]

{ #category : #testing }
King >> canMoveFrom: fromPosition to: toPosition now: now [
	| delta oponentAtToPosition |
	oponentAtToPosition := now ifTrue: [ player oponent allyWithPosition: toPosition ] ifFalse: [ player oponent allyWithNextPosition: toPosition ].
	delta := toPosition - fromPosition.
	(delta x abs <= 1 and: [ delta y abs <= 1 ]) ifTrue: [
		^ ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove: (oponentAtToPosition
		ifNotNil: [ ChessMove new piece: oponentAtToPosition; from: toPosition; to: nil; associatedMove: nil ])].
	now ifTrue: [
		(fromPosition = player king position and: [ toPosition = (fromPosition + (2 @ 0)) ]) ifTrue: [ ^ self canCastling: (player closerRook) ].
		(fromPosition = player king position and: [ toPosition = (fromPosition - (2 @ 0)) ]) ifTrue: [ ^ self canCastling: (player furtherRook) ]].
	^ nil
]
