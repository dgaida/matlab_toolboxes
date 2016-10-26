%% setpath_tool
% Set or remove the path to the toolbox located in a given directory.
%
function setpath_tool(bibpath, varargin)
%% Release: 1.6

%%

error( nargchk(1, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check input parameters

if ~ischar(bibpath)
  error(['The 1st parameter bibpath must be a ', ...
         '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
         '<a href="matlab:doc(''%s'')">%s</a>!'], ...
         class(bibpath), class(bibpath));
end

if nargin < 2
  inuninstall= @addpath;
else
  inuninstall= varargin{1};
end

if ~isa(inuninstall, 'function_handle')
  error(['The 2nd parameter inuninstall must be a ', ...
         '<a href="matlab:doc(''function_handle'')">function_handle</a>, ', ...
         'but is a <a href="matlab:doc(''%s'')">%s</a>!'], ...
         class(inuninstall), class(inuninstall));
end

if ~strcmp( func2str(inuninstall), 'addpath') && ...
   ~strcmp( func2str(inuninstall), 'rmpath')
  error(['The parameter inuninstall must be either ', ...
         '@addpath or @rmpath, but is @%s', func2str(inuninstall)]); 
end

if nargin >= 3, fileID= varargin{2}; else fileID= 0; end;

validateattributes(fileID, {'double'}, ...
                   {'scalar', 'nonnegative', 'integer'}, ...
                   mfilename, 'fileID', 3);

if nargin >= 4 && ~isempty(varargin{3})
  do_fast= varargin{3};
  validateattributes(do_fast, {'double'}, ...
                     {'scalar', 'nonnegative', 'integer'}, ...
                     mfilename, 'do_fast', 4);
else
  do_fast= 1;
end

%%

if do_fast && ( addpath2toolbox_fast(bibpath) ~= -1 )
  
  % addpath2toolbox_fast ran successfully
  
else

  % then addpath2toolbox_fast failed, thus try to create path_install.txt
  % in tool folder, such that next matlab start is faster
  % addpath2toolbox_fast fails when the path_install.txt file does not
  % exist in the mtools folder
  
  %%
  % write to file path_install.txt
  
  write2path_install_txt(bibpath, inuninstall, fileID, do_fast);

end

%%


