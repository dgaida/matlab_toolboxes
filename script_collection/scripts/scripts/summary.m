%% summary
% Calculate summary (mean, min, max) of given data (and display them). 
%
function [mean_data, min_data, max_data]= summary(data, varargin)
%% Release: 1.9

%%
% check param

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

checkArgument(data, 'data', 'double', '1st');

if nargin >= 2 && ~isempty(varargin{1})
  ignoreNaNs= varargin{1};
  
  is0or1(ignoreNaNs, 'ignoreNaNs', 2);
else
  ignoreNaNs= 1;
end

                 
%%
%

if ignoreNaNs
  mean_data= nanmean(data);
  min_data=  nanmin(data);
  max_data=  nanmax(data);
else
  mean_data= mean(data);
  min_data=  min(data);
  max_data=  max(data);
end

%%

if numel(mean_data) == 1
  fprintf('mean: %.2e\n', mean_data);
end

if numel(min_data) == 1
  fprintf('min:  %.2e \t max: %.2e\n', min_data, max_data);
end

%%


