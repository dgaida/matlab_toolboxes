%%
% # entwicklung eines bhkw blocks mit dynamischer bestimmung des
% wirkungsgrads in abhängigkeit der auslastung.
% # entwicklung eines blocks anmaischgrube (mit/ohne Heizung)
% # bei ADM1: reduzierung der substratzufuhr und hochskalieren der
% konzentration um massebilanz einzuhalten
% # pumpblock in substratzufuhrblock einfügen um energieverbrauch der
% substratzufuhr berechnen zu können
% # html Ordener und unterordner müssen in matlab pfad sein, wg. hilfe zu
% biogas blöcken
% # der endlager block könnte auch das ADM1 beinhalten, da im endlager auch
% biogas entsteht, bzw. überdachtes/unüberdachtes endlager. Zustandsvektor
% wird dadurch allerdings größer. D.h. offenes endlager wie bisher,
% geschlossenes als adm1 modellieren
% # Entwicklung eines blocks silo: erhöht den säuregehalt des substrats
% unter beibehaltung des gesamten csbs. passiert im silo teilweise auch
% disintegration, hydrolyse? ist wichtig bei der kalibrierung, da über
% kalibrierungszeitraum die gefütterte maissilage eine andere ist als wie
% am ende des zeitraums. 
%
%%
% # To make and publish the toolbox call:
%
% |make_toolbox('biogas_blocks', 'GECO-C Blocks for Biogas MATLAB Tool', '1.0',
% 'H:\wissMitarbeiter\matlab_toolboxes\biogas_blocks\trunk')| 
%
% and
%
% |publish_toolbox(biogas_blocks)|
%


