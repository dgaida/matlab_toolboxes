%% optimization.conPopulation.private.adaptConstraintsToLenGenom
% Adapt constraints A, b to length of genome of optimization problem
%
function [Amin, b]= adaptConstraintsToLenGenom(Amin, b, lenGenom)
%% Release: 1.7

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%% 
% check all arguments

checkArgument(Amin, 'Amin', 'double', '1st');
checkArgument(b,    'b',    'double', '2nd');

validateattributes(lenGenom, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'lenGenom', 3);

%%

nIneqs= size(Amin, 1);
            
% if (nIneqs > 1)
%   warning('!!! not yet tested !!!');
% end

% example:
% Amin= [1 0 1; 
%        0 0 1]
% lenGenom= 2

if (nIneqs > 0)

  % Amin= [1 0
  %        0 0
  %        1 1]
  Amin= Amin';

  % add zeros
  % Amin_ext= [1  0
  %            0  0
  %            1  0
  %            0  0
  %            0  0
  %            1  0]
  Amin_ext= [Amin(:), zeros(numel(Amin), lenGenom - 1)];

  % Amin_ext= [1 0 1 0 0 1
  %            0 0 0 0 0 0]
  Amin_ext= Amin_ext';

  % Amin_ext= [1 0 0 0 1 0 0 0 0 0 1 0]
  Amin_ext= Amin_ext(:)';

  % Amin_ext= [1  0
  %            0  0
  %            0  0
  %            0  0
  %            1  1
  %            0  0]
  Amin_ext= reshape(Amin_ext, numel(Amin_ext)/nIneqs, nIneqs);

  % Amin_ext= [1 0 0 0 1 0
  %            0 0 0 0 1 0]
  Amin_ext= Amin_ext';
  
  % Amin= [1 0 0 0 1 0
  %        0 0 0 0 1 0
  %        1 0 0 0 1 0
  %        0 0 0 0 1 0]
  Amin= repmat(Amin_ext, lenGenom, 1);

  for irow= nIneqs + 1 : nIneqs : size(Amin, 1)

    index= round((irow - 1) / nIneqs);
    
    Amin(irow:irow + nIneqs - 1, :)= ...
        [ zeros(nIneqs, index), ...
          Amin(irow:irow + nIneqs - 1, 1:end - index) ];

  end
  
  % Amin= [1 0 0 0 1 0
  %        0 0 0 0 1 0
  %        0 1 0 0 0 1
  %        0 0 0 0 0 1]

end


%%
% b

if numel(b) > 0

  % darf nicht abgefragt werden, da in conPopulation line 122, Amin schon
  % geändert wurde und nicht mehr zu dem b passt, deshalb nIneqs falsch
  % ist.
%   if numel(b) ~= nIneqs
%     error('numel(b) ~= nIneqs : %i ~= %i', numel(b), nIneqs);
%   end
  
  %% TODO
  % warum war das so?
  %b_ext= [b(:), zeros(numel(b), lenGenom - 1)];

  b_ext= [b(:); repmat(b(:), lenGenom - 1, 1)];
  
  b_ext= b_ext';

  b= b_ext(:);

end

%%
            
            
            