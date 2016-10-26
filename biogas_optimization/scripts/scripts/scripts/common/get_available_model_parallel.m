%% get_available_model_parallel
% Get a free model if we are working in parallel mode
%
function [fcn]= get_available_model_parallel(nWorker, fcn)
%% Release: 1.2

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%
% check arguments

isN(nWorker, 'nWorker', 1);
checkArgument(fcn, 'fcn', 'char', '2nd');

%% 
% take a plant model which isn't simulating at the moment

if nWorker == 1
  return;
end

%%

while(1)

  %%
  
  ilab= 1;

  while ilab <= nWorker

    %%

    fcn_lab= [fcn, '_', sprintf('%i', ilab)];

    %fcn_lab

    if ( exist([fcn_lab, '.mat'], 'file') ~= 0 )

      %%
      % erzeuge eine Warnung um alte zu löschen, da 3 Zeilen
      % später auf eine Warnung geprüft wird, die von delete
      % erzeugt wird 
      lastwarn('');

      if ( exist([fcn_lab, '.mat'], 'file') ~= 0 )

        %%
        % darf Warnungen der Arten
        % Warning: File 'plant_sunderhook_<ilab>.mat' not
        % found. 
        % und
        % Warning: File not found or permission denied
        % erzeugen. Passiert, wenn die MAT-Datei doch nicht
        % existiert, weil sie eben noch von einem anderen
        % Worker 
        % gelöscht wurde.
        % try catch als alternative auch möglich
        delete ([fcn_lab, '.mat']);

        [warnmsg, msgid]= lastwarn;

        if ~( strcmp( msgid, 'MATLAB:DELETE:FileNotFound' ) || ...
              strcmp( msgid, 'MATLAB:DELETE:Permission' ) )

          %%

          load_system(fcn_lab);

          %%

          save_system(fcn_lab);

          %%

          %disp(['load ', fcn_lab]);

          %%

          fcn= fcn_lab;

          %fcn

          break;

        end

      end

    end

    if (ilab >= nWorker)
      ilab= 0;
    end

    ilab= ilab + 1;

  end

  if strcmp(fcn, fcn_lab)
    break;
  end

end

%disp(['Start ', fcn]);

%%



%%


