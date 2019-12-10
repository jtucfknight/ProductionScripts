include "scripts\\splineTools.ms"
	rollout ro_1 "Spline Tools" (
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
			filePath
			enableInVP()
		)
		
		on btn_disableInVP pressed do (
			filePath
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
			filePath
			growThick()
		)
		
		on btn_shrinkThick pressed do (
			shrinkThick()
		)		
	)
	rof = newRolloutFloater "Spline Tools" 200 410
	addrollout ro_1 rof