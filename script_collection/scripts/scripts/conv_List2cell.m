%% conv_List2cell
% Convert a C# List<> object to a MATLAB cell array
%
function cellarr= conv_List2cell(listobj)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check argument

% funktioniert leider nicht
%checkArgument(listobj, 'listobj', 'System.Collections.Generic.List', '1st');

%%

cellarr= cell(listobj.Count, 1);

%%

for iel= 1:listobj.Count
  
  %% 
  
  myItem= listobj.Item(iel - 1);
  
  if isa(myItem, 'System.String')
    % for List<String>
    cellarr{iel}= char(myItem);
  else
    %% TODO - maybe add more cases
    cellarr{iel}= myItem;
  end
  
end

%%


