%% Syntax
%       [c, ceq]= nonlcon_substrate(u, plant, substrate, popBiogas)
%       [c, ceq]= nonlcon_substrate(u, plant, substrate, popBiogas, TS_max)
%       [c, ceq]= nonlcon_substrate(u, plant, substrate, popBiogas, TS_max,
%       OLR_max) 
%       [c, ceq, GC]= nonlcon_substrate(...)
%       [c, ceq, GC, GCeq]= nonlcon_substrate(...)
%
%% Description
% |[c, ceq]= nonlcon_substrate(u, plant, substrate, popBiogas)| returns
% nonlinear inequality  
% |c| and equality constraints |ceq| which depend on the substrate |u| of a
% plant. At the moment only one inequality constraint is implemented,
% which keeps the TS (dry matter)-value of the substrate input below a
% maximal level of 30 % FM. 
%
%%
% @param |u| : individual, double row vector
%
%%
% @param |plant| : object of class |biogas.plant|
%
%%
% @param |substrate| : object of class |biogas.substrates|
%
%%
% @param |popBiogas| : object of class <matlab:doc('biogas_optimization/popbiogas')
% |biogasM.optimization.popBiogas|> 
%
%%
% @return |c| : nonlinear inequality constraint $c(u) <= 0$
%
%%
% @return |ceq| : nonlinear equality constraint $ceq(u) = 0$
%
%%
% |[c, ceq]= nonlcon_substrate(u, plant, substrate, popBiogas, TS_max)|
% lets you define the upper bound of the TS-value |TS_max| in % FM.
%
%%
% @param |TS_max| : maximal TS-value which the substrate mix |u| may have,
% measured in % FM
%
%%
% @param |OLR_max| : maximal value of organic loading rate, not yet
% implemented
%
%%
% |[c, ceq, GC]= nonlcon_substrate(...)| returns
%
%%
% @return |GC| : the Gradient of |c| at |u|
%
%%
% |[c, ceq, GC, GCeq]= nonlcon_substrate(...)| returns
%
%%
% @return |GCeq| : the Gradient of |ceq| at |u|
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('biogas_optimization/getnetworkfluxfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getNetworkFluxFromIndividual</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('findoptimalequilibrium')">
% findOptimalEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('digester_state_nonlcon')">
% digester_state_nonlcon</a>
% </html>
% ,
% <html>
% <a href="nonlcon_plant.html">
% nonlcon_plant</a>
% </html>
% ,
% <html>
% <a href="nonlcon_params.html">
% nonlcon_params</a>
% </html>
%
%% TODOs
% # nebenbedingung mit OLR noch nicht implementiert, da auch noch fermenter
% zufluss aus rückführungen abhängig ist
% # das gleiche gilt auch für hydraulische verweilzeit, die frage ist, ob
% beide überhaupt hier implementiert werden sollten, da sie nicht
% ausschließlich von substrate abhängen. falls diese implementiert werden,
% dann nur als grobe schätzungen. da rückführung beide werte auch
% erniedrigen könnte, theoretisch, kann allerdings keine upper bound
% schätzung gemacht werden...
% # füge weitere (un-)gleichungsnebenbedingungen hinzu
% # s. TODO bei TS Gehalt
%
%% <<AuthorTag_DG/>>


