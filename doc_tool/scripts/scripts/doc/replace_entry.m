%% replace_entry
% Replace an entry in an array at a given position
%
function tocfile= replace_entry(tocfile, tocrep, pos)
%% Release: 1.1

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

%% TODO
% tocfile and tocrep could be much, maybe check size?


%%

validateattributes(pos, {'double'}, {'scalar', 'nonnegative', '>=', 1, 'integer'}, ...
                   mfilename, 'position', 3);


%%

tocfile = [tocfile(1:pos-1)  tocrep  tocfile(pos+1:end)];

    
%%


