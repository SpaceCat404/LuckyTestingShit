/datum/disease/advance/sns
	name = "Sudden Nyanification Syndrome (SNS)"
	max_stages = 4
	spread_text = "Airborne, Skin & Fluid Contact"
	spread_flags = DISEASE_SPREAD_AIRBORNE | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_BLOOD
	cure_text = "Moonsugar"
	cures = list(/datum/reagent/moonsugar)
	cure_chance = 7
	agent = "Genomophage UWU-13"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/alien)
	infectivity = 72
	permeability_mod = 0.8
	desc = "If left untreated the subject will develop feline attributes and a strong urge to consume milk. Felinids are asymptomatic carriers"
	severity = DISEASE_SEVERITY_BIOHAZARD

/datum/disease/advance/sns/stage_act()
    ..()
    switch(stage)
        if(1)
            if(affected_mob.dna.species == SPECIES_FELINID)
                to_chat(affected_mob, "<span class='warning'>" + "(DEBUG: SNS FELINE IMMUNITY)." + "</span>")
                carrier = TRUE
            else
                to_chat(affected_mob, "<span class='warning'>" + "(DEBUG: Stage 1 SNS - Initial)." + "</span>")
                to_chat(affected_mob, "<span class='warning'>" + pick("You feel extra silly today.",
                                                                     "You can't stop thinking about milk.",
                                                                     "You'd like to take a long nap.",
                                                                     "Mmmmm, fish.") + "</span>")

        if(2)
            to_chat(affected_mob, "<span class='warning'>" + "(DEBUG: Stage 2 SNS)." + "</span>")
            to_chat(affected_mob, "<span class='warning'>" + pick("Your ears feel oddly sensitive.",
                                                                 "You have an overwhelming urge to chase a laser pointer..",
                                                                 "You'd like to take a long nap in a sunny window.",
                                                                 "Hmm, maybe you deserve more.") + "</span>")

        if(3)
            to_chat(affected_mob, "<span class='warning'>" + "(DEBUG: Stage 3 SNS - Hairball)." + "</span>")
            affected_mob.stun(3)
            playsound(get_turf(affected_mob), 'sound/effects/splat.ogg', 20, TRUE)
            affected_mob.emote("cough")
            new /obj/item/toy/plush/hairball(affected_mob.loc)
            to_chat(affected_mob, "<span class='warning'>" + pick("You hack up a hairball! Gross.",
                                                                 "You cough up a hairball! Icky.",
                                                                 "You spit up a hairball! Eugh.") + "</span>")

        if(4)
            to_chat(affected_mob, "<span class='warning'>" + "(DEBUG: Stage 4 SNS - End)." + "</span>")
            del affected_mob.getorgan(/obj/item/organ/ears)
            var/obj/item/organ/ears/cat/newears = new
            newears.Insert(affected_mob)
            del affected_mob.getorgan(/obj/item/organ/tail)
            var/obj/item/organ/tail/cat/newtail = new
            newtail.Insert(affected_mob)
            del affected_mob.getorgan(/obj/item/organ/tongue)
            var/obj/item/organ/tongue/fluffy/newtongue = new
            newtongue.Insert(affected_mob)
            affected_mob.emote("mrrp")
            to_chat(affected_mob, "<span class='warning'>" + pick("You feel purrrfect.",
                                                                 "You've become a god.",
                                                                 "You're the most important person on this station.",
                                                                 "You should annoy CC.") + "</span>")

/obj/item/reagent_containers/glass/bottle/sns
	name = "SNS culture bottle"
	desc = "A small bottle. Contains Genomophage UWU-13 culture in synthblood medium."
	spawned_disease = /datum/disease/advance/sns
