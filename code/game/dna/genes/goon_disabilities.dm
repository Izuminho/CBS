//////////////////
// DISABILITIES //
//////////////////

////////////////////////////////////////
// Totally Crippling
////////////////////////////////////////

// WAS: /datum/bioEffect/mute
/datum/dna/gene/disability/mute
	name = "Mudo"
	desc = "Desligue completamente o centro de fala do c�rebro do sujeito."
	activation_message   = "Voc� se sente incapaz de se expressar."
	deactivation_message = "Voc� se sente capaz de falar livremente novamente."
	instability = -GENE_INSTABILITY_MODERATE
	disability = MUTE

/datum/dna/gene/disability/mute/New()
	..()
	block=MUTEBLOCK

/datum/dna/gene/disability/mute/OnSay(var/mob/M, var/message)
	return ""

////////////////////////////////////////
// Harmful to others as well as self
////////////////////////////////////////

/datum/dna/gene/disability/radioactive
	name = "Radioativo"
	desc = "O sujeito sofre de doen�a de radia��o constante e causa o mesmo em org�nicos pr�ximos."
	activation_message = "Voc� sente uma doen�a estranha permear todo o seu corpo."
	deactivation_message = "Voc� j� n�o se sente horrivelmente e doente por toda parte."
	instability = -GENE_INSTABILITY_MAJOR
	mutation = RADIOACTIVE

/datum/dna/gene/disability/radioactive/New()
	..()
	block=RADBLOCK


/datum/dna/gene/disability/radioactive/can_activate(var/mob/M,var/flags)
	if(!..())
		return 0
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if((RADIMMUNE in H.species.species_traits) && !(flags & MUTCHK_FORCED))
			return 0
	return 1

/datum/dna/gene/disability/radioactive/OnMobLife(var/mob/living/owner)
	var/radiation_amount = abs(min(owner.radiation - 20,0))
	owner.apply_effect(radiation_amount, IRRADIATE)
	for(var/mob/living/L in range(1, owner))
		if(L == owner)
			continue
		to_chat(L, "<span class='danger'>Voc� est� envolvido por um brilho verde suave que emana de [owner].</span>")
		L.apply_effect(5, IRRADIATE)
	return

/datum/dna/gene/disability/radioactive/OnDrawUnderlays(var/mob/M,var/g,var/fat)
	return "rads[fat]_s"

////////////////////////////////////////
// Other disabilities
////////////////////////////////////////

// WAS: /datum/bioEffect/fat
/datum/dna/gene/disability/fat
	name = "Obesidade"
	desc = "Realmente retarda o metabolismo do sujeito, permitindo maior ac�mulo de tecido lip�dico."
	activation_message = "Voc� sente blubbery e let�rgico!"
	deactivation_message = "Voc� se sente bem!"
	instability = -GENE_INSTABILITY_MINOR
	mutation = OBESITY

/datum/dna/gene/disability/fat/New()
	..()
	block=FATBLOCK

// WAS: /datum/bioEffect/chav
/datum/dna/gene/disability/speech/chav
	name = "Chav"
	desc = "For�a o centro de linguagem do c�rebro do sujeito a construir frases de maneira mais rudimentar."
	activation_message = "Voc� se sente como um homem da caverna?"
	deactivation_message = "Voc� n�o sente vontade de ser grosseiro e resmung�o."
	mutation = CHAV

/datum/dna/gene/disability/speech/chav/New()
	..()
	block=CHAVBLOCK

/datum/dna/gene/disability/speech/chav/OnSay(var/mob/M, var/message)
	// THIS ENTIRE THING BEGS FOR REGEX
	message = replacetext(message,"dick","prat")
	message = replacetext(message,"comdom","knob'ead")
	message = replacetext(message,"looking at","gawpin' at")
	message = replacetext(message,"great","bangin'")
	message = replacetext(message,"man","mate")
	message = replacetext(message,"friend",pick("mate","bruv","bledrin"))
	message = replacetext(message,"what","wot")
	message = replacetext(message,"drink","wet")
	message = replacetext(message,"get","giz")
	message = replacetext(message,"what","wot")
	message = replacetext(message,"no thanks","wuddent fukken do one")
	message = replacetext(message,"i don't know","wot mate")
	message = replacetext(message,"no","naw")
	message = replacetext(message,"robust","chin")
	message = replacetext(message," hi ","how what how")
	message = replacetext(message,"hello","sup bruv")
	message = replacetext(message,"kill","bang")
	message = replacetext(message,"murder","bang")
	message = replacetext(message,"windows","windies")
	message = replacetext(message,"window","windy")
	message = replacetext(message,"break","do")
	message = replacetext(message,"your","yer")
	message = replacetext(message,"security","coppers")
	return message

// WAS: /datum/bioEffect/swedish
/datum/dna/gene/disability/speech/swedish
	name = "sueco"
	desc = "For�a o centro de linguagem do c�rebro do sujeito a construir frases de forma vagamente n�rdica."
	activation_message = "Voc� se sente sueco, no entanto, isso funciona."
	deactivation_message = "A sensa��o de sueca passou."
	mutation = SWEDISH

/datum/dna/gene/disability/speech/swedish/New()
	..()
	block=SWEDEBLOCK

