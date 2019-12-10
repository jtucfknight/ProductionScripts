include "scripts\\helperTools.ms"
	rollout ro_1 "Tools" (
		group "Root" (
			button btn_root "root" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Creates root bone helper and adds skin modifer to single object or for each object in a group of selected objects.  Roots are green."
			radiobuttons rad_root labels:#("1 per object", "1 for all") columns:1
		)
		group "Socket" (
			button btn_socket "sockets" width:70 height:30 align:#left across: 2 offset:[0,0] tooltip:"Creates sockets for selected objects. Sockets are red."
			radiobuttons rad_socket labels:#("1 per object", "1 for all") columns:1
		)
		group "Helper" (
			button btn_sizeUp "+" width:30 height:30 align:#left across: 3 offset:[0,0] tooltip:"Select helper and size it up."
			button btn_sizeDown "-" width:30 height:30 align:#left offset:[-10,0] tooltip:"Select helper and size it down."
			button btn_selWire "selByWire" width:70 height:30 align:#left offset:[-15,0] tooltip:"Select helper with same color wires."
		)
		
		on btn_root pressed do (
			local getState = rad_root.state
			
			if getState == 1 then (
				createRoot()
			)
			if getState == 2 then(
				multiRoot()
			)
		)
		
		on btn_socket pressed do (
			local getState = rad_socket.state
			
			if getState == 1 then (
				createSocket()
			)
			if getState == 2 then (
				multiSocket()
				)
			)
			
		on btn_sizeUp pressed do (
			sizeUp()
		)
		
		on btn_sizeDown pressed do (
			sizeDown()
		)
		
		on btn_selWire pressed do (
			selByWire()
		)
	)--end ro_1	
	
rof = newrolloutfloater "Helper Tools" 200 220
addrollout ro_1 rof