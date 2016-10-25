%% Syntax
%       [data_filter]= filterData(data)
%       [...]= filterData(data, deviation)
%       [...]= filterData(data, deviation, replaceNANs)
%       [...]= filterData(data, deviation, replaceNANs, multiplicator)
%
%% Description
% |[data_filter]= filterData(data)| detects outliers in the double vector
% |data| using $3 \sigma$ edit rule, where $\sigma$ (sigma) is estimated using 
% the <matlab:doc('data_tool/mad') median absolute deviation> of |data|.
% Outliers are replaced using <matlab:doc('data_tool/replacenans')
% replaceNaNs>, which basically calculates the moving average of |data|.
% The filter implemented here is a 
% global filter, which only detects outliers on a global scale, so which
% are outliers regarding the whole range of values of |data|. If you want
% to detect outliers on a local scale use
% <matlab:doc('data_tool/online_outlier_detection')
% online_outlier_detection>. 
%
% For more informations on the $3 \sigma$ edit rule see the reference
% below. 
%
%%
% @param |data| : double data row- or columnvector
%
%%
% @return |data_filter| : filtered data vector with the same size as
% |data|. 
%
%%
% |[...]= filterData(data, deviation)| lets you choose how the
% standard deviation $\sigma$ should be estimated.
%
%%
% @param |deviation| : char
%
% * 'mad' : the median absolute deviation is calculated to estimate the
% standard deviation of |data|. The <matlab:doc('data_tool/mad') MAD> is an
% robust estimator for standard deviations. (Default)
% * 'std' : the normal standard deviation <matlab:doc('matlab/std') std> is
% calculated as an estimate of the real standard deviation of |data|.
%
%%
% |[...]= filterData(data, deviation, replaceNaNs)| replaces outliers or
% marks them as NaNs.
%
%%
% @param |replaceNANs| : 0 or 1, replace outliers with moving averages if
% 1 (default) calling <matlab:doc('data_tool/replacenans') replaceNaNs>,
% otherwise outliers are marked as NANs if 0. If 1, then the moving
% average is calculated using <matlab:doc('data_tool/nanmoving_average')
% data_tool/nanmoving_average>. This function is not causal as it takes
% values before and past the current value to estimate the current value
% using the moving average. 
%
%%
% |[...]= filterData(data, deviation, replaceNaNs, multiplicator)| lets you
% change the $3 \sigma$ edit rule to a |multiplicator| $\sigma$ edit rule to make
% the filter stronger (|multiplicator| < 3) or more soften (|multiplicator|
% > 3). 
%
%%
% @param |multiplicator| : double scalar. default is 3. It must be a
% positive integer.  
%
%% Examples
% 
% # Plot filtered data of the methane concentration inside a biogas stream
%

ref_ch4= load_file('reference_ch4_total_p');

figure;
plot(ref_ch4(1,:), ref_ch4(2,:), 'r', ref_ch4(1,:), filterData(ref_ch4(2,:)), 'b');
xlabel('days [d]');
ylabel('CH_4 concentration [%]');

%%
% # Plot the same data as a <matlab:doc('boxplot') box plot>.
%

s_f1= repmat('data         ', size(ref_ch4(2,:)'));
s_f2= repmat('filtered data', size(filterData(ref_ch4(2,:)')));

boxplot([ref_ch4(2,:)'; filterData(ref_ch4(2,:))'], [s_f1; s_f2]);

%%
% # Plot raw and filtered data of a biogas stream
%

ref_gas_1= load_file('reference_gas_stream_bhkw1');
ref_gas_2= load_file('reference_gas_stream_bhkw2');

figure;
subplot(1,2,1);
plot(ref_gas_1(1,:), ref_gas_1(2,:), 'r', ref_gas_1(1,:), filterData(ref_gas_1(2,:)), 'b');
xlabel('days [d]');
ylabel('biogas stream 1 [m³/d]');

subplot(1,2,2);
plot(ref_gas_2(1,:), ref_gas_2(2,:), 'r', ref_gas_2(1,:), filterData(ref_gas_2(2,:)), 'b');
xlabel('days [d]');
ylabel('biogas stream 2 [m³/d]');

%%
% # Plot raw and filtered data of produced energy
%

ref_el_1= load_file('reference_power_bhkw_1');
ref_el_2= load_file('reference_power_bhkw_2');

figure;
subplot(1,2,1);
plot(ref_el_1(1,:), ref_el_1(2,:), 'r', ref_el_1(1,:), filterData(ref_el_1(2,:)), 'b');
xlabel('days [d]');
ylabel('produced electrical energy 1 [kWh/d]');

subplot(1,2,2);
plot(ref_el_2(1,:), ref_el_2(2,:), 'r', ref_el_2(1,:), filterData(ref_el_2(2,:)), 'b');
xlabel('days [d]');
ylabel('produced electrical energy 2 [kWh/d]');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/nanmedian">
% matlab/nanmedian</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/std">
% matlab/std</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/mad">
% data_tool/mad</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/replacenans">
% data_tool/replaceNaNs</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/validateattributes">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/validatestring">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="getfiltereddatafromdb.html">
% data_tool/getFilteredDataFromDB</a>
% </html>
%
%% See Also
%
% <html>
% <a href="online_outlier_detection.html">
% data_tool/online_outlier_detection</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/median">
% matlab/median</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas/load_file')">
% biogas/load_file</a>
% </html>
%
%% TODOs
% # evtl. erweiterung auf double matrizen?
% # extend such that also a timeseries can be given to the function
% instead of data only
% # bei einigen datensätze gibt es große probleme ausreisser zu erkennen.
% Ein Beispiel ist ein Datensatz, welcher über einen großen wertebereich
% geht und ausreißer nicht über diesen wertebereich gehen, aber als
% ausreisser erkannt werden können, da diese ein kontiniuerliches signal
% unterbrechen. D.h. diese funktion schaut nicht auf die kontinuierlichkeit
% des signals, sondern nur auf den globalen wertebereich, lokale verfahren
% sind da evtl. besser, bzw. kombinationen davon. s.
% <online_outlier_detection.html online_outlier_detection>
% # make documentation for script file
% # es wird mad genutzt, sollte evtl. nanmad genutzt werden, aus
% data_tool/statistics? 
% # prüfe zu welcher toolbox load_file gehört
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Daszykowski, M., Kaczmarek, K., Vander Heyden, Y. and Walczak, B.: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\07 Robust statistics in data analysis - A review Basic concepts.pdf'', data_tool.getHelpPath())'))">
% Robust statistics in data analysis - A review Basic concepts</a>,
% Chemometrics and Intelligent Laboratory Systems, vol. 85:203-219, 
% 2007
% </li>
% </ol>
% </html>
%


