%% mergeTooSmallClasses
% Merges neighbouring classes if they have too few elements
%
function [yclass, my_bins, commentForPrinting]= ...
          mergeTooSmallClasses(dowhile, yclass, my_bins, varargin)
%% Release: 1.5

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(2, 3, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1})
  min_class_ub= varargin{1};
  isN(min_class_ub, 'min_class_ub', 4);
else
  min_class_ub= 5;
end

%%
% check arguments

is0or1(dowhile, 'dowhile', 1);
checkArgument(yclass, 'yclass', 'double', '2nd');
isN(my_bins, 'my_bins', 3);

%%

commentForPrinting= {''};

%%

while(dowhile)

  %%
  
  [min_class, class_id]= min(histc(yclass, 0:my_bins - 1));

  %%
  
  if min_class < min_class_ub

    %%
    
    class_id= class_id - 1;

    my_bins= my_bins - 1;

    %%
    
    if class_id == numel(unique(yclass)) - 1 % upper boundary
      yclass(yclass == class_id)= class_id - 1; % go to one previous class
    elseif class_id == 1 - 1 % lower boundary, class: 0
      yclass(yclass == class_id)= class_id + 1; % go to next class: class 1
    else
      if numel(yclass(yclass == class_id - 1)) < ...
         numel(yclass(yclass == class_id + 1)) % go to smaller class
        yclass(yclass == class_id)= class_id - 1;
      else
        yclass(yclass == class_id)= class_id + 1;
      end
    end

    %%
    % make total class number 1 smaller
    yclass(yclass > class_id)= yclass(yclass > class_id) - 1;

    warning('class:merged', 'Using only %i classes!', my_bins);

    commentForPrinting(1,1)= {[commentForPrinting{1,1}, '*']};

    %%
    
  else
    break;  % all classes are big enough
  end

end

%%


