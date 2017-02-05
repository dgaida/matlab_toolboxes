%% change_bounds_substrate_stock
% Change substrate_network_min/max based on available substrates (substrate_stock)
%
function [substrate_network_min, substrate_network_max]= ...
  change_bounds_substrate_stock(substrate_network_min, substrate_network_max, ...
  substrate_stock, timespan, control_horizon, substrate_network, varargin)
%% Release: 1.0

%%

error( nargchk(6, 7, nargin, 'struct') );
error( nargoutchk(2, 2, nargout, 'struct') );

%%

if nargin >= 7 && ~isempty(varargin{1})
  soft_feed= varargin{1};
  is0or1(soft_feed, 'soft_feed', 7);
else
  soft_feed= 1;
end

%%

is_substrate_network(substrate_network_min, 1);
is_substrate_network(substrate_network_max, 2);
isRn(substrate_stock, 'substrate_stock', 3);
isN(timespan, 'timespan', 4);
isN(control_horizon, 'control_horizon', 5);
is_substrate_network(substrate_network, 6);

%%

if numel(substrate_stock) ~= size(substrate_network, 1)
  error('substrate_stock must have %i elements, but has %i!', ...
    size(substrate_network, 1), numel(substrate_stock));
end

%%

if soft_feed
    
  %%
  % check whether substrate max has to be decreased
  
  %% TODO
  % wenn ich hier über den prediction horizon gehe, wird substrat
  % boundaries zu niedrig gesetzt - i have to test this what is the right
  % factor for timespan
  % at least predict for 14 days. I then assume that the duration of feed
  % change is about 28 days, a little less. but this should be enough time.
  % a longer prediction does not make sense, change of feed needs a too
  % long time
  min_pred= min( max(timespan/4, 14), timespan );
  % bei ersten phD experimenten hatte ich timespan/2 unten anstatt min_pred
  
  %% TODO
  % macht das Sinn? control_horizon ist im idealfall identisch mit pred.
  % horizon. müsste hier nicht viel mehr delta anstatt control_horizon
  % stehen? warum delta besser wäre, kann ich nicht begründen.
  % ich denke delta wäre besser, weil das die zeit ist, in der substrat
  % wirklich angewendet wird und nicht control horizon. allerdings ist
  % nutzung von Tc konservativer, vielleicht auch nicht völlig verkehrt.
  % ich denke ein mix aus beiden wäre die beste option.
  mypredtime= max(control_horizon, min_pred);
  
  % diff_subs ist negativ, wenn für das entsprechende substrat über den
  % horizont mypredtime nicht mehr genug substrat im speicher ist
  diff_subs= substrate_stock ./ mypredtime - sum(substrate_network_max, 2);
  idx= diff_subs < 0;

  %% 
  % hier mit substrate_network arbeiten, vorher substrate_network
  % normieren (ist schon normiert, in load_biogas_mat_files)

  %% TODO
  % die zeile kann man auch ohne repmat schreiben, steht in matlab
  % guidelines pdf drin
  % für jeden fermenter vervielfachen
  diff_subs= repmat(diff_subs, 1, size(substrate_network, 2));

  % diff_subs ist jetzt nach fermenter differenziert. n_substrate x
  % n_digester, das kann man so machen, weil substrate_network normiert ist
  diff_subs= diff_subs .* substrate_network;

  %% 
  % wenn substrate_stock == 0 für ein substrat, dann wird substrate_net_max
  % oben (Z.69) einmal substrahiert und hier wieder addiert. das führt dazu das
  % substrate_net_max == 0, < 0, > 0 werden kann, wobei < und > fast 0
  % bedeuten
  % wenn == 0, alles ok, dann bleibt es 0
  % wenn < 0 dann wird es in nächster zeile (Z. 99) 0 gemacht also auch ok
  % wenn > 0 dann wird unten Z. 104 dieses zu 0 gesetzt
  substrate_network_max(idx, :)= substrate_network_max(idx, :) + diff_subs(idx, :);
  
  %% 
  % substrate_network_max kann auch negativ werden, wenn diff_subs zu
  % negativ ist, wird hier auf 0 gesetzt
  substrate_network_max= max(substrate_network_max, 0);
  
  % set values almost equal to 0 (by accuracy of 0.01 m³/d) to 0
  % min bedeutet, es muss beides gelten, damit ergebnis wahr
  % ich glaube, dass bestimmung von idx2 etwas übertrieben kompliziert ist,
  % aber es funktioniert
  idx2= min( (substrate_network_max - 0.01 <= 0), (substrate_network_max + 0.01 >= 0) );
  substrate_network_max(idx2)= 0;
  
  %% TODO - ich kann den Wert nicht einfach pauschal auf 2 m³/d setzen
  % für eine full-scale anlage mag das ok sein, aber für eine pilot-scale
  % anlage wäre die zahl viel zu hoch
  %% TODO - 2 als parameter übergeben
  % wenn substrate_max > 0 und < 2 m³/d, dann begrenze max auf 2 m³/d,
  % damit substrat nicht ewig lang in sehr kleinen mengen gefüttert wird.
  % sondern einmal 2 bzw. mehrmals 2 bis substrat plötzlich zu ende ist
  idxx= min(substrate_network_max(idx, :) > 0, substrate_network_max(idx, :) < 2);
  
  if ~isempty(idxx)
    for irow= 1:size(idxx, 1)
      myidx= idxx(irow,:);
      % wertebereiche von idx und myidx sind [0; 1], d.h. ergebnis ist
      % entweder 0 oder 1, allerdings als boolean. Multiplikation
      % bedeutet, dass beide einzelne 1 sein müssen. macht auch sinn so. 
      substrate_network_max(logical(double(idx) * double(myidx)))= 2;
    end    
  end
  
  % min sollte von vorherein 0 sein, wenn ein substrat begrenzt ist, aber
  % ok
  substrate_network_min(idx, :)= min(substrate_network_min(idx, :), ...
                                     substrate_network_max(idx, :));
  
  if ~isempty(idxx)
    for irow= 1:size(idxx, 1)
      myidx= idxx(irow,:);
      % setze min auf 0. gleiche syntax wie oben, also ok
      substrate_network_min(logical(double(idx) * double(myidx)))= 0;
    end
  end
  
  %% TODO
  % muss min_limit hier auch geändert werden? besser nicht, falls ein
  % substrat 0 werden kann, dann min von vorherein 0 setzen. spricht etwas
  % dagegen das hier auf 0 zu setzen?
  % aktuell werden limits noch nicht übergeben, und auch nicht zurück
  % gegeben

  %% 
  % was ist mit max_limit ??? max_limit packe ich nie an, wenn
  % substrate_stock wieder aufgefüllt wird, muss max_limit wieder wie
  % original sein, sonst schwierigkeiten. es gibt auch keinen grund
  % max_limit zu ändern, da nicht verfügbarkeit von substrat nichts mit
  % max_limit zu tun hat, sondern nur mit substrate_stock. substrate_stock
  % setzt substrate_max immer wieder auf 0 zurück. 
  
else

  %%
  % wenn ein substrat nicht mehr vorhanden ist, dann wird min und max für
  % das substrat auf 0 gesetzt
  idx= substrate_stock <= 0;

  substrate_network_max(idx, :)= 0;
  substrate_network_min(idx, :)= 0;

  %% TODO
  % muss min_limit hier auch geändert werden? besser nicht, falls ein
  % substrat 0 werden kann, dann min von vorherein 0 setzen. spricht etwas
  % dagegen das hier auf 0 zu setzen?
  % aktuell werden limits noch nicht übergeben, und auch nicht zurück
  % gegeben

  %% 
  % was ist mit max_limit ??? max_limit packe ich nie an, wenn
  % substrate_stock wieder aufgefüllt wird, muss max_limit wieder wie
  % original sein, sonst schwierigkeiten. es gibt auch keinen grund
  % max_limit zu ändern, da nicht verfügbarkeit von substrat nichts mit
  % max_limit zu tun hat, sondern nur mit substrate_stock. substrate_stock
  % setzt substrate_max immer wieder auf 0 zurück. 
  
end

%%



%%


