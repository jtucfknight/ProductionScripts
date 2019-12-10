	include "scripts\\productionTools.ms" 

	rollout ro_1 "Production Tools" (
		group "" (
			button btn_removeLyr "removeLyr" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Clears out any unused layers."
			button btn_reset "reset" width:70 height:30 align:#left offset:[0,0] tooltip:"Select objects you would like to reset xform on and collapse."
			button btn_center "cntrPvts" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Center pivots on a single or multiple objects."
			button btn_detach "detachObj" width:70 height:30 align:#left offset:[0,0] tooltip:"Detaches each object in an object to its own element."
		)
		group ""(
			button btn_addUV "addUV" width:70 height:30 align: #left tooltip:"adds uv modifier to object"
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
	)
	
	rollout ro_2 "Filters" (
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
	)--end ro_1	
rof = newrolloutfloater "Production Tools" 200 365
addrollout ro_1 rof
addrollout ro_2 rof