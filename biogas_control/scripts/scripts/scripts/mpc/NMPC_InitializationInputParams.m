%% NMPC_InitializationInputParams
% Initialize the input parameters for the |startNMPC| function
%
function varargout= NMPC_InitializationInputParams(varargin)
%% Release: 1.6

%%

error( nargchk(0, 26, nargin, 'struct') );
error( nargoutchk(0, 26, nargout, 'struct') );

%% 
% INITIALIZATION
% read out varargin

%plant_id -> Plant name i.e. 'sunderhook'
if nargin >= 1 && ~isempty(varargin{1}), 
  plant_id= varargin{1}; 
  checkArgument(plant_id, 'plant_id', 'char || cell', '1st');
  plant_id= char(plant_id);
else
  plant_id= 'gummersbach'; 
  dispMessage('Attention: set plant_id to gummersbach', mfilename);
end

% method -> Optimization algorithm
if nargin >= 2 && ~isempty(varargin{2}), 
  method= varargin{2}; 
  checkArgument(method, 'method', 'char || cell', '2nd');
  method= char(method);
else
  method= 'CMAES';
end

% change_type -> type of nmpc step increment: 'absolute' || 'percentual'
if nargin >= 3 && ~isempty(varargin{3}), 
  change_type= varargin{3}; 
  validatestring(change_type, {'percentual', 'absolute'}, ...
                 mfilename, 'change_type', 3);
else
  change_type= 'percentual'; 
end

% change -> Percentage value for boundaries = 10%
if nargin >= 4 && ~isempty(varargin{4}), 
  change= varargin{4}; 
  checkArgument(change, 'change', 'double', 4);
else
  if strcmp(change_type, 'percentual') 
    change= 0.05; % [ 100 % ]
  elseif strcmp(change_type, 'absolute'),
    change= 1; % [ m^3/day ]           
  end
end

% N -> Number of days for NMPC
if nargin >= 5 && ~isempty(varargin{5}), 
  N= varargin{5}; 
  isN(N, 'N', 5);
else
  N= 15;
end

% timespan -> prediction time for NMPC -> @param findOptimalEquilibrium 
if nargin >= 6 && ~isempty(varargin{6}), 
  timespan= varargin{6}; 
  checkArgument(timespan, 'timespan', 'double', 6);
else
  timespan= 250;
end

% Control Horizon simulation time
if nargin >= 7 && ~isempty(varargin{7}), 
  control_horizon= varargin{7}; 
  isN(control_horizon, 'control_horizon', 7);
else
  control_horizon= 14;
end

% id where to read from
if nargin >= 8 && ~isempty(varargin{8}), 
  id_read= varargin{8}; 
  isN0(id_read, 'id_read', 8);
else
  id_read= [];
end

% id where to save
if nargin >= 9 && ~isempty(varargin{9}), 
  id_write= varargin{9}; 
  isN0(id_write, 'id_write', 9);
else
  id_write= 1;
end

% parallel -> clustering option for NMPC -> @param findOptimalEquilibrium 
if nargin >= 10 && ~isempty(varargin{10}), 
  parallel= varargin{10};
  validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 10);
else
  parallel= 'none';
end

% nWorker -> number of workers to run in parallel -> findOptimalEquilibrium param
if nargin >= 11 && ~isempty(varargin{11}), 
  nWorker= varargin{11};
  isN(nWorker, 'nWorker', 11);
else
  nWorker= 2;
end

% no parallel computing?
if strcmp(parallel, 'none'), 
  nWorker= 1; 
end

% pop_size -> @param findOptimalEquilibrium
if nargin >= 12 && ~isempty(varargin{12}), 
  pop_size= varargin{12}; 
  isN(pop_size, 'pop_size', 12);
else
  pop_size= 10;
end

% nGenerations -> @param findOptimalEquilibrium
if nargin >= 13 && ~isempty(varargin{13}),
  nGenerations= varargin{13}; 
  isN(nGenerations, 'nGenerations', 13);
else
  nGenerations= 10;
end

% OutputFcn -> @param findOptimalEquilibrium
if nargin >= 14 && ~isempty(varargin{14}), 
  OutputFcn= varargin{14}; 
  checkArgument(OutputFcn, 'OutputFcn', 'function_handle', 14, 'on');
else
  OutputFcn= [];
end

% useInitPop -> @param findOptimalEquilibrium
if nargin >= 15 && ~isempty(varargin{15}), 
  useInitPop= varargin{15}; 
  is0or1(useInitPop, 'useInitPop', 15);
