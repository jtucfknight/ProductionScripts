print "The file name is: " + getThisScriptFilename() 

test = getThisScriptFilename() 
print "Test is: " + test

newPath = pathConfig.removePathLeaf test
print "The new path is:  " + newPath

print newPath + "\\scripts\\colorPresets.ms"