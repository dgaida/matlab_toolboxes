%% plot3views
% Make a 3views plot
%
function plot3views(fcn_handle)
%% Release: 1.6

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(fcn_handle, 'fcn_handle', 'function_handle', '1st');

%%
%

for iplot= 1:4    % 4 views, front, left, top, 3d

  subplot(2, 2, iplot);

  % plot
  feval(fcn_handle);
  
  switch iplot
    case 1
      view([0.0 0.0]);
    case 2
      view([-90.0 0.0]);
    case 3
      view([0.0 90.0]);
    case 4
      view(3);
  end
  
end

%%


