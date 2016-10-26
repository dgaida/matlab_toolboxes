%% Syntax
%       [Amin, b]= adaptConstraintsToLenGenom(Amin, b, lenGenom)
%
%% Description
% |[Amin, b]= adaptConstraintsToLenGenom(Amin, b, lenGenom)| adapts
% constraints |Amin| and |b| to length of genome of optimization problem
% |lenGenom|. 
%
%%
% @param |Amin| : linear (in-)equality matrix |A| written for the dimension
% of the individual. Thus, just a normal linear (in-)equality matrix.
% Number of columns equal to dimension, number of rows equal to constraints
%
%%
% @param |b| : right side of constraint, double row or column vector with
% as many elements as |Amin| has rows. 
%
%%
% @param |lenGenom| : length of the genome, double scalar integer
%
%%
% @return |Amin| : returns the parameter |Amin| just for the problem where
% the variable x is now a vector with |lenGenom| elements, see example
%
%%
% @return |b| : returns the parameter |b| just for the problem where
% the variable x is now a vector with |lenGenom| elements, see example
%
%% Example
%
% given: Amin= [1 0 1; 
%               0 0 1]
%
%        b= [2
%            3]
%
% and |lenGenom|= 2
%
% the returned values are:
%
% Amin= [1 0 0 0 1 0;
%        0 0 0 0 1 0;
%        0 1 0 0 0 1;
%        0 0 0 0 0 1]
%
% b= [2
%     3
%     2
%     3]
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="conpopulation.html">
% optimization.conPopulation</a>
% </html>
% ,
% <html>
% <a href="getminimaldescription.html">
% optimization.conPopulation.private.getMinimalDescription</a>
% </html>
%
%% See Also
%
% <html>
% <a href="getindividualbymask.html">
% optimization.conPopulation.getIndividualByMask</a>
% </html>
%
%% TODOs
% # see TODO inside file
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>
            
            
            