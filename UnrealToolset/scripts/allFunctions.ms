----------------------------------------------------------------------------------------
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
	completeRedraw()
)

fn disableInVP = (
	$.render_displayRenderMesh = false
	completeRedraw()
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
----------------------------------------------------------------------------------------
fn exportFBX = (
	objSel = (selection as array)

	objName = objSel[1].name
	objStr = objSel[1].name.count - 5
	subStr = substring objName 1 objStr
	exportFile (maxfilepath + subStr +".fbx") selectedOnly:true
)

fn saveObj = (
	maxObj = (selection as array)
	objSelection = $
	folderExist = doesFileExist(maxfilepath + "components")
	
	if folderExist == true then(
			saveNodes objSelection (maxfilepath + "components\\" + maxObj[1].name + "\\" + maxObj[1].name + ".max")
		)else(
			messageBox "Create a components folder."
	)
)

fn createDir = (
	componentsFldr = doesFileExist (maxfilepath + "components")
	
	if componentsFldr == true then(
		objSelect = selection as array

		for i = 1 to objSelect.count do(
			exportExist = doesFileExist (maxfilepath + "components\\" + objSelect[i].name)
		 
			if exportExist != true then(
					expDir = (maxfilepath + "components\\" + objSelect[i].name)
					makeDir expDir
			)else(
				messageBox "Folder already exist."
			)
		)
	)else( messageBox "Create components folder first to save objects under.")	
)

fn exploreFldr = (
		subDir = maxfilepath
		shellLaunch "explorer.exe" subDir
)
----------------------------------------------------------------------------------------
fn createRoot = (
	undo on(
		objSelect = (selection as array)
		selGrp = $
		max modify mode
		for i = 1 to objSelect.count do(
			createSkin = (Skin())
			addModifier objSelect[i] createSkin

			rootPoint = Point size: 10 box: true cross: false centerMarker: false
			rootPoint.wirecolor = green
			rootPoint.name = (objSelect[i].name + "_root")	
			rootPoint.transform = objSelect[i].transform
			
			select objSelect[i]
			skinOps.addbone createSkin rootPoint 0
		)	
		$.modifiers[#Skin].bone_Limit = 4
		completeRedraw()
	)
)

fn multiRoot = (
	undo on(
		max modify mode
		objSelect = (selection as array)
		selGrp = $
		objPos = objSelect[1].pos
		rootPoint = Point pos: objPos size: 10 box: true cross: false centerMarker: false
		rootPoint.wirecolor = green
		rootPoint.name = (objSelect[1].name + "_root")	
		rootPoint.transform = objSelect[1].transform
		createSkin = (Skin())
		addModifier selGrp createSkin
		
		for i = 1 to objSelect.count do(
			select objSelect[i]
		)
		skinOps.addbone createSkin rootPoint 0
		$.modifiers[#Skin].bone_Limit = 4
		completeRedraw()
	)
)

fn multiSocket = (
	undo on(
		max modify mode
		objSelect = (selection as array)
		subRoot = Point size: 5 box: true cross: false
		subRoot.name = (objSelect[1].name)
		subRoot.wirecolor = red
		subRoot.transform = objSelect[1].transform
		completeRedraw()
	)
)

fn createSocket = (
	max modify mode
	local socketList = #()
	undo on(
		for obj in selection do(
			if classof obj == Editable_Poly then(
				subRoot = Point size: 5 box: true cross: false
				subRoot.name = (obj.name)
				subRoot.wirecolor = red
				subRoot.transform = obj.transform
				append socketList subRoot
			)else(
				throw "--exception--"
			)
		)
		select socketList
	)	
	completeRedraw()			
)

fn selByWire = (
	i = $.wirecolor
	select (for o in objects where o.wirecolor == i collect o)
)
----------------------------------------------------------------------------------------

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

fn clearSceneX = (
	sceneX = SceneExplorerManager.GetExplorerCount()
	for i = sceneX to 1 by -1 do(
		print i as string
		SceneExplorerManager.DeleteExplorer (SceneExplorerManager.GetExplorerName i)

	)
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
----------------------------------------------------------------------------------------
fn createBone = (
	objSel = $
	counter = 1
	vertCount = numKnots $
	boneList = #()

	for k = 1 to (vertCount) do(
		counter += 1
		if counter <= vertCount then(
			newPos = getKnotPoint $ 1 k
			newPos2 = getKnotPoint $ 1 counter
			aBone = BoneSys.createBone newPos newPos2 [0,0,1]
			append boneList aBone
			newPos = newPos2 
			--select objSel
		)
	)
	select boneList
	counter = 1
	for i = 1 to boneList.count do(
		counter += 1

		if counter <= boneList.count then(
			print (counter as string)
			boneList[counter].parent = boneList[i]
		)
	)
	select boneList
	$.width = .2
	$.height = .2
)

fn multiBone = (
	spSel = selection as array 
	boneList = #()
	counter = 1
	for i = 1 to spSel.count do(
		boneList = #()
		select spSel[i]
		vertCount = numKnots spSel[i]

		for k = 1 to (vertCount) do(
			counter += 1
			
			if counter <= vertCount then(
				newPos = getKnotPoint spSel[i] 1 k
				newPos2 = getKnotPoint spSel[i] 1 counter
				aBone = BoneSys.createBone newPos newPos2 [0,0,1]
				append boneList aBone
				newPos = newPos2 
			)--end if
		)--end k loop
			select boneList
			$.width = .1
			$.height = .1
			boneCounter = 1

			for j = 1 to boneList.count do(
				boneCounter += 1

				if boneCounter <= boneList.count then(
					boneList[boneCounter].parent = boneList[j]
				)
			)--end j loop
		counter = 1
	)--end i loop
)

fn ikChain = (
	boneSel = selection as array
	test = IKSys.solverName 1
	
	IKSys.ikChain boneSel[1] boneSel[2] test
	ikPos = $.pos
	ikObj = $
	ikMover = Point size: 5 box: true cross: false
	ikMover.pos = ikPos
	ikMover.wireColor = blue
	ikObj.parent = ikMover
	maxops.affectchildren = true 
	
	select ikMover
)

fn refineBone = (
	maxops.affectchildren = false 
	BoneSys.refineBone()
)

fn boneEditOff = (
	maxops.affectchildren = false 
)

fn boneEditOn = (
	maxops.affectchildren = true 
)

fn sectionRadius = (
	bnNum = skinOps.GetNumberBones $.skin

	for i = 1 to bnNum do(
		bnName = skinOps.GetBoneName $.skin i 1
		print bnName
		getSection = skinOps.getNumberCrossSections $.skin i
		print getSection as string

		for j = 1 to getSection do(
			print j as string
			skinOps.setOuterRadius $.skin  i j .1
			skinOps.SetInnerRadius $.skin i j .05
		)
	)
)

fn reverseSp = (
	reverse $ 1 
)

fn sizeUp = (
	local objSel = selection as array
		
	for i = 1 to objSel.count do(
		if superClassOf objSel[i] != helper then(
			messageBox "Please select a point helper"
		)else(
			max modify mode
			objSel[i].size += .5
		)
	)
)

fn sizeDown = (
	local objSel = selection as array
		
	for i = 1 to objSel.count do(
		if superClassOf objSel[i] != helper then(
			messageBox "Please select a point helper"
		)else(
			max modify mode
			objSel[i].size -= .5
		)
	)
)

fn parentObj = (
	selectObj = selection as array
	mainObj  = selectObj[1]
	
	for i = 2 to selectObj.count do(
		  selectObj[i].parent = mainObj
	)
)

fn objectReset = (
	max modify mode
	objSel = selection as array

	for i = 1 to objSel.count do(
		--print ("Obj is ----> " + objSel[i] as string)
		ResetXForm objSel[i]
		collapseStack objSel[i]
		convertToPoly objSel[i]
	)
)
----------------------------------------------------------------------------------------