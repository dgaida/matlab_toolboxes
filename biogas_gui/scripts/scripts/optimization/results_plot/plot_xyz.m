%% plot_xyz
%
%
function handles= plot_xyz(handles)
%% Release: 1.2

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

indexX= get(handles.lstXAxis, 'Value');
indexY= get(handles.lstYAxis, 'Value');
indexZ= get(handles.lstZAxis, 'Value');

if indexX == indexY || indexX == indexZ || indexZ == indexY

  return;
    
end

dataAnalysis= handles.dataAnalysis;


x= double(dataAnalysis(:,indexX));
y= double(dataAnalysis(:,indexY));
z= double(dataAnalysis(:,indexZ));


%%

plotArrows=  get(handles.chkDrawArrows, 'Value');
useKriging=  get(handles.chkUseKriging, 'Value');
chkFastSlow= get(handles.chkFastSlow,   'Value');

if (chkFastSlow)
  chkFastSlow= 'on';
else
  chkFastSlow= 'off';
end

%%

hold off;

newplot;

hold off;

%%

t_datum= double(dataAnalysis(:,1));

% t_datumm in Tagen, 1,0 = 1 Tage
t_datum= t_datum - min(t_datum);
% in Stunden
t_datum= t_datum * 24.0;
% in 10min
%t_datum= t_datum * 6;

dataAnalysis= replacedata(dataAnalysis, t_datum, 1);

%%

varnames= get(dataAnalysis, 'VarNames');

find_entry= @(varnames, entry) find(~cellfun('isempty', regexp(varnames, entry)));

col_simtime= find_entry(varnames, 'simtime');

simtime= double(dataAnalysis(:,col_simtime));

%%

if get(handles.chkScatter, 'Value')

  %%
  
  if ~get(handles.chk3D4Dplot, 'Value')

    %%
    % color is also 3rd dimension
    
    scatter3(x, y, z, [], z, 's', 'filled');

  else

    %%
    % color is 4th dimesnion: fitness
    
    indexF= get(handles.lst4Daxis, 'Value');
    
    if indexX == indexF || indexY == indexF || indexZ == indexF

      return;

    end
    
    fitness= double(dataAnalysis(:,indexF));

    %%

    plot4Dscatterdata(x, y, z, fitness, 0, useKriging, ...
                      plotArrows, simtime, chkFastSlow);
                    
    %%
        
  end
  
else
   
  %%
  
  if ~get(handles.chk3D4Dplot, 'Value')

    %%

    [X, Y, Z]= griddata_vectors(x, y, [], z, ...
                                [], [], [], [], ...
                                useKriging);
                                 
    %%
    
    surf(X, Y, Z, 'LineStyle', 'none');

  else

    %%

    indexF= get(handles.lst4Daxis, 'Value');

    %%

    if indexX == indexF || indexY == indexF || indexZ == indexF

      return;

    end

    %%

    fitness= double(dataAnalysis(:,indexF));
        
    %%

    plot4Dscatterdata(x, y, z, fitness, 1, useKriging, ...
                      plotArrows, simtime, chkFastSlow);
    
    %%
    
  end
      
end

%%

set( get( gca, 'XLabel' ), 'Interpreter', 'none' );
set( get( gca, 'YLabel' ), 'Interpreter', 'none' );
set( get( gca, 'ZLabel' ), 'Interpreter', 'none' );

%%

xlabel(char(varnames{1,indexX}));
ylabel(char(varnames{1,indexY}));
zlabel(char(varnames{1,indexZ}));

rotate3d on;

colorbar();

%%


