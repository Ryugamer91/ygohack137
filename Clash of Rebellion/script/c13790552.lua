--The Fang of Critias
function c13790552.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,13790552+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c13790552.target)
	e1:SetOperation(c13790552.activate)
	c:RegisterEffect(e1)
end
c13790552.list={[44095762]=13790561,[13790568]=13790566,[57728570]=13790565}
function c13790552.filter(c,e,tp)
    local code=c:GetCode()
	local tcode=c13790552.list[code]
	return tcode and Duel.IsExistingMatchingCard(c13790552.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,tcode)
end
function c13790552.spfilter(c,e,tp,tcode)
    return c:IsCode(tcode) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c13790552.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c13790552.filter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c13790552.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c13790552.filter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then 
	    local tc=g:GetFirst()
        local tcode=c13790552.list[tc:GetCode()]
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc1=Duel.SelectMatchingCard(tp,c13790552.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tcode)
		local sc=tc1:GetFirst()
		if sc then 
		    sc:SetMaterial(g)
			if tc:IsLocation(LOCATION_SZONE) and tc:IsFacedown() then Duel.ConfirmCards(1-tp,g) end
			Duel.SendtoGrave(tc,REASON_EFFECT)
			Duel.BreakEffect()
			Duel.SpecialSummon(sc,0,tp,tp,true,true,POS_FACEUP)
			sc:CompleteProcedure()
		end		
	end
end
