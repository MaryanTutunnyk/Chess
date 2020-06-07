Class {
	#name : #PlayableChessPiece,
	#superclass : #ChessPiece,
	#instVars : [
		'player',
		'shouldDie',
		'hasMoved',
		'nextPosition',
		'acceptableTurns'
	],
	#category : #'Chess-GameLogic'
}

{ #category : #accessing }
PlayableChessPiece >> acceptableTurns [
	^ acceptableTurns
]

{ #category : #moving }
PlayableChessPiece >> canAcceptMoveFrom: fromPosition to: toPosition [
	(player allyWithPosition: toPosition) ifNil: [
		| move |
		move := (self canMoveFrom: fromPosition to: toPosition now: true).
		move ifNotNil: [
			| associatedMove isCheck |
			move piece nextPosition: move to.
			associatedMove := move associatedMove.
			associatedMove ifNotNil: [ associatedMove to ifNotNil: [ associatedMove piece nextPosition: associatedMove to ] ifNil: [ associatedMove piece shouldDie: true ]].
			isCheck := player isCheck.
			associatedMove ifNotNil: [ associatedMove to ifNil: [ associatedMove piece shouldDie: false ]].
			isCheck
			ifTrue: [ player enPassant: nil.
				move piece nextPosition: move from.
				associatedMove ifNotNil: [ associatedMove to ifNil: [ associatedMove piece nextPosition: associatedMove from ]]]
			ifFalse: [ ^ move ]
			].
		^ nil
		].
	^ nil
]

{ #category : #moving }
PlayableChessPiece >> canMoveFrom: fromPosition to: toPosition now: now [
	^ self subclassResponsibility
]

{ #category : #accessing }
PlayableChessPiece >> hasMoved [
	^ hasMoved
]

{ #category : #accessing }
PlayableChessPiece >> hasMoved: aHasMoved [
	hasMoved := aHasMoved
]

{ #category : #initialization }
PlayableChessPiece >> initialize [
	super initialize.
	shouldDie := false.
	hasMoved := false.
]

{ #category : #moving }
PlayableChessPiece >> moveTo: aPosition [
	| moved move associatedMove |
	move := (self canAcceptMoveFrom: position to: aPosition).
	move ifNotNil: [
		player removeHighlightCheck.
		move piece position: move to.
		move piece element repositionPiece.
		move piece hasMoved: true.
		associatedMove := move associatedMove.
		associatedMove ifNotNil: [ 
			associatedMove to
			ifNotNil: [ associatedMove piece position: associatedMove to. associatedMove piece element repositionPiece ]
			ifNil: [ player capture: associatedMove piece ].
			associatedMove piece hasMoved: true
			].
		moved := true.
		]
	ifNil: [ element repositionPiece. moved := false ].
	^ moved
]

{ #category : #accessing }
PlayableChessPiece >> nextPosition [
	^ nextPosition
]

{ #category : #accessing }
PlayableChessPiece >> nextPosition: aPosition [
	nextPosition := aPosition
]

{ #category : #dragging }
PlayableChessPiece >> onDrag: aDelta [
	player canDragPieces ifFalse: [ ^ self ].
	element translateBy: aDelta
]

{ #category : #dragging }
PlayableChessPiece >> onDragEnd: aPosition [
	player canDragPieces
		ifFalse: [ ^ self ].
	player removeHighlightAcceptableTurns: acceptableTurns.
	(self moveTo: aPosition) ifTrue: [ player afterTurn ]
]

{ #category : #dragging }
PlayableChessPiece >> onDragStart [
	player canDragPieces ifFalse: [ ^ self ].
	player highlightAcceptableTurns: acceptableTurns.
	element pushFront
]

{ #category : #accessing }
PlayableChessPiece >> player: aPlayer [
	player := aPlayer
]

{ #category : #accessing }
PlayableChessPiece >> shouldDie [
	^ shouldDie
]

{ #category : #accessing }
PlayableChessPiece >> shouldDie: aShouldDie [
	shouldDie := aShouldDie
]

{ #category : #moving }
PlayableChessPiece >> updateAcceptableTurns [
	acceptableTurns := OrderedCollection new.
	1 to: 8 do: [ :i |
		1 to: 8 do: [ :j |
			| move |
			move := (self canAcceptMoveFrom: position to: (i @ j)).
			move ifNotNil: [ acceptableTurns add: (i @ j) ]]].
	nextPosition := position
]
