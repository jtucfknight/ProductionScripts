import maya.cmds as cmds
import maya.mel as mel
import sys

sys.path.append("Z:/Work\Jose/_Scripts/Maya/")
import callFile
reload (callFile)

# Define function
def CallCreateLocator(*args):
    print ("Anim control was pushed.")
    callFile.MakeLocator()   

def GetCheckBoxValue(*args):
    print ("Create Attributes control was pushed.")
    callFile.GetCheckBoxValue() 

def GetVals(val):
    print "Both values: "
    minVal = cmds.intField(numMin, q=True, value=True)
    maxVal = cmds.intField(numMax, q=True, value=True) 

    intValues = []
    intValues.append(minVal)
    intValues.append(maxVal)  

    for i in range(0,2):
        print intValues[i]        

    callFile.GetCheckBoxValue(intValues)

def AddCustomAttribute(*args):
    print "Pressed add attribute" 
    fieldText = cmds.textField(fieldTextEntered, editable = True, query = True, text=True)
    print(fieldText)
    callFile.AdditionalAttribute(fieldText)

def GetAxis(*args):
    print("In the GetAxis")  

def GetTranslate(translation):
    #Get object name
    print("Translate pressed")
    selected = cmds.ls(sl=True,long=True)
    print(selected[0])   

    #Get checkbox value
    getTranslate = cmds.checkBox('translate', query=True, value=False)
    getRotate = cmds.checkBox('rotate', query=True, value=False)
    getX = cmds.checkBox('x', query=True, value=False)
    getY = cmds.checkBox('y', query=True, value=False)
    getZ = cmds.checkBox('z', query=True, value=False)
    print "Transform selected is: "
    print getTranslate
    print getRotate
    print "Axis are: "
    print getX
    print getY
    print getZ   

    #Store checkbox values
    chkBoxValues = []
    chkBoxValues.append(getX)
    chkBoxValues.append(getY)
    chkBoxValues.append(getZ)
    print len(chkBoxValues)
    print "Checkbox values are: "
    for i in range(0,3):
        print chkBoxValues[i]
  
    callFile.ConnectObjects(selected[0], chkBoxValues)    

def GetRotation(rotation):
    print("Rotation pressed")
    selected = cmds.ls(sl=True,long=True)
    print(selected[0])  

    #Get checkbox value
    getX = cmds.checkBox('x', query=True, value=False)
    getY = cmds.checkBox('y', query=True, value=False)
    getZ = cmds.checkBox('z', query=True, value=False)
    print "Axis are: "
    print getX
    print getY
    print getZ   

    #Store checkbox values
    chkBoxValues = []
    chkBoxValues.append(getX)
    chkBoxValues.append(getY)
    chkBoxValues.append(getZ)
    print len(chkBoxValues)

    print "Checkbox values are: "
    for i in range(0,3):

        print chkBoxValues[i] 

    callFile.ConnectObjectRotation(selected[0], chkBoxValues)      

def PressedGetAttribute(*arg):
    selected = cmds.ls(sl=True,long=True)
    print(selected[0])  
    #Get attribute
    print "GetAttributePressed"
    channelBox = mel.eval('global string $gChannelBoxName; $temp=$gChannelBoxName;')
    attrs = cmds.channelBox(channelBox, q=True, sma=True)
    print attrs
    
    
    #Change label
    #attrLabelName = cmds.text( label='Select an attribute', align='left' )
    cmds.text("Test")

    #print test
    
def PressedConnect(*args):
    print("Pressed the connect button")
    
    #Query utility checkbox value
    print "Utility check: "
    chkNewUtility = cmds.checkBox("new", query=True, value=False)
    chkReuseUtility = cmds.checkBox("reuse", query=True, value=False)
    print chkNewUtility
    print chkReuseUtility

    print "Transform selected is: "
    #Query transform checkbox value
    getTranslate = cmds.checkBox('translate', query=True, value=False)
    getRotate = cmds.checkBox('rotate', query=True, value=False)
    print getTranslate
    print getRotate 
        
    #Query axis checkbox 
    print "Axis are: "
    getX = cmds.checkBox('x', query=True, value=False)
    getY = cmds.checkBox('y', query=True, value=False)
    getZ = cmds.checkBox('z', query=True, value=False)
    print getX
    print getY
    print getZ 
    
    chkBoxValues = []
    chkBoxValues.append(chkNewUtility)
    chkBoxValues.append(chkReuseUtility)
    chkBoxValues.append(getTranslate)
    chkBoxValues.append(getRotate)
    chkBoxValues.append(getX)
    chkBoxValues.append(getY)    
    chkBoxValues.append(getZ) 
    """print"The array is:\n"
    for x in range(0,6):
        print chkBoxValues[x] """ 
    callFile.ConnectObjects(chkBoxValues)  
    
def PressedAddNewUtility(*args):
    print"Pressed AddNewUtility"
    newShader = cmds.shadingNode('multiplyDivide', asShader=True)

def PressedDotRing(*arg):
    print("DotRing pressed")

def PressedDotLoop(*arg):
    print("DotLoop pressed")