else
  useInitPop= 0;
end

% broken_sim 
if nargin >= 16 && ~isempty(varargin{16}), 
  broken_sim= varargin{16}; 
  validatestring(broken_sim, {'true', 'false'}, mfilename, 'broken_sim', 16);
else
  broken_sim= 'false';
end

% delete_db 
if nargin >= 17 && ~isempty(varargin{17}), 
  delete_db= varargin{17}; 
  is_onoff(delete_db, 'delete_db', 17);
else
  delete_db= 'on';
end

% database_name
if nargin >= 18 && ~isempty(varargin{18}), 
  database_name= varargin{18}; 
  checkArgument(database_name, 'database_name', 'char || cell', 18);
  database_name= char(database_name);
else 
  database_name= ['equilibria_', plant_id]; 
end

% in case the simulation must restart then the database must not be
% deleted
if strcmp( broken_sim , 'true' ), delete_db = 'off'; end

if nargin >= 19 && ~isempty(varargin{19}), 
  trg= varargin{19}; 
  is_onoff(trg, 'trg', 19);
else
  trg= 'off';
end

if nargin >= 20 && ~isempty(varargin{20}), 
  trg_opt= varargin{20}; 
  checkArgument(trg_opt, 'trg_opt', 'double', 20);
else
  trg_opt= -Inf;
end

if nargin >= 21 && ~isempty(varargin{21}), 
  gui_opt= varargin{21}; 
  is_onoff(gui_opt, 'gui_opt', 21);
else
  gui_opt= 'off';
end

if nargin >= 22 && ~isempty(varargin{22}), 
  email= varargin{22}; 
  checkArgument(email, 'email', 'char || cell', 22);
  email= char(email);
else
  email= 'off';
end

if nargin >= 23 && ~isempty(varargin{23}), 
  delta= varargin{23}; 
  isR(delta, 'delta', 23, '+');
else
  % then we have one step control
  delta= control_horizon;   % days
end

if nargin >= 24 && ~isempty(varargin{24}), 
  use_real_plant= varargin{24}; 
  is0or1(use_real_plant, 'use_real_plant', 24);
else
  % control a simulation model
  use_real_plant= 0;   
end

if nargin >= 25 && ~isempty(varargin{25})
  use_history= varargin{25};
  
  is0or1(use_history, 'use_history', 25);
else
  use_history= 1; % default 0
end

if nargin >= 26 && ~isempty(varargin{26})
  soft_feed= varargin{26};
  
  is0or1(soft_feed, 'soft_feed', 26);
else
  soft_feed= 1; % default 0
end

%% 
% Delete equilibria_sunderhook.mat | equilibria_sunderhook.mdb
%  temporary solution to not append the results with previous simulations.
if strcmp( delete_db, 'on' ) 
  
  %%
  
  try
    % delete equilibria_sunderhook.mat
    database_name_mat= [database_name, '.mat'];
    
    if exist(database_name_mat, 'file')
      delete( database_name_mat );
    end
  catch ME
    rethrow(ME);
  end

  %%
  
  if ( strcmp(mexext, 'mexw32') && exist('database', 'file') == 2 )

    %%
    % open database to save values : equilibria_sunderhook.mdb

    % Connection to database with name, password
    dbconn= database(database_name, '', '');  
    % read metainformation to find number of tables
    dbmeta= dmd(dbconn);        
    % present catalog information - read storage location and save it
    cata= get(dbconn, 'Catalog');           
    % read table names and amount
    t= tables(dbmeta, cata);     
    tabellen_anzahl= size(t,1);     %#ok<NASGU> % save number of existing tables

    try
      % delete table
      curs= exec(dbconn, ['DROP TABLE Substrate_mixture;'] );  %#ok<NBRAK,NASGU>
    catch ME
      rethrow(ME);
    end

  end
  
elseif strcmp( delete_db, 'off') 
  warning ('NMPC:database', ...
           ['The data saving in "', database_name, '" will be appended'] );
else
  error( ['delete_db:  "', varargin{17}, '" is invalid!'] );
end


%% 
% OUTPUT
varargout= { plant_id, method, change_type, change, N, ...
             timespan, control_horizon, id_read, id_write, ...
             parallel, nWorker, pop_size, nGenerations, ...
             OutputFcn, useInitPop, broken_sim, delete_db, database_name, ...
             trg, trg_opt, gui_opt, email, delta, use_real_plant, ...
             use_history, soft_feed };

%%


