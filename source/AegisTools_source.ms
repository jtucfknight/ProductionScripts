fn cleanScene = (
--Delete Junk objects
	unhide $*
	select $*
	temp = selection as array
	arr = #("lod2", "Footprint", "lod3")
	junkList = #()
	test = #()
	for i = 1 to temp.count do(
		--print ("\n" + temp[i].name as string)
		for k = 1 to arr.count do(
			--print (arr[k] as string)
			if temp[i].name == arr[k] and superclassof temp[i] == helper then(
				--print "\n\n\t\t\t\t\t\tSAME!!! SAME!!! SAME!!!\n\n"
				append junkList temp[i]
				--call function that deletes children
				--select temp[i].children
				--delete $		
				--select $*
				temp = selection as array
			)else(
				print "not"
			)
		)
	)
	select junkList
	
	for i in selection do(
		selectMore i.children
	)
	delete $
	--delete helpers
	unhide $*
	select $*
	temp = selection as array
	junkList = #()
	counter = 0
	for i = 1 to temp.count do(
		print ("\n" + temp[i].name as string)
			strCheck1 = matchPattern temp[i].name pattern: "walltri*"
			strCheck2 = matchPattern temp[i].name pattern: "Roof"
		if  strCheck1 == true and superclassof temp[i] != helper then(
			counter += 1
			print ("\t\t\t\t\t\t\t\tCount is: " + counter as string)
			print "\n\n\t\t\t\t\t\tSAME!!! SAME!!! SAME!!!\n\n"
			--call function that deletes children
		)else if strCheck2 == true then(
			select temp[i].children
			print ("\t\t\t\tThis is the roof child:  " + temp[i].name) as string
			$.name = "walltri"
			append junkList temp[i]
		)else(
			print "not"
			append junkList temp[i]
		)
	)
	select junkList
	delete junkList
	
	messageBox "Unnecessary objects have been removed."
)
fn layerCreate = (
	--print "inside layer creator"
	--print ("The new name is: " + $.name) 
	--print mName as string
	undo on (
		objName = $.name
		defaultLayer = layerManager.getLayer 0
		defaultLayer.current = true
		
		LayerManager.newLayerFromName objName
		layerName = LayerManager.getLayerFromName objName
		layerName.addNode $
	)
)
fn matCheck = (
	print "In matCheck"
	--Creates Layers per material
	pObj = selection as array

	for i = 1 to pObj.count do(
		--print i
		--print pObj[i].material

		if pObj[i].material.name == "StuccoBeige" or pObj[i].material.name == "blockWall2" then(
			print "Condition #1\n"
			--print ("This is the wall\n" + pObj[i] as string)
			select pObj[i]
			pObj[i].name = "exterior_wall" 
			layerCreate()
		)else if pObj[i].material.name == "SGSandCementedTan" then(
			print "Condition #2\n"
			--print ("This is the rail\n" + pObj[i] as string)
			select pObj[i]
			pObj[i].name = "rail" 
			layerCreate()
		)else if pObj[i].material.name == "CeilingTile" then(
			print "Condition #3\n"
			--print ("This is the ceiling\n" + pObj[i] as string)
			select pObj[i]
			pObj[i].name = "ceiling" 
			layerCreate()
		)else if pObj[i].material.name == "CarpetRed" then(
			print "Condition #4\n"
			--print ("This is the carpet\n" + pObj[i] as string)
			select pObj[i]
			pObj[i].name = "stairs" 
			layerCreate()
		)else if pObj[i].material.name == "CarpetBlue" then(
			print "Condition #5\n"
			--print ("This is the carpet\n" + pObj[i] as string)
			select pObj[i]
			pObj[i].name = "floor" 
			layerCreate()
		)else if pObj[i].material.name == "SGDrywall3" then(
			print "Condition #6\n"
			--print ("This is the interior wall\n" + pObj[i] as string)
			select pObj[i]
			pObj[i].name = "interior_wall" 
			layerCreate()
		)else if pObj[i].material.name == "concreteLight" then(
			print "Condition #7\n"
			--print ("This is the roof\n" + pObj[i] as string)
			select pObj[i]
			pObj[i].name = "roof" 
			layerCreate()
		)else if pObj[i].material.name == "SGSteel" then(
			print "Condition #8\n"
			--print ("This is the rails\n" + pObj[i] as string)
			select pObj[i]
			pObj[i].name = "windowFrame" 
			layerCreate()
		)else(
			print "did NOT work :("
		)
	)
	
	messageBox "All objects have been separated to appropriate layer."
)
--nSel check name and attach objects
fn nSel = (
	undo on (
		pObj = selection as array
		h = #()
		q = #()
		pObj.count
		if pObj.count != 0 then( 
			main = pObj[1].name
			append h pObj[1]

			for i = 2 to pObj.count do (
				print pObj[i].name
				if pObj[i].name == main then (
					print "Same"
					append h pObj[i]
				)else(
					print "no worky work"
					append q pObj[i]
				)
			)
			select h
			pAttach()
			wVerts()

		)else(
			"no objects left"
		)
		select q
	)
)

