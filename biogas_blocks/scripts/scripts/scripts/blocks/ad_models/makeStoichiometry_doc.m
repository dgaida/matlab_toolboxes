%% Syntax
%       [A, p, G, rho]= makeStoichiometry(Vliq, Vgas, T_deg, x,
%       fermenter_id, t) 
%       
%% Description
% |makeStoichiometry(Vliq, Vgas, T_deg, x, fermenter_id, t)|
%
%%
% @param |Vliq| : liquid volume of the fermenter
%
%%
% @param |Vgas| : gas volume of the fermenter
%
%%
% @param |T_deg| : Temperature in °C inside the fermenter
%
%%
% @param |x| : actual state of the fermenter
%
%%
% @param |fermenter_id| : id of the fermenter, defined in
% plant.fermenter.ids
%
%%
% @param |t| : actual simulation time
%
%%
% @return |A| : the stoichiometric matrix
%
%%
% @return |p| : 
%
%%
% @return |G| : 
%
%%
% @return |rho| : 
%
%% Example
%
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('p_adm1xp')">
% p_adm1xp</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="calcadm1deriv.html">
% calcADM1Deriv</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1de_linearized')">
% ADM1DE_linearized</a>
% </html>
%
%% See Also
%
% <html>
% <a href="adm1de.html">
% ADM1DE</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/assigninmws')">
% script_collection/assigninMWS</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>


