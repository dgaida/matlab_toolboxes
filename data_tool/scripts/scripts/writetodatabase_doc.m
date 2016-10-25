%% Preliminaries
% The database |database_name| has to be set up first using the
% <matlab:doc('querybuilder') querybuilder>, in case you want to write into
% a ODBC database. For informations on setting up the connection to a
% postgreSQL database, see the documentation of <readfromdatabase.html
% readfromdatabase>. 
%
% HowTo (for further help see the MATLAB help searching for
% <matlab:doc('querybuilder') querybuilder>): 
%
% Open the Windows Data Source Administrator dialog box to define the ODBC
% data source: 
% 
% # Start Visual Query Builder by entering the command |querybuilder| at
% the MATLAB command prompt. 
% # In Visual Query Builder, select Query > Define ODBC data source.
% # The ODBC Data Source Administrator dialog box appears, listing existing
% data sources. 
% # Click the User DSN tab.
% # Click Add. A list of installed ODBC drivers appears in the ODBC Data
% Source Administrator dialog box. Select MS Access Database...
%
%% Syntax
%       errflag= writetodatabase(database_name, networkFluxString,
%       networkFlux, plant, substrate, fitness_params, fitness_function) 
%       [...]= writetodatabase(database_name, networkFluxString,
%       networkFlux, plant, substrate, fitness_params, fitness_function,
%       writeDatum)  
%       [...]= writetodatabase(database_name, networkFluxString,
%       networkFlux, plant, substrate, fitness_params, fitness_function,
%       writeDatum, appendData)  
%       [...]= writetodatabase(database_name, networkFluxString,
%       networkFlux, plant, substrate, fitness_params, fitness_function,
%       writeDatum, appendData, postgresql)  
%       [...]= writetodatabase(database_name, networkFluxString,
%       networkFlux, plant, substrate, fitness_params, fitness_function,
%       writeDatum, appendData, postgresql, writetodb)  
%
%% Description
% |errflag= writetodatabase(database_name, networkFluxString, networkFlux, 
% plant, substrate, fitness_params, fitness_function)| writes data returned
% by the fitness function |fitness_function| into the postgreSQL database
% |database_name|. Call this function directly after your simulation. 
%
%%
% @param |database_name| : char with the name of the database
%
%%
% @param |networkFluxString| : cell string describing the |networkFlux|, the
% network flux describes the state of the plant in the database. To save
% the state of the fermenters in the database too, would need too much
% columns. 
%
%%
% @param |networkFlux| : The corresponding values to |networkFluxString|. We
% recommend to get |networkFluxString| and |networkFlux| out of the
% equilibrium struct and pass both values through the function
% <matlab:doc('getnetworkfluxthreshold') getNetworkFluxThreshold> first.
% It, e.g., throws out all fluxes which are 0, when you call the function
% as shown in the 2nd example below. Double vector. 
%
%% <<plant/>>
%% <<substrate/>>
%% <<fitness_params/>>
%%
% @param |fitness_function| : function_handle to the fitness function.
% Fitness functions are found in the path |blocks/optimization/fitness|,
% see the |See Also| block for examples of fitness functions.
%
%%
% @return |errflag| : 1, if an error occurred, else 0
%
%%
% |[...]= writetodatabase(database_name, networkFluxString, networkFlux,
% plant, substrate, fitness_params, fitness_function, writeDatum)| 
%
%%
% @param |writeDatum| : 
%
%%
% |[...]= writetodatabase(database_name, networkFluxString, networkFlux,
% plant, substrate, fitness_params, fitness_function, writeDatum,
% appendData)|
%
%%
% @param |appendData| : 
%
%%
% |[...]= writetodatabase(database_name, networkFluxString, networkFlux,
% plant, substrate, fitness_params, fitness_function, writeDatum,
% appendData, postgresql)|
%
%%
% @param |postgresql| : 
%
%%
% |[...]= writetodatabase(database_name, networkFluxString, networkFlux,
% plant, substrate, fitness_params, fitness_function, writeDatum,
% appendData, postgresql, writetodb)|   
%
%%
% @param |writetodb| : 
%
%% Examples
% 
% 1.
%
%  error= writetodatabase('sunderhook_equilibria', fluxStringThres, ...
%  networkFluxThres, plant, substrate, @fitness_wolf_adapted)
%
% 2.
%
% load plant, substrate and you should have a equilibrium struct you just
% have simulated
%
%  plant_id= plant.id;
%
%  [networkFluxThres, fluxStringThres]= ...
%         getNetworkFluxThreshold(networkFlux, fluxString, 0);
%
%  % only the flux > 0 is written into the database
%  errorflag= writetodatabase(['equilibria_', plant_id], fluxStringThres, ...
%                networkFluxThres, plant, substrate, @fitness_wolf_adapted);
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc database">
% matlab/database</a>
% </html>
% ,
% <html>
% <a href="writeincsv.html">
% writeInCSV</a>
% </html>
% ,
% <html>
% <a href="writeinxls.html">
% writeInXLS</a>
% </html>
% ,
% <html>
% <a href="writeindataset.html">
% writeInDataset</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc dmd">
% matlab/dmd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc insert">
% matlab/insert</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('simbiogasplantextended')">
% simBiogasPlantExtended</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('fitness_wolf')">
% fitness_wolf</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fitness_wolf_adapted')">
% fitness_wolf_adapted</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fitness_costs')">
% fitness_costs</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getnetworkfluxthreshold')">
% getNetworkFluxThreshold</a>
% </html>
%
%% TODOs
%
% # ok, als erste Spalte Datum, Uhrzeit der Simulation nehmen (s. Funktion von
% Christian Wolf) 
% # fehler mit try catch anfangen und errflag raus schmeißen
% # improve code and documentation significantly
% # die funktion ist sehr auf die biogas toolbox ausgerichtet, evtl. kann
% man hier noch etwas verallgemeinern, ansonsten müsste die funktion wo
% anders hingeschoben werden. 
% # add an example
%
%% <<AuthorTag_DG/>>


