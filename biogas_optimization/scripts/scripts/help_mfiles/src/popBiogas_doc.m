%% Syntax
%       biogas.optimization.popBiogas()
%
%       biogas.optimization.popBiogas(pop_size)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max) 
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min) 
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
%       nonlcon_plant) 
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
%       nonlcon_plant, state_ineq) 
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
%       nonlcon_plant, state_ineq, state_eq) 
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
%       nonlcon_plant, state_ineq, state_eq, nonlcon_state) 
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
%       nonlcon_plant, state_ineq, state_eq, nonlcon_state, parallel) 
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
%       nonlcon_plant, state_ineq, state_eq, nonlcon_state, parallel,
%       nWorker)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
%       nonlcon_plant, state_ineq, state_eq, nonlcon_state, parallel,
%       nWorker, data)
%
%       biogas.optimization.popBiogas(pop_size, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       digester_state_min, digester_state_max, substrate_ineq,
%       substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
%       nonlcon_plant, state_ineq, state_eq, nonlcon_state, parallel,
%       nWorker, data, lenGenom)
%
%% Description
% |biogas.optimization.popBiogas()| is creating an object used for holding
% an initial population for optimizing biogas plants, where each 
% individual can be
% bounded and constrained to (non-)linear (in-)equality constraints. The
% population itself will not be created.
%
%% 
% |biogas.optimization.popBiogas(pop_size)| creates an initial population
% with size |pop_size|.
%
%%
% @param pop_size : 
%
% * wenn ein Skalar, dann gibt dieser die Populationsgröße an
%
% * wenn ein Vektor, dreidimensional, dann hat dieser folgende Bedeutung: 
%
% # [5, 0, 0] : selbe Bedeutung wie Skalar, Population mit Dim. 5 wird
% erstellt. D.h. es werden je 5 Individuen für Substrat, Pumpfluss und
% Fermenterzustand erstellt (falls es die Maske wünscht, min != max) und
% diese max. 15 Individuen werden zu je max. 3er Packs horizontal
% verknüpft, so dass eine 5 dim. Population mit je max. 3 Individuen
% entsteht, welche je zu einem Gesamtindividuumsvektor horizontal
% verbunden sind. Die Bedeutung der 0 ist, dass 1 Dimensionen vorher
% geschaut werden soll und so viele Individuen erstellt werden sollen. Das
% Zustandsindividuum schaut demnach auf die 0, und schaut dann weiter auf
% die 5, so dass der Vektor [5, 0, -1] zum gleichen Ergebnis führt, wobei
% die -1 heisst, dass 2 Dimensionen nach vorne geschaut werden soll, also
% direkt auf die 5 für beide Individuen.
% # [5,1,-1] : Hier werden 5 Substrat- und Zustandsindividuen erstellt, aber
% nur 1 Pumpfluss Individuum. Die Verknüpfung erfolgt so, dass das 1
% Pumpflussindividuum verfünffacht wird und damit 5 identische Pump
% Individuen entstehen, dann Verknüpfung wie oben. Die Bedeutung der -1 ist
% hier, dass 2 Dimensionen vorher geschaut werden soll, also auf die 5.
% # [5,1,0] : Hier werden 5 Substratindividuen erstellt, aber
% nur 1 Pumpfluss- und Zustands-Individuum. Die Verknüpfung erfolgt so,
% dass das 1 Pumpfluss- und Zustandsindividuum verfünffacht wird und damit
% 5 identische Pump- und Zustands-
% Individuen entstehen, dann Verknüpfung wie oben. Die Bedeutung der 0 ist
% hier, dass 1 Dimensionen vorher geschaut werden soll, also auf die 1.
% [5,2,0] : Die Gesamtpopulation hat Dimension 5*2= 10. Hier wird jedem
% Substrat Individuum 2 Pump- und Zustandsindividuen zugeordnet. D.h. Die
% Substratindividuuen werden verdoppelt und jedem Zweierpack werden die 2
% Pump- und Zustandsindividuen zugeordnet.
% # [5,2,-1] : Die Gesamtpopulation hat Dimension 5*2= 10. Hier wird jedem
% Substrat Individuum 2 Pumpindividuen zugeordnet. D.h. Die Substrat- und
% Zustandsindividuuen werden verdoppelt und jedem Zweierpack werden die 2
% Pumpindividuen zugeordnet.
% # [5,2,1] : Wie letztes, nur, dass jetzt die Zustandsindividuen
% verzehntfacht werden. 
% # [5,2,2] : Gesamtdimension der Population ist 20.
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq, substrate_eq)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate, plant_ineq)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate, plant_ineq, plant_eq)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
% nonlcon_plant)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
% nonlcon_plant, state_ineq)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
% nonlcon_plant, state_ineq, state_eq)| 
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
% nonlcon_plant, state_ineq, state_eq, nonlcon_state)|
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
% nonlcon_plant, state_ineq, state_eq, nonlcon_state, parallel)|
%
%%
% @param |parallel| : 
%
% * 'none' : the optimization method do not run in parallel
% * 'multicore' : if it is possible for the optimization method to run in
% parallel, like 'GA', 'PSO', then it is started in parallel on a multicore
% processor
% * 'cluster' : the optimiaztion method is started in parallel assuming it
% is run on a computer cluster
%
%%
% |biogas.optimization.popBiogas(pop_size, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% digester_state_min, digester_state_max, substrate_ineq,
% substrate_eq, nonlcon_substrate, plant_ineq, plant_eq,
% nonlcon_plant, state_ineq, state_eq, nonlcon_state, parallel,
% nWorker)| 
%
%%
% @param |nWorker| : number of workers
%
%%
% This class is a handle class, which is derived from the
% <matlab:doc('optimization_tool/conpopulation')
% optimization.conPopulation> class. 
%
%% Example
%
%

