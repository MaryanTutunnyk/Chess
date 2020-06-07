Class {
	#name : #ChessPieceInteraction,
	#superclass : #RTInteraction,
	#category : #'Chess-GUI'
}

{ #category : #hooks }
ChessPieceInteraction >> initializeElement: element [
	| piece |
	piece := element model.
	
	element when: TRMouseDragStart do: [ :e | piece onDragStart ].
	
	element when: TRMouseDragging do: [ :e |
		| delta |
		delta := element view canvas camera distanceFromPixelToSpace: e step.
		piece onDrag: delta.
		e signalUpdate
	].
	
	element when: TRMouseDragEnd do: [ :e |
		| destination |
		destination := element squareFromPosition: e position.
		piece onDragEnd: destination
	]
]
