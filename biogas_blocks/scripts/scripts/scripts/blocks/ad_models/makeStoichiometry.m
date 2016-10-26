%% makeStoichiometry
% Make the stoichiometric matrix for the ADM1.
%
function [A, p, G, rho]= ...
    makeStoichiometry(plant, x, sensors, substrate, ...Vliq, Vgas, T_deg, 
                      substrate_network, fermenter_id, t, varargin)
%% Release: 0.7

%%

error('this function is not used anymore, but never!!! delete it!')

%%

error( nargchk(7, 8, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% read out varargin

if nargin >= 8,
    substrate_flow= varargin{1};
else
    substrate_flow= [];
end



%%
% das ist normal für Simulationen
if isempty(substrate_flow)

    %%
    
    x_net= NET.convertArray(x, 'System.Double', numel(x));
    sub_net= NET.convertArray(substrate_network, 'System.Double', size(substrate_network));
    
    %%
  
    [A, p, G, rho]= biogas.ADMstate.makeStoichiometry(x_net, t, fermenter_id, plant, ...
                    substrate, sub_net, sensors);
    
    %%
    % TODO convert back to double
    
    A= double(A);
    p= double(p)';
    G= double(G);
    rho= double(rho)';
    
    %% evtl. noch transponieren TODO
    
    return;
    
%%    

%     params= obj_digester.AD_Model.getParams(t, sensors, substrate);

    substrate_network_digester= substrate_network(:, plant.getDigesterIndex(fermenter_id));
    
    params= plant.getDigesterByID(fermenter_id).getADMparams(t, ...
                  sensors, substrate, substrate_network_digester);

    params= double(params);
    
    %params= obj_digester.getADM1params(t);

else
  %% TODO
  % der Aufruf wird so nicht mehr funktionieren!!!
  % da plant und substrate vermutlich in workspace liegen dürften, sollte
  % ein call wie oben möglich sein.
  % substrate_flow is ein vektor mit substratfluss == Q
  %
  % s. ADM.cs
  % public double[] getParams(double[] Q, substrates mySubstrates)
  %
  
  error('p_adm1xp does not exist anymore');
    % das kommt aus nonlinear digester constraint    
    params= p_adm1xp(T_deg.Value, t, substrate_flow, fermenter_id);
    
    %[fCH_XC, fLI_XC, fPR_XC]= calcXCfractions(t);
            
%     params(3)= fCH_XC;
%     params(4)= fPR_XC;
%     params(5)= fLI_XC;
    
end




%%
%

try
  [Qgas_h2, Qgas_ch4, Qgas_co2, Qgas]= ...
            biogas.ADMstate.calcBiogasOfADMstate(x, Vliq, T_deg);
catch ME
  disp(ME.message);
  disp('makeStoichiometry:biogas.ADMstate.calcBiogasOfADMstate');
  rethrow(ME);
end

%%

T_K= T_deg.convertUnit('K');

RT= biogas.chemistry.R.Value * T_K.Value;
%RT= RT.Value;

pext= biogas.chemistry.pAtm.Value - 0.0084147 * exp(0.054 * T_deg.Value);

kp= biogas.digester.kp.Value;
         
%%

Qgas_h2= Qgas_h2.Value;
Qgas_ch4= Qgas_ch4.Value;
Qgas_co2= Qgas_co2.Value;
Qgas= Qgas.Value;


%%
% T [K]
%
%T= T_deg + 273.15;
%%
% external pressure [bar]
%
%pext= 1.04;



%% TODO
% ??
% s. simba's initfox5gas.m
%
% Anmerkung: Formel aus dem ADM1 Report kommt dieser am nächsten, genaue
% Umrechnung aber noch nicht möglich:
%
% ph2o= 0.0313 * exp( 5290 * ( 1/298 - 1/T ) )
% ph2o= 0.0313 * exp( 5290/298 ) * exp( - 5290/T ) )
% ph2o= 0.0313 * exp( 5290/298 ) * 1 / exp( T/5290 ) )
%
%
%pext= pext - 0.0084147 * exp(0.054 * T_deg);



