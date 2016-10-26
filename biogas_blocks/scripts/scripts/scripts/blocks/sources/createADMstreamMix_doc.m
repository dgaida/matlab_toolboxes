%% Syntax
%       createADMstreamMix(t,x,u,flag, substrate_name, substrate)
%
%% Description
% |createADMstreamMix(t,x,u,flag, ...)| is a Level-1 M-file
% S-function represented by the 'conv_primarydata2adm1xp_mat' block. 
%
% Calls the C# method |biogas.ADMstate.calcADMstream| which returns the 34
% dimensional ADM1 stream for the given substrate |substrate_name|. The
% substrate params are read out of the given C# object |substrate| of the
% |biogas.substrates| class.
%
%%
%
% creates the 'daily
% hydrograph' for a biogas plant. It reads all data out of substrate files
% and saves it in the |biogas.sensor| object. In the output
% callback the current volumeflow of the substrate is returned and the
% parameters of the substrate are saved inside the |biogas.substrate|
% object. It is a Level-1 M-file S-function represented by the 'Create
% daily hydrograph_mat' block. 
%
% The daily hydrograph consists of primary data measured in chemical lab
% analysis (among others):
%
% $$
% \begin{tabular}{lll}
% $cod$ & Chemical oxygen demand (total) & $\left[ \frac{g COD}{l} \right]$
% \\ 
% $tkn$ & Total Kjeldahl nitrogen & $\left[ \frac{g N}{l} \right]$ \\
% $p_{tot}$ & Total phosphorus & $\left[ \frac{g P}{m^3} \right]$
% \end{tabular}
% $$
%
% The volume flow $q(t)$ is read out of the file 
% 'volumeflow_|substrate_name|_ |volumeflow_type|.mat'. 
%
%%
% If you want to add noise to substrate params, do not do this in this
% function nor in simulink. Better before the start of the simulation edit
% the substrate xml file an load it again (should be done automatically at
% the start of the simulation, to be checked) 
%
%%
% Remarks:
%
% TKN consists of Ammonium + organic nitrogen (soluble + particulate).
%
% The TNb (total nitrogen) consists of Ammonium + nitrite + nitrate +
% organic nitrogen (soluble + particulate) 
%
% So TNb= TKN + nitrite + nitrate
%
%
%%
% @param |t| : current simulation time, double scalar, measured in days
%
%%
% @param |x| : state vector of the block at time t. Empty.
% actual state vector, here the empty vector [], since the model
% does not depend on a state
%
%%
% @param |u| : double scalar with the volumeflow of the substrate measured
% in m³/d. the input, here just a one-dimensional number not used, since
% the input comes from the structure |substrate|.
% If the datasource_type is |extern|, then u is the volumeflow $q(t)$.
%
%%
% @param |flag| : 
%
%   What is returned by SFUNC at a given point in time, T, depends on the
%   value of the FLAG, the current state vector, X, and the current
%   input vector, U.
%
%   FLAG   RESULT             DESCRIPTION
%   -----  ------             --------------------------------------------
%   0      [SIZES,X0,STR,TS]  Initialization, return system sizes in SYS,
%                             initial state in X0, state ordering strings
%                             in STR, and sample times in TS.
%   1      DX                 Return continuous state derivatives in SYS.
%   2      DS                 Update discrete states SYS = X(n+1)
%   3      Y                  Return outputs in SYS.
%   4      TNEXT              Return next time hit for variable step sample
%                             time in SYS.
%   5                         Reserved for future (root finding).
%   9      []                 Termination, perform any cleanup SYS=[].
%
%%
% @param |volumeflow_type| : char or cell defining the type of volumeflow
% $q(t)$, e.g. const, random, etc.. 
% The available types are defined in the MAT-file |volumeflowtypes.mat|.
%
%%
% @param |substrate_name| : char or cell with the id of the substrate, for
% which the ADM1 stream is created. Given ID must be defined in object
% |substrate|. 
%
%% <<substrate/>>
%%
% @param |appendDATA| : appendDATA flag of the 'Biogas Plant Modeling' toolbox. At the
% moment it is not used, but could be used to extend the sensor, while the
% simulation model is simulated in appendDATA mode (ADM1 gui's are then shown).
%
% * 0 : appendDATA mode is off
% * 1 : appendDATA mode is on
%
%%
% @param |datasource_type| : type of source for the volumeflow $q(t)$, e.g.
% file, workspace, modelworkspace, etc. The available types of datasources
% are defined in the MAT-File 'datasourcetypes.mat'
%
%%
% @return : see the MATLAB documentation
% 
%% Example
%
%
%% Dependencies
% 
% This function calls:
%
% -
%
% and is called by:
%
% (conv_primarydata2adm1xp_mat block in library)
%
%% See Also
% 
% <html>
% <a href="config_substrate_mixer_digester.html">
% config_substrate_mixer_digester</a>
% </html>
%
%% TODOs
% # solve the TODO inside the script regarding futterkalk
% # check links to pdfs
% # if there is a new ADM model, then you have to call a different method
% here instead of |biogas.ADMstate.calcADMstream|
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Copp, J.B.; Jeppsson, U. and Rosen, C.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\03 Towards an ASM1-ADM1 state variable interface for plant-wide WWT modeling.pdf'', 
% biogas_blocks.getHelpPath())'))">
% Towards an ASM1-ADM1 State Variable Interface for Plant-Wide Wastewater Treatment Modeling</a>, 
% in Proceedings of the Water Environment Federation, WEFTEC 2003: Session
% 51 through Session 60, pp. 498-510(13), 2003. 
% </li>
% <li> 
% Nopens, I., Batstone, D.J., Copp, J.B., Jeppsson, U., Volcke, E., Alex,
% J. and Vanrolleghem, P.A.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\09 An ASM ADM model interface for dynamic plant-wide simulation.pdf'', 
% biogas_blocks.getHelpPath())'))">
% An ASM/ADM model interface for dynamic plant-wide simulation</a>, 
% in Water Research, 43:1919-1923, 2009.
% </li>
% <li> 
% Zaher, U.; Li, R.; Jeppsson, U.; Steyer, J.-P.; Chen S.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\09 GISCOD - General Integrated Solid Waste Co-Digestion model.pdf'', 
% biogas_blocks.getHelpPath())'))">
% GISCOD: General Integrated Solid Waste Co-Digestion model</a>, 
% in Water Research, 43:2717-2727, 2009.
% </li>
% </ol>
% </html>
%


