%% setpopPlantToValue
% Set the index of the popPlant to the given |plantName|.
%
function handles= setpopPlantToValue(handles, plantName)
%% Release: 1.3

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

if ~ischar(plantName)
  error('The 2nd parameter plantName must be a char, but is a %s!', ...
        class(plantName));
end

%%

contents= cellstr( get(handles.popPlant, 'String') ); 

for ivalue= 1:size(contents,1)

  % returns selected item from popPlant
  if strcmp( deblank(char(contents{ivalue,1})), plantName )

    set(handles.popPlant, 'Value', ivalue);

    break;

  end
    
end

%%


