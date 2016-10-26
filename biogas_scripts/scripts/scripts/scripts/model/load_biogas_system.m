%% load_biogas_system
% Load the biogas plant simulation model (or models, when more are needed
% for parallel computing) created with the library of the
% _Biogas Plant Modeling_ Toolbox. 
%
function load_biogas_system(fcn, varargin)
%% Release: 1.9

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%% 
% read out varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  parallel= varargin{1}; 
else
  parallel= 'none'; 
end

if nargin >= 3 && ~isempty(varargin{2}), 
  nWorker= varargin{2}; 
else
  nWorker= 2; 
end


%%
% check parameters

checkArgument(fcn, 'fcn', 'char', '1st');

validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 2);

% no parallel computing?
if strcmp(parallel, 'none')
  nWorker= 1;
end

isN(nWorker, 'number of worker', 3);


%%
% throw away file extension

str= regexp(fcn, '\.mdl', 'split');

fcn= str{1};

%%

try 
  % close the system, to be sure that it is closed
  close_system(fcn);
catch ME
  rethrow(ME);
end


%%
% if using a multicore processor create one model for each worker

if strcmp( parallel, 'multicore' )

  for iWorker= 1:nWorker

    fcn_lab= [fcn, '_', sprintf('%i', iWorker)];

    try

      % close system to be sure that it is closed
      close_system(fcn_lab);

%             if matlab_ver <= 7.8
%                 % warning OFF LibraryVersion
%                 warning('off', 'Simulink:LibraryVersion');
%             end

      % load original system
      load_system(fcn);

%             if matlab_ver <= 7.8
%                 % warning OFF LibraryVersion
%                 warning('on', 'Simulink:LibraryVersion');
%             end

      % save it as a new system for the ith worker
      save_system(fcn, fcn_lab);

      % create a file, describing that if this file exists, 
      % than the model is free for simulating, if the file does not
      % exist, then the model is actually simulated by a worker
      save([fcn_lab, '.mat'], 'fcn_lab');

      %

      close_system(fcn_lab);

      %

    catch ME
      rethrow(ME);
    end

  end

  try
    % close the original system to be sure that it is closed, then
    % load_system is working properly
    close_system(fcn);
  catch ME
    rethrow(ME);
  end


%%
% just load the original system
elseif strcmp( parallel, 'none' )

  try
%         if matlab_ver <= 7.8
%             % warning OFF LibraryVersion
%             warning('off', 'Simulink:LibraryVersion');
%         end

    load_system(fcn);

%         if matlab_ver <= 7.8
%             % warning ON LibraryVersion
%             warning('on', 'Simulink:LibraryVersion');   
%         end

  catch ME
    rethrow(ME);
  end


%%
elseif strcmp( parallel, 'cluster' )

  error(['For the parallel option ', parallel, ...
         ' the code at this place is not yet implemented. Implement it or ', ...
         'contact the developers.']);

else

  error(['Unknown value for the parameter parallel: ', parallel]);

end

%%


