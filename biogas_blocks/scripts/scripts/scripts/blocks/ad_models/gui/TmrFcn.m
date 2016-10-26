%% TmrFcn
% Timer function updating <gui_digester_combi.html gui_digester_combi>
%
function TmrFcn(src, event, handles) %Timer function
%% Release: 1.3

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% it is a double, below it is converted into a struct 'guidata'
checkArgument(handles, 'handles', 'double', '3rd');

%%

try

%%

try
  sensors= evalinMWS('sensors');
catch ME
  rethrow(ME);
end

%%

handles= guidata(handles);

%%

fermenter_id= char( handles.fermenter_id );

%%

%[aceto_ratio, hydro_ratio]= calc_aceto_hydro_ratio(sensors, handles.plant, fermenter_id);

aceto_ratio= sensors.getCurrentMeasurementDind(['aceto_hydro_', fermenter_id], 0, 2);
hydro_ratio= sensors.getCurrentMeasurementDind(['aceto_hydro_', fermenter_id], 1, 2);

set(handles.lblCH4prod, 'String', sprintf('(%.1f / %.1f) %%', ...
                                  aceto_ratio, hydro_ratio));

%%

cur_time= sensors.getCurrentTime(2);

%%

%intvars= get_intvars(sensors, fermenter_id);

%%

pH= sensors.getCurrentMeasurementD(['pH_stream_', fermenter_id, '_2'], 2);
set(handles.lblpHZu, 'String', pH);

pH= sensors.getCurrentMeasurementD(['pH_', fermenter_id, '_3'], 2);
set(handles.lblpHAb, 'String', pH);

% pH value inhibition
% IpH_a=  intvars(1,28);
% IpH_h2= intvars(1,30);
% IpH_ac= intvars(1,32);

% index is 0 based, 4. komp. ist Produkt der pH inhibition terme
IpH= sensors.getCurrentMeasurementDind(['inhibition_', fermenter_id], 3, 2);

%% TODO: 
% einfärbung sollte man graduell machen, von grün über gelb bis rot

if (IpH ...IpH_a*IpH_h2*IpH_ac 
    < 0.9) %... && any(intvars))
    set(handles.lblpHAb, 'BackgroundColor', [1,0,0]);
else
    set(handles.lblpHAb, 'BackgroundColor', [0.098,0.098,0.29]);
end

%%

VFA_TAC= sensors.getCurrentMeasurement(['VFA_TAC_', fermenter_id, '_3'], 3);
set(handles.lblfostac, 'String', VFA_TAC.Value);
set(handles.lblfostac, 'TooltipString', char(VFA_TAC.printValue()));


%%

HRT= sensors.getCurrentMeasurement(['HRT_', fermenter_id], 2);
set(handles.lblHRT, 'String', char(HRT.printValue()));

%%

OLR= sensors.getCurrentMeasurement(['OLR_', fermenter_id], 2);
set(handles.lblVolLoading, 'String', char(OLR.printValue()));

density= sensors.getCurrentMeasurementD(['density_', fermenter_id], 2);
set(handles.lblDensity, 'String', density);

TS= sensors.getCurrentMeasurement(['TS_', fermenter_id, '_3'], 2);
set(handles.lblTS, 'String', TS.Value);

if (cur_time < 10)
  set(handles.lblTSunit, 'String', char(TS.printSymbolUnit()));
end

%%

Q= sensors.getCurrentMeasurement(['Q_', fermenter_id, '_2'], 2);
set(handles.lblinout, 'String', char(Q.printValue()));  

%%  

try
  VS_COD= sensors.getCurrentMeasurement(['VS_COD_', fermenter_id, '_2'], 2, 'gCOD/l');
  set(handles.lblTSSZu, 'String', VS_COD.Value);

  VS_COD= sensors.getCurrentMeasurement(['VS_COD_', fermenter_id, '_3'], 2, 'gCOD/l');
  set(handles.lblTSSAb, 'String', VS_COD.Value);

  if (cur_time < 10)
    set(handles.lblVSunit, 'String', char(VS_COD.getUnit(false, true)));
  end
catch ME
  % getCurrentMeasurement kann einen fehler erzeugen, wenn bei convertUnit
  % nicht in gegebene unit konvertiert werden kann, das ist der fall beim
  % start der gui, vor der datenaufzeichnung
end

%%

try
  SS_COD= sensors.getCurrentMeasurement(['SS_COD_', fermenter_id, '_2'], 2, 'gCOD/l');
  set(handles.lblSSZu, 'String', SS_COD.Value);

  SS_COD= sensors.getCurrentMeasurement(['SS_COD_', fermenter_id, '_3'], 2, 'gCOD/l');
  set(handles.lblSSAb, 'String', SS_COD.Value);

  if (cur_time < 10)
    set(handles.lblSSunit, 'String', char(SS_COD.getUnit(false, true)));
  end
catch ME
  % getCurrentMeasurement kann einen fehler erzeugen, wenn bei convertUnit
  % nicht in gegebene unit konvertiert werden kann, das ist der fall beim
  % start der gui, vor der datenaufzeichnung
end

%%

