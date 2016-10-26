%% Syntax
%       h= numerics.conRandMatrix.hgaussian(p)
%       
%% Description
% |h= hgaussian(p)| returns double vector |h| ranging from 0.5 ... 2, for
% each point in |p| one value is returned. It is the distance of the point
% to the mean of all points scaled by a gaussian distribution. 
%
% The formula is: 
%
% $$h = 2 - 1.75 \cdot exp \left( - \frac{1}{2 \sigma^2} \cdot (x - \mu)^2 \right)$$
%
% with $x= 1:N$, with $N$ the number of points in |p|. 
% 
%%
% @param |p| : double matrix defining a set of points. row size specifies
% number of points and column number specifies dimension of points. 
%
%%
% @return |h| : double vector ranging from 0.5 ... 2
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="conrandmatrix.html">
% numerics.conRandMatrix</a>
% </html>
% ,
% <html>
% <a href="getoptimalpopulation.html">
% numerics.conRandMatrix.private.getOptimalPopulation</a>
% </html>
%
%% See Also
%
% <html>
% <a href="hlhsamp.html">
% numerics.conRandMatrix.private.hlhsamp</a>
% </html>
% ,
% <html>
% <a href="huniform.html">
% numerics.conRandMatrix.private.huniform</a>
% </html>
% ,
% <html>
% <a href="fitness1dmesh.html">
% numerics.conRandMatrix.private.fitness1dmesh</a>
% </html>
% ,
% <html>
% <a href="fitness2dmesh.html">
% numerics.conRandMatrix.private.fitness2dmesh</a>
% </html>
% ,
% <html>
% <a href="fitnessndmesh.html">
% numerics.conRandMatrix.private.fitnessndmesh</a>
% </html>
%
%% TODOs
% # check link to pdf
% # check and improve documentation a bit
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Persson, Per-Olof: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\04 Mesh Generation for Implicit Geometries.pdf'', 
% numerics_tool.getHelpPath())'))">
% Mesh Generation for Implicit Geometries</a>, 
% Submitted to the Department of Mathematics in partial fulfillment of the
% requirements for the degree of Doctor of Philosophy at the MASSACHUSETTS
% INSTITUTE OF TECHNOLOGY, 2004
% </li>
% </ol>
% </html>
%


