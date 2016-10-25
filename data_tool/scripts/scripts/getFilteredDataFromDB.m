%% getFilteredDataFromDB
% Returns data read out of a DB, which is filtered for outliers
%
function [data, varargout]= ...
                getFilteredDataFromDB(database_name, table_name, varargin)
%% Release: 1.6

%%

error( nargchk(0, 12, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check if obligate parameters are set

if ~exist('database_name', 'var')
   
  warning('database_name:usingDefault', ...
          'The first parameter database_name is not set. Using default value: sunderhook_database');
  database_name= 'sunderhook_database';

end

if ~exist('table_name', 'var')

  warning('table_name:usingDefault', ...
          'The second parameter table_name is not set. Using default value: nachgaerer_fermenter0');
  table_name= 'nachgaerer_fermenter0';

end


%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1}), 
  nRows= varargin{1}; 
else
  nRows= Inf; 
end

if nRows <= 2,
  error('nRows must be 3 or bigger to allow a detection of outliers: 1 out of 3');
end

if nargin >= 4 && ~isempty(varargin{2})
  numPerDay= varargin{2};
else
  numPerDay= 24; % [h/d] % 24*60 [min/d], 24*60*60 [sec/d]
end

if nargin >= 5 && ~isempty(varargin{3})
  window_size= varargin{3};
else
  window_size= 6; % measured in 24 h / ( |numPerDay| * [d/h] ), so per default 6 h.
end

if nargin >= 6 && ~isempty(varargin{4}), 
  postgresql= varargin{4}; 
else
  postgresql= 1; 
end

if nargin >= 7 && ~isempty(varargin{5}), 
  user= varargin{5}; 
  
  checkArgument(user, 'user', 'char', 7);
else
  if postgresql
    user= 'gecouser';
  else
    user= '';
  end
end

if nargin >= 8 && ~isempty(varargin{6}), 
  password= varargin{6}; 
  
  checkArgument(password, 'password', 'char', 8);
else
  if postgresql
    password= 'geco';
  else
    password= '';
  end
end

if nargin >= 9 && ~isempty(varargin{7}), 
  col_ind= varargin{7}; 
else
  col_ind= 1:2; 
end


%%
% check params

checkArgument(database_name, 'database_name', 'char', '1st');
checkArgument(table_name, 'table_name', 'char', '2nd');

if ~isinf(nRows)
  validateattributes(nRows, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'nRows', 3);
end

validateattributes(numPerDay, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'numPerDay', 4);
                   
validateattributes(window_size, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'window_size', 5);

is0or1(postgresql, 'postgresql', 6);
                 
validateattributes(col_ind, {'double'}, ...
                   {'vector', 'positive', 'integer'}, ...
                   mfilename, 'col_ind', 9);
                 
%%
% liest daten aus datenbank / Tabelle
% data ist ein cell

if nargin >= 10
  % additional arguments are start and end date
  [data]= readfromdatabase(database_name, table_name, nRows, postgresql, ...
                           'DESC', user, password, col_ind, varargin{8:end});
else
  [data]= readfromdatabase(database_name, table_name, nRows, postgresql, ...
                           'DESC', user, password, col_ind);
end

%%
% sucht outlier und ersetzt diese durch NANs, NANs wiederum werden durch
% diese funktion durch moving averages der umgebung ersetzt. damit ist
% data_ok hier schon komplett double.

data_ok= filterData(cell2mat(data(:,2)), [], [], 50);%ts_res.Data);


%%
% daten wieder in cell Struktur einfügen

%data(:,2)= mat2cell(data_ok, ones(numel(data_ok), 1), 1);
data(:,2)= num2cell(data_ok);


%%
% daten resamplen auf gegebenes zeitraster

ts_res= resampleDataTS(data, numPerDay);

data= ts_res.Data;


%%
% abschließend daten über ein moving average filter legen, fenster wird
% gemessen im zeitraster. hier werdenn noch mal alle daten über das filter
% gelegt. 

data= nanmoving_average(data, window_size, 1, 1);


%%
%

if nargout >= 2,
  varargout{1}= ts_res.Time;
else
  varargout{1}= [];
end


%%


