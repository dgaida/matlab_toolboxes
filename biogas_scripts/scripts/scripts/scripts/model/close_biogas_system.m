%% close_biogas_system
% Close the biogas plant simulation model created with the library of the
% _Biogas Plant Modeling_ Toolbox. 
%
function close_biogas_system(fcn)
%% Release: 2.9

%%
% check param

error( nargchk(   1, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(fcn, 'fcn', 'char', '1st');

%%
% throw away file extension

str= regexp(fcn, '\.mdl', 'split');

fcn= str{1};

%%

try
  
  save_system(fcn);
  close_system(fcn);

catch ME
  
  error('Could not close system %s!', fcn);
  
  rethrow(ME);
  
end

%%
%


