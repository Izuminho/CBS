/////////////////////
// DISABILITY GENES
//
// These activate either a mutation, disability
//
// Gene is always activated.
/////////////////////

/datum/dna/gene/disability
	name="DISABILITY"

	// Mutation to give (or 0)
	var/mutation=0

	// Disability to give (or 0)
	var/disability=0

	// Activation message
	var/activation_message=""

	// Yay, you're no longer growing 3 arms
	var/deactivation_message=""

/datum/dna/gene/disability/can_activate(var/mob/M,var/flags)
	return 1 // Always set!

/datum/dna/gene/disability/activate(var/mob/living/M, var/connected, var/flags)
	..()
	if(mutation && !(mutation in M.mutations))
		M.mutations.Add(mutation)
	if(disability)
		M.disabilities|=disability
	if(activation_message)
		to_chat(M, "<span class='warning'>[activation_message]</span>")
	else
		testing("[name] n�o teve menssagem de ativa��o.")

/datum/dna/gene/disability/deactivate(var/mob/living/M, var/connected, var/flags)
	..()
	if(mutation && (mutation in M.mutations))
		M.mutations.Remove(mutation)
	if(disability)
		M.disabilities &= ~disability
	if(deactivation_message)
		to_chat(M, "<span class='warning'>[deactivation_message]</span>")
	else
		testing("[name] n�o teve menssagem de ativa��o.")

/datum/dna/gene/disability/hallucinate
	name="Alucinando"
	activation_message="Your mind says 'Hello'."
	deactivation_message ="Sanity returns. Or does it?"
	instability = -GENE_INSTABILITY_MODERATE
	mutation=HALLUCINATE

/datum/dna/gene/disability/hallucinate/New()
	block=HALLUCINATIONBLOCK

/datum/dna/gene/disability/epilepsy
	name="Epilepsia"
	activation_message="Voc� est� com dores de cabe�a."
	deactivation_message ="Sua dor de cabe�a se foi."
	instability = -GENE_INSTABILITY_MODERATE
	disability=EPILEPSY

/datum/dna/gene/disability/epilepsy/New()
	block=EPILEPSYBLOCK

/datum/dna/gene/disability/cough
	name="Tossindo"
	activation_message="Voc� come�ou a tossir."
	deactivation_message ="As tosses pararam."
	instability = -GENE_INSTABILITY_MINOR
	disability=COUGHING

/datum/dna/gene/disability/cough/New()
	block=COUGHBLOCK

/datum/dna/gene/disability/clumsy
	name="Desastrado"
	activation_message="Voc� se sente tonto."
	deactivation_message ="Voc� recupera algum controle de seus movimentos"
	instability = -GENE_INSTABILITY_MINOR
	mutation=CLUMSY

/datum/dna/gene/disability/clumsy/New()
	block=CLUMSYBLOCK

/datum/dna/gene/disability/tourettes
	name="Tourettes"
	activation_message="Voc� est� se contorcendo"
	deactivation_message ="Sua boca est� com gosto de sab�o."
	instability = -GENE_INSTABILITY_MODERATE
	disability=TOURETTES

/datum/dna/gene/disability/tourettes/New()
	block=TWITCHBLOCK

/datum/dna/gene/disability/nervousness
	name="Nervoso"
	activation_message="Voc� est� nervoso."
	deactivation_message ="Voc� se sente mais calmo."
	disability=NERVOUS

/datum/dna/gene/disability/nervousness/New()
	block=NERVOUSBLOCK

/datum/dna/gene/disability/blindness
	name="Cego"
	activation_message="Voc� n�o consegue enxergar nada."
	deactivation_message ="Voc� pode ver agora, no caso de voc� n�o ter notado..."
	instability = -GENE_INSTABILITY_MAJOR
	disability=BLIND

/datum/dna/gene/disability/blindness/New()
	block=BLINDBLOCK

/datum/dna/gene/disability/colourblindness
	name = "Daltonismo"
	activation_message = "Voc� sente um formigamento peculiar em seus olhos enquanto sua percep��o de mudan�as de cor."
	deactivation_message ="Seus olhos formigam de forma perturbadora, embora tudo pare�a tornar-se muito mais colorido."
	instability = -GENE_INSTABILITY_MODERATE
	disability = COLOURBLIND

/datum/dna/gene/disability/colourblindness/New()
	block=COLOURBLINDBLOCK

/datum/dna/gene/disability/colourblindness/activate(var/mob/M, var/connected, var/flags)
	..()
	M.update_client_colour() //Handle the activation of the colourblindness on the mob.

/datum/dna/gene/disability/colourblindness/deactivate(var/mob/M, var/connected, var/flags)
	..()
	M.update_client_colour() //Handle the deactivation of the colourblindness on the mob.

/datum/dna/gene/disability/deaf
	name="Surdez"
	activation_message="Est� muito sinlecioso."
	deactivation_message ="Voc� consegue escutar novamente!"
	instability = -GENE_INSTABILITY_MAJOR
	disability=DEAF

/datum/dna/gene/disability/deaf/New()
	block=DEAFBLOCK

/datum/dna/gene/disability/deaf/activate(var/mob/M, var/connected, var/flags)
	..()
	M.EarDeaf(1)

/datum/dna/gene/disability/nearsighted
	name="Miopia"
	activation_message="Seus olhos ets�o malucos..."
	deactivation_message ="Voc� consegue ver claramente novemante"
	instability = -GENE_INSTABILITY_MODERATE
	disability=NEARSIGHTED

/datum/dna/gene/disability/nearsighted/New()
	block=GLASSESBLOCK

/datum/dna/gene/disability/lisp
	name = "Balbuciar"
	desc = "Pergunto-me com o que est� fazendo."
	activation_message = "Algo n�o est� certo."
	deactivation_message = "Voc� est� apto a falar as consoantes novamente."
	mutation = LISP

/datum/dna/gene/disability/lisp/New()
	..()
	block=LISPBLOCK

/datum/dna/gene/disability/lisp/OnSay(var/mob/M, var/message)
	return replacetext(message,"s","th")

/datum/dna/gene/disability/comic
	name = "Comico"
	desc = "Isso s� trar� morte e destrui��o."
	activation_message = "<span class='sans'>Uh oh!</span>"
	deactivation_message = "Ainda bem, gra�as a Deus que isso acabou."
	mutation=COMIC

/datum/dna/gene/disability/comic/New()
	block = COMICBLOCK
