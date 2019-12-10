fn nodeSetup = (
	createNode = FlightStudio.CreateLOD()
	select $l*
	lodNode = $
	lodNode.name = "Land\\model\\3d\\Lof[0]"
	createObj = FlightStudio.CreateObject()
	select $o*
	objNode = $
	objNode.name = "footprint"
	deselect $
	newObjList = #()
	createNode = FlightStudio.CreateGroup()
	select $g*
	mainNode = $
	mainNode.name = "g1"
	pObj = selection as array
	
	for i = 1 to 10 do(
		--clone the selected objects
		maxOps.cloneNodes pObj cloneType:#copy newNodes:&newObjList[i]
		newObjList--> #()
	)

	newObjList[1].name = "Land"
	newObjList[2].name = "Land\\model"
	newObjList[3].name = "Land\\model\\footprint"
	newObjList[4].name = "Land\\model\\3d"
	newObjList[5].name = "missionfunction"
	newObjList[6].name = "collision"
	newObjList[7].name = "vbs2roadway"
	newObjList[8].name = "vbs2ai"
	newObjList[9].name = "vbs2ladder"
	newObjList[10].name = "vbs2shadow"

	newObjList[1].parent = $'g1'
	newObjList[2].parent = $'Land'
	newObjList[3].parent = $'Land\\model'
	newObjList[4].parent = $'Land\\model'
	$'Shadow'.parent = $'vbs2shadow'
	$'Roadway'.parent = $'vbs2roadway'
	lodNode.parent = $'Land\\model\\3d'
	$'exterior_wall'.parent = lodNode
	$'ceiling'.parent = lodNode
	$'interior_wall'.parent = lodNode
	$'floor'.parent = lodNode
	$'windowFrame'.parent = lodNode
	$'rail'.parent = lodNode
	$'roof'.parent = lodNode
--  	$'stairs'.parent = lodNode
-- 	$'stairwell'.parent = lodNode
	$'footprint'.parent = $'Land\\model\\footprint'
	$'footprint_01'.parent = $'footprint'

	newObjList[5].parent = $'Land\\model\\3d'
	newObjList[6].parent = $'missionfunction'
	newObjList[7].parent = $'missionfunction'
	newObjList[8].parent = $'missionfunction'
	newObjList[9].parent = $'missionfunction'
	newObjList[10].parent = $'missionfunction'
	
-- 	select $"CollisionBox*"
-- 	selCol = selection as array

-- 	for i = 1 to selCol.count do(
-- 		selCol[i].parent = $'collision'
-- 	)
	--=====================================================================
	--Comments text==================================================================
	FlightStudio.PutComment $'land' "#XML\n<CDBZone name='Land'/> "
	FlightStudio.PutComment $'Land\\model' "#XML
	 <CDBZone name='Land\model'>
	 <MaterialAttributes>
	 <FeatureID>-1</FeatureID>
	 <SMC>-1</SMC>
	 </MaterialAttributes>
	 </CDBZone>"
	FlightStudio.PutComment $'land\\model\\footprint' "#XML
	 <CDBZone name='Land\model\footprint'>
	 <MaterialAttributes>
	 <FeatureID>-1</FeatureID>
	 <SMC>-1</SMC>
	 </MaterialAttributes>
	 </CDBZone>"
	FlightStudio.PutComment $'land\\model\\3d' "#XML
	 <CDBZone name='Land\model\3d'>
	 <MaterialAttributes>
	 <FeatureID>-1</FeatureID>
	 <SMC>-1</SMC>
	 </MaterialAttributes>
	 </CDBZone>"
	FlightStudio.PutComment $'missionfunction' "#missionfunctiononly"
	FlightStudio.PutComment $'collision' "#collision"
	FlightStudio.PutComment $'vbs2roadway' "#vbs2roadway"
	FlightStudio.PutComment $'vbs2ai' "#vbs2ai"
	FlightStudio.PutComment $'vbs2ladder' "#vbs2ladder"
	FlightStudio.PutComment $'vbs2shadow' "#vbs2shadow"

-- 	FlightStudio.CreateObject()
-- 	select $o*
-- 	createObj = $
-- 	createObj.name = "Land\model\3d\Lof[0]"
-- 	createObj.parent = $'land\\model\\3d'
)