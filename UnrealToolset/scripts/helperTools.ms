fn createRoot = (
	objSelect = (selection as array)
	selGrp = $
	max modify mode
	for i = 1 to objSelect.count do(
		createSkin = (Skin())
		addModifier objSelect[i] createSkin

		rootPoint = Point size: 10 box: true cross: false centerMarker: false
		rootPoint.wirecolor = green
		rootPoint.name = (objSelect[i].name + "_root")	
		rootPoint.transform = objSelect[i].transform
		
		select objSelect[i]
		skinOps.addbone createSkin rootPoint 0
	)	
	$.modifiers[#Skin].bone_Limit = 4
	completeRedraw()
)

fn multiRoot = (
	max modify mode
	objSelect = (selection as array)
	selGrp = $
	objPos = objSelect[1].pos
	rootPoint = Point pos: objPos size: 10 box: true cross: false centerMarker: false
	rootPoint.wirecolor = green
	rootPoint.name = (objSelect[1].name + "_root")	
	rootPoint.transform = objSelect[1].transform
	createSkin = (Skin())
	addModifier selGrp createSkin
	
	for i = 1 to objSelect.count do(
		select objSelect[i]
	)
	skinOps.addbone createSkin rootPoint 0
	$.modifiers[#Skin].bone_Limit = 4
	completeRedraw()
)

fn multiSocket = (
	max modify mode
	objSelect = (selection as array)
	subRoot = Point size: 5 box: true cross: false
	subRoot.name = (objSelect[1].name)
	subRoot.wirecolor = red
	subRoot.transform = objSelect[1].transform
	completeRedraw()
)

fn createSocket = (
	max modify mode
	undo on(
		for obj in selection do(
			if classof obj == Editable_Poly then(
				subRoot = Point size: 5 box: true cross: false
				subRoot.name = (obj.name)
				subRoot.wirecolor = red
				subRoot.transform = obj.transform
			)else(
				throw "--exception--"
			)
		)
	)	
	completeRedraw()			
)

fn sizeUp = (
	max modify mode
	$.size += 1
)

fn sizeDown = (
	max modify mode
	$.size -= 1
)

fn selByWire = (
	i = $.wirecolor
	select (for o in objects where o.wirecolor == i collect o)
)