%%
% Proportionale Regelungskonstante für Gasausgleich [m^3/(m^3*d)]
%
%kp= 10000;
%%
% Norm cubic meter [mol/m^3]
%
%NQ= 44.6430; % aus ADM1

%global intvars;

% try
%     intvars= evalinMWS('intvars', 1);
% catch ME
%     rethrow(ME);
% end

% [Ssu, Saa, Sfa, Sva, Sbu, Spro, Sac, Sh2, Sch4, Sco2, ...
%           Snh4, SI, Xc, Xch, Xpr, Xli, Xsu, Xaa, Xfa, Xc4, ...
%           Xpro, Xac, Xh2, XI, Xp, Scat, San, Sva_, Sbu_, Spro_, ...
%           Sac_, Shco3, Snh3]= biogas.ADMstate.getADMstatevariables(x);

% monosaccarides [kg COD/m^3]
Ssu= x(1);
% amino acids [kg COD/m3]
Saa= x(2);
% total LCFA [kg COD/m3]
Sfa= x(3);
% valeric acid + valerate kg COD/m3 
Sva= x(4);
% butyric acid + butyrate kg COD/m3 
Sbu= x(5);
% propionic acid + propionate kg COD/m3 
Spro= x(6);
% acetic acid + acetate kg COD/m3 
Sac= x(7);
% hydrogen kg COD/m3 
Sh2= x(8);
% methane kg COD/m3 
Sch4= x(9);
% carbon dioxide k mol C/m3 
Sco2= x(10);
% Ammonium k mol N/m3 
Snh4= x(11);
% soluble inerts kg COD/m3 
SI= x(12);
% composite kg COD/m3 
Xc= x(13);
% carbohydrates kg COD/m3 
Xch= x(14);
% proteins kg COD/m3 
Xpr= x(15);
% lipids [kg COD/m^3]
Xli= x(16);
% Biomass Sugar degraders kg COD/m3 
Xsu= x(17);
% Biomass amino acids degraders kg COD/m3 
Xaa= x(18);
% Biomass LCFA degraders kg COD/m3 
Xfa= x(19);
% Biomass valerate, butyrate degraders kg COD/m3 
Xc4= x(20);
% Biomass propionate degraders kg COD/m3 
Xpro= x(21);
% Biomas acetate degraders kg COD/m3 
Xac= x(22);
% Biomass hydrogen degraders kg COD/m3 
Xh2= x(23);
% particulate inerts kg COD/m3 
XI= x(24);
% Particulate products arising from biomass decay kg COD/m^3 
Xp= x(25);
% cations k mol/m3 
Scat= x(26);
% Anions k mol/m3 
San= x(27);
% valerate kg COD/m3 
Sva_= x(28);
% Butyrate kg COD/m3 
Sbu_= x(29);
% propionate kg COD/m3 
Spro_= x(30);
% acetate kg COD/m3 
Sac_= x(31);
% bicarbonate k mol C/m3 
Shco3= x(32);
% Ammonia k mol N/m3 
Snh3= x(33);


%% 
% parameters

%params= p_adm1xp(T_deg, t);

% try
%     objects= evalinMWS('objects', 1);
% catch ME
%     rethrow(ME);
% end






%%
% to call the function is much slower!!!
% to call the c# function with the same is even slower

