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
