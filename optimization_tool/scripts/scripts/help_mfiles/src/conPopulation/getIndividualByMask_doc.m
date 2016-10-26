%% Syntax
%       [u, uMask]= getIndividualByMask(obj, nCols, Amax, Aeqmax, LBmax,
%       UBmax) 
%       [u, uMask]= getIndividualByMask(obj, nCols, Amax, Aeqmax, LBmax,
%       UBmax, dataForIndividual) 
%       [u, uMask]= getIndividualByMask(obj, nCols, Amax, Aeqmax, LBmax,
%       UBmax, dataForIndividual, lenGenom) 
%
%% Description
% |[u, uMask]= getIndividualByMask(obj, nCols, Amax, Aeqmax, LBmax, UBmax)|
% 
%%
% @param |obj| : object of the class
% <matlab:doc('optimization.conpopulation') optimization.conPopulation> 
%
%%
% @param |nCols| : number of columns, respectively the dimension of the
% original problem. 
%
%%
% @param |Amax| : matrix of the linear inequality constraints in the dimension
% of the original problem. 
%
%%
% @param |Aeqmax| : matrix of the linear equality constraints in the dimension
% of the original problem. 
%
%%
% @param |LBmax| : vector with lower bounds in the dimension
% of the original problem. 
%
%%
% @param |UBmax| : vector with upper bounds in the dimension
% of the original problem. 
%
%%
% @return |u| : individual created out of the given |dataForIndividual|
%
%%
% @return |uMask| : a column vector of size |lenVector|. It contains a 1,
% if the ith element should be inside the individual and a 0 if the ith
% element does not have to be inside the individual. 
%
%%
% |[u, uMask]= getIndividualByMask(obj, nCols, Amax, Aeqmax, LBmax, UBmax,
% dataForIndividual)| 
% 
%%
% @param |dataForIndividual| : data which should give the individual.
%
%%
% |[u, uMask]= getIndividualByMask(obj, nCols, Amax, Aeqmax, LBmax, UBmax,
% dataForIndividual, lenGenom)| 
% 
%%
% @param |lenGenom| : length of the genome
%
%% Example
%

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
% <a href="getminimaldescription.html">
% optimization.conPopulation.private.getMinimalDescription</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('getpumpedadm1stream')">
% getPumpedADM1Stream</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getadm1paramsfromindividual')">
% biogasM.optimization.popBiogas.getADM1ParamsFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getindividualfromequilibrium')">
% biogasM.optimization.popBiogas.getIndividualFromEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getnetworkfluxfromindividual')">
% biogasM.optimization.popBiogas.getNetworkFluxFromIndividual</a>
% </html>
%
%% See Also
%
% <html>
% <a href="conpopulation.html">
% optimization.conPopulation</a>
% </html>
% ,
% <html>
% <a href="adaptconstraintstolengenom.html">
% optimization.conPopulation.private.adaptConstraintsToLenGenom</a>
% </html>
%
%% TODOs
% # improve documentation
%
%% <<AuthorTag_DG/>>