%       [fSI_XC, fCH_XC, fPR_XC, fLI_XC, fXP_XC, N_Xc, N_I, N_aa, C_Xc, ...
%        C_SI, C_Xch, C_Xpr, C_Xli, C_XI, fFA_Xli, C_Sfa, fH2_SU, ...
%        fBU_SU, fPRO_SU, N_XB, C_Sbu, C_Spro, C_Sac, C_XB, Ysu, fH2_AA, ...
%        fVA_AA, fBU_AA, fPRO_AA, C_Sva, Yaa, fH2_FA, Yfa, fH2_VA, fPRO_VA, ...
%        fH2_BU, Yc4, fH2_PRO, Ypro, C_Sch4, Yac, Yh2, kdis, khyd_ch, khyd_pr, ...
%        khyd_li, KS_IN, km_su, KS_su, pHUL_a, pHLL_a, km_aa, KS_aa, km_fa, KS_fa, ...
%        KI_H2_fa, km_c4, KS_c4, KI_H2_c4, km_pro, KS_pro, KI_H2_pro, km_ac, ...
%                         KS_ac, KI_NH3, ...
%        pHUL_ac, pHLL_ac, km_h2, KS_h2, pHUL_h2, pHLL_h2, kdec_Xsu, kdec_Xaa, ...
%                         kdec_Xfa, kdec_Xc4, ...
%        kdec_Xpro, kdec_Xac, kdec_Xh2, Kw, Kava, Kabu, Kapro, Kaac, Kaco2, Kain, ...
%        kA_Bva, kA_Bbu, kA_Bpro, kA_Bac, kA_Bco2, kA_Bin, klaH2, klaCH4, ...
%                         klaCO2, KH_CO2, ...
%        KH_CH4, KH_H2, C_Xp, N_Xp, fP]= getADM1parameters(params);

%%

fSI_XC= params(1);             	% fraction SI from XC

fCH_XC= params(3);              % fraction Xch from XC
fPR_XC= params(4);              % fraction Xpr from XC
fLI_XC= params(5);              % fraction Xli from XC
fXP_XC= params(6);              % fraction Xp from XC
N_Xc= params(7);
N_I= params(8);
N_aa= params(9);
C_Xc= params(10);
C_SI= params(11);
C_Xch= params(12);
C_Xpr= params(13);
C_Xli= params(14);
C_XI= params(15);


fFA_Xli= params(18);
C_Sfa= params(19);
fH2_SU= params(20);
fBU_SU= params(21);
fPRO_SU= params(22);

N_XB= params(24);
C_Sbu= params(25);
C_Spro= params(26);
C_Sac= params(27);
C_XB= params(28);
Ysu= params(29);
fH2_AA= params(30);
fVA_AA= params(31);
fBU_AA= params(32);
fPRO_AA= params(33);

C_Sva= params(35);
Yaa= params(36);
fH2_FA= params(37);
Yfa= params(38);
fH2_VA= params(39);
fPRO_VA= params(40);
fH2_BU= params(41);
Yc4= params(42);
fH2_PRO= params(43);
Ypro= params(44);
C_Sch4= params(45);
Yac= params(46);
Yh2= params(47);
kdis= params(48);
khyd_ch= params(49);
khyd_pr= params(50);
khyd_li= params(51);
KS_IN= params(52);
km_su= params(53);
KS_su= params(54);
pHUL_a= params(55);
pHLL_a= params(56);
km_aa= params(57);
KS_aa= params(58);
km_fa= params(59);
KS_fa= params(60);
KI_H2_fa= params(61);
km_c4= params(62);
KS_c4= params(63);
KI_H2_c4= params(64);
km_pro= params(65);
KS_pro= params(66);
KI_H2_pro= params(67);
km_ac= params(68);
KS_ac= params(69);
KI_NH3= params(70);
pHUL_ac= params(71);
pHLL_ac= params(72);
km_h2= params(73);
KS_h2= params(74);
pHUL_h2= params(75);
pHLL_h2= params(76);
kdec_Xsu= params(77);
kdec_Xaa= params(78);
kdec_Xfa= params(79);
kdec_Xc4= params(80);
kdec_Xpro= params(81);
kdec_Xac= params(82);
kdec_Xh2= params(83);
Kw= params(84);
Kava= params(85);
Kabu= params(86);
Kapro= params(87);
Kaac= params(88);
Kaco2= params(89);
Kain= params(90);
kA_Bva= params(91);
kA_Bbu= params(92);
kA_Bpro= params(93);
kA_Bac= params(94);
kA_Bco2= params(95);
kA_Bin= params(96);
klaH2= params(97);
klaCH4= params(98);
klaCO2= params(99);
KH_CO2= params(100);
KH_CH4= params(101);
KH_H2= params(102);
C_Xp= params(103);
N_Xp= params(104);
fP= params(105);


