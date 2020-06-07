Class {
	#name : #Pawn,
	#superclass : #PlayableChessPiece,
	#instVars : [
		'direction'
	],
	#category : #'Chess-GameLogic'
}

{ #category : #adding }
Pawn >> addElement [
	element := PawnElement new model: self
]

{ #category : #testing }
Pawn >> canMoveFrom: fromPosition to: toPosition now: now [
	| delta move |
	delta := toPosition - fromPosition.
	delta y ~= 0 ifTrue: [
	(delta y / delta y abs) = direction ifTrue: [
		| middlePosition oponentWithMiddlePosition oponentWithToPosition |
		middlePosition := fromPosition + (0 @ direction).
		oponentWithToPosition := now ifTrue: [ player oponent allyWithPosition: toPosition ] ifFalse: [ player oponent allyWithNextPosition: toPosition ].
		oponentWithMiddlePosition := now ifTrue: [ player oponent allyWithPosition: middlePosition ] ifFalse: [ player oponent allyWithNextPosition: middlePosition ].
		(delta y abs = 2 and: [ delta x = 0 and: [ hasMoved not and: [ oponentWithMiddlePosition isNil and: [ oponentWithToPosition isNil ]]]]) ifTrue: [
			player enPassant: self. move := ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove: nil
		].
		delta y abs = 1 ifTrue: [
			delta x = 0 ifTrue: [
				oponentWithToPosition ifNil: [ move := ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove: nil ]].
			(delta x = -1 or: delta x = 1) ifTrue: [
				oponentWithToPosition ifNotNil: [
					move := ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove:
					(ChessMove new piece: oponentWithToPosition; from: toPosition; to: nil; associatedMove: nil) ].
				(player oponent enPassant isNotNil and: [ player oponent enPassant position = (toPosition - (0 @ direction)) ]) ifTrue: [
					move := ChessMove new piece: self; from: fromPosition; to: toPosition; associatedMove:
					(ChessMove new piece: player oponent enPassant; from: toPosition - (0 @ direction); to: nil; associatedMove: nil) ].
					]
				]
			]
		].
	^ move
]

{ #category : #accessing }
Pawn >> direction: aDirection [
	direction := aDirection
]
