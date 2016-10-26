%% nonlcon_params
% Nonlinear (in-)equality constraints on ADM1 parameters
%
function [c, ceq, varargout]= nonlcon_params(u)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

%%

c= [];
ceq= [];

%%

if nargout >= 3
    
  GC= [];
  varargout{1}= GC;

end

if nargout >= 4

  GCeq= [];
  varargout{2}= GCeq;
    
end

%%