/datum/dna/gene/disability/speech/swedish/OnSay(var/mob/M, var/message)
	// svedish
	message = replacetextEx(message,"W","V")
	message = replacetextEx(message,"w","v")
	message = replacetextEx(message,"J","Y")
	message = replacetextEx(message,"j","y")
	message = replacetextEx(message,"A",pick("Å","Ä","Æ","A"))
	message = replacetextEx(message,"a",pick("å","ä","æ","a"))
	message = replacetextEx(message,"BO","BJO")
	message = replacetextEx(message,"Bo","Bjo")
	message = replacetextEx(message,"bo","bjo")
	message = replacetextEx(message,"O",pick("Ö","Ø","O"))
	message = replacetextEx(message,"o",pick("ö","ø","o"))
	if(prob(30))
		message += " Bork[pick("",", bork",", bork, bork")]!"
	return message

// WAS: /datum/bioEffect/unintelligable
/datum/dna/gene/disability/unintelligable
	name = "Retardado"
	desc = "Corrige fortemente a parte do c�rebro respons�vel pela forma��o de frases faladas."
	activation_message = "Voc� n�o consegue formar pensamentos coerentes!"
	deactivation_message = "Sua mente est� mais clara."
	instability = -GENE_INSTABILITY_MINOR
	mutation = SCRAMBLED

/datum/dna/gene/disability/unintelligable/New()
	..()
	block=SCRAMBLEBLOCK

/datum/dna/gene/disability/unintelligable/OnSay(var/mob/M, var/message)
	var/prefix=copytext(message,1,2)
	if(prefix == ";")
		message = copytext(message,2)
	else if(prefix in list(":","#"))
		prefix += copytext(message,2,3)
		message = copytext(message,3)
	else
		prefix=""

	var/list/words = splittext(message," ")
	var/list/rearranged = list()
	for(var/i=1;i<=words.len;i++)
		var/cword = pick(words)
		words.Remove(cword)
		var/suffix = copytext(cword,length(cword)-1,length(cword))
		while(length(cword)>0 && suffix in list(".",",",";","!",":","?"))
			cword  = copytext(cword,1              ,length(cword)-1)
			suffix = copytext(cword,length(cword)-1,length(cword)  )
		if(length(cword))
			rearranged += cword
	return "[prefix][uppertext(jointext(rearranged," "))]!!"

// WAS: /datum/bioEffect/toxic_farts
/datum/dna/gene/disability/toxic_farts
	name = "Peidos Toxico"
	desc = "Causa a digest�o do sujeito para criar uma quantidade significativa de g�s nocivo."
	activation_message = "Seu est�mago resmunga desagradavelmente."
	deactivation_message = "Seu est�mago deixa de agir. Phew!"
	mutation = TOXIC_FARTS

/datum/dna/gene/disability/toxic_farts/New()
	..()
	block=TOXICFARTBLOCK

//////////////////
// USELESS SHIT //
//////////////////

// WAS: /datum/bioEffect/strong
/datum/dna/gene/disability/strong
	// pretty sure this doesn't do jack shit, putting it here until it does
	name = "Forte"
	desc = "Melhora a capacidade do sujeito de construir e reter m�sculos pesados."
	activation_message = "Voc� se sente melhorado!"
	deactivation_message = "Voc� se sente mal e fraco."
	mutation = STRONG

/datum/dna/gene/disability/strong/New()
	..()
	block=STRONGBLOCK

// WAS: /datum/bioEffect/horns
/datum/dna/gene/disability/horns
	name = "Chifres"
	desc = "Permite o crescimento de uma forma��o de queratina compactada na cabe�a do sujeito."
	activation_message = "Um par de chifres surge em sua cabe�a."
	deactivation_message = "Seus chifres se cairam derrepente."
	mutation = HORNS

/datum/dna/gene/disability/horns/New()
	..()
	block=HORNSBLOCK

/datum/dna/gene/disability/horns/OnDrawUnderlays(var/mob/M,var/g,var/fat)
	return "horns_s"

////////////////////////////////////////////////////////////////////////
// WAS: /datum/bioEffect/immolate
/datum/dna/gene/basic/grant_spell/immolate
	name = "Mitochondria Incendi�ria"
	desc = "O sujeito torna-se capaz de converter o excesso de energia celular em energia t�rmica."
	activation_messages = list("De repente voc� se sente bastante quente.")
	deactivation_messages = list("Voc� n�o se sente desconfortavelmente quente.")
	mutation = IMMOLATE

	spelltype=/obj/effect/proc_holder/spell/targeted/immolate

/datum/dna/gene/basic/grant_spell/immolate/New()
	..()
	block = IMMOLATEBLOCK

/obj/effect/proc_holder/spell/targeted/immolate
	name = "Mitochondria Incendi�ria"
	desc = "O sujeito torna-se capaz de converter o excesso de energia celular em energia t�rmica."
	panel = "Abilities"

	charge_type = "recharge"
	charge_max = 600

	clothes_req = 0
	stat_allowed = 0
	invocation_type = "none"
	range = -1
	selection_type = "range"
	var/list/compatible_mobs = list(/mob/living/carbon/human)
	include_user = 1

	action_icon_state = "genetic_incendiary"

/obj/effect/proc_holder/spell/targeted/immolate/cast(list/targets, mob/living/user = usr)
	var/mob/living/carbon/L = user
	L.adjust_fire_stacks(0.5)
	L.visible_message("<span class='danger'>[L.name]</b> subitamente entrou em combust�o!</span>")
	L.IgniteMob()
	playsound(L.loc, 'sound/effects/bamf.ogg', 50, 0)
