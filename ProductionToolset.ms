--Spline Creator/start =======================================================
fn makeSpline = (
	objSelection = selection as array
	sp = splineShape()
	addnewSpline sp
	obj = $

	for i = 1 to objSelection.count do(
			format "Counter_%\n" i
			objSelection[i].name = ("Target_" + i as string)
			knotPos = objSelection[i].position
			addknot sp 1 #smooth #curve knotPos	
		)
	updateShape sp
	select $Test*
)
--Spline Creator/end ====================================================
--Add UV Modifier/start ================================================
fn addUV = (
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
)
--Add UV Modifier/end ================================================
--====================================================================
--Add AO/start ======================================================
obj = $
--changerRenderer()
renderType = mental_ray_renderer()
renderers.current = renderType
obj.iNodeBakeProperties.removeAllBakeElements()
addAO = AmbientOcclusionBakeElement()
obj.INodeBakeProperties.bakeEnabled = true
obj.INodeBakeProperties.bakeChannel = 1
obj.INodeBakeProperties.BakeObjectLevel = true
addAO.bright = (color 255 255 255 255)
addAO.dark = (color 35 35 35)
addAO.falloff = .5
addAO.elementName = "_AO_pass"
addAO.samples = .75 --aoSpread
addAO.maxDistance = 0.0 --aoMaxDist
addAO.outputSzY = 256 --ao_size
addAO.outputSzX = 256 --ao_size
addAO.fileType = (maxfilepath + "ao.png")
addAO.fileName = filenameFromPath addAO.fileType
$.INodeBakeProperties.addBakeElement addAO
render renderType:#bakeSelected frame:#current vfb:true
--Add AO/end ================================================
--====================================================================
--Center Pivots/start=============================================
obj = (selection as array)
for i = 1 to obj.count do(
	CenterPivot obj[i]
)
--Center Pivots/end=============================================
--====================================================================
--Create bounding box/start
--====================================================================
--Black wires/start
select objects --selects all objects in scene
pObject = $
pObject.wirecolor = color 0 0 0 0
--Black wires/end
--====================================================================
--Delete Junk objects
select $f*
select $outlinetri*
--====================================================================
--Creates Layers per material
pObj = selection as array

for i = 1 to pObj.count do(
	--print i
	--print pObj[i].material

	if pObj[i].material.name == "StuccoBeige" then(
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
	)else if pObj[i].material.name == "CarpetBlue" then(
		print "Condition #4\n"
		--print ("This is the carpet\n" + pObj[i] as string)
		select pObj[i]
		pObj[i].name = "floor" 
		layerCreate()
	)else if pObj[i].material.name == "SGDrywall3" then(
		print "Condition #5\n"
		--print ("This is the interior wall\n" + pObj[i] as string)
		select pObj[i]
		pObj[i].name = "interior_wall" 
		layerCreate()
	)else if pObj[i].material.name == "concreteLight" then(
		print "Condition #6\n"
		--print ("This is the roof\n" + pObj[i] as string)
		select pObj[i]
		pObj[i].name = "roof" 
		layerCreate()
	)else(
		print "did NOT work :("
	)
)
fn layerCreate = (
	--print "inside layer creator"
	--print ("The new name is: " + $.name) 
	--print mName as string
	objName = $.name
	defaultLayer = layerManager.getLayer 0
	defaultLayer.current = true
	
	LayerManager.newLayerFromName objName
	layerName = LayerManager.getLayerFromName objName
	layerName.addNode $
)
--Attach multiple objects
pObj = selection as array
firstObj = pObj[1]
for i = 2 to pObj.count do(
	firstObj.attach pObj[i] firstObj
)

--Check name and attach objects
objSel = selection
for i = 1 to objSel.count do(
	nSel()
)
fn nSel = (
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
	--hide $
	select q
)
fn pAttach = (
	print "inside pAttach"
	pObj = selection as array
	firstObj = pObj[1]

	for i = 2 to pObj.count do(
		firstObj.attach pObj[i] firstObj
	)
)
--Weld verts
fn wVerts = (
	obj = $

	numVerts = #{1..(polyop.getnumverts obj)}
	obj.weldThreshold = 3
	polyop.weldVertsByThreshold obj numVerts
)
------------------------------------------------------------------
--Random wirecolor
pObj = selection as array

for i = 1 to pObj.count do (
	c1 = random 1 255
	c2 = random 1 255
	c3 = random 1 255
	c4 = random 1 255
	pObj[i].wirecolor = color c1 c2 c3 c4
)

--Position
$.position = [0,0,0]
-----------------------------------

--Clone object and rename to roadway v.1 this should not be done prior to creating shadow mesh
select $floor
pObj = selection as array
--clone the selected objects
maxOps.cloneNodes pObj cloneType:#copy newNodes:&newObjList
newObjList--> #()
select newObjList
newObjList.name = "roadway"
layerCreate()

--Clone mesh and rename to shadow and place on appropriate layer
select objects
pObj = selection as array
--clone the selected objects
maxOps.cloneNodes pObj cloneType:#copy newNodes:&newObjList
newObjList--> #()
select newObjList
newObjList.name = "shadow"

pAttach()
layerCreate()

--Consolidate layers and remove any unused layers
select objects
consolidateObj()
removeLyr()

fn consolidateObj = (
	pObj = selection as array
	defaultLayer = layerManager.getLayer 0
	defaultLayer.current = true
	
	--layerName = LayerManager.getLayerFromName objName
	for i = 1 to pObj.count do(
		defaultLayer.addNode pObj[i]
	)
)

--remove empty layers
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

