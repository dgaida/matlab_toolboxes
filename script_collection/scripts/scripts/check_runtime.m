%% check_runtime
% Check the runtime of a function
%
function [runtime, varargout]= check_runtime(func_handle, varargin)
%% Release: 1.7

%%

error( nargchk(1, 4, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

checkArgument(func_handle, 'func_handle', 'function_handle', '1st');

if nargin >= 2 && ~isempty(varargin{1})
  args= varargin{1};
  checkArgument(args, 'args', 'cell', '2nd');
else
  args= [];
end

if nargin >= 3 && ~isempty(varargin{2})
  iterations= varargin{2};
  isN(iterations, 'iterations', 3);
else
  iterations= 10;
end

if nargin >= 4 && ~isempty(varargin{3})
  nTests= varargin{3};
  isN(nTests, 'nTests', 4);
else
  nTests= 10;
end

%%

runtimes= zeros(nTests, 1);

%%

for itest= 1:nTests

  %%
  
  starttime= tic;

  %%
  
  for iiter= 1:iterations

    try
      if ~isempty(args)
        feval(func_handle, args{:});
      else
        feval(func_handle);
      end
    catch ME
      if itest == 1 && iiter == 1
        disp(ME.message);
      end
    end

  end

  %%
  
  runtimes(itest, 1)= toc(starttime);

  %%
  
end

%%
% median over tests, then divide through number of iterations
% to get time of one call
runtime= median(runtimes) / iterations;

%%

figure, hist(runtimes ./ iterations);

%%

fprintf('runtime= %.8f s\n', runtime);

%%

if nargout >= 2,
  varargout{1}= runtimes ./ iterations;
else
  varargout{1}= [];
end

%%


