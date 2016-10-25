%% plot1dLinConstraints
% Plot 1-d linear constraints.
%
function [X]= plot1dLinConstraints(A, b, varargin)
%% Release: 1.9

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isR(A, 'A', 1);
isR(b, 'b', 2);

%%
% readout varargin

if nargin >= 3 && ~isempty(varargin{1}), 
  color= varargin{1}; 
else
  color= 'r'; 
end

checkArgument(color, 'color', 'char', '3rd');

%%

if A(1,1) ~= 0

  %%
  % $$A \cdot x = b, A, b \in R$$
  %
  % $$x = \frac{b}{A}$$
  %
  X= b(1,1) ./ A(1,1);

  %%
  % the 1-dimensional space is plotted as a 2-dimensional one, where
  % the y-axis is fixed at 1.
  %
  plot( X, 1, color );

else
  X= [];
end

%%
   

