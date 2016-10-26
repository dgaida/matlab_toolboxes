%% calc_Deltap
% Calculate Delta p : "Averaged Hausdorff Distance"
%
function Deltap= calc_Deltap(pf, approx, p)
%% Release: 0.9

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

isRnm(pf, 'pf', 1);
isRnm(approx, 'approx', 2);
isN(p, 'p', 3);

%%

GD= calc_GDp(pf, approx, p);
IGD= calc_IGDp(pf, approx, p);

Deltap= max(GD, IGD);

%%


