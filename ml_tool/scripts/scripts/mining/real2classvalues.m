%% real2classvalues
% Scales real values in vector to class values. Needed for classification. 
%
function [data_classes, mini, maxi]= real2classvalues(data_real, varargin)
%% Release: 1.5

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% get input arguments

if nargin >= 2 && ~isempty(varargin{1})
  bins= varargin{1};
  isN(bins, 'bins', 2);
else
  bins= 0;
end

if nargin >= 3 && ~isempty(varargin{2})
  min_y= varargin{2};
  isR(min_y, 'min_y', 3);
else
  min_y= [];
end

if nargin >= 4 && ~isempty(varargin{3})
  max_y= varargin{3};
  isR(max_y, 'max_y', 4);
else
  max_y= [];
end

%%
% check input arguments

isRn(data_real, 'data_real', 1);

if ( isempty(min_y) && ~isempty(max_y) ) || ...
   ( isempty(max_y) && ~isempty(min_y) )

  warning('getVectorOutOfStream:boundaries', ...
          'If not both boundaries are non-empty, then no boundary is used!');
 
end

%%
%

mini= min(data_real);
maxi= max(data_real);

%%
  
if ~isempty(min_y) && ~isempty(max_y)

  %%

  scaled_data= scale_Data(data_real, min_y, max_y);

  if any(scaled_data > 1) || any(scaled_data < 0)
    warning('scale:error', 'scaled_data is not scaled between 0 and 1!');
  end

  % scaled_data is assumed between 0 and 1, thus multiplied with bins
  % -1 returns values between 0 and bins - 1
  data_classes= scaled_data .* (bins - 1);

else

  %%

  [data_classes, mini, maxi]= scale_Data(data_real);

  % das wird nie passieren, da yclass bei dem funktionsaufruf von
  % scale_Data immer zwischen 0 und 1 skaliert ist.
  if any(data_classes > 1) || any(data_classes < 0)
    warning('scale:error', 'yclass is not scaled between 0 and 1!');
  end

  % yclass is scaled between 0 and 1
  data_classes= data_classes .* (bins - 1);

end

%%
% creates classes
data_classes= round(data_classes);

%%


