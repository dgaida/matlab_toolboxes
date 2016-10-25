%% Syntax
%       rho= tukeybiweight(x)
%       rho= tukeybiweight(x, C)
%
%% Description
% |rho= tukeybiweight(x)| computes Tukey's biweight rho (not psi) function.
% 
%
%%
% @param |x| : 
%
%%
% @param |C| : default: 4.6851
%
%%
% @return |rho| : 
%
%% Example
%
% 

x= -6:0.1:6;
figure, plot(x, tukeybiweight(x));
xlabel('x');
ylabel('rho(x)')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_blocks/calcfitnessdigester_min_max')">
% biogas_blocks/calcFitnessDigester_min_max</a>
% </html>
%
%% See Also
% 
% -
%
%% TODOs
% # improve documentation and create it for script
% # add reference
% # improve documentation
% 
%% <<AuthorTag_DG/>>
%% References
% # 
%


