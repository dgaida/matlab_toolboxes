%% getNumDigesterSplits
% Returns number of splits between digesters on the plant
%
function [nSplits, varargout]= getNumDigesterSplits(plant_network, ...
                                                    plant_network_max, varargin)
%% Release: 1.8

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  plant= varargin{1};
  is_plant(plant, 3);
else
  plant= [];
end

if nargin >= 4 && ~isempty(varargin{2})
  delimiter= varargin{2};
  checkArgument(delimiter, 'delimiter', 'char', 4);
else
  delimiter= '_';
end

%%
% check input parameters

if ~isempty(plant)
  is_plant_network(plant_network, 1, plant);
  is_plant_network(plant_network_max, 2, plant);
else
  is_plant_network(plant_network, 1);
  is_plant_network(plant_network_max, 2);  
end

%%

n_digester= size(plant_network, 1);

%%

nSplits= 0;

%%

digester_splits= [];
digester_indices= [];

%%
% nº of Columms -> Inputs to the fermenter 
for ifermenterIn= 1:( n_digester + 1 ) 
    
  % nº of Rows -> Outputs to the fermenter
  for ifermenterOut= 1:n_digester    

    % Connection condition within fermenters
    if ( plant_network(ifermenterOut, ifermenterIn) > 0 ) && ...
       ( plant_network_max(ifermenterOut, ifermenterIn) < Inf ) 

      %%

      nSplits= nSplits + 1;
      
      %%
      
      digester_indices= [digester_indices; [ifermenterOut, ifermenterIn]];
      
      %%
      
      if ~isempty(plant)
        
        if ifermenterIn <= n_digester
          fermenterIDin=  char( plant.getDigesterID(ifermenterIn) );
        else
          fermenterIDin= 'storagetank';
        end
        
        fermenterIDout= char( plant.getDigesterID(ifermenterOut) );
        
        digester_splits= [digester_splits, {sprintf('%s%s%s', ...
                          fermenterIDout, delimiter, fermenterIDin)}];
        
      end
     
    end
    
  end
  
end

%%

if nargout >= 2
  varargout{1}= digester_splits;
end

if nargout >= 3
  varargout{2}= digester_indices;
end

%%


