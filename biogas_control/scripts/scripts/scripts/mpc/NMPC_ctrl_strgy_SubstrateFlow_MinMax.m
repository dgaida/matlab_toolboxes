%% NMPC_ctrl_strgy_SubstrateFlow_MinMax
% Create substrate flow min/max of nonlinearMPC function
%
function varargout= NMPC_ctrl_strgy_SubstrateFlow_MinMax(varargin)
%% Release: 1.2

%%

error( nargchk(6, 12, nargin, 'struct') );
error( nargoutchk(2, 2, nargout, 'struct') );

%%
% Input Initialization

substrate=                   varargin{1};
plant=                       varargin{2};
substrate_network_min=       varargin{3};
substrate_network_max=       varargin{4};
substrate_network_min_limit= varargin{5};
substrate_network_max_limit= varargin{6};

if nargin >= 7 && ~isempty(varargin{7})
  change_type= varargin{7};
  validatestring(change_type, {'percentual', 'absolute'}, mfilename, 'change_type', 7);
else
  change_type= 'percentual';
end

if nargin >= 8 && ~isempty(varargin{8})
  change_substrate= varargin{8};
  checkArgument(change_substrate, 'change_substrate', 'double', 8);
else
  change_substrate= 0.05;
end

if nargin >= 9 && ~isempty(varargin{9})
  trg= varargin{9};
  is_onoff(trg, 'trg', 9);
else
  trg= 'off';
end

if nargin >= 10 && ~isempty(varargin{10})
  trg_opt= varargin{10};
  isR(trg_opt, 'trg_opt', 10);
else
  trg_opt= -Inf;
end

if nargin >= 11 && ~isempty(varargin{11})
  fitness_trg= varargin{11};
  checkArgument(fitness_trg, 'fitness_trg', 'double', 11);
else
  fitness_trg= [];
end

if nargin >= 12 && ~isempty(varargin{12})
  wrng_msg= varargin{12};
  is_onoff(wrng_msg, 'wrng_msg', 12);
else
  wrng_msg= 'on';
end

%%
% check params

is_substrate(substrate, '1st');
is_plant(plant, '2nd');

is_substrate_network(substrate_network_min, 3, substrate, plant);
is_substrate_network(substrate_network_max, 4, substrate, plant);
is_substrate_network(substrate_network_min_limit, 5, substrate, plant);
is_substrate_network(substrate_network_max_limit, 6, substrate, plant);

%% 
% SUBSTRATE FLOW MIN/MAX

% Check substrate_network_min/max violation
if strcmp(wrng_msg, 'on') 
    
  NMPC_check_substrate_network_bounds(substrate_network_min, substrate_network_max, ...
  substrate_network_min_limit, substrate_network_max_limit, substrate, plant);
  
end

%% 
% Change Control Strategy

nfit_trg= size( fitness_trg, 2 );
change_max= 0.25; % André original: 0.10;  finde ich etwa zu klein
change_min= 0.005; 

%%

if strcmp( trg, 'on' ) 
    
  %%
  
  if nfit_trg >= 5    % fitness_trg > 5

    %%
    % fitness_trg : fitness is not changing
    % look at the last 5 values in fitness_trg
    if sum( abs( fitness_trg( nfit_trg - 4 : nfit_trg ) ) ) <= 0.01
      
      %%
      % increase
      if trg_opt == Inf
        change_substrate= min( change_substrate * 1.1, change_max );
        assignin( 'caller', 'change_substrate' , change_substrate );
      end
      
      % decrase
      if trg_opt == -Inf
        change_substrate= max( change_substrate * 0.9, change_min);
        assignin( 'caller', 'change_substrate' , change_substrate );
      end
      
      warning('nonlinearMPC:TriggerActive', 'Trigger active!');
      
    end
    
  end

  %% TODO
  % macht das sinn, dass das hier steht und nicht auch in if abfrage oben,
  % dass fitness sich nicht mehr ändert? 
  if trg_opt ~= Inf && trg_opt ~= -Inf
    % factor must be positive
    isR(trg_opt, 'trg_opt', 10, '+');
    
    change_substrate= change_substrate * trg_opt;
    %% TODO
    % why not set to caller workspace?
