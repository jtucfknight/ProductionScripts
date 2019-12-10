macroScript colorPresets
category:"Jose Tools"(
	include "scripts\\colorPresets.ms"
	rollout ro_1 "Color Presets"(
		group "Spline Tools"(
			button btn_green "green" width:45 height:30 align:#left across: 5 offset:[0,0] tooltip:"Green wireframe."
			button btn_red "red" width:45 height:30 align:#left offset:[0,0] tooltip:"Red wireframe."
			button btn_blue "blue" width:45 height:30 align:#left offset:[0,0] tooltip:"Blue wireframe."
			button btn_cyan "cyan" width:45 height:30 align:#left offset:[0,0] tooltip:"Cyan wireframe."
			button btn_black "black" width:45 height:30 align:#left offset:[0,0] tooltip:"Black wireframe."
		)
			
		on btn_green pressed do (
			makeGreen()
		)
			
		on btn_red pressed do (
			makeRed()
		)

		on btn_blue pressed do (
			makeBlue()
		)

		on btn_cyan pressed do (
			makeCyan()
		)
		
		on btn_black pressed do (
			makeBlack()
		)
	)
	rof = newrolloutfloater "Color Presets" 280 100
	addrollout ro_1 rof
)