def PressedMakeLOD(*arg):
    print("MakeLOD pressed")


def PressedSelectLOD(*arg):
    print("SelectLOD pressed") 
             

# Destroy dialog if exist
if cmds.window("TestUI", exists = True):
    cmds.deleteUI("TestUI")

# Create window
window = cmds.window("TestUI", title = "LOD Production Tool", sizeable = True, widthHeight=(500, 550), minimizeButton = True, maximizeButton = True)

# Begin GUI
cmds.frameLayout( label='Animation Control' )

cmds.rowColumnLayout(numberOfColumns=1, columnSpacing=[(1, 10)], rowSpacing=[(1, 10)])
cmds.button("create animation control", command=CallCreateLocator)
cmds.setParent( '..' )

cmds.frameLayout( label='Standard Attribution', width=100 )
cmds.rowColumnLayout(numberOfColumns=4, columnSpacing=[(1, 107), (2, 14), (3, 178), (4, 19)], rowSpacing=[(1, 10)])
cmds.text( label='Min', align='left' )
cmds.text( label='Max', align='left' )
cmds.text( label='Min', align='left' )
cmds.text( label='Max', align='left' )
cmds.setParent( '..' )

cmds.rowColumnLayout(numberOfColumns=6, columnSpacing=[(1, 10), (2, 10), (3, 5), (4, 40), (5, 10), (6, 10)], rowSpacing=[(1, 10)])
cmds.checkBox("Wheels")

numMin = cmds.intField(width=30)
numMax = cmds.intField(width=30)

cmds.checkBox("Steering Wheel")
cmds.intField(width=30)
cmds.intField(width=30)
cmds.checkBox("Doors")
cmds.intField(width=30)
cmds.intField(width=30)
cmds.checkBox("Commander Hatch")
cmds.intField(width=30)
cmds.intField(width=30)
cmds.checkBox("Driver Hatch")
cmds.intField(width=30)
cmds.intField(width=30)
cmds.checkBox("Gunner Hatch")
cmds.intField(width=30)
cmds.intField(width=30)
cmds.checkBox("Main Trav")
cmds.intField(width=30)
cmds.intField(width=30)
cmds.checkBox("Main Elev")
cmds.intField(width=30)
cmds.intField(width=30)
cmds.setParent( '..' )

cmds.rowColumnLayout(numberOfColumns=1, columnSpacing=[(1, 10)])
cmds.button("create attributes", command=GetVals)
cmds.setParent( '..' )
cmds.separator( height=10, style='in' )

cmds.rowColumnLayout(numberOfColumns=1, columnSpacing=[(1, 10)], rowSpacing=[(1, 10), (2, 10)])
cmds.text( label='Custom Attribute', align='left' )
fieldTextEntered = cmds.textField(width=150)
cmds.button("add attribute", command=AddCustomAttribute)
cmds.setParent( '..' )

cmds.frameLayout( label='Connections' )
cmds.rowColumnLayout(numberOfColumns=3, columnSpacing=[(1, 10), (2, 58)], rowSpacing=[(1, 10), (2, 10)])
attrLabelName = cmds.text( label='Select an attribute', align='left' )
cmds.text( label='Optional: Utility Node', align='left' )
cmds.setParent('..')

cmds.rowColumnLayout(numberOfColumns=4, columnSpacing=[(1, 10),(2, 75), (3, 20),(4, 20)], rowSpacing=[(1, 10)])
cmds.button("Get Attribute", command=PressedGetAttribute)
cmds.checkBox("new")
cmds.checkBox("reuse")
cmds.setParent('..')

cmds.rowColumnLayout(numberOfColumns=1, columnSpacing=[(1, 10)], rowSpacing=[(1, 10)])
cmds.text( label='Pick an axis:', align='left' )
cmds.rowColumnLayout(numberOfColumns=3, columnSpacing=[(1, 0), (2, 10), (3, 10)], rowSpacing=[(1, 10)])
xAxis = cmds.checkBox("x")
yAxis = cmds.checkBox("y")
zAxis = cmds.checkBox("z")
cmds.setParent('..')

cmds.rowColumnLayout(numberOfColumns=1, columnSpacing=[(1, 0)], rowSpacing=[(1, 10)])
cmds.text( label='Pick transform to connect:', align='left' )
cmds.rowColumnLayout(numberOfColumns=3, columnSpacing=[(1, 0),(2, 20), (3, 20)], rowSpacing=[(1, 10)])
cmds.checkBox("translate")
cmds.checkBox("rotate")
cmds.button("connect", command=PressedConnect)
cmds.setParent('..')

cmds.frameLayout( label='Production Tools' )
cmds.columnLayout()
cmds.setParent( '..' )



cmds.rowColumnLayout(numberOfColumns=2, columnSpacing=[(1, 10), (2, 10)], rowSpacing=[(1, 10)])
cmds.button("dotRing")
cmds.button("dotLoop")
cmds.button("MakeLOD")
cmds.intField(width=30)
cmds.button("SelectLOD")
cmds.intField(width=30)

cmds.showWindow()