fn pAttach = (
	print "inside pAttach"
	pObj = selection as array
	firstObj = pObj[1]

	for i = 2 to pObj.count do(
		firstObj.attach pObj[i] firstObj
	)
)

fn wVerts = (
	obj = $
	numVerts = #{1..(polyop.getnumverts obj)}
	obj.weldThreshold = .001
	polyop.weldVertsByThreshold obj numVerts
)

fn createShadow = (
	--Clone mesh and rename to shadow and place on appropriate layer
	--select $*
	local selObj = $
	if selObj != undefined then (
		pObj = selection as array
		newObjList = #()
		--clone the selected objects
		maxOps.cloneNodes pObj cloneType:#copy newNodes:&newObjList
		newObjList--> #() --pass by reference
		select newObjList
		newObjList[1].name = "shadow"

		pAttach()
		wVerts()
		matAssign()
		layerCreate()
		--capAllHoles()

		messagebox "Shadow created."
	)else(
		messageBox "Need to select an object first"
	)
)

fn matAssign = (
	$.material = StandardMaterial()
	$.material.diffuse = color 255 255 255
)

fn createRoadway = (
	local selObj = $
		if selObj != undefined then (
		--Clone object and rename to roadway v.1 this should not be done prior to creating shadow mesh
		select $'floor*'
		pObj = selection as array
		--clone the selected objects
		maxOps.cloneNodes pObj cloneType:#copy newNodes:&newObjList
		newObjList--> #()
		select newObjList
		newObjList[1].name = "roadway"
		
		pAttach()
		matAssign()
		layerCreate()
		messagebox "Roadway created."
		)else(
				messageBox "Please select an editable poly first."
		)
			
)

fn consolidateObj = (
	pObj = selection as array
	defaultLayer = layerManager.getLayer 0
	defaultLayer.current = true
	
	for i = 1 to pObj.count do(
		defaultLayer.addNode pObj[i]
	)
	messageBox "All objects have been consolidated"
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

fn addUV = (
	local selObj = $
	
	if selObj != undefined then(
		max modify mode
		polyobject = Unwrap_UVW()
		addMod = addModifier selection (polyobject)
		
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
	)else(
			messageBox "Must select an editable poly first."
	)
)

fn flattenUV =  (
	local getMod = modPanel.getCurrentObject()
	if classof getMod == Unwrap_UVW then(
		subobjectlevel = 3
		if subobjectlevel == 3 then(
			local polyObject = selection as array
			for i = 1 to polyObject.count do (
				polyObject[i].Unwrap_UVW.setFlattenNormalize on
				polyObject[i].Unwrap_UVW.setFlattenSpacing (.015)
				polyObject[i].Unwrap_UVW.flattenMapNoParams()
			)
		)else(
				messageBox "Must be in face mode."
		)
	)else(
			messageBox "Need to add uv modifier first."
	)
)

fn cntrPivot = (
	obj = (selection as array)
	for i = 1 to obj.count do(
		CenterPivot obj[i]
	)
)

fn randomWires = (
	pObj = selection as array

	for i = 1 to pObj.count do (
		c1 = random 1 255
		c2 = random 1 255
		c3 = random 1 255
		c4 = random 1 255
		pObj[i].wirecolor = color c1 c2 c3 c4
	)
)

fn blackWires = (
	pObject = $
	pObject.wirecolor = color 0 0 0 0
)

fn cnvrtToPoly = (
	print "converted to poly"
	pMesh = selection as array
	for i = 1 to pMesh.count do(	
		convertToPoly pMesh[i]
	)
	messageBox"Converted to editable Poly"
)
--Cannot use capAllHoles function because faces come in separated and may grab wrong edge.
-- fn capAllHoles = (
-- 	subobjectLevel = 3
-- 	selEdge = polyop.getOpenEdges $
-- 	$.EditablePoly.SetSelection #Edge selEdge
-- 	polyop.capHolesByEdge $ selEdge
-- )