fn makeSpline = (
	objSelection = selection as array
	sp = splineShape()
	addnewSpline sp
	obj = $
	for i = 1 to objSelection.count do(
		objSelection[i].name = "TARGET"
		knotPos = objSelection[i].position
		addKnot sp 1 #smooth #curve knotPos
	)
	updateShape sp

	select $Target*
)

fn selTarget = (
	select $Target*
)

fn hideTarget = (
	select $Target*
	hide $Target*
)

fn unhideTarget = (
	unhide $Target*
)

fn enableInVP = (
	$.render_displayRenderMesh = true
)

fn disableInVP = (
	$.render_displayRenderMesh = false
)

fn genMap = (
	$.render_mapcoords = true
)

fn spSides sideCount = (
	$.render_sides = (sideCount as integer)
)

fn spThickness splineSize = (
	$.render_thickness = (splineSize as float * .1)
)

fn growSide = (
	$.render_sides += 1
)

fn shrinkSide = (
	$.render_sides -= 1
)

fn growThick = (
	$.render_thickness += .1
)

fn shrinkThick = (
	$.render_thickness -= .1
)




fn selAllVerts = (
	max modify mode
	subObjectLevel = 1
	vertCount = numKnots $ 1
	list1 = #() 

	for i = 1 to vertCount do(
		append list1 i
	)
	--print ("List one contains: " + list1 as string)
	setMyVert = setKnotSelection $ 1 list1
)

fn smoothCurve = (
	spl = $
	X = (getKnotSelection $ 1)

	for i in X do(
		setKnotType spl 1 i #smooth
	)
	updateshape spl
)

fn bezierCurve = (
	spl = $
	X = (getKnotSelection $ 1)

	for i in X do(
		setKnotType spl 1 i #bezier
	)
	updateshape spl
)

fn cornerCurve = (
	spl = $
	X = (getKnotSelection $ 1)

	for i in X do(
		setKnotType spl 1 i #corner
	)
	updateshape spl
)


