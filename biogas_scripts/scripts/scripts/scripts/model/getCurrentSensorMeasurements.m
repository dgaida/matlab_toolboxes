%% getCurrentSensorMeasurements
% Returns current measurements in sensors as double vector and cellstring. 
%
function [sensorsData, sensorsSymbolsUnits]= getCurrentSensorMeasurements(varargin)
%% Release: 1.3

%%

error( nargchk(0, 2, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin == 0
  sensors= evalinMWS('sensors');
else
  sensors= varargin{1};
  
  is_sensors(sensors, '1st');
end

if nargin >= 2 && ~isempty(varargin{2})
  noisy= varargin{2};
  checkArgument(noisy, 'noisy', 'logical', '2nd');
else
  noisy= false;
end


%%

[sensorsData, sensorsSymbols]= sensors.getCurrentMeasurements(noisy);

%%

sensorsData= double(sensorsData);

%%

% sensorsSymbolsUnits= cell(sensorsSymbols.Length, 1);
% 
% for iel= 1:numel(sensorsSymbolsUnits)
% 
%   sensorsSymbolsUnits{iel}= char( sensorsSymbols.Get(iel - 1) );
% 
% end

%%
% so ist es kürzer

sensorsSymbolsUnits= cell(sensorsSymbols)';

%%


