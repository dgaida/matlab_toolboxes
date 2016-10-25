%% writeInDatabase
% Write data in a database
%
function writeInDatabase(database_name, data, table_headline, varargin)
%% Release: 1.3

%%

error( nargchk(3, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(database_name, 'database_name', 'char', '1st');
isRn(data, 'data', 2);
checkArgument(table_headline, 'table_headline', 'cellstr', '3rd');

%%

if nargin >= 4 && ~isempty(varargin{1})
  postgresql= varargin{1};
  is0or1(postgresql, 'postgresql', 4);
else
  postgresql= 1;
end

if nargin >= 5 && ~isempty(varargin{2})
  writeDatum= varargin{2};
  is0or1(writeDatum, 'writeDatum', 5);
else
  writeDatum= 1;
end

%%
% create the header of the table

table_headline_char= char(table_headline);

table_header= '';

for istring= 1:size(table_headline_char,1)

  table_header= [table_header, deblank( table_headline_char(istring, :) ), ' FLOAT, '];

end

table_header= table_header(1,1:end - 2);

clear table_headline_char;

%%
% open database to save values

try

  %%

  if (postgresql == 1)
    % Connection to database with name, password
    dbconn= database(database_name, 'gecouser', 'geco', ...
                     'org.postgresql.Driver', 'jdbc:postgresql://localhost/');  
  else
    % Connection to database with name, password
    dbconn= database(database_name, '', '');  
  end

  %%
  % read metainformation to find number of tables
  dbmeta= dmd(dbconn);        
  % present catalog information - read storage location and save it
  cata= get(dbconn, 'Catalog');           
  % read table names and amount
  t= tables(dbmeta, cata);     
  tabellen_anzahl= size(t,1);     % save number of existing tables

  %%
  
  if writeDatum == 1

    %%

    if ( tabellen_anzahl <=   9 && postgresql == 0 ) || ...
       ( tabellen_anzahl <= 253 && postgresql == 1 )    

      %%

      if (postgresql == 0)
        curs= exec(dbconn, ['CREATE TABLE Substrate_mixture ( Datum DATETIME, ' ...
                                          table_header ' );']);
      else
        curs= exec(dbconn, ['CREATE TABLE Substrate_mixture ( Datum TIMESTAMP, ' ...
                                          table_header ' );']);
      end

    %else
    end

    %else

%         curs= exec(dbconn, ...
%                 ['SELECT COUNT(1) FROM Substrate_mixture']);
%       
%         if (1)
%             curs= exec(dbconn, ...
%                     ['CREATE TABLE ', table_name, ... 
%                      ' ( Datum DATETIME, ' ...
%                     table_header ' );']);
%         end

     %   curs= exec(dbconn, ...
      %      ['SELECT COUNT(*) AS Anzahl FROM Substrate_mixture']);

    %end

    %%

    if ( postgresql == 1 )

      % data ändern

      dataTemp= data;

      data= {datestr(now)};

      % alternative: mat2cell(data,1,ones(1,numel(data))
      for idata= 2:numel(dataTemp)
        data= [data, {dataTemp(idata)}];
      end

    end

    %%

    try
      insert(dbconn, 'Substrate_mixture', table_headline, data);
    catch ME1

      try
        % delete table
        curs= exec(dbconn, ['DROP TABLE Substrate_mixture;']);

        if (postgresql == 0)
          curs= exec(dbconn, ...
             ['CREATE TABLE Substrate_mixture ( Datum DATETIME, ' ...
                                            table_header ' );']);
        else
          curs= exec(dbconn, ...
             ['CREATE TABLE Substrate_mixture ( Datum TIMESTAMP, ' ...
                                            table_header ' );']);
        end

        insert(dbconn, 'Substrate_mixture', table_headline, data);
      catch ME
        ME= addCause(ME1, ME);

        rethrow(ME);
      end

    end

  else

    %%

    if ( tabellen_anzahl <=   9 && postgresql == 0 ) || ...
       ( tabellen_anzahl <= 253 && postgresql == 1 )   
      curs= exec(dbconn, ['CREATE TABLE Substrate_mixture ( ' table_header ' );']);
    end

    %%

    try
      fastinsert(dbconn, 'Substrate_mixture', table_headline, data);
    catch ME1

      try
        % delete table
        curs= exec(dbconn, ['DROP TABLE Substrate_mixture;']);

        curs= exec(dbconn, ['CREATE TABLE Substrate_mixture ( ' table_header ' );']);

        fastinsert(dbconn, 'Substrate_mixture', table_headline, data);
      catch ME
        ME= addCause(ME1, ME);

        rethrow(ME);
      end

    end

  end

  disp(['Successfully written to database ' database_name]);

  close (dbconn);

catch ME

  % evtl. probleme eine freie lizenz zu bekommen für
  % database toolbox, es gibt nur 2 an der fh
  disp(['Could not write to database ' database_name]);

end

%%


