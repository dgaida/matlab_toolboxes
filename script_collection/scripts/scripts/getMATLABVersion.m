%% getMATLABVersion
% Get MATLAB version as a numeric number.
%
function matlab_ver= getMATLABVersion()
%% Release: 1.9

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

% get version of matlab as a struct
sver= ver('matlab');

% matlab_ver is for example 7.11, but also could be 7.8
% 7.11 is newer as 7.8
matlab_ver= str2double( sver.Version );

% get whole number: 7
m_ver= fix(matlab_ver);

% fractional digits: 0.11 or 0.8, 0.8 should be smaller then 0.11
nk= matlab_ver - m_ver;

% get 11 for 0.11 and 8 for 0.8
% multiply by 10 until we have a whole number
% for 0.8 multiply once
% for 0.11 multiply twice
while( abs( fix(nk) - nk ) > 1e-4 )
  % multiply with little more then 10, because fix returns only the digits
  % before the decimal point, so instead of 8.0000... the number could also
  % be 7.999999...
  nk= nk*10.000001;
end
    
% return 7.11 as 711
matlab_ver= m_ver * 100 + fix(nk);

%%


