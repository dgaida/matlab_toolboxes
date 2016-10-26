%% biogas_model_closefcn
% Save the biogas plant model before closing it.
%
function biogas_model_closefcn(varargin)
%% Release: 1.4

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% readout varargin

if nargin >= 1 && ~isempty(varargin{1}), 
  DEBUG= varargin{1}; 
  is0or1(DEBUG, 'DEBUG', 1);
else
  DEBUG= 0; 
end

%%

dispMessage(['Close model ', bdroot], mfilename);

%%

try
  if DEBUG && 0
    % Construct a questdlg with two options
    choice= questdlg('Do you want to save the model?', ...
                     'Save model', ...
                     'Yes','No','Yes');
  else
    choice= 'Yes';
  end

  % Handle response
  switch choice
    case 'Yes'
      save_system(bdroot);
      dispMessage('Save the model.', mfilename);
  end

catch ME
  warning('IO:SaveModel', ['Could not save the system ', gcs, '!']);
  warning('IO:SaveModel', ['Could not save the system ', bdroot, '!']);

  rethrow(ME);
end

%%
    
  
