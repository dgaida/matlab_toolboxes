%% writeInDatabase
% Write data in a database
%
function writeInDatabase(database_name, table_name, data, table_headline, varargin)
%% Release: 0.9

%%

error( nargchk(4, 6, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(database_name, 'database_name', 'char', '1st');
checkArgument(table_name, 'table_name', 'char', '2nd');
isRn(data, 'data', 3);
checkArgument(table_headline, 'table_headline', 'cellstr', '4th');

%%

if nargin >= 5 && ~isempty(varargin{1})
  postgresql= varargin{1};
  is0or1(postgresql, 'postgresql', 5);
else
  postgresql= 1;
end

if nargin >= 6 && ~isempty(varargin{2})
  writeDatum= varargin{2};
  is0or1(writeDatum, 'writeDatum', 6);
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
    %% TODO: is only going to work with geco password
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
    %% TODO
    % that is a strange if clause! I do not know how to proove whether a
    % table already exists. In postgreSQL there seem to be 253 default
    % tables and in MS SQL 9, so I check these numbers to test whether
    % there is any table in the database
    if ( tabellen_anzahl <=   9 && postgresql == 0 ) || ...
       ( tabellen_anzahl <= 253 && postgresql == 1 )    

      %%

      if (postgresql == 0)
        % MS SQL
        curs= exec(dbconn, ['CREATE TABLE ', table_name, ' ( Datum DATETIME, ' ...
                                          table_header ' );']);
      else
        % PostgreSQL
        curs= exec(dbconn, ['CREATE TABLE ', table_name, ' ( Datum TIMESTAMP, ' ...
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
    %% TODO: what happens for MS SQL? the same? does it not?
    if ( postgresql == 1 )
      % here the first column of data is replaced by a string with the
      % current date/time. So, the first column of data is deleted!!!
      %% TODO: what is the reason of deleting 1st column???
      
      % data ändern

      dataTemp= data;

      data= {datestr(now)};

      % alternative: mat2cell(data,1,ones(1,numel(data))
      %for idata= 2:numel(dataTemp)
      for idata= 1:numel(dataTemp)
        data= [data, {dataTemp(idata)}];
      end

      % add date as first column
      table_headline= [{'Datum'}, table_headline];

    end

    %%

    try
      % try to insert data in given table
      insert(dbconn, table_name, table_headline, data);
    catch ME1

      try
        % I cannot write into table. reason could be that it has a
        % different number of columns or that it does not exist. In any
        % case first delete the table (if existent) and then create table
        % anew. 
        % delete table
        curs= exec(dbconn, ['DROP TABLE ', table_name, ';']);

        if (postgresql == 0)
          curs= exec(dbconn, ...
             ['CREATE TABLE ', table_name, ' ( Datum DATETIME, ' ...
                                            table_header ' );']);
        else
          curs= exec(dbconn, ...
             ['CREATE TABLE ', table_name, ' ( Datum TIMESTAMP, ' ...
                                            table_header ' );']);
        end

        insert(dbconn, table_name, table_headline, data);
      catch ME
        ME= addCause(ME1, ME);

        rethrow(ME);
      end

    end

  else % writeDatum == 0

    %%

    if ( tabellen_anzahl <=   9 && postgresql == 0 ) || ...
       ( tabellen_anzahl <= 253 && postgresql == 1 )   
      curs= exec(dbconn, ['CREATE TABLE ', table_name, ' ( ' table_header ' );']);
    end

    %%

    try
      fastinsert(dbconn, table_name, table_headline, data);
    catch ME1

      try
        % delete table
        curs= exec(dbconn, ['DROP TABLE ', table_name, ';']);

        curs= exec(dbconn, ['CREATE TABLE ', table_name, ' ( ' table_header ' );']);

        fastinsert(dbconn, table_name, table_headline, data);
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
  disp(['Could not write to database ' database_name, '. Error Message is: ', ME.message]);

end

%%


