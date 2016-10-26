%% is_moa
% Checks whether given optimization method is a multi-objective algorithm
%
function is_mo= is_moa(method)
%% Release: 0.3

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(method, 'method', 'char', '1st');

%% TODO
% has to be extended if more mo methods are implemented in the toolbox
% das funktioniert so nicht. methoden müsen automatisch erkannt werden ob
% diese MO oder SO sind, deshalb die geringe release version

if strcmp(method, 'SMS-EGO') || strcmp(method, 'SMS-EMOA') || ...
   strcmp(method, 'EHVI-EGO')
  is_mo= 1;
else
  is_mo= 0;
end

%%



%%


