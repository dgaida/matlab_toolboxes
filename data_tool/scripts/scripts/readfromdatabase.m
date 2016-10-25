%% readfromdatabase
% Reads last written data from a table of a database
%
function [data]= readfromdatabase(database_name, table_name, varargin)
%% Release: 1.6

%%

error( nargchk(2, 11, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

% number of rows to be read out of the table, default all rows are read
if nargin >= 3 && ~isempty(varargin{1}), 
  nRows= varargin{1}; 
else
  nRows= Inf; 
end

if nargin >= 4 && ~isempty(varargin{2}), 
  postgresql= varargin{2}; 
else
  postgresql= 1; 
end

% the data is sorted with respect to the first column, either descending or
% ascending
if nargin >= 5 && ~isempty(varargin{3}), 
  sorted= varargin{3}; 
else
  sorted= 'DESC'; %'ASC'
end

if nargin >= 6 && ~isempty(varargin{4}), 
  user= varargin{4}; 
  
  checkArgument(user, 'user', 'char', 6);
else
  if postgresql
    user= 'gecouser';
  else
    user= '';
  end
end

if nargin >= 7 && ~isempty(varargin{5}), 
  password= varargin{5}; 
  
  checkArgument(password, 'password', 'char', 7);
else
  if postgresql
    password= 'geco';
  else
    password= '';
  end
end

% column index that is read from the table, default all columns are read,
% can slo be a range of numbers: 1:3
if nargin >= 8 && ~isempty(varargin{6}), 
  col_ind= varargin{6}; 
else
  col_ind= Inf; 
end

if nargin >= 9 && ~isempty(varargin{7}), 
  startDate= varargin{7}; 
  
  checkArgument(startDate, 'startDate', 'char', 9);
else
  startDate= []; %
end

if nargin >= 10 && ~isempty(varargin{8}), 
  endDate= varargin{8}; 
  
  checkArgument(endDate, 'endDate', 'char', 10);
else
  endDate= []; %
end

if nargin >= 11 && ~isempty(varargin{9}), 
  eachNth= varargin{9}; 
  
  isN(eachNth, 'eachNth', 11);
else
  eachNth= 0; 
end


%%
% check input parameters

checkArgument(database_name, 'database_name', 'char', '1st');
checkArgument(table_name, 'table_name', 'char', '2nd');

if ~isinf(nRows)
  validateattributes(nRows, {'double'}, ...
                     {'scalar', 'positive', 'integer', '>=', 1}, ...
                     mfilename, 'nRows', 3);
end

is0or1(postgresql, 'postgresql', 4);

validatestring(sorted, {'DESC', 'ASC'}, ...
               mfilename, 'sorted', 5);
           
if ~isinf(col_ind)
  validateattributes(col_ind, {'double'}, ...
                     {'vector', 'positive', 'integer', '>=', 1}, ...
                     mfilename, 'col_ind', 8);
end
                 
%%

if ( ...
     ( strcmp(mexext, 'mexw32') || (postgresql == 1) ) ...
                                && ...
       existMPfile('database') ...
   )
  
  %%
  
  try

    %%
    
    if (postgresql == 1)
      %% TODO
      % password und nutzer sind fix
      % Connection to database with name, password
      dbconn= database(database_name, user, password, ...
                       'org.postgresql.Driver', ...
                       'jdbc:postgresql://localhost/');  
    else
      % Connection to database with name, password
      dbconn= database(database_name, user, password);  
    end

    %%
    % read metainformation to find number of tables
%         dbmeta= dmd(dbconn);        
%         % present catalog information - read storage location and save it
%         cata= get(dbconn, 'Catalog');           
%         % read table names and amount
%         t= tables(dbmeta, cata);  
%         % save number of existing tables
%         tabellen_anzahl= size(t,1);    

    %%
    % get names of columns

    sql= ['SELECT * FROM ', table_name, ' LIMIT 2'];
    mycursor= exec(dbconn, sql);
    
    if isa(mycursor, 'cursor')
      mycursor= fetch(mycursor, 2);   % just get two rows
    else
      disp('dbconn: ');
      disp(dbconn);
      disp('dbconn.Message: ');
      disp(dbconn.Message);
      disp('mycursor: ');
      disp(mycursor);
      warning('database:connect', 'An error occurred!');
      mycursor= fetch(mycursor);    % will throw an error
    end
    
    fieldString=  columnnames(mycursor);
    fieldString=  strrep(fieldString, '''', '');
    
    if ~isempty(fieldString)
     fieldStrings= regexp(fieldString, ',', 'split');
    else
      error('fieldString is empty!');
    end
    

    %%
    % all columns are read out of the table
    % but it is assumed that in the first column the date/timestamp
    % resp. the primary key of the table is written in, the stuff is
    % returned sorted

    data= [];

    dateString= [];
    
    if ~isempty(startDate)
      dateString= sprintf(' WHERE date >= ''%s''', startDate);
      
      if ~isempty(endDate)
        dateString= sprintf('%s AND date <= ''%s''', dateString, endDate);
      end
    else
      if ~isempty(endDate)
        dateString= sprintf(' WHERE date <= ''%s''', endDate);
      end
    end
    
    if isinf(col_ind)
      col_ind= 1:numel(fieldStrings);  
    end
    
    if ~isinf(nRows)
      myLimit= [' LIMIT ', sprintf('%i', nRows)];
    else
      myLimit=[];
    end
    
    for icol= col_ind

      if eachNth > 0
        myCommand= ['SELECT t.* FROM ( SELECT ', char(fieldStrings(icol)), ...
                    ', row_number() OVER(ORDER BY ', char(fieldStrings(1)), ...
                    ' ', sorted, ') AS row FROM ', table_name, dateString, ...
                    myLimit, ') t WHERE t.row % ', sprintf('%i', eachNth), ' = 0'];
      else
        myCommand= ['SELECT ', char(fieldStrings(icol)), ' FROM ', ...
                table_name, dateString, ' ORDER BY ', char(fieldStrings(1)), ...
                ' ', sorted, myLimit];
      end
      
      curs= exec(dbconn, myCommand);

      cursorA= fetch(curs, nRows); 

      % the eachNth option returns a second column with the row number
      if size(cursorA.Data,2) > 1   
        cursorA.Data= cursorA.Data(:,1);
      end
      
      data= [data, cursorA.Data];

    end

  catch ME
    
    rethrow(ME);

  end
     
else
    
  if ( ~strcmp(mexext, 'mexw32') && ~(postgresql == 1) )
    warning('database:err', ['You cannot access an ODBC database on a 64 bit system! ', ...
            'Either use postgreSQL or change to a 32 bit system.']);
  end
  
  if ~existMPfile('database')
    warning('database:err', ['database function is missing! ', ...
            'Maybe the commercial MATLAB Database Toolbox is not installed!']);
  end
  
  data= [];
    
end


%%


