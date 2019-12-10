-- macroScript AegisTools
-- category: "Aegis Tools"
-- toolTip: "AegisTools v.1"
-- buttonText: "Aegis Tools"
-- autoUndoEnabled:true
(
	fileIn "source\\AegisTools_source.ms"
	fileIn "source\\AegisNodeSetup_source.ms"
	--=========================================================================
	try(closerolloutfloater rof) catch("Dialog close error!")
	rollout ro_1 "Tools" (

		group "Production" (
			button btn_addUV "addUV" across: 2 width:70 height: 30 align: #left tooltip:"Adds uv modifier."
			button btn_flattenUV "flattenUV" width:70 height: 30 align: #left tooltip:"Select all faces in UV editor then press Flatten tool."
			button btn_randomWires "randomWires" across: 2 width:70 height: 30 align: #left tooltip:"Changes wireframe of an object to a random color."
			button btn_blackWires "blackWires"  width:70 height: 30 align: #left tooltip:"Changes wireframe of an object to black."		
			button btn_cntrPivot "cntrPivot" width:70 height: 30 align: #left tooltip:"Centers pivot for objects."
		)

		on btn_addUV pressed do(
			addUV()
		)
		on btn_flattenUV pressed do(
			flattenUV()
		)	
		on btn_cntrPivot pressed do(
			cntrPivot()
		)	
		on btn_randomWires pressed do(
			randomWires()
		)	
		on btn_blackWires pressed do(
			blackWires()
		)		
	)
	rollout ro_2 "Scene" (
		group "Scene"(
			button btn_cleanScene "cleanScene_1" width:100 height: 30 align: #left tooltip:"Step 1.  Removes unnecessary LOD's and null objects."
			button btn_cnvrtToPoly "convertPoly_2" width:100 height: 30 align: #left tooltip:"Step 2.  Converts geometry to editable poly."	
			button btn_matCheck "matCheck_3" width:100 height: 30 align: #left tooltip:"Step 3. Select all geometry and it will be separated into layers."
			button btn_nSel "selectAttach_4" width:100 height: 30 align: #left tooltip:"Step 4. Select all geometry and it will be attached to its corresponding object and weld verts."		
			button btn_createShadow "createShadow_5" width:100 height: 30 align: #left tooltip:"Step 5. Creates your shadow geometry and places it on a separate layer."		
			button btn_createRoadway "createRoadway_6" width:100 height: 30 align: #left tooltip:"Step 6. Creates your roadway geometry and places it on a separate layer."	
			button btn_consolidateObj "consolidateObj_7" width:100 height: 30 align: #left tooltip:"Step 7.  Select all your geometry to consolidate to default layer."	
			button btn_removeLyr "removeLyr_8" width:100 height: 30 align: #left tooltip:"Step 8.  Removes all unused layers."
			button btn_nodeSetup "nodeSetup_9" width:100 height: 30 align: #left tooltip:"Step 9.  Creates node setup."
		)
		
		on btn_cleanScene pressed do(
			cleanScene()
		)
		on btn_cnvrtToPoly pressed do(
			cnvrtToPoly()
		)	
		on btn_matCheck pressed do(
			matCheck()
		)
		on btn_nSel pressed do(
			undo on (	
				objSel = selection
				for i = 1 to objSel.count do(
					nSel()
				)
			)
		)
		on btn_createShadow pressed do(
			createShadow()
		)	
		on btn_createRoadway pressed do(
			createRoadway()
		)		
		on btn_consolidateObj pressed do(
			consolidateObj()
		)	
		on btn_removeLyr pressed do(
			removeLyr()
		)	
		on btn_nodeSetup pressed do(
			nodeSetup()
		)				
	)
	rof = newrolloutfloater "Production Tools" 200 550
	addrollout ro_1 rof
	addrollout ro_2 rof
)