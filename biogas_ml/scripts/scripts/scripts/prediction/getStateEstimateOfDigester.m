%% getStateEstimateOfDigester
% Return current state estimate of a digester
%
function [x_hat, x_lb, x_ub]= getStateEstimateOfDigester(plant, sensors, fermenter_id, ...
                                           varargin)
%% Release: 1.4

%%

error( nargchk(3, 8, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1})
  method= varargin{1};
  checkArgument(method, 'method', 'char', 4);
else
  method= 'RF';
end

if nargin >= 5 && ~isempty(varargin{2})
  dataset_flag_vec= varargin{2};
  checkArgument(dataset_flag_vec, 'dataset_flag_vec', 'logical', 5);
else
  dataset_flag_vec= load_file('dataset_flag_vec');
end

if nargin >= 6 && ~isempty(varargin{3})
  goal_variables= varargin{3};
  checkArgument(goal_variables, 'goal_variables', 'cellstr', 6);
else
  goal_variables= load_file('adm1_state_abbrv');
end

%%

is_plant(plant, 1);
checkArgument(sensors, 'sensors', 'biogas.sensors || struct', '2nd');
checkArgument(fermenter_id, 'fermenter_id', 'char', '3rd');

%%

if nargin >= 7 && ~isempty(varargin{4})
  digester_state_dataset_min= varargin{4};
  checkArgument(digester_state_dataset_min, 'digester_state_dataset_min', 'double', 7);
else
  digester_state_dataset_min= load_file('digester_state_dataset_min');
  
  fermenter_index= plant.getDigesterIndex(fermenter_id);

  digester_state_dataset_min= digester_state_dataset_min(:, fermenter_index);
end

%%

if nargin >= 8 && ~isempty(varargin{5})
  digester_state_dataset_max= varargin{5};
  checkArgument(digester_state_dataset_max, 'digester_state_dataset_max', 'double', 8);
else
  digester_state_dataset_max= load_file('digester_state_dataset_max');
  
  fermenter_index= plant.getDigesterIndex(fermenter_id);

  digester_state_dataset_max= digester_state_dataset_max(:, fermenter_index);
end

%%

%% WARNING
% although we pass fermenter_id here, sensors must contain measurement data
% from both digesters. That's because we assume that the state of one
% digester may also be depend on the measured data at the other digester.
% E.g. the state of the post digester may be dependent on the state of the
% primary digester

[data]= createDataSetForPredictor(sensors, plant, fermenter_id);

if isempty(data)
  x_hat= NaN;
  x_lb= NaN;
  x_ub= NaN;
  
  return;
end

% last instance of resampled measurement data with added moving average
% filtered data 
featurevector= data(end,:);
         
featurevector= featurevector(:, dataset_flag_vec);


%%

x_hat= zeros(size(goal_variables, 1), 1);

% das sind die LB und UB der klasse in der sich x_hat befinden kann
x_lb= zeros(size(goal_variables, 1), 1);
x_ub= zeros(size(goal_variables, 1), 1);

%%

if strcmp(method, 'LDA')
  
  %%
  % look inside the subfolder LDA
  
  TransMatnorms= load_file('TransMatnorms', [], 'LDA');

  alphas= load_file('alphas', [], 'LDA');

  ClassMeanMs= load_file('ClassMeanMs', [], 'LDA');

  %%
  
end

%%

for component_id= 1:size(x_hat, 1)

  %%
  
  switch(method)
    
    case 'RF'
      %% TODO - das gibt an welche datei aus welchem exp. genommen wird
      % aktuell: sampling rate= 6 h, kein noise, alle filter, ergebnis aus
      % cross-validation exp. 1. 
      file_apdx= '_6h_0n_0f_1t';
      
      filename= sprintf('rf_model_classify_%s_v%02i%s', ...
                              fermenter_id, component_id, file_apdx);

      rf_model= load_file(filename, [], 'RF');

      %%

      no_classes= rf_model.nclass;

      %%

      classValue= classRF_predict(featurevector, rf_model);

    case 'LDA'
      component= goal_variables{component_id,1};

      TransMatnorm= TransMatnorms.(fermenter_id).(component);
      alpha= alphas.(fermenter_id).(component);
      ClassMeanM= ClassMeanMs.(fermenter_id).(component);
            
      %%

      no_classes= size(ClassMeanMs.(fermenter_id).(component), 1);

      %%
      
      classValue= LDA_lin_classifier(featurevector, no_classes, ...
                                  TransMatnorm, ClassMeanM, alpha);
      
    otherwise
      error('Unknown method: %s', method);
  end
    
  %%
  
  component_min= digester_state_dataset_min(component_id);
  component_max= digester_state_dataset_max(component_id);

  % number of classes for each component could be different, so we have to
  % do this component wise
  
  [class_real, lb, ub]= get_real_value_from_class(classValue, ...
                               component_min, component_max, no_classes);

  %%
  
  x_hat(component_id, 1)= class_real;                        

  x_lb(component_id, 1)= lb;                        
  x_ub(component_id, 1)= ub;                        

  %%
  
end

%%


