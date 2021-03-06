/obj/item/projectile/beam
	name = "laser"
	icon_state = "laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 20
	damage_type = BURN
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	flag = "laser"
	eyeblur = 2
	is_reflectable = TRUE

/obj/item/projectile/beam/holy_bullet
	icon = 'icons/obj/projectiles.dmi'   //Sprites by Demetreo
	name = "holy bullet"
	icon_state = "holy_bullet"
	damage = 25
	damage_type = BRUTE

/obj/item/projectile/beam/holy_bullet/New()
	..()
	create_reagents(100)
	reagents.set_reacting(FALSE)
	reagents.add_reagent("holywater", 100)

/obj/item/projectile/beam/holy_bullet/on_hit(var/atom/target, var/blocked = 0, var/hit_zone)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100)
			if(M.can_inject(null,0,hit_zone)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.trans_to(M, reagents.total_volume)
				return 1
			else
				blocked = 100
	..(target, blocked, hit_zone)
	reagents.set_reacting(TRUE)
	reagents.handle_reactions()
	return 1

/obj/item/projectile/beam/laser

/obj/item/projectile/beam/laser/heavylaser
	name = "heavy laser"
	icon_state = "heavylaser"
	damage = 40

/obj/item/projectile/beam/practice
	name = "practice laser"
	damage = 0
	nodamage = 1
	log_override = TRUE

/obj/item/projectile/beam/scatter
	name = "laser pellet"
	icon_state = "scatterlaser"
	damage = 5

/obj/item/projectile/beam/xray
	name = "xray beam"
	icon_state = "xray"
	damage = 15
	irradiate = 30
	forcedodge = 1
	range = 15

/obj/item/projectile/beam/disabler
	name = "disabler beam"
	icon_state = "omnilaser"
	damage = 36
	damage_type = STAMINA
	flag = "energy"
	hitsound = 'sound/weapons/tap.ogg'
	eyeblur = 0

/obj/item/projectile/beam/pulse
	name = "pulse"
	icon_state = "u_laser"
	damage = 50

/obj/item/projectile/beam/pulse/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target,/turf/)||istype(target,/obj/structure/))
		target.ex_act(2)
	..()

/obj/item/projectile/beam/pulse/shot
	damage = 40

/obj/item/projectile/beam/emitter
	name = "emitter beam"
	icon_state = "emitter"
	damage = 30
	legacy = 1
	animate_movement = SLIDE_STEPS

/obj/item/projectile/beam/emitter/singularity_pull()
	return //don't want the emitters to miss

/obj/item/projectile/beam/lasertag
	name = "laser tag beam"
	icon_state = "omnilaser"
	hitsound = null
	damage = 0
	damage_type = STAMINA
	flag = "laser"
	var/suit_types = list(/obj/item/clothing/suit/redtag, /obj/item/clothing/suit/bluetag)
	log_override = TRUE

/obj/item/projectile/beam/lasertag/on_hit(atom/target, blocked = 0)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/M = target
		if(istype(M.wear_suit))
			if(M.wear_suit.type in suit_types)
				M.adjustStaminaLoss(34)
	return 1

/obj/item/projectile/beam/lasertag/omni
	name = "laser tag beam"
	icon_state = "omnilaser"

/obj/item/projectile/beam/lasertag/redtag
	icon_state = "laser"
	suit_types = list(/obj/item/clothing/suit/bluetag)

/obj/item/projectile/beam/lasertag/bluetag
	icon_state = "bluelaser"
	suit_types = list(/obj/item/clothing/suit/redtag)

/obj/item/projectile/beam/sniper
	name = "sniper beam"
	icon_state = "sniperlaser"
	damage = 60
	stun = 5
	weaken = 5
	stutter = 5

/obj/item/projectile/beam/immolator
	name = "immolation beam"

/obj/item/projectile/beam/immolator/on_hit(var/atom/target, var/blocked = 0)
	. = ..()
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(1)
		M.IgniteMob()

/obj/item/projectile/beam/instakill
	name = "instagib laser"
	icon_state = "purple_laser"
	damage = 200
	damage_type = BURN

/obj/item/projectile/beam/instakill/blue
	icon_state = "blue_laser"

/obj/item/projectile/beam/instakill/red
	icon_state = "red_laser"

/obj/item/projectile/beam/instakill/on_hit(atom/target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.visible_message("<span class='danger'>[L] explodes!</span>")
		L.gib()