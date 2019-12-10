fn cntrPivots = (
	obj = (selection as array)

	for i = 1 to obj.count do(
		CenterPivot obj[i]
	)	
)

fn removeLyr = (
	defaultLayer = LayerManager.getLayer 0
	defaultLayer.current = true
	lyrCount = LayerManager.count
	lyrRemoved = 0

	for i = 0 to LayerManager.count do(
		if lyrCount > 1 then(
			lyrCount -= 1
			print lyrCount
			layerName = (LayerManager.getLayer lyrCount).name
			LayerManager.deleteLayerByName layerName
		)else(
			print "no more layers."
		)
	)
)

fn detachObj = (
	faceCount = $.getNumFaces()
	obj = $
	max modify mode
	subObjectLevel = 4

	while faceCount != 0 do(

		polyop.setFaceSelection $ #{1}
		selectEle = obj.selectElement()

		list = polyop.getFaceSelection obj
		polyop.detachFaces obj list asNode:true
		newCount = $.getNumFaces()
		faceCount = newCount
	)
	subObjectLevel = 0
	obj.name = "delete"
)

fn addUV = (
	max modify mode
	polyObject = selection
	objMod = Unwrap_UVW()
	addMod = addModifier polyObject (objMod)
	list = #()
	obj = (selection as array)

		for i = 1 to obj.count do(
			append list obj[i]
		)
	select list
	subobjectLevel = 1
	obj[1].Unwrap_UVW.DisplayMap off
	obj[1].Unwrap_UVW.setShowMapSeams off
	obj[1].Unwrap_UVW.setPeltAlwaysShowSeams off
	obj[1].Unwrap_UVW.setNormalizeMap off
	deselect
	select list
	obj[1].Unwrap_UVW.edit()
)

fn filterAll = (
	setSelectFilter 1
)

fn filterGeo = (
	setSelectFilter 2
)

fn filterShapes = (
	setSelectFilter 3
)

fn filterHelpers = (
	setSelectFilter 6
)

fn filterBones = (
	setSelectFilter 8
)