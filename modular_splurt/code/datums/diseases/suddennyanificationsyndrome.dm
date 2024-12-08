/datum/disease/sns
    name = "Sudden Nyanification Syndrome (SNS)"
    max_stages = 4
    spread_text = "Airborne, Skin & Fluid Contact"
    spread_flags = DISEASE_SPREAD_AIRBORNE | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_BLOOD
    cure_text = "Moonsugar"
    cures = list(/datum/reagent/moonsugar)
    cure_chance = 7
    agent = "Genomophage UWU-13"
    viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey, /mob/living/carbon/alien)
    infectivity = 75
    permeability_mod = 0.8
    stage_prob = 2
    desc = "If left untreated the subject will develop feline attributes and a strong urge to consume milk. Felinids are asymptomatic carriers. Highly infectious."
    severity = DISEASE_SEVERITY_MEDIUM

/datum/disease/sns/stage_act()
    ..()

switch (stage)
    if(stage_progressed < stage)
        if(stage == 1)
            stage_progressed = 1  // Mark progression to the next stage
            if(affected_mob.dna.species == SPECIES_FELINID)
                to_chat(affected_mob, "<span class='warning'>(DEBUG: SNS FELINE IMMUNITY.)</span>")
                carrier = TRUE
            else
                to_chat(affected_mob, "<span class='warning'>(DEBUG: Stage 1 SNS - Initial.)</span>")
                to_chat(affected_mob, "<span class='warning'>" + pick(
                    "You feel extra silly today.",
                    "You can't stop thinking about milk.",
                    "You'd like to take a long nap.",
                    "Mmmmm, fish.") + "</span>")

        else if(stage == 2)
            stage_progressed = 2  // Mark progression to the next stage
            to_chat(affected_mob, "<span class='warning'>(DEBUG: Stage 2 SNS.)</span>")
            to_chat(affected_mob, "<span class='warning'>" + pick(
                "Your ears feel oddly sensitive.",
                "You have an overwhelming urge to chase a laser pointer.",
                "You'd like to take a long nap in a sunny window.",
                "Hmm, maybe you deserve more.") + "</span>")

        else if(stage == 3)
            stage_progressed = 3  // Mark progression to the next stage
            to_chat(affected_mob, "<span class='warning'>(DEBUG: Stage 3 SNS - Hairball.)</span>")
            affected_mob.Stun(3)
            playsound(get_turf(affected_mob), 'sound/effects/splat.ogg', 20, TRUE)
            affected_mob.emote("cough")
            new /obj/item/toy/plush/hairball(affected_mob.loc)
            to_chat(affected_mob, "<span class='warning'>" + pick(
                "You hack up a hairball! Gross.",
                "You cough up a hairball! Icky.",
                "You spit up a hairball! Eugh.") + "</span>")

        else if(stage == 4)
            stage_progressed = 4  // Mark progression to the next stage
            to_chat(affected_mob, "<span class='warning'>(DEBUG: Stage 4 SNS - End.)</span>")
            var/mob/living/carbon/human/L = affected_mob
            if(!L.getorgan(/obj/item/organ/ears/cat) && L.stat) // target doesn't have cat ears
                if (L.getorgan(/obj/item/organ/ears)) // slice off the old ears
                    var/obj/item/organ/ears/ears = L.getorgan(/obj/item/organ/ears)
                    ears.Remove(L)
                else // implant new ears
                    var/obj/item/organ/ears/cat/newears = new /obj/item/organ/ears/cat
                    newears.Insert(L)
            else if(!L.getorgan(/obj/item/organ/tail/cat) && L.stat)
                if(L.getorgan(/obj/item/organ/tail)) // cut off the tail if they have one already
                    var/obj/item/organ/tail/tail = L.getorgan(/obj/item/organ/tail)
                    tail.Remove(L)
                else // put a cat tail on
                    var/obj/item/organ/tail/cat/newtail = new /obj/item/organ/tail/cat
                    newtail.Insert(L)
            else if(!L.getorgan(/obj/item/organ/tongue/fluffy) && L.stat)
                if(L.getorgan(/obj/item/organ/tongue)) // cut off the tongue if they have one already
                    var/obj/item/organ/tongue/tongue = L.getorgan(/obj/item/organ/tongue)
                    tongue.Remove(L)
                else // put a cat tongue on
                    var/obj/item/organ/tongue/fluffy/newtongue = new /obj/item/organ/tongue/fluffy
                    newtongue.Insert(L)

            affected_mob.emote("mrrp")
            to_chat(affected_mob, "<span class='warning'>" + pick(
                "You feel purrrfect.",
                "You've become a god.",
                "You're the most important person on this station.",
                "You should annoy CC.") + "</span>")

    return

/obj/item/reagent_containers/glass/bottle/sns
    name = "SNS culture bottle"
    desc = "A small bottle. Contains genomophage UWU-13 culture in synthblood medium."
    spawned_disease = /datum/disease/sns
