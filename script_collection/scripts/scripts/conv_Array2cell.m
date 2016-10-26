%% conv_Array2cell
% Convert a C# Array object to a MATLAB cell array
%
function cellarr= conv_Array2cell(arrayobj)
%% Release: 1.4

%%

narginchk(1, 1);
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check argument - is difficult



%%

cellarr= cell(arrayobj.Length, 1);

%%

for iel= 1:numel(cellarr)

  myItem= arrayobj.Get(iel - 1);
  
  if isa(myItem, 'System.String')
    cellarr{iel}= char( myItem );
  else
    cellarr{iel}= myItem;
  end
  
end

%%


