%% round_float
% Round to nearest float with |digits| fractional digits.
%
function round_value= round_float(value, varargin)
%% Release: 1.9

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 2
  digits= varargin{1};
else
  digits= 2;
end


%%
% check the parameters

checkArgument(value, 'value', 'numeric', '1st');

%%

if max((size(value) ~= size(digits))) && ...
   (numel(value) ~= 1) && (numel(digits) ~= 1)
   
  error(['The parameters value and digits must either be of the same', ...
         ' size or one of the parameters must be a scalar. Here ', ...
         'value has %i and digits has %i elements.'], ...
         numel(value), numel(digits));
    
end

validateattributes(digits, {'numeric'}, ...
                   {'2d', 'nonnegative', 'integer'}, ...
                   mfilename, 'digits', 2);
                 

%%

round_value= round( value .* 10.^digits ) ./ 10.^digits;

%%