%%
% variables

% 1
% fraction XI from XC
fXI_XC= 1 - fSI_XC - fCH_XC - fPR_XC - fLI_XC - fXP_XC;
fCO2_XC= C_Xc - fSI_XC*C_SI - fCH_XC*C_Xch - fPR_XC*C_Xpr - fLI_XC*C_Xli - ...
         fXI_XC*C_XI - fXP_XC*C_Xp;
% NH3+NH4 fraction from XC
fSIN_XC= N_Xc-fSI_XC*N_I-fPR_XC*N_aa-fXI_XC*N_I-fXP_XC*N_Xp;


%% TEST TODO

%fSIN_XC= 0;


%%
% Inorganic C fraction hydolysis Xli
fCO2_Xli= C_Xli - fFA_Xli * C_Sfa - ( 1 - fFA_Xli ) * C_Xch;
fAC_SU= 1 - fH2_SU - fBU_SU - fPRO_SU;
fCO2_SU= C_Xch-(fBU_SU*C_Sbu+fPRO_SU*C_Spro+fAC_SU*C_Sac)*(1-Ysu) - Ysu*C_XB;
fAC_AA= 1 - fH2_AA - fVA_AA - fBU_AA - fPRO_AA;
fCO2_AA= C_Xpr - (fVA_AA*C_Sva + fBU_AA*C_Sbu + fPRO_AA*C_Spro + ...
         fAC_AA*C_Sac)*(1 - Yaa) - Yaa*C_XB;
fAC_FA= 1.0 - fH2_FA;
fCO2_FA= C_Sfa-fAC_FA*C_Sac*(1-Yfa)-Yfa*C_XB;

% 11
fAC_VA= 1 - fPRO_VA - fH2_VA;
fCO2_VA= C_Sva-(fPRO_VA*C_Spro + fAC_VA*C_Sac)*(1-Yc4) - Yc4*C_XB;
fAC_BU= 1 - fH2_BU;
fCO2_BU= C_Sbu-fAC_BU*C_Sac*(1-Yc4)-Yc4*C_XB;
fAC_PRO= 1 - fH2_PRO;
fCO2_PRO= C_Spro-fAC_PRO*C_Sac*(1-Ypro)-Ypro*C_XB;
fCO2_AC= C_Sac-(1-Yac)*C_Sch4-Yac*C_XB;
fCO2_H2= -1*(1-Yh2)*C_Sch4-Yh2*C_XB;

%pfac_h= Scat + Snh4 - Shco3 - Sac_ / 64 - Spro_ / 112 - Sbu_ / 160 - Sva_
%/ 208 - San; 
%SH= -1 * pfac_h/2 + 0.5 * ( pfac_h * pfac_h + 4*Kw )^0.5;

%% TODO
% die angabe false sollte in abhängigkeit von usePhysValue gesetzt werden
try
  [dummy1, SH, pfac_h]= biogas.ADMstate.calcPHOfADMstate(x, Kw);
catch ME
  disp(ME.message);
  disp('makeStoichiometry:biogas.ADMstate.calcPHOfADMstate');
  rethrow(ME);
end

% 21
Iin= (Snh4+Snh3)/(Snh4+Snh3+KS_IN);
I_NH3= KI_NH3 / ( KI_NH3 + Snh3 );
I_H2_c4= KI_H2_c4/(KI_H2_c4 + Sh2);
KI_H_a= 10^(-1* (pHUL_a+pHLL_a)/2);
IpH_a= KI_H_a^2/(SH^2+KI_H_a^2);
KI_H_h2= 10^(-1*(pHUL_h2+pHLL_h2)/2);
IpH_h2= KI_H_h2^3/(SH^3+KI_H_h2^3);
KI_H_AC= 10^( -1 * ( pHUL_ac + pHLL_ac ) / 2 );
IpH_ac= KI_H_AC^3 / ( SH^3 + KI_H_AC^3 );
% Fraction Xsu from biomass arising by decay
fCH_XB= fCH_XC/(fCH_XC+fPR_XC+fLI_XC)*(1-fP);

