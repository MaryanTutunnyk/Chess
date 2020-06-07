Class {
	#name : #ChessPieceElement,
	#superclass : #RTElement,
	#category : #'Chess-GUI'
}

{ #category : #accessing }
ChessPieceElement >> addHighlight: aColor [
	trachelShape strokePaint: aColor; borderWidth: 3
]

{ #category : #adding }
ChessPieceElement >> addedIn: aView [
	super addedIn: aView.
	self addShape: self shape.
	self translateTo: self positionInView
]

{ #category : #accessing }
ChessPieceElement >> borderColor [
	^ Color black
]

{ #category : #accessing }
ChessPieceElement >> fillColor [
	^ Color perform: self model color
]

{ #category : #positioning }
ChessPieceElement >> positionInView [
	| squareSize posx posy |
	squareSize := self squareSize.
	posx := squareSize * (self model position x - 0.5).
	posy := squareSize * (8.5 - self model position y).
	^ posx @ posy
]

{ #category : #accessing }
ChessPieceElement >> removeHighlight [
	trachelShape strokePaint: Color black; borderWidth: 1
]

{ #category : #accessing }
ChessPieceElement >> shape [
	^ RTSVGPath new
		path: self svgPath;
		fillColor: self fillColor;
		borderColor: self borderColor;
		borderWidthConstant
]

{ #category : #'as yet unclassified' }
ChessPieceElement >> squareFromPosition: pixelPosition [
	| squareSize position |
	squareSize := self squareSize.
	position := self view canvas camera fromPixelToSpace: pixelPosition.
	1 to: 8 do: [ :i |
		1 to: 8 do: [ :j |
			(position x >= (squareSize * (i - 0.5))
			and: [ position x < (squareSize * (i + 0.5))
			and: [ position y >= (squareSize * (j - 0.5))
			and: [ position y < (squareSize * (j + 0.5)) ]]])
				ifTrue: [ ^ i @ (9 - j) ]
			]
		].
	^ nil
]

{ #category : #'as yet unclassified' }
ChessPieceElement >> squareSize [
	^ 45
]

{ #category : #icon }
ChessPieceElement >> svgPath [
	^ 'M 0 0 L 0 45 L 45 45 L 45 45 L 45 0 z'
]
