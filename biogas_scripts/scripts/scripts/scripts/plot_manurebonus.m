%% plot_manurebonus
% Plot manurebonus as linear constraint as line or plane (hyperplane)
%
function plot_manurebonus(plant_id, feed_indices, varargin)
%% Release: 1.4

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1})
  LB= varargin{1};
  isRn(LB, 'LB', 3);
  
  if numel(LB) ~= numel(feed_indices)
    error('Dimension mismatch between LB (%i) and feed_indices (%i)!', ...
      numel(LB), numel(feed_indices));
  end
else
  LB= zeros(numel(feed_indices), 1);
end

if nargin >= 4 && ~isempty(varargin{2})
  UB= varargin{2};
  isRn(UB, 'UB', 4);
  
  if numel(UB) ~= numel(feed_indices)
    error('Dimension mismatch between UB (%i) and feed_indices (%i)!', ...
      numel(UB), numel(feed_indices));
  end
else
  UB= 10 .* ones(numel(feed_indices), 1);
end

%%
% check arguments

is_plant_id(plant_id, '1st');

if numel(feed_indices) ~= 2 && numel(feed_indices) ~= 3
  error('The 2nd parameter feed_indices must be 2- or 3-dimensional!');
end


%%

substrate= load_biogas_mat_files(plant_id);

% not really used here, needed for C# method
Qdummy= ones(substrate.getNumSubstratesD(), 1);

%%

[is_bonus, A, b]= biogas.eeg2009.check_manurebonus(substrate, Qdummy);

%%

A= double(A);
myA= A(feed_indices);

%%

if numel(feed_indices) == 3
  plot3dLinConstraints(myA, b, LB, UB);
else
  plot2dLinConstraints(myA, b, LB, UB);
end

%%

xlabel([char(substrate.get(feed_indices(1)).name), ' [m^3/d]'])
ylabel([char(substrate.get(feed_indices(2)).name), ' [m^3/d]'])

if numel(feed_indices) == 3
  zlabel([char(substrate.get(feed_indices(3)).name), ' [m^3/d]'])
end

%%



%%