plant_id= 'gummersbach';

parallel= 'none';
nWorker= 1;

[substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, ...
   plant_network_min, plant_network_max, ...
   digester_state_min, digester_state_max, ...
   params_min, params_max, ...
   substrate_eq, substrate_ineq, fitness_params]= ...
                                load_biogas_mat_files(plant_id);

[popBiogas]= biogasM.optimization.popBiogas(0, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    @(obj)@(u)nonlcon_substrate(u, plant, substrate, ...
                                        obj, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], 1);%2);%1);%2);%1);

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    @(u)nonlcon_substrate(u, plant, substrate, ...
                            popBiogas, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], 1);%2);%1);%2);%1);

                  
%%

plant_id= 'gummersbach';

parallel= 'none';
nWorker= 1;

[substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, ...
   plant_network_min, plant_network_max, ...
   digester_state_min, digester_state_max, ...
   params_min, params_max, ...
   substrate_eq, substrate_ineq, fitness_params]= ...
                                load_biogas_mat_files(plant_id);

[popBiogas]= biogasM.optimization.popBiogas(0, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    @(obj)@(u)nonlcon_substrate(u, plant, substrate, ...
                                        obj, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], 2);

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    @(u)nonlcon_substrate(u, plant, substrate, ...
                            popBiogas, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], 2);


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="popsubstrate.html">
% biogasM.optimization.popSubstrate</a>
% </html>
% ,
% <html>
% <a href="popstate.html">
% biogasM.optimization.popState</a>
% </html>
% ,
% <html>
% <a href="popplantnetwork.html">
% biogasM.optimization.popPlantNetwork</a>
% </html>
% ,
% <html>
% <a href="popparameters.html">
% biogasM.optimization.popParameters</a>
% </html>
% ,
% <html>
% <a href="setsizeoflineq.html">
% biogasM.optimization.popBiogas.private.setSizeOfLinEq</a>
% </html>
% ,
% <html>
% <a href="concatdata.html">
% biogasM.optimization.popBiogas.private.concatData</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/setparams')">
% numerics_tool/numerics.conRandMatrix.setParams</a>
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
% <a href="matlab:doc('numerics_tool/conrandmatrix')">
% numerics_tool/numerics.conRandMatrix</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/conpopulation')">
% optimization_tool/optimization.conPopulation</a>
% </html>
%
%% TODOs
% 
%


