%% add_noise_to_y_ekf_filterbank
% Add noise to measurement data for EKF and filterbank
%
function [y, varargout]= add_noise_to_y_ekf_filterbank(y, rel_noise_out, set)
%% Release: 0.9

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%% 

checkArgument(y, 'y', 'double', '1st');
isR(rel_noise_out, 'rel_noise_out', 2, '+');
is0or1(set, 'set', 3);

%%

std_dev_out= zeros(size(y, 2), 1);

for iy= 1:numel(std_dev_out)

  %% TODO
  % definition der std. abweichung über das SNR verhältnis
  % SNRdB= 20 * log10 (Asignal / Anoise)
  % dabei sind A die RMS Amplituden der Signale
  % Anoise= Asignal / 10^(SNRdB/20)

  Asignal= numerics.math.calcRMSE(y(:,iy), zeros(numel(y(:,iy)),1));
  %SNRdB= 30;    % macht der Wert Sinn? 20 dB == 10 %, 1 % == 40 dB

%    Anoise= Asignal / (10^(SNRdB/20));
  Anoise= Asignal * rel_noise_out;    % 5 % Fehler, ist ok, man könnte auch mal mit 10 % versuchen

  std_dev_out(iy,1)= Anoise;

  %% 
  % es kann passieren, dass y negativ wird!!!
  y(:,iy)= y(:,iy) + std_dev_out(iy,1) .* randn(size(y, 1),1);
  y(:,iy)= max(y(:,iy), 0);

  if set == 1
    figure, plot(1:size(y, 1), y(:,iy));
    % alternativ
    % figure, plot(1:toiteration, y(:,iy));
  end

end

%%

if nargout >= 2,
  varargout{1}= std_dev_out;
end

%%


