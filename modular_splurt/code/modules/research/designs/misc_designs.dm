/datum/design/light_replacer_blue/New()
	departmental_flags |= DEPARTMENTAL_FLAG_SCIENCE
	. = ..()

/datum/design/bluespacespray/New()
	departmental_flags |= DEPARTMENTAL_FLAG_SERVICE
	. = ..()

/datum/design/diskplantgene/New()
	departmental_flags |= DEPARTMENTAL_FLAG_SCIENCE
	. = ..()

/datum/design/plant_analyzer/New()
	departmental_flags |= DEPARTMENTAL_FLAG_SCIENCE
	. = ..()

// MODULAR SPLURT NEW DESIGNS
/datum/design/ultimatespray
	name = "Ultimate Spray"
	desc = "The ultimate sprayer, no mess shall go unclean today."
	id = "ultimatespray"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2250, /datum/material/glass = 2250, /datum/material/plasma = 2250, /datum/material/diamond = 370, /datum/material/bluespace = 370)
	build_path = /obj/item/reagent_containers/spray/ultimate
	reagents_list = list(/datum/reagent/liquid_dark_matter = 10)
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SERVICE

	/datum/design/msc
	name = "Memory Scanner"
	desc = "A hand-held mind scanner able to penetrate the surface mind of a target."
	id = "memory_scanner"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 20000, /datum/material/glass = 10000, /datum/material/plasma = 2000, /datum/material/gold = 2000)
	build_path = obj/item/memoryscanner
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
