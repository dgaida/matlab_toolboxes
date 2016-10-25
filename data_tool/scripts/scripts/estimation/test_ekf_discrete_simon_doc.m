
%%

close all;
clear;

%% 

global PUBLISH_FLAG;

%%

if ~isempty(PUBLISH_FLAG)
  return;
end

%%

D= 0.90;                    % 

params= setAM1params(D);  

%%
% we measure once per hour and simulate 100 days

sampletime= 1/24;             % days

toiteration= 100 / sampletime;% 10

%%

opt= odeset('RelTol', 1e-4, 'AbsTol', 1e-6);

load('u_rand_signal.mat');    % sample time in u is in hours

%%
% die originalen us haben zu viele Schritte, deshalb wird hier noch mal
% interpoliert, damit insgesamt 1/delta weniger Schritte in u sind

% delta= 3;
% u_size= numel(u11);
% t_sample= 0:delta:delta*(u_size - 1);
% 
% u11= interp1(t_sample, u11, 0:1:u_size - 1)';
% u12= interp1(t_sample, u12, 0:1:u_size - 1)';
% u13= interp1(t_sample, u13, 0:1:u_size - 1)';
% u21= interp1(t_sample, u21, 0:1:u_size - 1)';
% u22= interp1(t_sample, u22, 0:1:u_size - 1)';
% u23= interp1(t_sample, u23, 0:1:u_size - 1)';

%%

U= {[u11, u21], [u11, u22], [u11, u23], ...
    [u12, u21], [u12, u22], [u12, u23], ...
    [u13, u21], [u13, u22], [u13, u23]};

%%

X= load_file('X_rand_state.mat');

%%

fA= @(x)calcAM1_ABC_discrete(x, sampletime, params, 'A');
fB= @(x)calcAM1_ABC_discrete(x, sampletime, params, 'B');
fC= @(x)calcAM1_ABC_discrete(x, sampletime, params, 'C');

f= @(x, u)AM1ode4_discrete(0, x, u, sampletime, params);
h= @(x)calcAM1y(x, params);

%% TODO
% evtl. auch variieren
std_dev_in_out= 0.1;

w= [std_dev_in_out .* randn(toiteration,1), std_dev_in_out .* randn(toiteration,1)];

R= diag(std_dev_in_out.^2);

%%

std_devs= [0.01, 0.1, 1];

%%

err_mat= zeros(size(X, 1), numel(U), numel(std_devs));

%%

for istd= 1:1%numel(std_devs)

  std_dev= std_devs(istd);

  %%

  P0= std_dev^2 .* eye(4, 4);

  %%

  for ix= 1:1%size(X, 1)

    x0= X(ix, :);

    %% TODO
    % just to test
    %x0= [5 0.4 45.8 0.061];
    %x0= [0.035 0.98 0.1 0.11];
    %x0= [4.29 0.275 15.6809 0.07522];

    x0hat= x0 + std_dev .* randn(1,4);
    x0hat= max(0, x0hat);

    %%

    for iu= 1:1%numel(U)

      u= U{iu};

      %%

      [tsim, xsim]= ode15s( @AM1ode4, [0:sampletime:(toiteration - 1)*sampletime], ...
                            x0, opt, u, sampletime, params );

      y= calcAM1y(xsim, params);

      %% TODO
      % es kann passieren, dass y negativ wird!!!
      y= y + std_dev_in_out .* randn(toiteration,1);
      % y= max(y, 0);
      
      %%

      [xp, xm, Pp, Pm, K]= ...
        ekf_discrete_simon( f, h, fA, fB, fC, u, y, w, R, ...
                            x0hat, P0, toiteration );


      %%

      if(0)
      figure, plot(1:toiteration, u(1:toiteration,1), 'b', ...
                   1:toiteration, u(1:toiteration,2), 'r');

      %%

      figure, plot(1:toiteration, xsim(:,1), 1:toiteration, xp(1,:));
      figure, plot(1:toiteration, xsim(:,2), 1:toiteration, xp(2,:));
      figure, plot(1:toiteration, xsim(:,3), 1:toiteration, xp(3,:));
      figure, plot(1:toiteration, xsim(:,4), 1:toiteration, xp(4,:));
      end

      %%

      err= zeros(1,4);

      for ierr= 1:4
        err(ierr)= numerics.math.calcRMSE(xsim(:,ierr), xp(ierr,:));
      end

      err_mat(ix, iu, istd)= mean(err);

    end

  end

  %%
  % make a boxplot of err_mat

  %% TODO

  % s_u01= repmat('u01', numel(err_mat(:,1)));
  % s_u02= repmat('u02', numel(err_mat(:,2)));
  % s_u03= repmat('u03', numel(err_mat(:,3)));
  % s_u04= repmat('u04', numel(err_mat(:,4)));
  % s_u05= repmat('u05', numel(err_mat(:,5)));
  % 
  % s_meth= [s_u01; s_u02; s_u03];

  %boxplot([err_mat(:,1); err_mat(:,2); err_mat(:,3)], s_meth);

  figure, boxplot(err_mat(:,:,istd));

end

%%


