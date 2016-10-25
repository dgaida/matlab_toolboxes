%% writeInCSV
% Write data in CSV file
%
function wasSuccessful= writeInCSV(database_name, data, ...
                                   table_headline, varargin)
%% Release: 1.8

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1})
  sheet_name= varargin{1};
else
  sheet_name= [];
end

%%

checkArgument(database_name,  'database_name',  'char',    '1st');
checkArgument(data,           'data',           'double',  '2nd');
checkArgument(table_headline, 'table_headline', 'cellstr', '3rd');
checkArgument(sheet_name,     'sheet_name',     'char',    '4th', 'on');

if numel(data) ~= numel(table_headline)
  error(['The two parameters data and table_headline must be of ', ...
         'the same dimension: %i ~= %i!'], numel(data), numel(table_headline));
end

%%

wasSuccessful= 0;

%%

if exist('csvwrite', 'file') == 2 && exist('csvread', 'file') == 2

  %%

  if ~exist([ database_name, '.csv' ], 'file')

    %%

    try

      %%
      % save data array
      csvwrite( [database_name, '.csv'], data );

      disp(['Successfully written to csv file ', database_name, '!']);

      wasSuccessful= 1;
    
    catch ME
      warning('csvwrite:error', 'Could not write to csv file: %s! %s', ...
              [database_name, '.csv'], ME.message);
    end

    %%
    
    try
      % additionally save table_headline in first row of an excel file
      if ~isempty(sheet_name)
        xlswrite( [database_name, '.xls'], table_headline, sheet_name ); 
      else
        xlswrite( [database_name, '.xls'], table_headline ); 
      end
    catch ME2
      warning('csvwrite:error', ...
              'Could not write header to xls file: %s! %s', ...
              [database_name, '.xls'], ME2.message);
    end

    %%

  else

    %% 
    % read in existing data
    
    num= csvread( [database_name, '.csv'] );

    %%

    try

      if size(num, 2) == size(data, 2)
        % append data array to the existing data array
        csvwrite( [database_name,'.csv'] , [num; data] );
      else
        csvwrite( [database_name,'.csv'] , data );
      end

      disp(['Successfully written to csv file ' database_name, '!']);

      wasSuccessful= 1;
      
    catch ME

      warning('csvwrite:error', ...
              'Could not write to csv file: %s! %s', ...
              [database_name, '.csv'], ME.message);
      
    end

  end % end if

  %%

else
  
  error(['The functions <a href="matlab:doc(''csvwrite'')">csvwrite</a>', ...
         ' and/or <a href="matlab:doc(''csvread'')">csvread</a> do not exist!']);
  
end % end if

%%


