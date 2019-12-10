fn createBone = (
	objSel = $
	counter = 1
	vertCount = numKnots $
	boneList = #()

	for k = 1 to (vertCount) do(
		counter += 1
		if counter <= vertCount then(
			newPos = getKnotPoint $ 1 k
			newPos2 = getKnotPoint $ 1 counter
			aBone = BoneSys.createBone newPos newPos2 [0,0,1]
			append boneList aBone
			newPos = newPos2 
			--select objSel
		)
	)
	select boneList
	counter = 1
	for i = 1 to boneList.count do(
		counter += 1

		if counter <= boneList.count then(
			print (counter as string)
			boneList[counter].parent = boneList[i]
		)
	)
	select boneList
	$.width = .2
	$.height = .2
)

fn multiBone = (
	spSel = selection as array 
	boneList = #()
	counter = 1

	for i = 1 to spSel.count do(
		boneList = #()
		select spSel[i]
		vertCount = numKnots spSel[i]

		for k = 1 to (vertCount) do(
			counter += 1
			
			if counter <= vertCount then(
				newPos = getKnotPoint spSel[i] 1 k
				newPos2 = getKnotPoint spSel[i] 1 counter
				aBone = BoneSys.createBone newPos newPos2 [0,0,1]
				append boneList aBone
				newPos = newPos2 
			)--end if
		)--end k loop
			select boneList
			$.width = .1
			$.height = .1
			boneCounter = 1

			for j = 1 to boneList.count do(
				boneCounter += 1

				if boneCounter <= boneList.count then(
					boneList[boneCounter].parent = boneList[j]
				)
			)--end j loop
		counter = 1
	)--end i loop
)

fn ikChain = (
	boneSel = selection as array
	test = IKSys.solverName 1
	
	IKSys.ikChain boneSel[1] boneSel[2] test
	ikPos = $.pos
	ikObj = $
	ikMover = Point size: 5 box: true cross: false
	ikMover.pos = ikPos
	ikMover.wireColor = blue
	ikObj.parent = ikMover
	maxops.affectchildren = true 
	
	select ikMover
)

fn refineBone = (
	maxops.affectchildren = false 
	BoneSys.refineBone()
)

fn boneEditOff = (
	maxops.affectchildren = false 
)

fn boneEditOn = (
	maxops.affectchildren = true 
	
)

fn sizeUp = (
	max modify mode
	$.size += 1
)

fn sizeDown = (
	max modify mode
	$.size -= 1
)

fn parentObj = (
	selectObj = selection as array
	mainObj  = selectObj[1]
	
	for i = 2 to selectObj.count do(
		  selectObj[i].parent = mainObj
	)
)

fn objectReset = (
	max modify mode
	objSel = selection as array

	for i = 1 to objSel.count do(
		--print ("Obj is ----> " + objSel[i] as string)
		ResetXForm objSel[i]
		collapseStack objSel[i]
		convertToPoly objSel[i]
	)
)

