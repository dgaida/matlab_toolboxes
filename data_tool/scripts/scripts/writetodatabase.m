%% writetodatabase
% Write data returned by a fitness function into a ODCB database.
%
function errflag= ...
        writetodatabase(database_name, networkFluxString, networkFlux, ...
                        plant, substrate, fitness_params, fitness_function, ...
                        varargin)
%% Release: 1.0

error( nargchk(7, 14, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 8 && ~isempty(varargin{1}), 
  writeDatum= varargin{1}; 
  
  is0or1(writeDatum, 'writeDatum', 8);
else
  writeDatum= 1; 
end

%%

if nargin >= 9 && ~isempty(varargin{2}), 
  appendData= varargin{2}; 
  
  is0or1(appendData, 'appendData', 9);
else
  appendData= 1; 
end

%%

if nargin >= 10 && ~isempty(varargin{3}), 
  postgresql= varargin{3}; 
  
  is0or1(postgresql, 'postgresql', 10);
else
  postgresql= 1; 
end

%%

if nargin >= 11 && ~isempty(varargin{4}), 
  writetodb= varargin{4}; 
  
  is0or1(writetodb, 'writetodb', 11);
else
  writetodb= 0; 
end

if nargin >= 12 && ~isempty(varargin{5}), 
  sensors= varargin{5}; 
  
  %% TODO
  % check argument
else
  sensors= []; 
end

if nargin >= 13 && ~isempty(varargin{6}), 
  use_history= varargin{6}; 
  is0or1(use_history, 'use_history', 13);
else
  use_history= 0; 
end

if nargin >= 14 && ~isempty(varargin{7}), 
  init_substrate_feed= varargin{7}; 
  
  %% TODO
  % check argument
else
  init_substrate_feed= []; 
end


%%
% Check Excel Service
% If Excel is not installed warning off

if ( ( strcmp(mexext, 'mexw32') || (postgresql == 1) ) && ...
   exist('database', 'file') == 2 )

else

  xls_service= 'true';

  try
    exl = actxserver('excel.application');
    exl.Quit;
    exl.delete;
  catch me
    if strcmp( me.identifier, 'MATLAB:COM:InvalidProgid')
       warning off MATLAB:xlswrite:NoCOMServer
       xls_service = 'false';
    else
       warning on MATLAB:xlswrite:NoCOMServer
       xls_service = 'true';
    end
  end

end


%%
%
errflag= 1; 

%%
% check input parameters

checkArgument(database_name, 'database_name', 'char', '1st');

if size(networkFlux) ~= size(networkFluxString)
  error('size(networkFlux) ~= size(networkFluxString)!');
end

%%

if ~isempty(plant)
  is_plant(plant, 4);
else
  warning('parameter plant is empty!');   
end

%%

if ~isempty(substrate)
  is_substrate(substrate, 5);
else
  warning('parameter substrate is empty!');
end

%%

if ~isempty(fitness_params)
  is_fitness_params(fitness_params, 6);
else
  warning('parameter fitness_params is empty!');
end

%%

if ~isempty(fitness_function)
  checkArgument(fitness_function, 'fitness_function', 'function_handle', 7);
else
  warning('parameter fitness_function is empty!');
end


%%        
% save fitness and individual to database

if ~isempty(fitness_function) && ~isempty(substrate) && ...
   ~isempty(plant) && ~isempty(fitness_params)
  % get the data returned by the specified fitness function
  [fitness, data, data_string]= ...
      feval( fitness_function, plant, substrate, fitness_params );

  %% TODO
  % evtl. anders lösen
  
  [fitness, udotnorm, xdotnorm]= ...
    getRecordedFitnessExtended(sensors, substrate, plant, [], [], ...
                               fitness_params, use_history, init_substrate_feed);
  
else
  fitness= [];
  udotnorm= [];
  xdotnorm= [];
  data= [];
  data_string= [];
end

%%

networkFluxString= regexprep(networkFluxString, '->', '_');

fitness_string= [];

for ival= 1:numel(udotnorm)
  fitness_string= [fitness_string, {'udotnorm'}];
end
for ival= 1:numel(xdotnorm)
  fitness_string= [fitness_string, {'xdotnorm'}];
end
for ival= 1:numel(fitness)
  fitness_string= [fitness_string, {sprintf('fitness_%i', ival)}];
end
%% TODO
% verallgemeinern für andere MO dimensionen
if numel(fitness) > 1 % thats the merged fitness
  fitness_string= [fitness_string, {'fitness_final'}];
end

%%
% delete duplicates in data_string and then also in data
% see also deleteDuplicates function

[junk, index]= unique(data_string, 'first');
data_string= data_string(sort(index));
data= data(sort(index));

%%

table_headline= [networkFluxString, data_string, fitness_string];

%%

len_table= numel(table_headline);

% generates valid matlab identifier
table_headline= genvarname(table_headline);

if (len_table ~= numel(table_headline))
  error('length of table_headline has changed calling genvarname! %i ~= %i', ...
        len_table, numel(table_headline));
end

%%

data= [networkFlux, data, udotnorm, xdotnorm, fitness];

%% TODO
% verallgemeinern für andere MO dimensionen
if numel(fitness) > 1
  % calculate merged fitness
  data= [data, fitness_params.myWeights.w_money * fitness(1) + sum(fitness(2:end))];
end

%%

if writeDatum == 1

  Datum= m2xdate(now);
  data= [Datum, data];

  table_headline= [{'Datum'}, table_headline];

end


% write to db or excel or only to mat file
if ( writetodb == 1 )

  % matlab 32 bit installed
  % and the database toolbox?
  if ( ( strcmp(mexext, 'mexw32') || (postgresql == 1) ) && ...
       exist('database', 'file') == 2 )

    %%
    
    writeInDatabase(database_name, data, table_header, table_headline, ...
                    postgresql, writeDatum);
    
    %%

  else  
    %%
    % write in excel file

    try

      writeInXLS(database_name, data, table_headline, xls_service);

    catch ME
      %         
      %warning('Could not write to Excel file!');

      %%

      writeInCSV(database_name, data, table_headline, 'Substrate_mixture');

      %% 
    end % end try

  end % 

end % writetodb == 1

%%

writeInDataset(database_name, data, table_headline, appendData);


%%

errflag= 0;

%% Warning ON No Excel Server
warning on MATLAB:xlswrite:NoCOMServer

%%


