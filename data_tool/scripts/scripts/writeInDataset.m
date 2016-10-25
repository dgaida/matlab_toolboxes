%% writeInDataset
% Write data in dataset named |database_name|
%
function dataAnalysis= writeInDataset(database_name, data, ...
                                      table_headline, varargin)
%% Release: 1.4

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1}), 
  appendData= varargin{1}; 
else
  appendData= 1; 
end

%%
% check input parameters

checkArgument(database_name,  'database_name',  'char',    '1st');
checkArgument(data,           'data',           'double',  '2nd');
checkArgument(table_headline, 'table_headline', 'cellstr', '3rd');

if numel(data) ~= numel(table_headline)
  error(['The two parameters data and table_headline must be of ', ...
         'the same dimension: %i ~= %i!'], numel(data), numel(table_headline));
end

is0or1(appendData, 'appendData', 4);

%%

if exist('dataset', 'file') == 2

  %%
  
  try
    %% TODO
    % better do not use load_file
    dataAnalysis= load_file(database_name);
  catch ME
    dataAnalysis= [];
    ME.message;
  end

  %%
  
  datas= dataset( {data(1), char(table_headline{1})} );

  %%
  
  for idb= 2:size(data,2)
    dbtemp= dataset( {data(idb), char(table_headline{idb})} );

    try
      datas= horzcat(datas, dbtemp);
    catch ME
      rethrow(ME);
    end
  end

  %%
  
  if ~isempty(dataAnalysis) && ...
     ( size(dataAnalysis, 2) == size(datas, 2) ) && ...
     appendData
   try
      dataAnalysis= vertcat(dataAnalysis, datas);
   catch ME
      dataAnalysis= datas;

      ME.message;
   end
  else
    % overwrite dataAnalysis with new dataset
    dataAnalysis= datas;
  end

  %%
  
  save(database_name, 'dataAnalysis');

  %%
  
end

%%


