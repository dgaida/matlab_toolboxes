%% Syntax
%       plot4Dscatterdata(x, y, z, fitness)
%       plot4Dscatterdata(x, y, z, fitness, plotSurface)
%       plot4Dscatterdata(x, y, z, fitness, plotSurface, useKriging)
%       plot4Dscatterdata(x, y, z, fitness, plotSurface, useKriging,
%       plotArrow) 
%       plot4Dscatterdata(x, y, z, fitness, plotSurface, useKriging,
%       plotArrow, simtime) 
%       plot4Dscatterdata(x, y, z, fitness, plotSurface, useKriging,
%       plotArrow, simtime, chkFastSlow) 
%       plot4Dscatterdata(x, y, z, fitness, plotSurface, useKriging,
%       plotArrow, simtime, chkFastSlow, Npoints) 
%
%% Description
% |plot4Dscatterdata(x, y, z, fitness)| 
%
%%
% @param |x| : data double column vector
%
%%
% @param |y| : data double column vector
%
%%
% @param |z| : data double column vector
%
%%
% 
%
%% Example
%
% 

steps= 10;    % 2
end_index= 200; %520;

make_subplot= 1;

if make_subplot
  
  dataAnalysis= load_file('nmpc_results.mat', [], ...
                          'datasets/nmpc/Dublin_2011');
                        
  v_maize=      load_file('volumeflow_maize.mat', [], ...
                          'datasets/nmpc/Dublin_2011');
  v_manure=     load_file('volumeflow_manure.mat', [], ...
                          'datasets/nmpc/Dublin_2011');
  v_manure_solids= load_file('volumeflow_manure_solids.mat', [], ...
                          'datasets/nmpc/Dublin_2011');                 
                        
else
  dataAnalysis= load_file('NMPC_data_to_plot.mat');
end

%%

ivideo= 1;

if ivideo == 1
  t_datum= double(dataAnalysis(:,1));

  % t_datum in Tagen, 1,0 = 1 Tage
  t_datum= t_datum - min(t_datum);
  % in Stunden
  x= t_datum * 24.0;
else
  x= double(dataAnalysis(:,8));
end
  
y= double(dataAnalysis(:,2));
z= double(dataAnalysis(:,3));
fitness= double(dataAnalysis(:,end));
simtime= double(dataAnalysis(:,10));

%%

%subplot(3,2,1);

%i_pic= 0;

%%

fak= 2;
figure('Position', [45 100 560*fak 420*fak]);

set(gcf, 'Renderer', 'zbuffer');

filename= sprintf('NMPC%i.avi', ivideo);

aviobject= avifile(filename, 'fps', 3); 


%%

for ii= 1:steps:end_index%52%0%1:2:520%520

  clf
  newplot
  
  %figure
  %i_pic= i_pic + 1;

  if make_subplot
    subplot(2,1,1);
  end
  
  [X, Y, Z, Fitness, criteria]= plot4Dscatterdata(x, y, z, fitness, ...
                                                  0, [], [], simtime, [], ii);

  %%
  
%   eval_at_2= 'end';
%   
%   surface(reshape( X(:,end,:), size(X,1), size(X,3) ), ...
%         reshape( Y(:,end,:), size(Y,1), size(Y,3) ), ...
%         reshape( Z(:,end,:), size(Z,1), size(Z,3) ), ...
%         reshape( eval(['Fitness(:,round(', eval_at_2, '),:)']), ...
%                  size(Fitness,1), size(Fitness,3) ) );       
%   
%   surface(reshape( X(end,:,:), size(X,2), size(X,3) ), ...
%         reshape( Y(end,:,:), size(Y,2), size(Y,3) ), ...
%         reshape( Z(end,:,:), size(Z,2), size(Z,3) ), ...
%         reshape( eval(['Fitness(round(', eval_at_2, '),:,:)']), ...
%                  size(Fitness,2), size(Fitness,3) ) );      
%   
%   surface(reshape( X(:,:,end), size(X,1), size(X,2) ), ...
%         reshape( Y(:,:,end), size(Y,1), size(Y,2) ), ...
%         reshape( Z(:,:,end), size(Z,1), size(Z,2) ), ...
%         reshape( eval(['Fitness(:,:,round(', eval_at_2, '))']), ...
%                  size(Fitness,1), size(Fitness,2) ) );
%   
%   %%
%   
%   shading interp%flat
%   alpha(0.25)

  %%

  setAxisLimits(3, min([x, y, z]), max([x, y, z]));
  
  %%
  
  if ivideo == 1
    view([42.5 + ii/25 18 + 0*ii/25]);
  else
    view([60.0 + ii/20 18 + 0*ii/25]);
  end
  
  %%
  %rotate3d on;
  
  if ivideo == 1
    xlabel('simulated control duration [h]');
  else
    xlabel('manure (solid parts) [t/d]');
  end
  
  zlabel('manure [m³/d]');
  ylabel('maize silage [t/d]');
  
  %%
  
  colorbar
  
  %%
  
  if make_subplot && sum(criteria) > 1
    subplot(2,1,2);
    
    [AX, H1, H2]= plotyy(v_maize(1, 1:(sum(criteria) - 1) * 2), ...
                         v_maize(2, 1:(sum(criteria) - 1) * 2), ...'r');
    ...hold on;
    ...plot(
    v_manure(1, 1:(sum(criteria) - 1) * 2), v_manure(2, 1:(sum(criteria) - 1) * 2));%, 'b');
    
    %hold off;
    
    set(AX(1), 'XLim', [0, max(v_maize(1,:))]);
    set(AX(2), 'XLim', [0, max(v_maize(1,:))]);
    %ylim([10, 40]);
    
    xlabel('simulated period [d]');
    %ylabel('substrate feed');
    
    set(get(AX(1), 'Ylabel'), 'String', 'maize silage [t/d]');
    set(get(AX(2), 'Ylabel'), 'String', 'manure [m³/d]'); 
    
    set(AX(1), 'YLim', [30, 40]); 
    set(AX(2), 'YLim', [14, 20]); 
    
    set(AX(1), 'YTick', 30:2:40);
    set(AX(2), 'YTick', 14:1:20);
    
%     if sum(criteria) > 1
%       legend('maize silage [t/d]', 'manure [m³/d]', 'Location', 'SE');
%     end
    
  end
  
  %%
  
  frame= getframe(gcf);

  aviobject= addframe(aviobject, frame); 
    
  %%
      
end

%%

aviobject= close(aviobject);
clear aviobject;
  

%%

% figure
% 
% dataAnalysis= load_file('equilibria_sunderhook_costs.mat');
% 
% t_datum= double(dataAnalysis(:,1));
% 
% % t_datum in Tagen, 1,0 = 1 Tage
% t_datum= t_datum - min(t_datum);
% % in Stunden
% x= t_datum * 24.0;
% 
% y= double(dataAnalysis(:,2));
% z= double(dataAnalysis(:,3));
% fitness= double(dataAnalysis(:,end));
% simtime= double(dataAnalysis(:,10));
% 
% plot4Dscatterdata(x, y, z, fitness, ...
%                   1, [], [], simtime);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/griddata_vectors')">
% script_collection/griddata_vectors</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/plot3dsurface_alpha')">
% data_tool/plot3dsurface_alpha</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/arrow3d_connect_dots')">
% data_tool/arrow3d_connect_dots</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/scatter3markeredgecolor')">
% data_tool/scatter3MarkerEdgeColor</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="plot_xyz.html">
% plot_xyz</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="gui_plot_optimresults.html">
% gui_plot_optimResults</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


