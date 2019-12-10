macroScript SimTools
category:"Jose Tools"
toolTip:"SimTools v1.0"
buttonText:"SimTools"
/*
SimTools v1.0
Date:	5/6/2013
by:		José Torres
*************************
Updates:
-----------------------------------------------------
name			-	José Torres
date			-	05/07/2013
description:
-fixed code for mapOn/mapOff function
-added modifier check on quickMask and renderUV
-added fileExist to explore, open, assetDir functions
-added geometry check to addUV function
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	05/08/2013
description:
-added unhide button to unhide faces
-added undo option on tempTXTR, mulitPDR
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	05/09/2013
description:
-updated unhide button to polyop method
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	05/20/2013
description:
-updated production tools
-fixed auto smoothing
-reorganized buttons
-added samples and spread to ao tool
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	05/22/2013
description:
-updated mapping tools to check for object selection
-updated renderUV to render a wireframe with alpha rather than a solid.
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	05/24/2013
description:
-updated and condensed renderUV and renderAO
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	05/29/2013
description:
-added radio buttons to toggle the wire selection color while uv'ing
-added mapOn/mapOff, blkWires, and hardware shade to their own group.
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	05/30/2013
description:
-fixed renderUV.  Was not rendering sizes above 512.
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	06/10/2013
description:
-changed visibility tool to use material rather than opacity
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	06/13/2013
description:
-added a function for cleaning up and creating layers
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	06/17/2013
description:
-fixed black/white wires to update viewport to accept new colors
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	07/11/2013
description:
-fixed autoSm bug
-the variable for autoSm and the variable for renderUV were the same and getting confused
-changed the name of autoSm val to list_val
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	07/17/2013
description:
-added max distance to addAO function
-added  tooltip to all buttons
-----------------------------------------------------
-----------------------------------------------------
name			-	José Torres
date			-	08/20/2013
description:
-updated autoSm tool
-added argument to function call and parameters to function
-added mentalRay and scanline buttons to change renderer.
**************************************************
*/
(
	fn quickMask theIndex theSize colorName colorValue = (
		print "Parameters passed:  "
		print theIndex
		print theSize
		print colorName
		print colorValue
		
		Local fileName = colorName
		Local getMod
		getMod = modPanel.getCurrentObject()
		local fileExist = doesFileExist (maxfilepath + "\\_assets\\" + fileName + ".png")

		if (classOf getMod) != Unwrap_UVW or superclassof $ != GeometryClass then(
			messageBox "Please select an object or add unwrap modifier."
		)else if theIndex >= 1 and theSize >= 1 then(
			max modify mode
			polyObject = $
			subobjectLevel = 3
			polyObject.unwrap_uvw.unhide()
			polyObject.unwrap_uvw.selectByMatID theIndex
			max select invert()
			polyObject.unwrap_uvw.hide()
			polyObject.unwrap_uvw.renderuv_fillmode = 1
			polyObject.unwrap_uvw.renderuv_showoverlap = off
			polyObject.unwrap_uvw.renderuv_seamedges = off
			polyObject.unwrap_uvw.renderuv_visibleedges = off
			polyObject.unwrap_uvw.renderuv_width = theSize
			polyObject.unwrap_uvw.renderuv_height = theSize
			polyObject.unwrap_uvw.renderuv_fillColor = colorValue
			pngio.setAlpha true
			polyObject.unwrap_uvw.renderuv_showframebuffer = true
			--polyObject.unwrap_uvw.unhide()
			--***********************************************************************
				if fileExist != fileName then(
					saveUV = maxfilepath + "\\_assets\\" + fileName + ".png"
					uvRenderPath = saveUV
					polyObject.unwrap_uvw.renderuv_showframebuffer = true	
					polyObject.unwrap_uvw.renderUV uvRenderPath
				) else (
					local counter
					counter += 1
					saveUV = maxfilepath + "\\_assets\\" + "test" + ".png"
				)
			--***********************************************************************
				
		)else(
			throw "exception"
		)
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

	fn edgeToFace = (
		if subobjectLevel == 2 then(
			actionMan.executeAction 2077580866 "40100"  -- All Commands: Edge to Face Select
			subobjectLevel = 3
		) else(
			throw "modeException"
		)
	)

	fn flattenUV = (
		subobjectLevel = 3
		undo on(
			if subobjectLevel == 3 then(
				local polyObject = $
				polyObject.Unwrap_UVW.setFlattenNormalize off
				polyObject.Unwrap_UVW.setFlattenSpacing(0.003) 
				polyObject.Unwrap_UVW.flattenMapNoParams()
			) else(
				messageBox "Please select face mode."
			)
		)
	)

	fn explore = (
		local folderExist = doesFileExist (maxfilepath + "\\_assets\\")
		
		if folderExist == true then(		
			subDir = maxfilepath + "_assets\\"
			shellLaunch "explorer.exe" subDir
		)else(
			messageBox "Please create an _assets folder first."
		)
	)

	fn multiSub = (
		MatEditor.mode = #basic
		MatEditor.Open() 
		$.material = meditMaterials[1]
		meditMaterials[1] = Multimaterial numsubs:6
		meditMaterials[1].name = "TempColors"
		meditMaterials[1].names[1] = "red"
		meditMaterials[1].names[2] = "green"
		meditMaterials[1].names[3] = "blue"
		meditMaterials[1].names[4] = "cyan"
		meditMaterials[1].names[5] = "magenta"
		meditMaterials[1].names[6] = "yellow"

		meditMaterials[1].materialList[1].Diffuse = color 255 0 0
		meditMaterials[1].materialList[2].Diffuse = color 0 255 0
		meditMaterials[1].materialList[3].Diffuse = color 0 0 255
		meditMaterials[1].materialList[4].Diffuse = color 0 255 255
		meditMaterials[1].materialList[5].Diffuse = color 255 0 255
		meditMaterials[1].materialList[6].Diffuse = color 255 255 0
		$.material = meditMaterials[1]
	)

	fn createDirectory = (
		local folderExist = doesFileExist (maxfilepath + "\\_assets\\")
			
		if folderExist != true then(			
			test = maxfilepath + "\\_assets\\"
			makeDir test
		)else(
			messageBox "_assets folder already exist.  Press explore."
		)
	)

	fn autoOpen = (
	-- 	deselect(objects)
	-- 	clearselection()
		try(
			local folderExist = doesFileExist (maxfilepath + "\\_assets\\")
				
			if folderExist == true then(	
				subDirectory = maxFilePath + "\_assets\*.png"
				files = getFiles (subDirectory)
				--print ("Num files: %\n" + files.count as string)
					for f in files do (
						--print ("File name is:  %\n" + f)
						pshop = CreateOLEObject ("Photoshop.Application")
						pshop.application.name
						pshop.application.visible = true
						pshop.open f
						releaseOLEObject pshop
					)
				)else(
						messageBox "Please create an _assets folder first."
				)
			)catch print (getCurrentException())
	-- 			messagebox (getCurrentException() as string) 
		)

	fn renderUV uv_size = (
-- 		format "Inside of render512() \n"
		polyObject = $
		subobjectLevel = 3
		polyObject.Unwrap_UVW.unhide()
		polyObject.Unwrap_UVW.DisplayMap off
		polyObject.Unwrap_UVW.setShowMapSeams off
		polyObject.Unwrap_UVW.setPeltAlwaysShowSeams off
		polyObject.Unwrap_UVW.setNormalizeMap off
		polyObject.Unwrap_UVW.renderuv_width = uv_size
		polyObject.Unwrap_UVW.renderuv_height = uv_size
		polyObject.Unwrap_UVW.renderuv_force2sided = off
		polyObject.Unwrap_UVW.renderuv_showoverlap = off
		polyObject.Unwrap_UVW.renderuv_fillColor = color 150 150 150
		polyObject.Unwrap_UVW.renderuv_fillmode = 1
		polyObject.Unwrap_UVW.renderuv_visibleedges = on
		polyObject.Unwrap_UVW.renderuv_seamedges = on
		pngio.setAlpha true
		saveUV = maxfilepath + "\\_assets\\" + "uv.png"
		uvRenderPath = saveUV
		polyObject.Unwrap_UVW.renderuv_showframebuffer = true	
		polyObject.Unwrap_UVW.renderUV uvRenderPath
		subobjectLevel = 0
-- 		uv_size = 0
-- 		uvSizeReturned = 0
	)
		
	fn changeRenderer = (
		renderType = mental_ray_renderer ()
		renderers.current = renderType
		renderType.FinalGatherEnable2 = false
		renderType.Jitter = false
		renderType.TaskOrder = 2
	)
	
	global aoSample = 64
	global aoSpread = .5
	global aoMaxDist = 0.0
	global ao_size = 0
	
	fn renderAO = (

-- 		format "Inside of render512() \n"
		obj = $
		changeRenderer()
		obj.iNodeBakeProperties.removeAllBakeElements()
		addAO = AmbientOcclusionBakeElement()
		obj.INodeBakeProperties.bakeEnabled = true
		obj.INodeBakeProperties.bakeChannel = 1
		obj.INodeBakeProjProperties.BakeObjectLevel = true
		addAO.bright = (color 255 255 255 255)
		addAO.dark = (color 35 35 35)
		addAO.falloff = .5
		addAO.elementName = "_AO_pass"
		addAO.samples = aoSample
		addAO.spread = aoSpread
		addAO.maxDistance = aoMaxDist
		print ("Max Distance is: " + aoMaxDist as string)
		addAO.outputSzY = ao_size
		addAO.outputSzX = ao_size
		addAO.fileType = (maxfilepath +"\\_assets\\" +"ao.png")
		addAO.fileName = filenameFromPath addAO.fileType
		$.INodeBakeProperties.addBakeElement addAO
		render renderType:#bakeSelected frame:#current vfb:true
		--aoSizeReturned = 0
		--ao_size = 0
	)

	--Production Functions***********************************************************************************************************
	fn unhideFace = (
			undo on(
				for obj in selection do(
					if classof obj == Editable_Poly then (
						polyop.unHideAllFaces obj
					)else(
						messageBox "Please select an editable poly."
					)
				)
				completeRedraw()
			)
		)
	
	fn autoSm smAngle = (
		undo on(
			theObj = selection as array
			count = 1
			
			max modify mode
			
			for i = 1 to theObj.count do(
				select theObj[count]
				count += 1
				
				facenumber = polyop.getNumFaces $
				faceSet = #()

				for j=1 to facenumber do(
					append faceSet j
				)

				subobjectlevel = 4

				polyop.setFaceSelection $ faceSet
				$.autoSmoothThreshold = smAngle
				$.EditablePoly.autosmooth ()
				subobjectlevel = 0
			)
		)
	)
		
	fn tempTXTR = (
		undo on(
			local polyObject = $
			polyObject.wirecolor = color 0 0 255
			polyObject.material = meditMaterials[19]
			polyObject.name = "temp_components"
		)
		completeRedraw()
	)
		
	fn visible = (
-- 		obj = $
-- 		obj.visibility = true
		meditMaterials[19].opacity = 100
		completeRedraw()
	)

	fn invisible = (
-- 		obj = $
-- 		obj.visibility = false
		meditMaterials[19].opacity = 0
		completeRedraw()
	)
		
	fn backCullOn = (
		local polyObject
		polyObject = $
		polyObject.backfacecull = on
	)

	fn backCullOff = (
		local polyObject
		polyObject = $
		polyObject.backfacecull = off
	)

	fn resetX = (
		selectedObjects = selection as array

		for i = 1 to selectedObjects.count do(
			convertToPoly(selectedObjects)
			RESETXFORM selectedObjects
			convertToPoly(selectedObjects)
		)		
	)
	
	fn polyFlip = (
		for obj in selection do(
			addModifier obj (normalModifier())
			obj.modifiers[#Normal].flip = on
			convertToPoly (obj)
		)
		completeRedraw()
	)

	fn blackWires = (
		polyObject = $
		polyObject.wirecolor = color 0 0 0
		
	)
	fn mapOn = (
		for obj in selection do(
			showTextureMap obj.material on
-- 			enableHardwareMaterial obj.material true
		)
	)	
	
	fn mapOff = (
		for obj in selection do(
			showTextureMap obj.material off
			enableHardwareMaterial obj.material false
		)
	)		
	
	fn cvtPoly = (
		undo on(
			for obj in selection do(
				convertToPoly obj
			)
		)
	)
	
	fn multiPDR = (
		undo on(
-- 		print "In the function"
			for obj in selection do (
				if superclassof obj == GeometryClass then (
					print "This is geometry"
					--theObject = $
					myHelper = Dummy pos:[0,0,0] scale:[5,5,5]
					selectObj = selection
					selectObj.parent = myHelper
					--myHelper.name = selectObj.name
					myHelper.name = "RENAME ME"
					clearselection()
				)else	(
					messagebox "This is not valid geometry.\nPlease select valid geometry."
					print "This is not valid geometry"
				)
			)
		)
	)
	
	fn PDR = (
		selectedObjects = selection as array

		for i = 1 to selectedObjects.count do
		(
			format "The object is: %\n" selectedObjects[i]
			helpObj = Dummy pos:[0,0,0] scale:[3,3,3]
			helpObj.name = selectedObjects[i].name
			selectedObjects[i].parent = helpObj
		)
	)
	
	fn mirrorMod = (
		undo on(
			max modify mode
			addMod = (Mirror())
			polyObject = $	
			for obj in selection do (
				addModifier obj addMod
				obj.mirror.copy = on
				subobjectLevel = 1
			)
			
			for obj in selection do(
				modPanel.setCurrentObject obj.modifiers[1]
				subobjectLevel = 1
			)
-- 			modPanel.setCurrentObject polyObject.baseObject
-- 			modPanel.setCurrentObject polyObject.modifiers[1]
		)
	)
	
	
--Layer Tools Functions***********************************************************************************************************
	fn createLyr = (
	--sets layers to 0
	defaultLayer = LayerManager.getLayer 0
	defaultLayer.current = true

	select $*
	objSelection = selection as array

	for i = 1 to objSelection.count do(
		obj = objSelection[i]	
		defaultLayer.addnode obj
	)

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

	--creates layers for models, proxies, and dummies
		
	objSelection = ( selection as array )

	LayerManager.newLayerFromName "model"
	LayerManager.newLayerFromName "proxy"
	LayerManager.newLayerFromName "dummy"

		for i = 1 to objSelection.count do(
			obj = objSelection[i]
			objString = obj.name
			
			strCheck1 = matchPattern objString pattern:"*proxy*"
			strCheck2 = matchPattern objString pattern:"*dummy*"
			
			if strCheck1 == true then(
				proxyLyrExist = (LayerManager.getLayerFromName "proxy").name
				
				if proxyLyrExist == "proxy" then(
					print "proxy layer exist"
					layerName = (LayerManager.getLayerFromName "proxy")
					layerName.addnode obj
				)else if doesLyrExist == undefined then(
					print "proxy layer does not exist"
				)

			) else if classof obj == Dummy then(
				dummyLyrExist = (LayerManager.getLayerFromName "dummy").name
				
				if dummyLyrExist == "dummy" then(
					print "dummy layer exist"
					layerName = (LayerManager.getLayerFromName "dummy")
					layerName.addnode obj
				)else if doesLyrExist == undefined then(
					print "dummy layer does not exist"
				)

			) else if strCheck1 == false and strCheck2 == false then(
				modelLyrExist = (LayerManager.getLayerFromName "model").name
				
				if modelLyrExist == "model" then(
					print "layer exist"
					layerName = (LayerManager.getLayerFromName "model")
					layerName.addnode obj
				)else if doesLyrExist == undefined then(
					print "layer does not exist"
				)
			)
		)
	)
	
	fn isMentalRay = (
		renderType = mental_ray_renderer ()
		renderers.current = renderType
	)
	
	fn isDefaultScanLine = (
		renderType = Default_Scanline_Renderer()
		renderers.current = renderType
	)
--end function******************************************************************************************************************
--try(closerolloutfloater rof) catch("Dialog close error!")
	
	global docPath = "C:\\Users\\" + sysinfo.username + ".ALIONSCIENCE\\Downloads\\Subversion\\CG_Resources\\Scripts\\MaxScripts\\help.docx"
-- 	global docPath = getSourceFileName() + "\\help.docx"
	format "The path is:  %\n"docPath
-- 	format "The doc path is:  %\n" docPath
	rollout a "Help"(
		group "Help"	(
			HyperLink Hypl_homepage "Sim Tools Help" align:#center width:75 height:15 address: docPath color:(color 0 0 255) hovercolor:(color 255 255 0) visitedcolor:(color 255 0 255)
		)--end group
	)--end rollout a

	rollout b "UV Tools" (
		group "UV Quick Tools"	(
			button btn_A "addUV" across:3 width:50 height:30 align: #left tooltip:"adds uv modifier to object"
			button btn_B "edgeFace" width:50 height:30 align: #left tooltip:"converts multiple edges to face in uv editor"
			button btn_C "flattenUV" width:50 height:30 align: #left tooltip:"flattens uv's"
			button btn_D "explore" across: 3 width:50 height:30 align: #left tooltip:"opens windows explorer window where assets are located"
			button btn_E "assetDir" width:50 height:30 align: #left tooltip:"creates an asset directory in the folder in which max file is saved"
			button btn_F "open" across:3 width:50 height:30 align: #left tooltip:"opens all templates located in assets folder in photoshop for merge"
		)--end group
		
		group ""(
			label wires_lbl "Selected Wire Color: " across:2 offsets:#([0,40]) align:#left
			radiobuttons wires_rdo labels:#("black", "white") offsets:#([-130,20], [-177,40]) align:#left default:2 tooltip:"changes wire selection to black or white when in uv mode"
		)
		
		on btn_A pressed do(
			try(
			addUV ()
			)catch(
				messageBox "modeException -- Please convert to editable poly."
			)
		)

		on btn_B pressed do(
			try(
				edgeToFace ()
			)catch(
				messageBox "modeException -- Please select an edge."
			)
		)

		on btn_C pressed do(
			try(
				flattenUV()
			)catch(
				messageBox "modeException -- Please select a polygon."
			)
		)
		
		on btn_d pressed do (
			explore()
		)
		
		on btn_E pressed do (
			createDirectory()
		)
		
		on btn_F pressed do (
			clearselection()
			autoOpen()
		)
		
		on wires_rdo changed state do(
			print "radio button changed"
				
			if state == 1 then(
				backCullOn ()
				print state
				SetUIColor 0 (color 0 0 0)--black 
				colorMan.repaintUI #repaintAll
				state = 1
-- 				completeRedraw()
			)else if state == 2 then(
				print state
				SetUIColor 0 (color 1 1 1)--white
				colorMan.repaintUI #repaintAll
				local polyObject
				polyObject = $
				polyObject.backfacecull = on
-- 				completeRedraw()
				state = 2
			)
		)
	)--end rollout b

	rollout c "Mapping Tools" (
		
		group "Mapping Tools"	(
			button btn_G "rend.UV" width:50 height:30 across:2 align:#left tooltip:"renders uv map template"
			button btn_H "addAO" width:50 height:30 align: #left offset:[-45,0] tooltip:"adds ambient occlusion"
			edittext edt_samples "Samples:" width:80 height:15 align: #left offset:[150,-30] type:#integer text: "64"
			edittext edt_spread "Spread:  " width:80 height:15 align: #left offset:[150,0] type:#float text: ".5"
			edittext edt_maxDist "MaxDist.:  " width:88 height:15 align: #left offset:[142,0] type:#float text: "0.0"
			dropdownlist ddl_G "UV Size" items:#("select","512","1024","2048","4096") across:2 width:50 height:30 align: #left
			dropdownlist ddl_H "AO Size" items:#("select","512","1024","2048","4096") width:50 height:30 offset:[-45,0]

		)--end group
		
		group "" (
			button btn_qm "quickMask" width:50 height:30  across: 2 align: #left  tooltip:"creates rgb mask for specified material id"
			dropdownlist ddl_size "Size" items:#("512","1024","2048","4096") width:55 height:30 align: #left offset:[-70,-10]
			listBox listbox_color "Mask I.D." items:#("red - 1","green - 2","blue - 3","cyan - 4","magenta - 5","yellow - 6") width:80 height: 7 align: #left
		)
		
		on edt_samples changed text do(
			if aoSample == undefined then(
				messageBox "Enter a sample and spread."
			)else(
				--global aoSample = 64
				aoSample = text as integer
	-- 			print ("edt_samples text is:" + text) 
			)
		)
		
		on edt_spread changed text do(
			--global aoSpread = .5
			if aoSample == undefined then(
				messageBox "Enter a sample and spread."
			)else(
				aoSpread = text as float
-- 				print ("edt_spread text is:" + text) 
			)
		)
		
		on edt_maxDist changed text do(
			if aoMaxDist == undefined then(
				messageBox "Enter a sample and spread."
			)else(
				aoMaxDist = text as float
-- 				print ("edt_spread text is:" + text) 
			)
		)
		
		on ddl_G selected sel do(
			format "Value returned back to ddl_G: %\n" sel
			global uvSizeReturned = sel
-- 			print sel
			format "RenderUV should have: %\n" uvSizeReturned
		)
		
		on btn_G pressed do (
-- 			print uvSizeReturned
			local getMod
			global uv_size = 0
			
			getMod = modPanel.getCurrentObject()
			
			if (classOf getMod) != Unwrap_UVW or superclassof $ != GeometryClass then(
				messageBox "Please select an object or add unwrap modifier."
			)else if  uvSizeReturned == undefined or uvSizeReturned < 2 then(
				messageBox "Please select a size."
			)else	if uvSizeReturned == 2 then (
-- 				format "You selected %\n" uvSizeReturned
				uv_size = 512
				renderUV(uv_size)
			) else if uvSizeReturned == 3 then (
-- 				format "You selected %\n" uvSizeReturned
				uv_size = 1024
				renderUV(uv_size)
			) else if uvSizeReturned == 4 then(
-- 				format "You selected %\n" uvSizeReturned
				uv_size = 2048
				renderUV(uv_size)	
				
			) else if uvSizeReturned == 5 then(
-- 				format "You selected %\n" uvSizeReturned
				uv_size = 4096
				renderUV(uv_size)	
			)
		)
		
		on ddl_H selected sel do (
-- 			format "The value passed in to H is:  %\n" sel2
			global aoSizeReturned = sel
-- 			format "aoSizeReturned is %\n" aoSizeReturned
		)
		
		on btn_H pressed do (
			if aoSizeReturned == undefined or aoSizeReturned < 2 or superclassof $ != GeometryClass then(
					messageBox "Please select an object or a size."
			)else	if aoSizeReturned == 2 then (
-- 				format "You selected %\n" aoSizeReturned
				ao_size = 512
				renderAO()
-- 				aoSizeReturned = 0
			) else if aoSizeReturned == 3 then (
-- 				format "You selected %\n" aoSizeReturned
				ao_size = 1024
				renderAO()
-- 				aoSizeReturned = 0
			) else if aoSizeReturned == 4 then(
-- 				format "You selected %\n" aoSizeReturned
				ao_size = 2048
				renderAO()
-- 				aoSizeReturned = 0
			) else if aoSizeReturned == 5 then(
-- 				format "You selected %\n" aoSizeReturned
				ao_size = 4096
				renderAO()
-- 				aoSizeReturned = 0				
			)
		)
		
		fn getSelectedID = (
			Local maskID = listbox_color.selection
		)
		
		fn getMapSize = (
			Local maskSize = ddl_size.selection
		
			case  maskSize of(
				1:  512
				2:  1024
				3:  2048
				4:  4096
				default: print "no map size selected"
			)
		)
		
		fn getColorName theIndex =(
			Local colorName = theIndex
			--print ("Mask id is:  " + maskID)
 			case  colorName of(
				1:  "red"
				2:  "green"
				3:  "blue"
				4:  "cyan"
				5:  "magenta"
				6:  "yellow"
				default: print "No color assigned"
			)
		)
		
		fn getColorValue theIndex =(
			Local maskID = theIndex
			--print ("Mask id is:  " + maskID)
 			case  maskID of(
				1:  color 255 0 0
				2:  color 0 255 0
				3:  color 0 0 255
				4:  color 0 255 255
				5:  color 255 0 255
				6:  color 255 255 0
				default: print "No color assigned"
			)
		)
	
		on btn_qm pressed do (
			Local theIndex = getSelectedID()
			Local theSize = getMapSize()
			Local colorName = getColorName theIndex
			Local colorValue = getColorValue theIndex
			
			quickMask theIndex theSize colorName colorValue 
		)
	)--end rollout c

	rollout d "Production Tools" (
		
		group "Production Tools" (
			button btn_M "invisible" width:50 height:30 across:3 align:#left tooltip:"temp texture opacity set to zero"
			button btn_L "visible" width:50 height:30 align: #left tooltip:"temp texture opacity set to 100"
			button btn_K "tempTXTR" width:50 height:30 align: #left tooltip:"temporary texture"
			
-- 			button btn_J "autoSm" width:50 height:30 across:3 align:#left
			button btn_N "cullOn" width:50 height:30 across:3 align: #left tooltip:"turns on back face cull"
			button btn_O "cullOff" width:50 height:30 align: #left tooltip:"turns off back face cull"
			button btn_Z "unhide" width:50 height:30 align:#left tooltip:"unhides all faces in editable poly"
			
			button btn_Q "PDR" width:50 height:30 across:3 align:#left tooltip:"Each object gets a dummy"
			button btn_P "multiPDR" width:50 height:30 align:#left tooltip:"One dummy for several objects"
			button btn_R "multiSub" width:50 height:30 align: #left tooltip:"creates a multi colored multi sub to work with quickMask"
			
			button btn_X "cnvtPoly" width:50 height:30 across: 3 align:#left tooltip:"converts to editable polygon"
			button btn_S "resetX" width:50 height:30  align:#left tooltip:"resets xform"
			button btn_T "polyFlip" width:50 height:30 align: #left tooltip:"with cullOn, uniformly flips inverted faces"
			
			button btn_mirror "mirror" width:50 height:30 across:1 align:#left tooltip:"adds mirror modifier object stack"
			

-- 			button btn_X "modPanel" width:50 height:30 across:3 align:#left
			
		)--end group
		
		group ""(
			button btn_V "mapOn" width:50 height:30 across: 3 align:#left tooltip:"turns on map on a standard material"
			button btn_W "mapOff" width:50 height:30 align:#left tooltip:"turns on map off a standard material"
			button btn_U "blkWires" width:50 height:30 align: #left tooltip:"sets wires to black"
			checkBox hardware_checkBox "Hardware Shade" checked:false triState:0 across: 1 offsets:#([-180,0]) align:#left  tooltip:"turns on hardware shade in standard material"

		)--end group
		
		group "" (
			button btn_J "autoSm" width:50 height:30 align:#left across: 2 offset:[0,0] tooltip:"automatically smooths object to specified angle"
			listBox listbox_autoSm "AutoSm" items:#("Choose angle: ","1", "15","25","35","45","75","90") width:80 height: 8 offset:[-70,0] align:#left
		)--end group
		
		group "Layers" (
			button btn_createLyr "layer" width:50 height:30 align:#left across: 3 offset:[0,0] tooltip:"removes unused layers and sets final model, dummy, proxy to appropriate layer"
			button btn_mr "mentalRay" width:70 height:30 align:#left offset:[-10,0] tooltip:"sets renderer to Mental Ray"
			button btn_scanLine "scanLine" width:50 height:30 align:#left offset:[0,0] tooltip:"sets renderer to Default Scanline"
		)--end group
		
		on btn_createLyr pressed do (
			createLyr ()
		)
		
		on btn_mr pressed do (
			isMentalRay()
		)
		
		on btn_scanLine pressed do (
			isDefaultScanLine()
		)		
		on hardware_checkBox changed state do(
			
			if state == true then(
				print ("state is:  " + state as string)
				enableHardwareMaterial $.material true
			)else(
				print ("it's:  " + state as string)
				enableHardwareMaterial $.material false
			)
		)
		
		on listbox_autoSm selected lb_val do(
			global smAngle
			global noAngle = lb_val
			format "List box value is: %\n" lb_val
			smAngle = 0.0
-- 			format "Smooth angle is: %\n" smAngle
			if lb_val == 2 then(
				smAngle = 10.0
			) else if lb_val == 3 then(
				smAngle = 15.0
			) else if lb_val == 4 then(
				smAngle = 25.0
			)else if lb_val == 5 then(
				smAngle = 35.0
			)else if lb_val == 6 then(
				smAngle = 45.0
			)else if lb_val == 7 then(
				smAngle = 75.0
			)else if lb_val == 8 then(
				smAngle = 90.0
			)
		)
		
		on btn_J pressed do (
			if noAngle == 1 or noAngle == undefined or classOf $ != Editable_Poly then (
				messageBox "Please select an angle or an object."
			)else(
				autoSm (smAngle)
				--smAngle = 0.0
			)
		)
		
		on btn_K pressed do (
			tempTXTR ()
		)

			on btn_L pressed do (
			visible ()
		)

		on btn_M pressed do (
			invisible ()
		)

		on btn_N pressed do (
			backCullOn ()
		)	

		on btn_O pressed do (
			backCullOff ()
		)	
		
		on btn_P pressed do (
			multiPDR ()
		)	
		
		on btn_Q pressed do (
			PDR()
		)	
		
		on btn_R pressed do (
			multiSub ()
		)	
		
		on btn_S pressed do (
			resetX ()
		)
		
		on btn_T pressed do (
			polyFlip ()
		)
		
		on btn_U pressed do (
			blackWires ()
		)		
		
		on btn_V pressed do (
			mapOn ()
		)	

		on btn_W pressed do (
			
			mapOff ()
			
		)	

		on btn_X pressed do (
			cvtPoly ()
		)
		
		on btn_Z pressed do (
			unhideFace ()
		)		
		
		on btn_mirror pressed do (
			mirrorMod ()
		)	
	)--end rollout d
	rof = newrolloutfloater "Sim Tools v1.0" 300 500
	addrollout a rof
	addrollout b rof
	addrollout c rof
	addrollout d rof
	--end main**********************************************
)