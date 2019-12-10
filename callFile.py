import maya.cmds as cmds

def MakeLocator():
    print("In the file")
    cmds.spaceLocator(p=(0,0,0), name="animation_control")

def GetCheckBoxValue(minMaxVal=[]):
	wheelsCheckBoxVal = cmds.checkBox('Wheels', query=True, value=False)

	print("Now we're here ")
	print("size...")
	print(len(minMaxVal))
	a = minMaxVal[0]
	b = minMaxVal[1]
	
	print(a)
	print(b)
	
	if(wheelsCheckBoxVal):
		print("*****Passing the intField value: ")
		CreateAttr(wheelsCheckBoxVal, "wheels", minMaxVal)

def GetIntFieldValue(intFieldVal=[]):
	print("In the callFile.  The text box values are: ")

	for x in intFieldVal:
		print(x)
		
	getCheckBoxValue(intFieldVal)

def CreateAttr(checkBoxVal, attrName, test = []):
	print("In the connection")
	print("Once in the connection the value is: ")
	print(checkBoxVal)
	cmds.select('animation_control')
	
	print("In the create.....")
	print(test[0])
	print(test[1])
	cmds.addAttr(longName = attrName, keyable=True, attributeType='float', min=test[0], max=test[1])
	
def AdditionalAttribute(customAttrName):
	print("In the call file additionalAttribute")
	cmds.select('animation_control')
	cmds.addAttr(longName = customAttrName, keyable=True, attributeType='float', min=0, max=100)

def ConnectObjects(someObj, checkBoxValue = []):
	print("In ConnectObjects")
	
	print"Array is: "
	for i in range(0,6):
		print checkBoxValue[i]
	
	"""
	if(checkBoxValue[0]):
		print "X is true"
		cmds.connectAttr( 'animation_control.wheels', objName+'.translateX')
	if(checkBoxValue[1]):
		print "Y is true"
		cmds.connectAttr( 'animation_control.wheels', objName+'.translateY')
	if(checkBoxValue[2]):
		print "Z is true"
		cmds.connectAttr( 'animation_control.wheels', objName+'.translateZ')
	"""
	print "the end"
	
"""def ConnectObjectRotation(objName, checkBoxValue = []):
	print("In ConnectObjectRotation")
	print(objName)
	print("The transform type is: ")
	
	if(checkBoxValue[0]):
		print "X is true"
		cmds.connectAttr( 'animation_control.wheels', objName+'.rotateX')
	if(checkBoxValue[1]):
		print "Y is true"
		cmds.connectAttr( 'animation_control.wheels', objName+'.rotateY')
	if(checkBoxValue[2]):
		print "Z is true"
		cmds.connectAttr( 'animation_control.wheels', objName+'.rotateZ')

	print "the end"
"""	
def AddNewUtility():
	print("In callfile AddNewUtility")
	if(checkBoxValue[0]):
		print "X is true"
		cmds.connectAttr( 'animation_control.wheels', objName+'.rotateX')
