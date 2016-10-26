%% get_real_value_from_class
% Get real value out of class bin
%
function [class_real, lb, ub]= get_real_value_from_class(class, ...
                        digester_state_dataset_min, ...
                      	digester_state_dataset_max, no_classes)
%% Release: 1.6

%%

error( nargchk(4, 4, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%% 
% 0 ... no_classes - 1. hier sage ich gnaz klar, dass klasse 0 basiert sein
% soll
isZ(class, 'class', 1, 0, no_classes - 1);
isR(digester_state_dataset_min, 'digester_state_dataset_min', 2);
isR(digester_state_dataset_max, 'digester_state_dataset_max', 3);
                 
if any(digester_state_dataset_min > digester_state_dataset_max)  
  error('Invalid boundaries!');
end

isN(no_classes, 'no_classes', 4); 

%%

step= ( digester_state_dataset_max - digester_state_dataset_min ) ./ no_classes;

%%
% add +-0.5 to class, to get the mean value, depends on if class is zero- or
% one-based
% wenn class 0 basiert, dann ist class_real die untere schranke

class_real= class .* step + digester_state_dataset_min;                    

%%
% annahme, dass class= 0, ..., no_classes - 1, dann gilt das:

lb= class_real;     % lower boundary
ub= (class + 1) .* step + digester_state_dataset_min;  % upper boundary

%%