% 31
% Fraction Xpr from biomass arising by decay
fPR_XB= fPR_XC/(fCH_XC+fPR_XC+fLI_XC)*(1-fP);
% Fraction Xli from biomass arising by decay
fLI_XB= fLI_XC/(fCH_XC+fPR_XC+fLI_XC)*(1-fP);
fSIN_XB= N_XB-fP*N_Xp-fPR_XB*N_aa;
fCO2_XB= C_XB-fP*C_Xp-fCH_XB*C_Xch-fPR_XB*C_Xpr-fLI_XB*C_Xli;


%% 
% reaction rates p

% 36
% Disintegration
p(1,1)= kdis*Xc;
% Hydrolysis carbohydrates
p(2,1)= khyd_ch*Xch;
% Hydrolysis of proteins
p(3,1)= khyd_pr*Xpr;
% Hydrolysis of Lipids
p(4,1)= khyd_li*Xli;
% Uptake of sugars
p(5,1)= km_su*Ssu/(KS_su+Ssu)*Xsu*Iin*IpH_a;

% 41
% Uptake of amino acids
p(6,1)= km_aa*Saa/(KS_aa+Saa)*Xaa*Iin*IpH_a;
% Uptake of LCFA
p(7,1)= km_fa*Sfa/(KS_fa+Sfa)*Xfa*Iin*KI_H2_fa/(KI_H2_fa + Sh2)*IpH_a;
% Uptake of valerate
p(8,1)= km_c4*Sva/(KS_c4+Sva)*Xc4*Sva/(Sva+Sbu+0.000001)*Iin*I_H2_c4*IpH_a;
% Uptake of Butyrate
p(9,1)= km_c4*Sbu/(KS_c4+Sbu)*Xc4*Sbu/(Sbu+Sva+0.000001)*Iin*I_H2_c4*IpH_a;
% Uptake of propionate
p(10,1)= km_pro*Spro/(KS_pro+Spro)*Xpro*Iin*KI_H2_pro/(KI_H2_pro + Sh2)*IpH_a;
% Uptake of acetate
p(11,1)= km_ac * Sac / ( KS_ac + Sac ) * Xac * Iin * I_NH3 * IpH_ac;
% Uptake of hydrogen
p(12,1)= km_h2 * Sh2 / ( KS_h2 + Sh2 ) * Xh2 * Iin * IpH_h2;
% decay of Xsu
p(13,1)= kdec_Xsu*Xsu;
% Decay of Xaa
p(14,1)= kdec_Xaa*Xaa;
% Decay of Xfa
p(15,1)= kdec_Xfa*Xfa;

% 51
% Decay of Xc4
p(16,1)= kdec_Xc4*Xc4;
% Decay of Xpro
p(17,1)= kdec_Xpro*Xpro;
% Decay of Xac
p(18,1)= kdec_Xac * Xac;
% Decay of Xh2
p(19,1)= kdec_Xh2*Xh2;
% valerate acid-base
p(20,1)= kA_Bva  * ( Sva_  * SH - Kava  * ( Sva -  Sva_  ) );
% acid-base (butyrate)
p(21,1)= kA_Bbu  * ( Sbu_  * SH - Kabu  * ( Sbu  - Sbu_  ) );
% acid-base (propionate)
p(22,1)= kA_Bpro * ( Spro_ * SH - Kapro * ( Spro - Spro_ ) );
% acid-base (acetate)
% Sac ist ein Summenparameter definiert als Sac := Shac + Sac_
% Shac ist demmnach die Säure und Sac_ die Base
% hier steht demnach das selbe wie in der ADM1 Doku:
% kA_Bac  * ( Sac_  * SH - Kaac  * Shac )
p(23,1)= kA_Bac  * ( Sac_  * SH - Kaac  * ( Sac  - Sac_  ) );
% 
p(24,1)= kA_Bco2 * ( Shco3 * SH - Kaco2 * Sco2 );
% acid-base (inorganic nitrogen)
p(25,1)= kA_Bin  * ( Snh3  * SH - Kain  * Snh4 );


