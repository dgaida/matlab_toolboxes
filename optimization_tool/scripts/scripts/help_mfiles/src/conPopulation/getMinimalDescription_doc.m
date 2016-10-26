%% Syntax
%       [lenIndividual]= getMinimalDescription( lenVector )
%       [lenIndividual]= getMinimalDescription( lenVector, A ) 
%       [lenIndividual]= getMinimalDescription( lenVector, A, Aeq )
%       [lenIndividual]= getMinimalDescription( lenVector, A, Aeq, LB )
%       [lenIndividual]= getMinimalDescription( lenVector, A, Aeq, LB, UB )
%       [lenIndividual]= getMinimalDescription( lenVector, A, Aeq, LB, UB,
%       dataForIndividual )
%       [lenIndividual]= getMinimalDescription( lenVector, A, Aeq, LB, UB,
%       dataForIndividual, lenGenom )
%
%       [lenIndividual, uMask]= getMinimalDescription( ... )
%       [lenIndividual, uMask, Amin]= getMinimalDescription( ... )
%       [lenIndividual, uMask, Amin, Aeqmin]= getMinimalDescription( ... )
%       [lenIndividual, uMask, Amin, Aeqmin, LBmin]= getMinimalDescription( ... )
%       [lenIndividual, uMask, Amin, Aeqmin, LBmin, UBmin]= getMinimalDescription(
%       ... ) 
%       [lenIndividual, uMask, Amin, Aeqmin, LBmin, UBmin, u]=
%       getMinimalDescription( ... ) 
%
%% Description
% |[lenIndividual]= getMinimalDescription( lenVector )|
%
%%
% @param |lenVector| : defines the dimension of the original problem.
%
%%
% @return |lenIndividual| : length of the individual
%
%%
% |[lenIndividual]= getMinimalDescription( lenVector, A )|
%
%%
% @param |A| : matrix of the linear inequality constraints in the dimension
% of the original problem. 
%
%%
% |[lenIndividual]= getMinimalDescription( lenVector, A, Aeq )|
%
%%
% @param |Aeq| : matrix of the linear equality constraints in the dimension
% of the original problem. 
%
%%
% |[lenIndividual]= getMinimalDescription( lenVector, A, Aeq, LB )|
%
%%
% @param |LB| : vector with lower bounds in the dimension
% of the original problem. 
%
%%
% |[lenIndividual]= getMinimalDescription( lenVector, A, Aeq, LB, UB )|
%
%%
% @param |UB| : vector with upper bounds in the dimension
% of the original problem. 
%
%%
% |[lenIndividual]= getMinimalDescription( lenVector, A, Aeq, LB, UB,
% dataForIndividual )|
%
%%
% @param |dataForIndividual| : data which should give the individual.
%
%%
% |[lenIndividual]= getMinimalDescription( lenVector, A, Aeq, LB, UB,
% dataForIndividual, lenGenom )|
%
%%
% @param |lenGenom| : length of the genome
%
%%
% |[lenIndividual, uMask]= getMinimalDescription( ... )|
%
%%
% @return |uMask| : a column vector of size |lenVector|. It contains a 1,
% if the ith element should be inside the individual and a 0 if the ith
% element does not have to be inside the individual. 
%
%%
% |[lenIndividual, uMask, Amin]= getMinimalDescription( ... )|
%
%%
% @return |Amin| : matrix |A| written for the dimension of the individual
%
%%
% |[lenIndividual, uMask, Amin, Aeqmin]= getMinimalDescription( ... )|
%
%%
% @return |Aeqmin| : matrix |Aeq| written for the dimension of the
% individual 
%
%%
% |[lenIndividual, uMask, Amin, Aeqmin, LBmin]= getMinimalDescription( ... )|
%
%%
% @return |LBmin| : bounds |LB| written for the dimension of the individual
%
%%
% |[lenIndividual, uMask, Amin, Aeqmin, LBmin, UBmin]= getMinimalDescription(
% ... )|
%
%%
% @return |UBmin| : bounds |UB| written for the dimension of the individual
%
%%
% |[lenIndividual, uMask, Amin, Aeqmin, LBmin, UBmin, u]=
% getMinimalDescription( ... )|
% 
%%
% @return |u| : individual created out of the given |dataForIndividual|
%
%% Example
%
% because this is a private method, call the public method, which calls
% this method. 

[u, uMask]= getIndividualByMask(...
            optimization.conPopulation(), 3, [1 0 0; 0 0 1], [], [1 0 0], [1 5 3]);
        
disp('u: ')   
disp(u)
disp('uMask: ')     
disp(uMask)

%%
% here we can kick out the first element. because it is not in a
% (in-)equality and the LB and UB are equal for this element: 1.

[u, uMask]= getIndividualByMask(...
            optimization.conPopulation(), 3, [0 1 0; 0 0 1], [], [1 0 0], [1 5 3]);
        
disp('u: ')   
disp(u)
disp('uMask: ')     
disp(uMask)

%%
%

[u, uMask]= getIndividualByMask(...
            optimization.conPopulation(), 3, [0 1 0; 0 0 1], [1 1 1], [1 0 0], [1 5 3]);
        
disp('u: ')   
disp(u)
disp('uMask: ')     
disp(uMask)

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="adaptconstraintstolengenom.html">
% optimization.conPopulation.private.adaptConstraintsToLenGenom</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="getindividualbymask.html">
% optimization.conPopulation.getIndividualByMask</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('numerics_tool/conrandmatrix')">
% numerics_tool/numerics.conRandMatrix</a>
% </html>
% ,
% <html>
% <a href="conpopulation.html">
% optimization.conPopulation</a>
% </html>
%
%% TODOs
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


