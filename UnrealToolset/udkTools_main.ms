macroScript udkTools_main
category:"UDK Tools"(
	include "scripts\\allFunctions.ms"

	rollout ro_1 "File Tools" (
			group "File Handle" (
				button btn_dir "Object Folder" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Creates a folder for your object under components subfolder in your max directory with the name of the root bone that is selected.  This can be on a single object or multiple objects."
				button btn_saveObj "SaveObject" width:70 height:30 align:#left  offset:[0,0] tooltip:"Creates a max file for the object selected in the object's folder directory under components folder."
				button btn_exploreFldr "explore" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Explores the max work folder."
				button btn_exportFBX "export fbx" width:70 height:30 align:#left offset:[0,0] tooltip:"Exports an object or group of selected objects as a single file to the object's directory under components folder.  Select the root first then the objects that you would like to export with it."
			)
			
			on btn_dir pressed do (
				createDir()
			)
			
			on btn_exportFBX pressed do (
				exportFBX()
			)
			
			on btn_exploreFldr pressed do (
				exploreFldr()
			)
			
			on btn_saveObj pressed do (
				saveObj()
			)
		)--end ro_1

	rollout ro_2 "Production" (
			group "" (
				button btn_removeLyr "removeLyr" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Clears out any unused layers."
				button btn_reset "reset" width:70 height:30 align:#left offset:[0,0] tooltip:"Select objects you would like to reset xform on and collapse."
				button btn_center "cntrPvts" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Center pivots on a single or multiple objects."
				button btn_detach "detachObj" width:70 height:30 align:#left offset:[0,0] tooltip:"Detaches each object in an object to its own element."
			)
			group ""(
				button btn_addUV "addUV" width:70 height:30 align: #left across: 2 offset:[0,0] tooltip:"adds uv modifier to object"
				button btn_clearSceneX "clearSceneX" width:70 height:30 align: #left offset:[0,0] tooltip:"Removes random scene explorers"
				
			)
			
			on btn_removeLyr pressed do (
				removeLyr()
			)
			
			on btn_reset pressed do (
				objectReset()
			)
				
			on btn_center pressed do (
				cntrPivots()
			)
			
			on btn_detach pressed do (
				detachObj()
			)
			
			on btn_addUV pressed do(
				try(
				addUV ()
				)catch(
					messageBox "modeException -- Please convert to editable poly."
				)
			)
		
			on btn_clearSceneX pressed do (
					clearSceneX()
			)	

		)
			
		rollout ro_2a "Filters" (
			group "Filters"(
				button btn_all "all" width:70 height:30 align:#left offset:[40,0] tooltip:"Sets filter to all."			
				button btn_geo "geometry" width:70 height:30 align:#left across: 2  offset:[0,10] tooltip:"Sets filter to geometry."	
				button btn_shape "shapes" width:70 height:30 align:#left offset:[0,10] tooltip:"Filters out shapes"	
				button btn_helper "helpers" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Filters out helpers"	
				button btn_bone "bones" width:70 height:30 align:#left offset:[0,0] tooltip:"Filters out bones"	
			)
			
			on btn_all pressed do (
				filterAll()
			)
			on btn_geo pressed do (
				filterGeo()
			)
			on btn_shape pressed do (
				filterShapes()
			)		
			on btn_helper pressed do (
				filterHelpers()
			)	
			on btn_bone pressed do (
				filterBones()
			)	
		)--end ro_1a	
		
	rollout ro_3 "Bone Tools" (
			group "Create Chain" (
				button btn_createBone "createBone" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Select spline and creates bones along spline.."
				radiobuttons rad_bone labels:#("Single Chain", "Multiple Chains") columns:1
			)
			group ""(
				button btn_ikChain "ikChain" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Select start and end bone to create ik."
				button btn_refineBone "refineBone" width:70 height:30 align:#left offset:[0,0] tooltip:"Presses refine bone without panel.  Right click to end."
			
				button btn_sizeUp "+" width:30 height:30 align:#left offset:[0,10] tooltip:"Select helper and size it up."
				button btn_sizeDown "-" width:30 height:30 align:#left offset:[40,-35] tooltip:"Select helper and size it down."
				
				button btn_boneEdOFF "ON" width:30 height:30 align:#left offset:[80,-35] tooltip:"Enables bone edit mode."
				button btn_boneEdON "OFF" width:30 height:30 align:#left offset:[120,-35] tooltip:"Disables bone edit mode."
			)
			group "" (
				button btn_parent "parent" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Select the object to be parented to first, then pick children you would like to link to the parent."
				button btn_reset "reset" width:70 height:30 align:#left offset:[0,0] tooltip:"Select objects you would like to reset xform on and collapse."
				button btn_sectionRadius "sctnRadius" width:70 height:30 align: #left across: 2 tooltip:"Changes radius of first bone to 10"
				button btn_revSp "reverseSp" width:70 height:30 align: #left tooltip:"Reverses orientation of spline."
			)
			
			on btn_createBone pressed do (
				local getState = rad_bone.state
				
				if getState == 1 then(
					createBone()
				)else	if getState == 2 then(
					multiBone()
				)
			)
			
			on btn_ikChain pressed do (
				ikChain()
			)
					
			on btn_refineBone pressed do (
				refineBone()
			)	
			
			on btn_boneEdOff pressed do (
				boneEditOff()
			)	
			
			on btn_boneEdOn pressed do (
				boneEditOn()
			)	
			
			on btn_parent pressed do (
				parentObj()
			)
			
			on btn_reset pressed do (
				objectReset()
			)
			
			on btn_sizeUp pressed do (
					sizeUp()
			)
			
			on btn_sizeDown pressed do (
				sizeDown()
			)
						
			on btn_sectionRadius pressed do (
				sectionRadius()
			)
			
			on btn_revSp pressed do (
				reverseSp()
			)			
		)--end ro_2	
		
	rollout ro_4 "Helper Tools" (
			group "Root" (
				button btn_root "root" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Creates root bone helper and adds skin modifer to single object or for each object in a group of selected objects.  Roots are green."
				radiobuttons rad_root labels:#("1 per object", "1 for all") columns:1
			)
			group "Socket" (
				button btn_socket "sockets" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Creates sockets for selected objects. Sockets are red."
				radiobuttons rad_socket labels:#("1 per object", "1 for all") columns:1
			)
			group "Helper" (
				button btn_sizeUp "+" width:30 height:30 align:#left across: 3 offset:[0,0] tooltip:"Select helper and size it up."
				button btn_sizeDown "-" width:30 height:30 align:#left offset:[-10,0] tooltip:"Select helper and size it down."
				button btn_selWire "selByWire" width:70 height:30 align:#left offset:[-15,0] tooltip:"Select helper with same color wires."
			)
			
			on btn_root pressed do (
				local getState = rad_root.state
				
				if getState == 1 then (
					createRoot()
				)
				if getState == 2 then(
					multiRoot()
				)
			)
			
			on btn_socket pressed do (
				local getState = rad_socket.state
				
				if getState == 1 then (
					createSocket()
				)
				if getState == 2 then (
					multiSocket()
					)
				)
				
			on btn_sizeUp pressed do (
				sizeUp()
			)
			
			on btn_sizeDown pressed do (
				sizeDown()
			)
			
			on btn_selWire pressed do (
				selByWire()
			)
		)--end ro_3		
		
	rollout ro_5 "Spline Tools" (
			group "Spline Tools"(
				button btn_makeSpline "makeSpline" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Creates spline at pivot of selected objects."
				button btn_selTarget "select target" width:70 height:30 align:#left offset:[0,0] tooltip:"Selects target objects used to create spline."
				button btn_hideTarget "hide target" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Hides target objects used to create spline."
				button btn_unhideTarget "unhide target" width:70 height:30 align:#left offset:[0,0] tooltip:"Unhides target objects used to create spline."
			)
			group "" (
				button btn_enableInVP "Enable In Viewport" width:100 height:30 align:#left offset:[0,0] tooltip:"Enables spline mesh in viewport."
				button btn_disableInVP "Disable In Viewport" width:100 height:30 align:#left offset:[0,0] tooltip:"Disables spline mesh in viewport."
				button btn_genMap "Generate Map" width:100 height:30 align:#left offset:[0,0] tooltip:"Turns on mapping coordinates for splines."
				edittext edt_sides "Sides:" width:65 height:15 align: #left across: 3 offset:[20,5] type:#integer text: ""
				button btn_growSide "+" width:15 height:15 align:#left offset:[40,10] tooltip:"Select helper and size it up."
				button btn_shrinkSide "-" width:15 height:15 align:#left offset:[10,10] tooltip:"Select helper and size it down."
				edittext edt_thickness "Thickness:" width:85 height:15 align: #left across: 3 offset:[0,0] type:#integer text: ""
				button btn_growThick "+" width:15 height:15 align:#left offset:[40,0] tooltip:"Select helper and size it up."
				button btn_shrinkThick "-" width:15 height:15 align:#left offset:[10,0] tooltip:"Select helper and size it down."
			)
			group ""(
				button btn_selAllVerts "selAllVerts" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Selects all spline verts."
				button btn_smoothC "SmoothCurve" width:70 height:30 align:#left offset:[0,0] tooltip:"Changes points to smooth."
				button btn_bezierC "BezierCurve" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Changes points to bezier."
				button btn_cornerC "Corner" width:70 height:30 align:#left offset:[0,0] tooltip:"Changes points to corner."
			)
			
			on btn_makeSpline pressed do (
				makeSpline()
			)
			
			on btn_selTarget pressed do (
				selTarget()
			)
			
			on btn_hideTarget pressed do (
				hideTarget()
			)		

			on btn_unhideTarget pressed do (
				unhideTarget()
			)		
			
			on btn_settings pressed do (
				selTarget()
			)
			
			on btn_selAllVerts pressed do (
				selAllVerts()
			)
			
			on btn_smoothC pressed do (
				smoothCurve()
			)	
			
			on btn_bezierC pressed do (
				bezierCurve()
			)	
			
			on btn_cornerC pressed do (
				cornerCurve()
			)
			
			on btn_enableInVP pressed do (
				enableInVP()
			)
			
			on btn_disableInVP pressed do (
				disableInVP()
			)
			on btn_genMap pressed do (
				genMap()
			)
			
			on edt_sides changed txt do(
				spSides txt
			)
				
			on edt_thickness changed txt do(
				spThickness txt
			)
			
			on btn_growSide pressed do (
				growSide()
			)
			
			on btn_shrinkSide pressed do (
				shrinkSide()
			)
			
			on btn_growThick pressed do (
				growThick()
			)
			
			on btn_shrinkThick pressed do (
				shrinkThick()
			)		
		)
	rof = newrolloutfloater "UDK Tools" 200 265
	addrollout ro_1 rof
	addrollout ro_2 rof
	addrollout ro_2a rof	
	addrollout ro_3 rof
	addrollout ro_4 rof
	addrollout ro_5 rof
)