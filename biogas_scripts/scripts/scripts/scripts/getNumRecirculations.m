%% getNumRecirculations
% Returns number of recirculations between digesters on the plant
%
function [nRecirculations, varargout]= getNumRecirculations(plant_network, varargin)
%% Release: 1.7

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  plant= varargin{1};
  is_plant(plant, 2);
else
  plant= [];
end

if nargin >= 3 && ~isempty(varargin{2})
  delimiter= varargin{2};
  checkArgument(delimiter, 'delimiter', 'char', '3rd');
else
  delimiter= '_';
end

%%
% check input parameters

if ~isempty(plant)
  is_plant_network(plant_network, 1, plant);
else
  is_plant_network(plant_network, 1);
end

%%

nRecirculations= 0;

%%

digester_recirculations= [];
digester_indices= [];

%%
% for hydraulic delays
%
% plant_network= [ 0 1 0 ]
%                [ 1 0 1 ]
%
% das erste - 1, da es aus dem Endlager heraus keine rückführung zu anderen
% fermentern geben soll, ein Endlager hat nur eingänge, das ist inherent in
% der plant_network zu erkennen, da die 3. Reihe im Bsp. oben fehlt.
% 
% die zweite - 1, da angenommen wird, dass in der letzten Spalte der letzte
% fermenter, das heißt der Nachgärer eingetragen ist und flüsse welche in
% den nachgärer gehen im modell nicht als rückführungen modelliert werden.
%
for idigester_in= 1:size(plant_network, 2) - 2

  for idigester_out= idigester_in + 1:size(plant_network, 1)

    % only the lower triangular matrix of plant_network has entries
    % which need a hydraulic delay, because they describe a return
    % flow
    if plant_network(idigester_out, idigester_in) > 0

      %%
      
      nRecirculations= nRecirculations + 1;
      
      %%
      
      digester_indices= [digester_indices; [idigester_out, idigester_in]];
      
      %%
      
      if ~isempty(plant)
        
        fermenterIDin=  char( plant.getDigesterID(idigester_in) );
        fermenterIDout= char( plant.getDigesterID(idigester_out) );
        
        digester_recirculations= [digester_recirculations, {sprintf('%s%s%s', ...
                          fermenterIDout, delimiter, fermenterIDin)}];
        
      end
     
    end
    
  end
  
end

%%

if nargout >= 2
  varargout{1}= digester_recirculations;
end

if nargout >= 3
  varargout{2}= digester_indices;
end

%%


