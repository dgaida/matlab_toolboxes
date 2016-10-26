%% Syntax
%       [xdot]= calcADM1LinearizedDeriv(t, x, u, fermenter_id, plant)
%
%% Description
% |[xdot]= calcADM1LinearizedDeriv(t, x, u, fermenter_id, plant)| calculates
% $\vec{x}'(t)= \vec{f} \left( \vec{x}(t), \vec{u}(t), t \right)$ of the
% linearized ADM1 model. 
%
%%
% @param |t| : double scalar with the actual time
%
%%
% @param |x| : current state vector (double) of the ADM1
%
%%
% @param |u| : current 34dim input double vector of the ADM1
% 
%%
% @param |fermenter_id| : char containing the id of the fermenter modeled
% by the ADM1
% 
%%
% @param |plant| : plant structure
% 
%%
% @return |xdot| : returns $\vec{x}'(t)$.
%
%% Example
% 
%
%% See Also
%
% <html>
% <a href="adm1de.html">
% ADM1DE</a>
% </html>
% ,
% <html>
% <a href="calcadm1deriv.html">
% calcADM1Deriv</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1de_linearized')">
% ADM1DE_linearized</a>
% </html>
% ,
% <html>
% <a href="makestoichiometry.html">
% makeStoichiometry</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>


