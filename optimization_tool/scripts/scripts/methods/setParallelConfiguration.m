%% setParallelConfiguration
% Open and close environment for parallel computing.
%
function varargout= setParallelConfiguration(action, varargin)
%% Release: 1.6

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% readout varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  parallel= varargin{1}; 
  
  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 2);
else
  parallel= 'multicore';
end

if nargin >= 3 && ~isempty(varargin{2}),
  nWorker= varargin{2};
  
  validateattributes(nWorker, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'nWorker', 2);
else
  nWorker= 2;
end


%%
% check parameters

validatestring(action, {'open', 'close'}, mfilename, 'action', 1);

% no parallel computing?
if strcmp(parallel, 'none')
  nWorker= 1;
end

if ~isa(nWorker, 'double')
  if strcmp(parallel, 'none')
    nWorker= 1;
  else
    nWorker= 2;
  end
end


%%

switch action

  %%

  case 'open'

    %%

    if strcmp( parallel, 'multicore' )

      %%

      try
        if exist('matlabpool', 'file') == 2
          if ~getIsMatlabPoolOpen()
            matlabpool( 'open', nWorker );
          else
            disp('matlabpool is already open!');
          end
        else
          warning('Parallel:NotInstalled', ...
                 ['Parallel Toolbox not installed!', ...
                  ' Changing to non-parallel mode!']);

          nWorker= 1;
          parallel= 'none';
        end
      catch ME
        warning('matlabpool:Error', ...
               ['Could not open matlabpool! ', ...
                'Setting parallel to ''none''!']);
        disp(ME.message);
        
        parallel= 'none';
        nWorker= 1;
      end

    %%

    elseif strcmp( parallel, 'cluster' )

      %%

      warning('Toolbox:TODO', ...
             ['The function for parallel == ''cluster'' ', ... 
              'is not yet working! Setting parallel to ''none''!']);

      parallel= 'none';
      nWorker= 1;

      if(0)

        % network path to the ObjectiveFunction
        % 'fitnessFindOptimalEquilibrium' 
        network_file_path= 'blabla';

        pctRunOnAll('addpath', network_file_path);

        % fitnessFunktion als Parameter übergeben
        pctRunOnAll('which fitnessFindOptimalEquilibrium');

        % conf has to be the configuration
        matlabpool( 'open', 'conf', nWorker );

      end

    end

  %%

  case 'close'

    %%

    if ~strcmp( parallel, 'none' )

      if exist('matlabpool', 'file') == 2
        %% TODO
        %
        if(0)
          matlabpool close;
        else
          warning('Toolbox:TODO', 'not closing matlabpool!')
        end
      end

    end

end


%%
% set varargout

if nargout >= 1, varargout{1}= parallel; end
if nargout >= 2, varargout{2}= nWorker; end

%%


