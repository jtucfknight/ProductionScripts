include "scripts\\fileHandle.ms"
	rollout ro_1 "File" (
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
	
rof = newrolloutfloater "File Handling" 200 135
addrollout ro_1 rof