%% get_volumeflows_from
% Get substrate volumeflows from file or workspace
%
function volumeflows= get_volumeflows_from(substrate, vol_type, varargin)
%% Release: 1.4

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 3, 0, 1);
else
  accesstofile= 1; 
end

if nargin >= 4 && ~isempty(varargin{2})
  mypath= varargin{2};
  checkArgument(mypath, 'mypath', 'char', 4);
else
  mypath= pwd;
end

%%
% check arguments

is_substrate(substrate, '1st');
is_volumeflow_type(vol_type, 2);

%%

for isubstrate= 1:substrate.getNumSubstratesD()

  %%

  filename= ['volumeflow_', char(substrate.getID(isubstrate)), '_', vol_type];
  varname=  char(substrate.getID(isubstrate));
  
  %%
  
  if accesstofile == 1
    % load from file
    try

      %%

      filename_full= fullfile(mypath, [filename, '.mat']);

      %%

      if exist(filename_full, 'file')

        s= load(filename_full);

        % get volumeflow
        volumeflows.(varname)= s.(filename);

        clear s;

      else

        volumeflows.(varname)= [];

      end

    catch ME
      rethrow(ME);
    end
  
  else
    % load from workspace
    % get volumeflow
    volumeflows.(varname)= evalin('base', filename);
    
  end

  %%

end

%%



%%


