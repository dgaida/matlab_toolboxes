%% getNetworkFluxThreshold
% Return the parts of the |networkFlux| vector, which are > |threshold|.
%
function [networkFluxThres, fluxStringThres]= ...
                getNetworkFluxThreshold(networkFlux, fluxString, varargin)
%% Release: 1.9

%%
%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1}), 
  threshold= varargin{1};
  
  isR(threshold, 'threshold', 3);
else
  threshold= 0; 
end


%%
% check input parameters

checkArgument(networkFlux, 'networkFlux', 'double', '1st');
checkArgument(fluxString, 'fluxString', 'cellstr', '2nd');

if size(networkFlux) ~= size(fluxString)
  error('size(networkFlux) ~= size(fluxString)!');
end


%% 
% set NetworkFlux for Substrate Mix and Pumps

networkFluxFlag= networkFlux > threshold;

%%

networkFluxThres= networkFlux(networkFluxFlag);
fluxStringThres=  fluxString(networkFluxFlag);

%%


