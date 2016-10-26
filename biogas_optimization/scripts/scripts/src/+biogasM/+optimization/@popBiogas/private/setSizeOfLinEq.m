%% biogasM.optimization.popBiogas.private.setSizeOfLinEq
% Get linear (in-)equality constraints out of the constraints of the four
% subproblems substrate, plant, state and ADM params.
%
function A= setSizeOfLinEq(obj, A_substrate, A_plant, A_state, A_params, ...
                                varargin)
%% Release: 1.4

%%

error( nargchk(5, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 6 && ~isempty(varargin{1})
  constrained= varargin{1};
else
  constrained= 1;
end

%%
% check params

validateattributes(A_substrate, {'double'}, {'2d'}, mfilename, 'A_substrate',  1);
validateattributes(A_plant,     {'double'}, {'2d'}, mfilename, 'A_plant',      2);
validateattributes(A_state,     {'double'}, {'2d'}, mfilename, 'A_state',      3);
validateattributes(A_params,    {'double'}, {'2d'}, mfilename, 'A_params',     4);

is0or1(constrained, 'constrained',  5);


%%

if constrained

  LB= [obj.pop_substrate.conObj.conLB, ...
       obj.pop_plant.conObj.conLB, obj.pop_state.conObj.conLB, ...
       obj.pop_params.conObj.conLB];

else

  LB= [obj.pop_substrate.conObj.LB, ...
       obj.pop_plant.conObj.LB, obj.pop_state.conObj.LB, ...
       obj.pop_params.conObj.LB];

end


%%

% blockdiagonale matrix, da jede randbedingung A für sich alleine
% wirken muss, also bspw:
%
%    [A_substrate, 0      , 0      , 0       ]
% A= [0          , A_plant, 0      , 0       ] * x <= b
%    [0          , 0      , A_state, 0       ]
%    [0          , 0      , 0      , A_params]
%
A= blkdiag(A_substrate, A_plant, A_state, A_params);

% das ist die korrekte spaltenzahl der endgültigen matrix A
LB_cols= size(LB, 2);

%%

% die zahl der reihen stimmt schon mal
rows_A= size(A, 1);
%cols_A= size(A, 2);

%%

if constrained

  LB_substrate_cols= size(obj.pop_substrate.conObj.conLB, 2);
  LB_plant_cols=     size(obj.pop_plant.conObj.conLB, 2);
  LB_state_cols=     size(obj.pop_state.conObj.conLB, 2);
  LB_params_cols=    size(obj.pop_params.conObj.conLB, 2);

else

  LB_substrate_cols= size(obj.pop_substrate.conObj.LB, 2);
  LB_plant_cols=     size(obj.pop_plant.conObj.LB, 2);
  LB_state_cols=     size(obj.pop_state.conObj.LB, 2);
  LB_params_cols=    size(obj.pop_params.conObj.LB, 2);

end


%%

if isempty(A_substrate)
  % es wird am anfang mit 0er aufgefüllt, falls LB_cols > size(A,2)
  % also der grund für die differenz ist dann, dass substrate keine
  % lineare RB hat, 
  %% TODO
  % ist das richtig? müsste anstatt der differenz
  % da nicht L_substrate_cols stehen?
  %
  A= [ zeros( size(A,1), LB_cols - size(A,2) ), ...
                                                A ];
end

%%

if isempty(A_plant)
  % 
  A= [ zeros( size(A,1), ...
              LB_substrate_cols - size(A_substrate,2) ), ...
       A, ...
       zeros( size(A,1), LB_state_cols - size(A_plant,2) ) ...
     ];
end

%%

if isempty(A_state)
  A= [A, zeros(size(A,1), LB_cols - size(A,2))];
end

%%

if isempty(A_params)
  A= [A, zeros(size(A,1), LB_cols - size(A,2))];
end

%%

if numel(A) == 0
  A= [];
end


%%
% Alternative Bestimmung von A, da oben nicht ganz verständlich und im
% Falle von A_state und A_params durch hinzunahme von A_params
% sicherlich nicht mehr richtig

%    [A_substrate, 0      , 0      , 0       ]
% A= [0          , A_plant, 0      , 0       ]
%    [0          , 0      , A_state, 0       ]
%    [0          , 0      , 0      , A_params]
%
% A= [A1         , A2     , A3     , A4      ]
%

%%
% A1
% der ausdruck in der ersten zeile ist nur dafür da, falls 
% A_substrate leer ist, dann mit 0er füllen
A1= [ [A_substrate, zeros( size(A_substrate, 1), ...
                           LB_substrate_cols - size(A_substrate, 2) )]; ...
      zeros( rows_A - size(A_substrate, 1), LB_substrate_cols ) ];

%%
% A2
% Ausdruck in der zweiten zeile, falls A_plant leer ist, dann mit 0er
% füllen
A2= [ zeros( size(A_substrate, 1), LB_plant_cols ); ...
      [A_plant, zeros( size(A_plant, 1), ...
                       LB_plant_cols - size(A_plant, 2) )]; ...
      zeros( rows_A - size(A_substrate, 1) - size(A_plant, 1), ...
             LB_plant_cols ) ];

%%
% A3
% Ausdruck in der dritten zeile, falls A_state leer ist, 
% dann mit 0er füllen
A3= [ zeros( size(A_substrate, 1), LB_state_cols ); ...
      zeros( size(A_plant, 1), LB_state_cols ); ...
      [A_state, zeros( size(A_state, 1), ...
                       LB_state_cols - size(A_state, 2) )]; ...
      zeros( rows_A - size(A_substrate, 1) - ...
                      size(A_plant, 1) - size(A_state, 1), ...
             LB_state_cols ) ];

%%
% A4
% Ausdruck in der vierten zeile, falls A_params leer ist, dann mit 0er
% füllen
A4= [ zeros( size(A_substrate, 1), LB_params_cols ); ...
      zeros( size(A_plant, 1), LB_params_cols ); ...
      zeros( size(A_state, 1), LB_params_cols ); ...
      [A_params, zeros( size(A_params, 1), ...
                        LB_params_cols - size(A_params, 2) )] ];

%%

A_new= [A1, A2, A3, A4];

if numel(A_new) == 0
  A_new= [];
end

%%
% Prüfung auf Gleichheit

if max(max(abs(A - A_new))) > eps

  error('Kritischer Fehler, Matrizen nicht identisch!!!');

else

  A= A_new;

end

%%
    
        
    