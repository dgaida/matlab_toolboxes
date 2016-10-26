%% biogasM.optimization.popBiogas.private.concatData
% Concatenate the data matrices out of the 4 subproblems substrate, plant, 
% state and ADM params. 
%
function popData= concatData(pop_size, data_substrate, data_plant, ...
                             data_state, data_params, popSizePlant, ...
                             popSizeState, popSizeParams)
%% Release: 1.1

%%

error( nargchk(8, 8, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(pop_size,       {'double'}, {'2d'}, mfilename, 'pop_size',       1);
validateattributes(data_substrate, {'double'}, {'2d'}, mfilename, 'data_substrate', 2);
validateattributes(data_plant,     {'double'}, {'2d'}, mfilename, 'data_plant',     3);
validateattributes(data_state,     {'double'}, {'2d'}, mfilename, 'data_state',     4);
validateattributes(data_params,    {'double'}, {'2d'}, mfilename, 'data_params',    5);
validateattributes(popSizePlant,   {'double'}, {'2d'}, mfilename, 'popSizePlant',   6);
validateattributes(popSizeState,   {'double'}, {'2d'}, mfilename, 'popSizeState',   7);
validateattributes(popSizeParams,  {'double'}, {'2d'}, mfilename, 'popSizeParams',  8);


%%

pop_mask= (pop_size > 0);

tot_pop_size= prod( pop_size(pop_mask) );

if numel( pop_size(pop_mask) ) == 0
  tot_pop_size= 0;
end

%%

if ( tot_pop_size > pop_size(1) && pop_size(1) ~= 0 )

  pop_subs= repmat(data_substrate, ...
                   tot_pop_size / pop_size(1), []);

  pop_subs= sortrows(pop_subs);

else

  pop_subs= data_substrate;

end

%%

if ( tot_pop_size > popSizePlant && popSizePlant ~= 0 )

  pop_plnt= repmat(data_plant, ...
      tot_pop_size / popSizePlant, []);

  pop_plnt= sortrows(pop_plnt);

  if popSizePlant < pop_size(1)

      %% TODO
      error('Not yet implemented');

  end

else

  pop_plnt= data_plant;

end

%%

if ( tot_pop_size > popSizeState && popSizeState ~= 0 )

  pop_stte= repmat(data_state, ...
                   tot_pop_size / popSizeState, []);

  %% TODO
  % evtl. sortrows wie oben , warum macht man das?

else

  pop_stte= data_state;

end

%%

disp('TODO! noch mal debuggen')

%%

if ( tot_pop_size > popSizeParams && popSizeParams ~= 0 )

  pop_params= repmat(data_params, ...
                     tot_pop_size / popSizeParams, []);

else

  pop_params= data_params;

end


%%

popData= [pop_subs, pop_plnt, pop_stte, pop_params];

%%


