%% getDefaultMeasurementUnit
% Return the default unit for a state vector component used for
% visualization
%
function unit= getDefaultMeasurementUnit(symbol)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(symbol, 'symbol', 'char', '1st');

%%

switch symbol
  
  case {'Ssu', 'Saa', 'Sfa', 'Sva', 'Sbu', 'Spro', 'Sac', 'Sch4', 'Sco2', ...
        'Sva_', 'Sbu_', 'Spro_', 'Sac_', 'Snh3'}
    unit= 'mg/l';
   
  case 'Sh2'
    unit= 'ng/l';
    
  case {'Snh4', 'Shco3'}
    unit= 'g/l';
    
  case {'SI', 'Xc', 'Xch', 'Xpr', 'Xli', 'XI', 'Xp'}
    unit= 'gCOD/l';
    
  case {'Xsu', 'Xaa', 'Xfa', 'Xc4', 'Xpro', 'Xac', 'Xh2'}
    unit= 'g/l';
    
  case {'Scat', 'San'}
    unit= 'mol/l';
    
  case 'piSh2'
    unit= 'µbar';
    
  case {'piSch4', 'piSco2', 'pTOTAL'}
    unit= 'mbar';
    
  otherwise
    error('Unknown symbol: %s!', symbol);
    
end

%%


