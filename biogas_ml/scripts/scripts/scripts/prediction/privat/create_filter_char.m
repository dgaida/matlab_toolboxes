%% create_filter_char
% Create cell array of characters containing filter shortcuts for the
% wanted filters. 
%
function filter_char= create_filter_char(filter_num)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(filter_num, {'double'}, {'vector', 'nonempty', 'integer', 'nonnegative'}, ...
                   mfilename, 'filter_num', 1);

%%

filter_char= cell(1, numel(filter_num));

for iel= 1:numel(filter_num)

  if ( filter_num ) % if at least one entry is 0, then nothing is created

    if ( filter_num(iel) / 24 > 1 )
      filter_char(iel)= {sprintf('d%i', filter_num(iel) / 24)};
    else
      filter_char(iel)= {sprintf('h%i', filter_num(iel))};
    end

  end

end

%%


