%%
% # To make and publish the toolbox call:
%
% |make_toolbox('biogas_calibration', 'GECO-C Calibration for Biogas MATLAB Tool', '1.0',
% 'H:\wissMitarbeiter\matlab_toolboxes\biogas_calibration\trunk')| 
%
% and
%
% |publish_toolbox(biogas_calibration)|
%
%% Further Topics
%
% Einige Anmerkungen zur Kalibrierung und Re-Kalibrierung von ADM1
% Parametern:
%
% # Generell ist es so, dass die ADM1 Parameter eher weniger direkt durch
% Messungen bestimmt werden können. Deshalb ist es am besten möglichst
% wenige Parameter zu verändern/kalibrieren. Eine Sensitivitätsanalyse
% hilft, um die sensitivsten Parameter zu identifizieren. Die folgende
% Arbeit zeigt eine gute Darstellung der wichtigsten Parameter (S. 98):
%
% <html>
% <ol>
% <li> 
% Wolfsberger, A.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\08 modelling and control of the anaerobic digestion of energy crops.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Modelling and Control of the Anaerobic Digestion of Energy Crops</a>, 
% Dissertation zur Erlangung des Doktorgrades an der Universität für
% Bodenkultur, 2008. 
% </li>
% </ol>
% </html>
%
% Werden Parameterwerte bestimmt, sollen die Werte mit einer zusätzlichen
% Streuweite angegeben werden (woher sollte man die bekommen, bzw. was sagt
% diese aus?). 
%
% # Rekalibrierung des ADM1:
%
% * Parameter der Substratzufuhr müssen durch regelmäßige Laboranalysen
% bestimmt werden
% * Parameter des Modells sollten nur logisch verändert werden, also nur
% wenn ein biochemischer Grund vorliegt. Der Grund ist, dass man sonst
% alles mögliche kalibrieren kann, was aber nichts mit der Realität zu tun
% hat. Bsp. für ein logischer Grund wäre bspw. ein langer Betrieb bei niedrigem pH
% Wert, damit könnte sich die untere Grenze des pH Wertes verschieben. Das
% gleiche gilt für Stickstoff-Inhibition. 
% Bspw. könnte auch etwas im System auftreten was nicht mit dem Modell
% beschreibbar ist (bspw. Antibiotika in Güllezufuhr), eine neue
% Kalibrierung würde evtl. falsche Ergebnisse liefern. 
% Deshalb ist es besser Modellparameter als konstant anzunehmen und alle
% paar Wochen mit allen Messdaten eine neue Kalibrierung zu machen. 
%
% 
%