Snh4= sensors.getCurrentMeasurementD(['Snh4_', fermenter_id, '_2'], 2);
set(handles.lblNH4Zu, 'String', Snh4);

Snh4= sensors.getCurrentMeasurement(['Snh4_', fermenter_id, '_3'], 2);
set(handles.lblNH4Ab, 'String', Snh4.Value);

if (cur_time < 10)
  set(handles.lblNH4unit, 'String', char(Snh4.getUnit(false, true)));
end

%%

try
  Snh3= sensors.getCurrentMeasurement(['Snh3_', fermenter_id, '_2'], 2, 'mg/l');
  set(handles.lblNH3Zu, 'String', Snh3.Value);

  Snh3= sensors.getCurrentMeasurement(['Snh3_', fermenter_id, '_3'], 2, 'mg/l');
  set(handles.lblNH3Ab, 'String', Snh3.Value);

  if (cur_time < 10)
    set(handles.lblNH3unit, 'String', char(Snh3.getUnit(false, true)));
  end
catch ME
  % getCurrentMeasurement kann einen fehler erzeugen, wenn bei convertUnit
  % nicht in gegebene unit konvertiert werden kann, das ist der fall beim
  % start der gui, vor der datenaufzeichnung
end

%%

Svfa= sensors.getCurrentMeasurement(['VFA_', fermenter_id, '_3'], 2);
set(handles.lblVFAAb, 'String', Svfa.Value);

if (cur_time < 10)
  set(handles.lblVFAunit, 'String', ['VFA ', char(Svfa.getUnit(true, true))]);
end

%%

AcVsPro= sensors.getCurrentMeasurement(['AcVsPro_', fermenter_id, '_3'], 2);
set(handles.lblAc_Pro, 'String', char(AcVsPro.printValue()));

if AcVsPro.Value < 2
    set(handles.lblAc_Pro, 'BackgroundColor', [1,0,0]);
else
    set(handles.lblAc_Pro, 'BackgroundColor', [0.098,0.098,0.29]);
end
  
%%
% nitrogen (nh4 + nh3) inhibition
% Iin= intvars(1,24);
% % nh3 inhibition
% I_NH3= intvars(1,25);

% index is 0 based, 7. komp. ist Produkt der N inhibition terme
I_N= sensors.getCurrentMeasurementDind(['inhibition_', fermenter_id], 6, 2);

if (I_N...Iin*I_NH3 
    < 0.9) %... && any(intvars))
    set(handles.lblNH3Ab, 'BackgroundColor', [1,0,0]);
else
    set(handles.lblNH3Ab, 'BackgroundColor', [0.098,0.098,0.29]);
end

%%

TAC= sensors.getCurrentMeasurementD(['TAC_', fermenter_id, '_2'], 2);
set(handles.lblsalkZu, 'String', TAC); 

TAC= sensors.getCurrentMeasurement(['TAC_', fermenter_id, '_3'], 2);
set(handles.lblsalkAb, 'String', TAC.Value); 

if (cur_time < 10)
  set(handles.lblTACunit, 'String', char(TAC.getUnit(false, true)));
end

%%

VS= sensors.getCurrentMeasurementD(['VS_', fermenter_id, '_2'], 2);
set(handles.lbloTSZu, 'String', VS); 

VS= sensors.getCurrentMeasurement(['VS_', fermenter_id, '_3'], 2);
set(handles.lbloTSAb, 'String', VS.Value); 
    
if (cur_time < 10)
  set(handles.lbloTSunit, 'String', char(VS.getUnit(false, true)));
end

%%

biogas_v= sensors.getCurrentMeasurementVector(['biogas_', fermenter_id], 6);

set(handles.lblh2vp, 'String', biogas_v.Get(3).Value * 10000);
set(handles.lblh2v,  'String', numerics.math.round_float(biogas_v.Get(0).Value, 3));

biogas_v= sensors.getCurrentMeasurementVector(['biogas_', fermenter_id], 2);

set(handles.lblch4vp, 'String', biogas_v.Get(4).Value);
set(handles.lblco2vp, 'String', biogas_v.Get(5).Value);

%%
% hydrogen inhibition
%I_H2_c4= intvars(1,26);

% index is 0 based, 8. komp. ist I_H2_c4
I_H2_c4= sensors.getCurrentMeasurementDind(['inhibition_', fermenter_id], 7, 2);

if (I_H2_c4 < 0.9) %... && any(intvars))
    set(handles.lblh2v, 'BackgroundColor', [1,0,0]);
    set(handles.lblh2vp, 'BackgroundColor', [1,0,0]);
else
    set(handles.lblh2v, 'BackgroundColor', [0.098,0.098,0.29]);
    set(handles.lblh2vp, 'BackgroundColor', [0.098,0.098,0.29]);
end

%%

if exist('biogas_v', 'var')
  set(handles.lblch4v, 'String', biogas_v.Get(1).Value);
  set(handles.lblco2v, 'String', biogas_v.Get(2).Value);
end

%%
% take the time component of any measurement
set(handles.lbltime, 'String', sprintf('%.2f d', cur_time ) );

%%

guidata(handles.guifig, handles);

%%

catch ME

  disp(ME.message);
  warning(ME.message);
  
end

%%