%%
% stoichiometric matrix

A= zeros(25, 33);

% columns 1 - 4
A(2,1)= 1;
                        A(3,2)= 1;
A(4,1)= 1 - fFA_Xli;                    A(4,3)= fFA_Xli;
A(5,1)= -1;     
                        A(6,2)= -1;                         A(6,4)= (1 - Yaa) * fVA_AA;
                                        A(7,3)= -1;         
                                                            A(8,4)= -1;

% columns 5 - 7
A(5,5)= (1 - Ysu) * fBU_SU;     A(5,6)= (1 - Ysu) * fPRO_SU;        A(5,7)= (1 - Ysu) * fAC_SU;
A(6,5)= (1 - Yaa) * fBU_AA;     A(6,6)= (1 - Yaa) * fPRO_AA;        A(6,7)= (1 - Yaa) * fAC_AA;
                                                                    A(7,7)= (1 - Yfa) * fAC_FA;
                                A(8,6)= (1 - Yc4) * fPRO_VA;        A(8,7)= (1 - Yc4) * fAC_VA;
A(9,5)= -1;                                                         A(9,7)= (1 - Yc4) * fAC_BU;
                                A(10,6)= -1;                        A(10,7)= (1 - Ypro) * fAC_PRO;
                                                                    A(11,7)= -1;

% columns 8 - 10
                                                        A(1,10)= fCO2_XC;


                                                        A(4,10)= fCO2_Xli;
A(5,8)= (1 - Ysu) * fH2_SU;                             A(5,10)= fCO2_SU;
A(6,8)= (1 - Yaa) * fH2_AA;                             A(6,10)= fCO2_AA;
A(7,8)= (1 - Yfa) * fH2_FA;                             A(7,10)= fCO2_FA;
A(8,8)= (1 - Yc4) * fH2_VA;                             A(8,10)= fCO2_VA;
A(9,8)= (1 - Yc4) * fH2_BU;                             A(9,10)= fCO2_BU;
A(10,8)= (1 - Ypro) * fH2_PRO;                          A(10,10)= fCO2_PRO;
                                A(11,9)= 1 - Yac;       A(11,10)= fCO2_AC;
A(12,8)= -1;                    A(12,9)= 1 - Yh2;       A(12,10)= fCO2_H2;
                                                        A(13:19,10)= fCO2_XB;
                                                        
                                                        A(24,10)= 1;

% columns 11 - 14
A(1,11)= fSIN_XC;               A(1,12)= fSI_XC;        A(1,13)= -1;    A(1,14)= fCH_XC;
                                                                        A(2,14)= -1;


A(5,11)= -Ysu * N_XB;           
A(6,11)= N_aa - Yaa * N_XB;
A(7,11)= -Yfa * N_XB;
A(8,11)= -Yc4 * N_XB;
A(9,11)= -Yc4 * N_XB;
A(10,11)= -Ypro * N_XB;
A(11,11)= -Yac * N_XB;
A(12,11)= -Yh2 * N_XB;
A(13:19,11)= fSIN_XB;                                                   A(13:19,14)= fCH_XB;

A(25,11)= 1;

% columns 15 - 18
A(1,15)= fPR_XC;            A(1,16)= fLI_XC;        

A(3,15)= -1;                
                            A(4,16)= -1;
                                                    A(5,17)= Ysu;
                                                                                        A(6,18)= Yaa;
A(13:19,15)= fPR_XB;        A(13:19,16)= fLI_XB;    A(13:19,17:23)= -1 .* eye(7,7);

