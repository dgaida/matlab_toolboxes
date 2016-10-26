%% checkArgument
% Check given function argument for correct class and throw error on mismatch
%
function checkArgument(argument, argument_name, argument_class, ...
                       ordinal_number, varargin)
%% Release: 1.9

%%

% Attention: this function may not call error_time and warning_time,
% because then we have an infinitive loop. 
% may also not call dispMessage

error( nargchk(4, 6, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

global IS_DEBUG;

%%

if nargin >= 5 && ~isempty(varargin{1})
  onlycheckifnotempty= varargin{1};
else
  onlycheckifnotempty= 'off';
end

% using global variable is faster, see check_runtime
% if nargin >= 6 && ~isempty(varargin{2})
%   is_debug= varargin{2};
%   
%   if is_debug
%     is0or1(is_debug, 'is_debug', 6);
%   end
% else
%   is_debug= 1;
% end

%%
% check arguments

if IS_DEBUG % if is_debug
  
  if ~ischar(argument_name)
    error(['The 2nd argument argument_name must be a ', ...
           '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
           '<a href="matlab:doc(''%s'')">%s</a>!'], ...
           class(argument_name), class(argument_name));
  end

  if ~ischar(argument_class)
    error(['The 3rd argument argument_class must be a ', ...
           '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
           '<a href="matlab:doc(''%s'')">%s</a>!'], ...
           class(argument_class), class(argument_class));
  end

  if ~isnumeric(ordinal_number)
    validatestring(ordinal_number, {'1st', '2nd', '3rd', '4th',  '5th', ...
                                    '6th', '7th', '8th', '9th', '10th', ...
                                    '11th', '12th', '13th', '14th', '15th'}, ...
                   mfilename, 'ordinal_number', 4);
  else
    validateattributes(ordinal_number, {'double'}, ...
                       {'scalar', 'positive', 'integer'}, ...
                       mfilename, 'ordinal_number', 4);
  end

  validatestring(onlycheckifnotempty, {'on', 'off'}, ...
                 mfilename, 'onlycheckifnotempty', 5);   

end

%%
% if argument is empty and I do not want to check it, then return

if strcmp(onlycheckifnotempty, 'on') && isempty(argument)
  return;
end

%%

errorneous= 0;

%%

arg_classes= regexp(argument_class, '\|\|', 'split');
argument_class_orig= argument_class;

%%

for iarg= 1:numel(arg_classes)
  
  %%

  argument_class= strtrim(arg_classes{iarg});
  
  %%
  
  switch (argument_class)

    case 'double'
      if ~isa(argument, argument_class)
        errorneous= 1;
      end

    case 'numeric'
      if ~isnumeric(argument)
        errorneous= 1;
      end

    case 'logical'
      if ~islogical(argument)
        errorneous= 1;
      end
      
    case 'char'
      if ~ischar(argument)
        errorneous= 1;
      end

    case 'cell'
      if ~iscell(argument)
        errorneous= 1;
      end

    case 'cellstr'
      if ~iscellstr(argument)
        errorneous= 1;
      end

    case 'struct'
      if ~isstruct(argument)
        errorneous= 1;
      end

    otherwise
      try
        if ~isa(argument, argument_class)
          errorneous= 1;
        end
      catch ME
        error('Cannot check for argument_class: "%s" not yet implemented! %s', ...
              argument_class, ME.message);
      end

  end
  
  %%
  
  if errorneous == 0
    break;
  else
    if iarg < numel(arg_classes)
      errorneous= 0;
    end
  end
  
  %%
  
end

%%
 
if errorneous

  if isnumeric(ordinal_number)
    if strcmp(argument_class, 'numeric')
      error(['The %ith argument %s must be a ', ...
             '<a href="matlab:doc(''is%s'')">%s</a>, but is a ', ...
             '<a href="matlab:doc(''%s'')">%s</a>!'], ...
            ordinal_number, argument_name, argument_class, ...
            argument_class_orig, class(argument), class(argument));
    else
      error(['The %ith argument %s must be a ', ...
             '<a href="matlab:doc(''%s'')">%s</a>, but is a ', ...
             '<a href="matlab:doc(''%s'')">%s</a>!'], ...
            ordinal_number, argument_name, argument_class, ...
            argument_class_orig, class(argument), class(argument));
    end
  else
    if strcmp(argument_class, 'numeric')
      error(['The %s argument %s must be a ', ...
             '<a href="matlab:doc(''is%s'')">%s</a>, but is a ', ...
             '<a href="matlab:doc(''%s'')">%s</a>!'], ...
            ordinal_number, argument_name, argument_class, ...
            argument_class_orig, class(argument), class(argument));
    else
      error(['The %s argument %s must be a ', ...
             '<a href="matlab:doc(''%s'')">%s</a>, but is a ', ...
             '<a href="matlab:doc(''%s'')">%s</a>!'], ...
            ordinal_number, argument_name, argument_class, ...
            argument_class_orig, class(argument), class(argument));
    end
  end
  
end

%%



%%


