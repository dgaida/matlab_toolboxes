%% changeColorInRGB
% Change given color colFrom in RGB image to given color colTo
%
function data= changeColorInRGB(data, colTo, varargin)
%% Release: 0.6

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  colFrom= varargin{1};
else
  colFrom= [255, 255, 255];
end

%%

data_map1= ( data(:,:,1) == colFrom(1) );
data_map2= ( data(:,:,2) == colFrom(2) );
data_map3= ( data(:,:,3) == colFrom(3) );

data_map= min(data_map1, data_map2);
data_map= min(data_map, data_map3);

clear data_map1 data_map2 data_map3;

RGB8= uint8(round(colTo * 255));

data(:,:,1)= RGB8(1) .* uint8( data_map ) + ...
             max((1 - uint8( data_map )),0) .* data(:,:,1);
data(:,:,2)= RGB8(2) .* uint8( data_map ) + ...
             max((1 - uint8( data_map )),0) .* data(:,:,2);
data(:,:,3)= RGB8(3) .* uint8( data_map ) + ...
             max((1 - uint8( data_map )),0) .* data(:,:,3);

clear data_map;

%%