% columns 19 - 24
                                                                                        A(1,24)= fXI_XC;
A(7,19)= Yfa;
                A(8,20)= Yc4;
                A(9,20)= Yc4;
                             	A(10,21)= Ypro;
                                                    A(11,22)= Yac;
                                                                        A(12,23)= Yh2;
                                                                        
% columns 25 - 
A(1,25)= fXP_XC;

A(13:19,25)= fP;
                                                    A(20:25,28:33)= -1 .* eye(6,6);


                                                   
%pgas_h2o= 0.0313 * exp( 5290 * ( 1 / 298 - 1 / T ) );

% Partial pressure of Sh2 bar
piSh2= x(34);
% Partial pressure of Sch4 bar 
piSch4= x(35);
% Partial pressure of Sco2 bar
piSco2= x(36);
% Sum of all partial pressures bar 
pTOTAL= x(37);

% Gas law constant R [bar / ( M * K )]
%R= 8.313999999999999 * 10^(-2);

% Gas constant temperature [bar m^3/kmol]
%RT= R*T;

rho(1,1)= klaH2  * ( Sh2  - piSh2  * 16 / RT / KH_H2  ) * Vliq.Value / Vgas;
rho(2,1)= klaCH4 * ( Sch4 - piSch4 * 64 / RT / KH_CH4 ) * Vliq.Value / Vgas;
rho(3,1)= klaCO2 * ( Sco2 - piSco2 *  1 / RT / KH_CO2 ) * Vliq.Value / Vgas;
rho(4,1)= kp * ( pTOTAL - pext ) * Vliq.Value / Vgas;

G= [RT/16,         0,              0,              RT/16;
    0,             RT/64,          0,              RT/64;
    0,             0,              RT,             RT;
    -piSh2/max(pTOTAL,eps), -piSch4/max(pTOTAL,eps), -piSco2/max(pTOTAL,eps), -1 ];



%%
% Norm cubic meter [mol/m^3]
%
%NQ= 44.64300; % aus ADM1

% total biogas flow [m^3/d]
%Qgas= max( kp * ( pTOTAL - pext ) / ( RT / 1000 * NQ ) * Vliq, 0);

%sum_pp= x(34,1) + x(35,1) + x(36,1);

% calculate gas flow for each component
%Qgas_h2= Qgas * x(34,1) / max(sum_pp, eps);
%Qgas_ch4= Qgas * x(35,1) / max(sum_pp, eps);
%Qgas_co2= Qgas * x(36,1) / max(sum_pp, eps);



%intvars.adm1.(fermenter_id)= 
intvars_data= ...
       [ Qgas_h2, Qgas_ch4, Qgas_co2, ...
         [fXI_XC; fCO2_XC; fSIN_XC; fCO2_Xli; fAC_SU; fCO2_SU; fAC_AA; ...
          fCO2_AA; ...
          fAC_FA; fCO2_FA; fAC_VA; fCO2_VA; fAC_BU; fCO2_BU; fAC_PRO; ...
          fCO2_PRO; fCO2_AC; fCO2_H2; pfac_h; SH; Iin; I_NH3; I_H2_c4; ...
          KI_H_a; IpH_a; KI_H_h2; IpH_h2; KI_H_AC; IpH_ac; fCH_XB; ...
          fPR_XB; fLI_XB; fSIN_XB; fCO2_XB]', Qgas, p', rho'];
                                              % Qgas set in mdlOutputs

% try
%     assigninMWS('intvars', intvars, 1);
% catch ME
%     rethrow(ME);
% end

% if exist('plant_model', 'var') == 1
% 
%     plant_model.setintvars('ADM1', fermenter_id, intvars_data);
%     
% end

if exist('sensors', 'var') == 1

  sensors.measureVec(t, ['ADMintvars_', fermenter_id], 0.01, ...
          NET.convertArray(intvars_data, 'System.Double', numel(intvars_data)));
    
end

%%