%   assignin( 'caller', 'change_substrate' , change_substrate );
  end
  
end

%% 
% NEW SUBSTRATE FLOW MAX/MIN

% set substrate mix min/max +/- around current volume flow
if strcmp(change_type, 'percentual') 
  
  %%
  
  if any(change_substrate > 1)
    error('Some element in change_substrate is larger 100 %%: %.2f %%!', ...
      100 .* max(max(change_substrate)));
  end
  
  %%
  % M[substrate_network_max/min] = M[substrate_network]*(1 +/- 10%)
  % LB for substrate_network_min
  substrate_network_min= min( max( substrate_network_min.*(1 - change_substrate), ...
          substrate_network_min_limit ), substrate_network_max_limit ); 
  
  %%
  
  substrate_network_max_new= substrate_network_max.*(1 + change_substrate);
  
  %if (change_substrate >= 0.05)
  %  substrate_network_max_new= max(substrate_network_max_new, ...
  %                                 substrate_network_max + ...
  %                                 (substrate_network_max_limit > 0) * 7.5);
  %end
        
  % UB for substrate_network_max      
  substrate_network_max= max( min( substrate_network_max_new, ...
          substrate_network_max_limit ), substrate_network_min_limit ); 

else % change_type== 'absolute'
  
  %% TODO
  % die Abfrage: (substrate_network_min_limit >= 0) kann jetzt auch
  % gelöscht werden, da es alle betrifft, vorher stand da > 0, was
  % allerdings falsch war. 
  % habe ich jetzt geändert auf: (substrate_network_max_limit > 0), da das
  % die variablen sind, welche in optimierung genutzt werden
  
  substrate_network_min= min( max( max(substrate_network_min - ...
            change_substrate .* (substrate_network_max_limit > 0), 0), ...
            substrate_network_min_limit ), ...
            substrate_network_max_limit ); % LB for substrate_network_min
  
  substrate_network_max= max( min( max(substrate_network_max + ...
            change_substrate .* (substrate_network_max_limit > 0), 0), ...
            substrate_network_max_limit ), ...
            substrate_network_min_limit ); % UB for substrate_network_max

end

%% 
% Warning ! Substrate Flow
if all( abs( substrate_network_max - substrate_network_max_limit) < 0.00001 )
  warning('nonlinearMPC:SubstrateUBequal', ...
          'substrate_network_max/limit is identical! diff= %.2f!', ...
          sum(sum(abs( substrate_network_max - substrate_network_max_limit ))));
end

if all( abs( substrate_network_min - substrate_network_min_limit) < 0.00001 )
  warning('nonlinearMPC:SubstrateLBequal', ...
          'substrate_network_min/limit is identical! diff= %.2f!', ...
          sum(sum(abs( substrate_network_min - substrate_network_min_limit ))));
end

%%
% ich glaube nicht, dass das inkonsistent ist. es könnte bspw. sein, dass
% aus irgendeinem grund (bspw. substratbegrenzung) max == min für eine
% gewisse zeit ist, aber im prinzip max_limit > min_limit ist
if sum( any( ( substrate_network_max ~= substrate_network_min ) - ...
             ( substrate_network_max_limit ~= substrate_network_min_limit ) ) ...
      )
    
  % diese warnung kann kommen, wenn ein substrat 0 ist, welches
  % allerdings eine max grenze > 0 hat. könnte andeuten, dass substrat
  % bei 0 hängen geblieben sit, sollte aber nicht passieren. 
  warning('nonlinearMPC:SubstrateBoundsInconsistent', ...
          'ERROR : Substrate Flow MIN/MAX & Limists are inconsistent!');
  
end

%%
% scheint wohl mal aufgreteten zu sein. Grund weiß ich gerade nicht. 
if any(any(isnan(substrate_network_max))) || any(any(isnan(substrate_network_min)))

  warning('nonlinearMPC:boundsNaN', 'PROBLEM!!! ERROR!!!');

  disp(substrate_network_min)

  disp(substrate_network_max)

end

%%

%% 
% Output vector
varargout = { substrate_network_min, substrate_network_max };

%%


