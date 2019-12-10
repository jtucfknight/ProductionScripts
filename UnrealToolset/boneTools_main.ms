include "scripts\\boneTools.ms"

	rollout ro_1 "Tools" (
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
		)
		
		on btn_createBone pressed do (
			local getState = rad_bone.state
			
			if getState == 1 then(
				filePath
				createBone()
			)else	if getState == 2 then(
				filePath
				multiBone()
			)
		)
		
		on btn_ikChain pressed do (
			filePath
			ikChain()
		)
				
		on btn_refineBone pressed do (
			filePath
			refineBone()
		)	
		
		on btn_boneEdOff pressed do (
			filePath
			boneEditOff()
		)	
		
		on btn_boneEdOn pressed do (
			filePath
			boneEditOn()
		)	
		
		on btn_parent pressed do (
			filePath
			parentObj()
		)
		
		on btn_reset pressed do (
			filePath
			objectReset()
		)
		
		on btn_sizeUp pressed do (
			filePath
			sizeUp()
		)
		
		on btn_sizeDown pressed do (
			filePath
			sizeDown()
		)
	)--end ro_1	
	
rof = newrolloutfloater "Bone Tools" 200 265
addrollout ro_1 rof