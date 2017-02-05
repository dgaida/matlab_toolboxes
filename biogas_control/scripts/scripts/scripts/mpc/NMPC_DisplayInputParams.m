%% NMPC_DisplayInputParams
% Display Input parameters of |startNMPC| function in the command
% window. 
%
function escKey= NMPC_DisplayInputParams(varargin)
%% Release: 1.5

%%

error( nargchk(27, 27, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% 
% Empty option check

for n= 1:size(varargin,2)
  if isempty (varargin{n})
    varargin{n}= '[]';
  end
end
    
%% 
% DISPLAY OF OPTIONS

disp('---------------------------------------------------------------')
disp('----------------  startNMPC function started  -----------------')
disp('---------------------------------------------------------------')
disp('Input options:                                                 ')
disp(' varargout = startNMPC(                                        ')
disp('                                                               ')
disp(['                          plant_id:        ', varargin{1}             ]) 
disp(['                          method:          ', varargin{2}             ]) 
disp(['                          change_type:     ', varargin{3}             ]) 
disp(['                          change:          ', num2str( varargin{4}  ) ]) 
disp(['                          N:               ', num2str( varargin{5}  ) ]) 
disp(['                          timespan:        ', num2str( varargin{6}  ) ]) 
disp(['                          control_horizon: ', num2str( varargin{7}  ) ]) 
disp(['                          id_read:         ', num2str( varargin{8}  ) ]) 
disp(['                          id_write:        ', num2str( varargin{9}  ) ]) 
disp(['                          parallel:        ', num2str( varargin{10} ) ]) 
disp(['                          nWorker:         ', num2str( varargin{11} ) ]) 
disp(['                          pop_size:        ', num2str( varargin{12} ) ]) 
disp(['                          nGenerations:    ', num2str( varargin{13} ) ]) 
disp(['                          OutputFcn:       ', num2str( varargin{14} ) ])
disp(['                          useInitPop:      ', num2str( varargin{15} ) ]) 
disp(['                          broken_sim:      ', varargin{1,16}          ])
disp(['                          delete_db:       ', varargin{1,17}          ])
disp(['                          database_name:   ', varargin{1,18}          ])
disp(['                          trg:             ', varargin{1,19}          ])
disp(['                          trg_opt:         ', num2str( varargin{20} ) ])
disp(['                          email:           ', varargin{23}            ])
disp(['                          delta:           ', num2str(varargin{24})   ])
disp(['                          use_real_plant:  ', num2str(varargin{25})   ])
disp(['                          use_history:     ', num2str(varargin{26})   ])
disp(['                          soft_feed:       ', num2str(varargin{27})   ])
disp('                                                               ')
disp('                           )                                   ')
disp('---------------------------------------------------------------')
disp('---------------------------------------------------------------')
disp('                                                               ')

%%
% sim_time == varargin{21} 
estimatedtime_h= fix( varargin{21} / 60 ); % hours
estimatedtime_min= round( varargin{21} - estimatedtime_h * 60); % minutes

fprintf( 'Estimated NMPC simulation time:  %i h : %i min', ...
        estimatedtime_h, estimatedtime_min );
disp('                                                               ')

%%

escKey= 'off';

%%
% if the gui_nmpc calls, the 'pause' is off
if strcmp ( varargin{22}, 'on' )
  disp('NMPC optimization started!')
else
  
  disp('Press Key to start NMPC optimization')
  keycode= getkey();

  if keycode == 27 % "ESC" key == 27
    disp('NMPC optimization canceled')
    disp(' ') % new line
    
    escKey= 'on';
  else 
    disp('NMPC optimization started!')
  end
  
end

%%


