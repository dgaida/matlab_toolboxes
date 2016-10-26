%% Syntax
%       A= setSizeOfLinEq(obj, A_substrate, A_plant, A_state, A_params)
%       A= setSizeOfLinEq(obj, A_substrate, A_plant, A_state, A_params, constrained)
%       
%% Description
% |A= setSizeOfLinEq(obj, A_substrate, A_plant, A_state, A_params)| concatenates the
% linear (in-)equality constraints such that out of the four subproblems 1
% matrix is created such that the four problems result into 1 problem.
%
%%
% @param |obj| : object of the class <popbiogas.html
% biogasM.optimization.popBiogas>.
%
%%
% @param |A_substrate| : linear (in-)equality constraints coming from the
% class <popsubstrate.html biogasM.optimization.popSubstrate>.
%
%%
% @param |A_plant| : linear (in-)equality constraints coming from the
% class <popplantnetwork.html biogasM.optimization.popPlantNetwork>.
%
%%
% @param |A_state| : linear (in-)equality constraints coming from the
% class <popstate.html biogasM.optimization.popState>.
%
%%
% @param |A_params| : linear (in-)equality constraints coming from the
% class <popparameters.html biogasM.optimization.popParameters>.
%
%%
% |A= setSizeOfLinEq(obj, A_substrate, A_plant, A_state, A_params, constrained)|
%
%%
% @param |constrained| : if 1, then the constrained problem is handled,
% else (0) then the full problem.
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/blkdiag')">
% matlab/blkdiag</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="popbiogas.html">
% biogasM.optimization.popBiogas</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('numerics_tool/consetofpoints')">
% numerics.conSetOfPoints</a>
% </html>
% ,
% <html>
% <a href="popsubstrate.html">
% biogasM.optimization.popSubstrate</a>
% </html>
% ,
% <html>
% <a href="popplantnetwork.html">
% biogasM.optimization.popPlantNetwork</a>
% </html>
% ,
% <html>
% <a href="popstate.html">
% biogasM.optimization.popState</a>
% </html>
% ,
% <html>
% <a href="popparameters.html">
% biogasM.optimization.popParameters</a>
% </html>
%
%% TODOs
% # es gibt einige TODOs in der Datei
% # bspw. wird die Matrix A doppelt berechnet, eins von beiden sollte
% gelöscht werden, wenn man sich sicher ist, welches besser ist.
%
%% <<AuthorTag_DG/>>
    
       
    