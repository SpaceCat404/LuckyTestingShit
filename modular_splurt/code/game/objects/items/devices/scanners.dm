obj/item/memoryscanner
	name = "handheld memory scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "memoryscanner"
	item_state = "inducer-sci"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	desc = "A hand-held mind scanner able to penetrate the surface mind of a target."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=400, /datum/material/plasma=180)

/obj/item/memoryscanner/Initialize(mapload)
	. = ..()
	register_item_context()

/obj/item/memoryscanner/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to wipe [user.p_their()] mind with the [src]!</span>")
	return OXYLOSS

/obj/item/memoryscanner/attack(mob/living/M, mob/living/carbon/human/user)
	if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		memory_scan(user, user)
		to_chat(user, "<span class='warning'>Uh... how does this dohickey work?!</span>")
		user.visible_message("<span class='danger'>[user] clumsily zaps his head with the [src]!</span>")
		user.adjustOrganLoss(ORGAN_SLOT_BRAIN, 30)
	else
		user.visible_message("<span class='danger'>[user] is trying to scan [M]'s mind with the [src]!</span>")
		if(do_mob(user, M, 15))
			user.visible_message("<span class='danger'>[user] scans [M]'s mind with the [src]!</span>")
			memory_scan(user, M)

proc/memory_scan(mob/user, mob/living/T)
	var/msg = "<span class='info'>Analyzing results for [T]'s memory.</span>"
	if(!isliving(T) || !T.client)
		msg += "\n<span class='alert'>[T]'s mind is non-compliant! Scan failed.</span>"
		return
	else if (T.mind.unconvertable)
		msg += "\n<span class='alert'>[T]'s mind is too well reinforced! Scan failed.</span>"
		return
	else
		msg += "\n<span class='info'>Memory scan complete. \n [T.mind] </span>"
		return
