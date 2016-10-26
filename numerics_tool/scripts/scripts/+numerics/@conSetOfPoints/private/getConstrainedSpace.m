%% numerics.conSetOfPoints.private.getConstrainedSpace
% Get the description for the dimension reduced vector space which
% satisfies $A_{eq} \cdot \vec{x} = \vec{b}_{eq}$. 
%
function obj= getConstrainedSpace(obj)
%% Release: 1.9

  %%

  error( nargchk(1, 1, nargin, 'struct') );
  error( nargoutchk(0, 1, nargout, 'struct') );

  %%

  Aeq= obj.Aeq;
  beq= obj.beq;

  A= obj.A;
  b= obj.b;

  LB= obj.LB(:);
  UB= obj.UB(:);


  %%
  % the constrained space automatically satisfies the linear equality
  % constraints Aeq, beq, such that they are empty in the constrained space
  %
  obj.conAeq= [];
  obj.conbeq= [];


  %%
  % $$V := \left[ \vec{v}_1, \dots, \vec{v}_z \right] \in R^{n \times
  % z}$$ 
  %
  % The set of orthonormal vectors
  %
  % $$\left\{ \vec{v}_1, \dots, \vec{v}_z \right\}$$
  %
  % $$\vec{v}_i \in R^n, i= 1, \dots, z$$
  %
  % span up the, by the constraints $A_{eq} \cdot \vec{x} =
  % \vec{b}_{eq}$,
  % reduced space containing the vectors $\vec{\alpha} \in R^z$.
  % 
  [V]= numerics.math.calcNullspace(Aeq);


  %%

  if ~isempty(Aeq)

    %%

    dim= numel(LB);

    %%
    % formulate the lower and upper bounds as linear inequality constraints
    % in the form 
    % $A \cdot x \leq b$
    %
    % $$x \geq LB$$
    %
    % ->
    %
    % $$-x \leq -LB$$
    %
    % $$x \leq UB$$
    %
    A= [ A;...
        -eye(numel(LB));
         eye(numel(UB))];

    b= [b;...
        -LB;...
        UB];

    
    %%
    % $$A_V := A \cdot V$$
    %
    AV= A*V;

    %%
    % $$\vec{a}_v := \vec{b} - A \cdot \left( A_{eq} \backslash 
    % \vec{b}_{eq} \right)$$ 
    %
    % Now
    %
    % $$A_V \cdot \vec{\alpha} \leq \vec{a}_v$$
    %
    % holds.
    %
    av= b - A*(Aeq\beq);

    %%
    % particular solution
    %
    % $$x_p := A_{eq} \backslash \vec{b}_{eq}$$
    %
    xp= Aeq\beq;


    %%
    % determine the lower and upper bounds in the reduced space 
    %

    x0= AV\av;

    if ~isempty(x0)

%       options= optimset('Algorithm', 'interior-point');

      % müsste identisch mit xmin sein
      % least squares solution of the lower bounds in the transformed
      % space
      x0= AV(end-2*dim+1:end-dim,:)\av(end-2*dim+1:end-dim,:);

%       if 0 && exist('fmincon', 'file') == 2
% 
%         [xmin]= ...
%           fmincon(@(x)minboundarydist(x, AV(end-2*dim+1:end-dim,:), ...
%                                          av(end-2*dim+1:end-dim,:)), ...
%                        x0, AV(end-2*dim+1:end,:), ...
%                        av(end-2*dim+1:end,:), ...
%                        [], [], [], [], [], options);
% 
%         if norm(x0 - xmin) > 1e-3
%             warning('norm(x0 - xmin) > 1e-3= %.2e', ...
%                     norm(x0 - xmin));
%         end
% 
%       else
        xmin= x0;
%       end

      % müsste identisch mit xmax sein          
      % least squares solution of the upper bounds in the transformed
      % space
      x0= AV(end-dim+1:end,:)\av(end-dim+1:end,:);

%       if 0 && exist('fmincon', 'file') == 2
% 
%         [xmax]= ...
%             fmincon(@(x)minboundarydist(x, AV(end-dim+1:end,:), ...
%                                            av(end-dim+1:end,:)), ...
%                      x0, AV(end-2*dim+1:end,:), ...
%                      av(end-2*dim+1:end,:), ...
%                      [], [], [], [], [], options);                      
% 
%         if norm(x0 - xmax) > 1e-3
%             warning('norm(x0 - xmax) > 1e-3= %.2e', ...
%                     norm(x0 - xmax));
%         end
% 
%       else
        xmax= x0;
%       end

    else

      % then the transformed space is the empty space
      xmin= xp;
      xmax= xp;

    end


    %%

    xmin_n= min(xmin, xmax);
    xmax_n= max(xmax, xmin);

    xmin= xmin_n;
    xmax= xmax_n;


    %%
    %

    obj.V= V;

    %%
    % row vectors
    obj.conLB= xmin(:)';
    obj.conUB= xmax(:)';

    num_bounds= numel(LB) + numel(UB);

    if ~isempty(V)
      obj.conA= AV(1:end - num_bounds, :);
      obj.conb= av(1:end - num_bounds, :);
    else
      obj.conA= obj.A;
      obj.conb= obj.b;
    end

    if isempty(obj.conA)
      obj.conA= [];
      obj.conb= [];
    end

    obj.conDim= numel(obj.conLB);

  else

    obj.V= [];

    obj.conLB= LB(:)';
    obj.conUB= UB(:)';

    obj.conA= A;
    obj.conb= b;

    obj.conDim= obj.dim;

  end

  %%
  % scale between 0 and 1
  %
  [obj.conLB, obj.conUB, obj.conA, obj.conb, ...
   obj.C, obj.Cinv, obj.d]= ...
                  getScalingTransformation(...
                          obj.conLB, obj.conUB, obj.conA, obj.conb);

  %%

end



%%
% $$AV \cdot \vec{\alpha} \leq \vec{a}_v$$
%
% ->
%
% $$\vec{a}_v - AV \cdot \vec{\alpha} \geq \vec{0}$$
%
% since $AV$ and $\vec{a}_v$ just contain the upper resp. lower bounds of
% all valid $\vec{\alpha}$'s, we try to minimize the term above, to come as
% close as possible to the lower resp. upper boundary.
%
% x= alpha
%
% function fitness= minboundarydist(x, AV, av)
% 
%   fitness= norm( av - AV * x );
% 
% end

%%


