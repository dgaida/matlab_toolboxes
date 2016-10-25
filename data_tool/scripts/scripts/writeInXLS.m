%% writeInXLS
% Write data in xls file
%
function wasSuccessful= writeInXLS(database_name, data, ...
                                   table_headline, xls_service, varargin)
%% Release: 1.2

%%

error( nargchk(4, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1})
  sheet_name= varargin{1};
  
  checkArgument(sheet_name, 'sheet_name', 'char', 5);
else
  sheet_name= 'Substrate_mixture';
end

%%

checkArgument(database_name,  'database_name',  'char',    '1st');
checkArgument(data,           'data',           'double',  '2nd');
checkArgument(table_headline, 'table_headline', 'cellstr', '3rd');

validatestring(xls_service, {'true', 'false'}, ...
               mfilename, 'xls_service', 4);

%%

wasSuccessful= 0;

%%
% creation of database_name.xls file

if ~exist( [ database_name, '.xls' ], 'file')

  % Warning off for creation of xls file
  warning off MATLAB:xlswrite:AddSheet

  %%
  
  try             
    % save table_headline in first row
    xlswrite( [ database_name, '.xls'], table_headline, sheet_name, 'A1'); 
 
    % save data array in the 2nd row
    xlswrite( [ database_name, '.xls'], data, sheet_name, 'A2');
  catch ME
    warning('xlswrite:error', 'Could not write in Excel file: %s! %s', ...
            [database_name, '.xls'], ME.message);
  end
  
  %% TODO
  % was soll das hier???
  % If the file is not written
  % Warning OFF
  if strcmp( xls_service, 'false' )
      disp(['Warning: Could not write to excel file ' database_name, ...
            '; Excel might not be intalled']);
  else
      disp(['Successfully written to excel file ' database_name]);
      
      wasSuccessful= 1;
  end

else
  
  %%
  % Catch Spread Sheet name if modified
  [ typ, sheet_names ]= xlsfinfo( [ database_name, '.xls' ] ); 

  %%
  % worksheets name is empty sometimes for unkown reason
  if ~isempty( sheet_names )
    % get 4th worksheets name; due to the created sheet_name is in the 4th worksheet
    % tabelle 1,2,3 sind davor
    if numel(sheet_names) >= 4
      sheet_name= sheet_names{4}; 
    end
  end


  %% 
  % Check number of rows in the database_name.xls

  try

    currentFolder= pwd; % current folder
    file_name= [currentFolder, '\', database_name, '.xls']; % path and file name

    % Starts the excel service application
    exl= actxserver('excel.application');
    exlWkbk= exl.Workbooks;
    exlFile= exlWkbk.Open( file_name );
    exlSheet1= exlFile.Sheets.Item( sheet_name );
    robj= exlSheet1.Columns.End(4);       % Find the end of the column
    numrows= robj.row;                    % And determine what row it is

    % Save value directly in Spread Sheet
%         dat_range = ['A', num2str(numrows), ':CE', num2str(numrows)]; % write to the last row
%         rngObj = exlSheet1.Range(dat_range);
%         exlData = rngObj.Value;
%         rngObj.Value= data % i.e. { 1 2 4 5 };

    % Closes the excel service application
    %exlFile.Save;
    exlFile.Close
    exlWkbk.Close
    exl.Quit
    exl.delete;

  catch ME
    
    disp(ME.message);

    num= xlsread( [ database_name,'.xls'], sheet_name );

    % titelzeile wird nicht eingelesen, deshalb + 1
    % because num doesn't contain the header line i add +1 the
    % first time
    numrows= size(num, 1) + 1;

    % 0 basiert
    %numrows= size(num, 1) - 1;

  end

  numrows= numrows + 1;

  %%

  try

    % save data array in the 'numrows' row
    xlswrite( [ database_name,'.xls'] , data, sheet_name, ['A', num2str(numrows)] );

    %%
    
    if strcmp( xls_service, 'false' )
      disp(['Warning: Could not write to excel file ' database_name, ...
            '; excel might not be intalled']);
    else
      disp(['Successfully written to excel file ' database_name]);
      
      wasSuccessful= 1;
    end
         
  catch ME
         
    warning('xlswrite:error', 'Could not write to Excel file!');
    rethrow(ME);
             
  end

  %%

end

%%


