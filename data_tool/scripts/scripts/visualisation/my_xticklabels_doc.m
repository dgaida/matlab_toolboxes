%%
%MY_XTICKLABELS replaces XTickLabels with "normal" texts
%   accepting multiline texts and TEX interpreting
%   and shrinks the axis to fit the texts in the window
%
%%
%    ht = my_xticklabels(Ha, xtickpos, xtickstring)
% or
%    ht = my_xticklabels(xtickpos, xtickstring)
%
%  in:    xtickpos     XTick positions [N*1]
%        xtickstring   Strings to use as labels {N*1} cell of cells
%
%% Example
%

plot(randn(20,1))
xtl = {{'one';'two';'three'} '\alpha' {'\beta';'\gamma'}};
my_xticklabels(gca,[1 10 18],xtl);
% vertical
h = my_xticklabels([1 10 18],xtl, ...
    'Rotation',-90, ...
    'VerticalAlignment','middle', ...
    'HorizontalAlignment','left');

%%  
% Pekka Kumpulainen 12.2.2008
%
%% TODOs
% # make documentation
% # understand script
%


