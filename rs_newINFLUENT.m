function[INFLUENT,NEWINFLUENT] = rs_newINFLUENT(row,space)
    % Resul modeified to match gsi09 fractionation uncertainties.
    % Creates a new influent fractionation  according to Sin et al.,2008
    % Returns a new influet file given an uncertain influent vector.

    % STEP1: Get the defaults from BSM2 CONSINFLUENT and assign them.
    INFLUENT = rs_get_influent('bsm2');
    
        
    i_XB = 0.08; i_XP = 0.06; % kept constant
    CODin = INFLUENT.SI + INFLUENT.SS + INFLUENT.XI + INFLUENT.XS + INFLUENT.XBH +INFLUENT.XBA + INFLUENT.XP+INFLUENT.XBA2+INFLUENT.XANAOB; % keep constant
    TKN   = INFLUENT.SNH + INFLUENT.SND + INFLUENT.XND + i_XB*(INFLUENT.XBH+INFLUENT.XBA+INFLUENT.XBA2+INFLUENT.XANAOB) + i_XP*(INFLUENT.XI+INFLUENT.XP);
    TN    = TKN + INFLUENT.SNO3+INFLUENT.SNO2+INFLUENT.SNO+INFLUENT.SN2O+INFLUENT.SN2; % keep constant
    

    % STEP2: Set the uncertain vector.
       
    INFLUENT.XI     = row(find(contains(space.ParNames,'XI')));  
    INFLUENT.SI     = row(find(contains(space.ParNames,'SI')));  
    INFLUENT.SS     = row(find(contains(space.ParNames,'SS')));    
    INFLUENT.XBH    = row(find(contains(space.ParNames,'XBH'))); 
    
       
    INFLUENT.XS  = CODin - INFLUENT.SI - INFLUENT.SS - INFLUENT.XI - INFLUENT.XBH - INFLUENT.XBA - INFLUENT.XP-INFLUENT.XBA2-INFLUENT.XANAOB; % Bimoass are typicaly zero except synthetic
    if(INFLUENT.XS<0)
        INFLUENT.XS=0.01;
    end
    
    
    INFLUENT.TSS = 0.75*(INFLUENT.XS+INFLUENT.XI + INFLUENT.XBH + INFLUENT.XBA + INFLUENT.XP+INFLUENT.XBA2+INFLUENT.XANAOB);
      
    
    INFLUENT.XND=TN-(INFLUENT.SNH + INFLUENT.SND + i_XB*(INFLUENT.XBH+INFLUENT.XBA+INFLUENT.XBA2+INFLUENT.XANAOB) + i_XP*(INFLUENT.XI+INFLUENT.XP));
    if(INFLUENT.XND<0)
        INFLUENT.XND=0.01;
    end
    
    % STEP3: Rewrite the influent.
    NEWINFLUENT          = zeros(2,24);
    NEWINFLUENT(2,1)     = 1000; % days
    
    NEWINFLUENT(1,2:end)=[INFLUENT.SI INFLUENT.SS  INFLUENT.XI  INFLUENT.XS  INFLUENT.XBH INFLUENT.XBA  INFLUENT.XP INFLUENT.SO INFLUENT.SNO3 INFLUENT.SNH INFLUENT.SND INFLUENT.XND INFLUENT.SALK INFLUENT.TSS INFLUENT.Q INFLUENT.T INFLUENT.SNO2 INFLUENT.SNO INFLUENT.SN2O INFLUENT.SN2 INFLUENT.XBA2 INFLUENT.XANAOB INFLUENT.XC];  
    NEWINFLUENT(2,2:end)=[INFLUENT.SI INFLUENT.SS  INFLUENT.XI  INFLUENT.XS  INFLUENT.XBH INFLUENT.XBA  INFLUENT.XP INFLUENT.SO INFLUENT.SNO3 INFLUENT.SNH INFLUENT.SND INFLUENT.XND INFLUENT.SALK INFLUENT.TSS INFLUENT.Q INFLUENT.T INFLUENT.SNO2 INFLUENT.SNO INFLUENT.SN2O INFLUENT.SN2 INFLUENT.XBA2 INFLUENT.XANAOB INFLUENT.XC];  
end