%% set_solver
% Set parameters of the solver for the gcs.
%
function set_solver(varargin)
%% Release: 1.4

%%
%

error( nargchk(0, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 1 && ~isempty(varargin{1})
  reltol= varargin{1};
  isR(reltol, 'reltol', 1, '+');
else
  reltol= 1e-3;
end

if nargin >= 2 && ~isempty(varargin{2})
  abstol= varargin{2};
  isR(abstol, 'abstol', 2, '+');
else
  abstol= 1e-6;
end

if nargin >= 3 && ~isempty(varargin{3})
  deltatime= varargin{3};
  isR(deltatime, 'deltatime', 3, '+');
else
  %% 
  % could use get_biogas_block_deltatime() instead - no, this function will
  % soon not be used anymore
  deltatime= 12 * 1/24;  % 12 h
end

%%

hCs= getActiveConfigSet(gcs);
hSolver= hCs.getComponent('Solver');

%if(0)
hSolver.Solver= 'ode15s';
hSolver.RelTol= sprintf('%.6f', reltol);
hSolver.AbsTol= sprintf('%.9f', abstol);
% maximale Schrittweite = 1 Tag, das Problem ist, dass Sensoren oft nur
% mit max. schrittweite aufgerufen werden, und nicht mit der schrittweite
% mit der andere simulink blöcke aufgerufen werden. in den s-functions
% kann man die sample time mit der ein block aufgerufen werden soll
% angeben, hat aber nicht so funktioniert wie erwartet, s. bspw. die
% sensor blöcke
hSolver.MaxStep= sprintf('%i', deltatime);%'10';
%end

% fraglich ob 100 hier sinnvoll sind, warum habe ich das überhaupt
% gemacht?
%% 
% wie ist das wenn ich simulation über control sampling time machen will,
% welche normalerweise kleiner 10 tage ist???
% niemals setze StopTime - macht einfach keinen Sinn
%hSolver.StopTime= num2str( max(str2double(hSolver.StopTime), 10) );

%%


