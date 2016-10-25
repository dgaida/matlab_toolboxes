%% lhSampling
% Create sample points using latin hypercube method
%
function X= lhSampling(nosp, nod, lob, upb)
%% Release: 1.8

%%

error( nargchk(4, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check params

validateattributes(nosp, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'number of sample points (nosp)', 1);

validateattributes(nod, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'number of dimensions (nod)', 2);

checkArgument(lob, 'lob', 'double', '3rd');
checkArgument(upb, 'upb', 'double', '4th');

lob= lob(:)';
upb= upb(:)';

%%

if ((size(lob,2) == nod) && (size(upb,2) == nod))

  X= lhsamp(nosp, nod);

  diff = upb - lob;

  %% TODO
  % is this for loop needed?
  for ii=1:nod
    X(:,ii)= lob(ii) + diff(ii)*X(:,ii);    
  end

else

  error('Dimension mismatch in lower and upper boundaries for search space!');

end
  
%%


