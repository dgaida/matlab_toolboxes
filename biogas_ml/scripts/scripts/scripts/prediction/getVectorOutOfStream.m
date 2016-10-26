%% getVectorOutOfStream
% Get data for state vector component out of recorded data stream matrix of
% the state vector.
%
function [ys, varargout]= ...
                getVectorOutOfStream(stream, goal_variable, varargin)
%% Release: 1.8

%%
% check input parameters

error( nargchk(2, 7, nargin, 'struct') );
error( nargoutchk(0, 5, nargout, 'struct') );

checkArgument(stream, 'stream', 'double', '1st');
checkArgument(goal_variable, 'goal_variable', 'char', '2nd');

%%
% read out varargin and check parameters

if nargin >= 3 && ~isempty(varargin{1})
  bins= varargin{1};
  isN(bins, 'bins', 3);
else
  bins= 0;
end

if nargin >= 4 && ~isempty(varargin{2})
  min_y= varargin{2};
  isR(min_y, 'min_y', 4);
else
  min_y= [];
end

if nargin >= 5 && ~isempty(varargin{3})
  max_y= varargin{3};
  isR(max_y, 'max_y', 5);
else
  max_y= [];
end

if ( isempty(min_y) && ~isempty(max_y) ) || ...
   ( isempty(max_y) && ~isempty(min_y) )

  warning('getVectorOutOfStream:boundaries', ...
          'If not both boundaries are non-empty, then no boundary is used!');
 
end

%%

if nargin >= 6 && ~isempty(varargin{4})
  fromUnit= varargin{4};
  checkArgument(fromUnit, 'fromUnit', 'char', 6);
else
  % das ist ok, sogar sehr gut!!!
  % mittlerweile gibt es in C# eine Variable welche definiert in welchen
  % Einheiten die ADM1 Zustandsgrößen gemessen werden, diese wird genutzt
  % wenn fromUnit leer gelassen wird, also perfekt!
%   warning('fromUnit:empty', ...
%           'fromUnit is empty! This is not recommended! See documentation.');
  fromUnit= [];
end

if nargin >= 7 && ~isempty(varargin{5})
  toUnit= varargin{5};
  checkArgument(toUnit, 'toUnit', 'char', 7, 'on');
else
  toUnit= getDefaultMeasurementUnit(goal_variable);
end

%% 
% 

if isempty(fromUnit)
  %% 
  % get data and transform it to unit toUnit. the unit that the stream
  % values have are gotten from the C# method, ADMstream.getUnitOfADMstatevariable(symbol);
  % the unit this function returns is 100 % the unit of the ADM1 model
  ys= biogas.ADMstate.calcFromADMstate( ...
               NET.convertArray(stream, 'System.Double', size(stream)), ...
               goal_variable, toUnit );
else
  if min(size(stream)) == 1
    % stream is a vector
    % converts the vector from the unit fromUnit to a default unit given by
    % the C# method physValue.getDefaultUnit(symbol)
    
    if isempty(toUnit)
      ys= biogas.ADMstate.calcFromADMstate( ...
                 NET.convertArray(stream, 'System.Double', numel(stream)), ...
                 goal_variable, fromUnit );
    else
      ys= biogas.ADMstate.calcFromADMstate( ...
                 NET.convertArray(stream, 'System.Double', numel(stream)), ...
                 goal_variable, fromUnit, toUnit );     
    end
  else
    % convert stream from given unit fromUnit to given unit toUnit
    ys= biogas.ADMstate.calcFromADMstate( ...
               NET.convertArray(stream, 'System.Double', size(stream)), ...
               goal_variable, fromUnit, toUnit );
  end
end

ys= double(ys)';

%%
%

if nargout >= 2 && ~isempty(bins) && bins > 0

  [yclass, mini, maxi]= real2classvalues(ys, bins, min_y, max_y);

  varargout{1}= yclass;

else
  varargout{1}= [];
  
  mini= min(ys);
  maxi= max(ys);
end

%%

if nargout >= 3
  varargout{2}= toUnit;
end

%%

if nargout >= 4
  varargout{3}= mini;
end

%%

if nargout >= 5
  varargout{4}= maxi;
end

%%


