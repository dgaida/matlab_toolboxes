%% addNewRowInLatexTable
% Adds a row to a LaTeX table
%
function addNewRowInLatexTable(fid, row_data, row_type, table_flag, varargin)
%% Release: 1.1

%%

error( nargchk(4, 6, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 5 && ~isempty(varargin{1})
  table_header= varargin{1};
  checkArgument(table_header, 'table_header', 'cellstr', 5);
else
  table_header= [];
end

if nargin >= 6 && ~isempty(varargin{2})
  row_end= varargin{2};
  checkArgument(row_end, 'row_end', 'char', 6);
else
  row_end= '\\\\';
end

%% 
% check arguments

isN0(fid, 'fid', 1);
checkArgument(row_data, 'row_data', 'cell', '2nd');
checkArgument(row_type, 'row_type', 'cellstr', '3rd');
isZ(table_flag, 'table_flag', 4);

%%

n_cols= numel(row_data);

%%

checkDimensionOfVariable(row_type(:), [n_cols, 1]);

if ~isempty(table_header)
  checkDimensionOfVariable(table_header(:), [n_cols, 1]);
end

%%

if table_flag == 1

  %%
  
  alignment= [];

  for icol= 1:n_cols      % alignment of all columns is left
    alignment= [alignment, 'l'];
  end

  %fprintf(fid, ['\\begin{tabular}{', alignment, '}\r\n\\hline \r\n']);
  fprintf(fid, ['\\begin{tabular}{', alignment, '}\r\n\\toprule \r\n']);

  %%
  
  if ~isempty(table_header)

    row_content= [];

    for icol= 1:n_cols - 1

      row_content= sprintf('%s\\\\textbf{%s} & ', row_content, table_header{icol});

    end

    row_content= sprintf(...
        '%s\\\\textbf{%s} \\\\\\\\ \r\n\\\\hline\\\\\\\\\r\n', ...
                     row_content, table_header{end});

    fprintf(fid, row_content);

  end

end

%%

row_content= [];

for icol= 1:n_cols - 1

  data= row_data{icol};

  data= parseLatex(data);

  row_content= sprintf(['%s', row_type{icol}, ' & '], row_content, data);

end

data= row_data{end};

data= parseLatex(data);

row_content= sprintf(['%s', row_type{end}, ' %s\r\n'], ...
               row_content, data, row_end);

fprintf(fid, row_content);


%%

if table_flag == 2

  %fprintf(fid, '\\hline\r\n\\end{tabular}\r\n');
  fprintf(fid, '\\bottomrule\r\n\\end{tabular}\r\n');

end



%%
%
function data= parseLatex(data)

if ischar(data) && ~isempty(strfind(data, '^'))
  data= ['$', data, '$'];
end

if ischar(data) && ~isempty(strfind(data, 'µ'))
  pos= strfind(data, 'µ');
  data= [data(1:pos-1), '\\mu ', data(pos+1:end)];
  data= ['$', data, '$'];
end

% if ischar(data) && ~isempty(strfind(data, '_'))
%     pos= strfind(data, '_');
% 
%     data= [data(1:pos-1), '\\', data(pos:end)];
% end


