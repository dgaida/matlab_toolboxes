%% createvolumeflowfile
% Create the volumeflow file for data input.
%
function [simudata]= createvolumeflowfile(type, q_max, substrate_name, ...
                                          varargin)
%% Release: 1.9

%%

error( nargchk(3, 11, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 4
  user_deltatime= varargin{1}; 
else
  user_deltatime= []; 
end

if nargin >= 5, user_data= varargin{2}; else user_data= []; end;
if nargin >= 6, user_density= varargin{3}; else user_density= []; end;

if nargin >= 7 && ~isempty(varargin{4}), 
  user_unit= varargin{4}; 
else
  user_unit= 'm3_day'; 
end

if strcmp(user_unit, 'm3_day')
  user_density= 1;
end

if nargin >= 8 && ~isempty(varargin{5}), 
  accesstofile= varargin{5}; 
  
  isZ(accesstofile, 'accesstofile', 8, -1, 1);
else
  accesstofile= 1;
end

if nargin >= 9 && ~isempty(varargin{6}), 
  pathToSaveIn= varargin{6}; 
  
  checkArgument(pathToSaveIn, 'pathToSaveIn', 'char', '9th');
else
  pathToSaveIn= pwd;
end

% number appended at the end of the filename
if nargin >= 10 && ~isempty(varargin{7}), 
  file_id= varargin{7}; 
  
  isR(file_id, 'file_id', 10);
else
  file_id= [];
end

if nargin >= 11 && ~isempty(varargin{8}), 
  add_intermediates= varargin{8}; 
  
  is0or1(add_intermediates, 'add_intermediates', 11);
else
  add_intermediates= 1;
end


%%
% check parameters

validatestring(type, {'random', 'const', 'user'}, mfilename, 'flow type', 1);
                   
validateattributes(substrate_name, {'char'}, {'vector'}, mfilename, 'substrate ID', 3);

if strcmp(type, 'user')
  isR(user_deltatime, 'user_deltatime', 4, '+');
  validateattributes(user_data, {'double'}, {'vector'}, mfilename, 'user_data', 5);
  isR(user_density, 'user_density', 6, '+');
                   
  validatestring(user_unit, {'m3_day', 'kg_day'}, mfilename, 'user_unit', 7);                 
else
  isR(q_max, 'q_max', 2, '+');
end


%%

% data changes once per week
time_grid= (0:7:45*12)';

user_data= user_data(:);

%%

switch type

  case 'random'

    %%

    q= q_max .* rand( size(time_grid,1), 1 );

  case 'const'

    % data changes once per week
    time_grid= (0:7:21)';

    %%

    if strcmp(user_unit, 'kg_day')

      %%
      % constant volumeflow = q_max
      q= q_max ./ user_density .* 1000 .* ones (size(time_grid,1), 1);

    elseif strcmp(user_unit, 'm3_day')

      %%
      % constant volumeflow = q_max
      q= q_max .* ones (size(time_grid,1), 1);

    else

      error('Unknown user_unit : %s.', user_unit);

    end

  case 'user'
    
    %%
    % Zwischenwerte einfügen, damit piecewise constant daraus wird
    
    if (add_intermediates)

      [time_grid, q]= make_pwc(user_deltatime, user_data);

    else
      
      %%
      % letzter fluss wird noch mal angehängt, damit simulink ab
      % letztem fluss konstant weiter simuliert, sonst abnahme auf 0
      time_grid= (0:user_deltatime:size(user_data,1)*user_deltatime)';
      q= [user_data; user_data(end)];
      
    end
    
    %%
    %

    if strcmp(user_unit, 'kg_day')

      %%
      % $q [m^3/d]= \frac{ q [kg/d] }{ \rho [g/m^3] } \cdot 1000
      % g/kg$ 
      %
      q= q ./ user_density .* 1000;

    elseif strcmp(user_unit, 'm3_day')

      %q= q;

    else

      error('Unknown user_unit : %s.', user_unit);

    end

end


%%
% schreibt *.mat file, wird benutzt als Import für Simulationen

simudata= [time_grid q]';

filenamepre= sprintf('volumeflow_%s_%s', substrate_name, type);

if ~isempty(file_id)
  filename= sprintf('volumeflow_%s_%s_%i.mat', ...
                     substrate_name, type, file_id);
else
  filename= sprintf('volumeflow_%s_%s.mat', substrate_name, type);
end

filestruct.(filenamepre)= simudata;

if accesstofile == 1

  save( fullfile(pathToSaveIn, filename), '-struct', 'filestruct', filenamepre);

elseif accesstofile == -1

  if getMATLABVersion() < 711

    try
      assigninMWS(filenamepre, simudata);
    catch ME

      warning('assigninMWS:error', 'assigninMWS error');
      rethrow(ME);

    end

  else

    %%

    bdroot_split= regexp( bdroot, '_', 'split' );

    if ~isempty(file_id)
      filename= sprintf('volumeflow_%s_%s_%i.mat', ...
                 substrate_name, type, file_id);
    else
      filename= sprintf('volumeflow_%s_%s.mat', substrate_name, type);
    end

    if size(bdroot_split, 2) >= 3 && ~isnan( str2double(bdroot_split{1,end}) )

      if ~isempty(file_id)
        filename= sprintf('volumeflow_%s_%s_%i_%s.mat', ...
                          substrate_name, type, file_id, ...
                          bdroot_split{1,end});
      else
        filename= sprintf('volumeflow_%s_%s_%s.mat', substrate_name, type, ...
                          bdroot_split{1,end});
      end

    end

    %

    save( fullfile(pathToSaveIn, filename), '-struct', ...
          'filestruct', filenamepre );

  end        

else
  % accesstofile == 0
  assignin('base', filenamepre, simudata);

end

%%

    
    