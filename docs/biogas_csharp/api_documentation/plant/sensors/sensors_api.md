# Sensors Package API Documentation

## Übersicht

Das `biogas.sensors` Namespace enthält die Klasse zur Verwaltung von Sensoren in Biogasanlagen. Die `sensors`-Klasse ist eine partielle Klasse, die über mehrere Dateien verteilt ist und eine umfassende Sensor-Verwaltung mit verschiedenen Sensor-Typen, Messwertspeicherung und -abruf ermöglicht.

---

## Klasse: `sensors`

Verwaltet eine Liste von Sensoren und Sensor-Arrays. Sensoren sind in verschiedene Typen (0-8) gruppiert, abhängig von ihrer `measure()`-Methodensignatur.

**Basisklasse:** `List<sensor>`

### Eigenschaften

#### Sensor-IDs

```csharp
public List<string> ids { get; }              // IDs aller Sensoren (read-only)
public string[] getIDs()                      // IDs als Array (für MATLAB)
```

#### Sampling-Zeit

```csharp
public double sampling_time { get; set; }     // Abtastzeit in Tagen
                                              // Standard: 12/24 = 0.5 Tage (12 Stunden)
```

#### Interne Listen (private)

```csharp
private List<sensor_array> array              // Sensor-Arrays
private List<string> ids_type0                // Typ 0: Sva_sensor, VFA_sensor, ...
private List<string> ids_type1                // Typ 1: HRT_sensor
private List<string> ids_type7                // Typ 7: TS_sensor, OLR_sensor, ...
private List<string> ids_type8                // Typ 8: Fitness-Sensoren
```

---

## Konstruktoren

### `sensors()`

Erstellt eine leere Sensor-Liste.

```csharp
var mySensors = new sensors();
```

### `sensors(sensor mySensor)`

Erstellt eine Sensor-Liste mit einem Sensor.

**Parameter:**
- `mySensor` (sensor): Initialer Sensor

```csharp
var ph_sensor = new pH_sensor("F1_3");
var mySensors = new sensors(ph_sensor);
```

### `sensors(string XMLfile, plant myPlant)`

Lädt Sensoren aus XML-Datei.

**Parameter:**
- `XMLfile` (string): Pfad zur XML-Datei
- `myPlant` (plant): Anlagen-Objekt

```csharp
var plant = new plant("plant.xml");
var mySensors = new sensors("sensors.xml", plant);
```

---

## Sensor-Verwaltung

### Sensoren hinzufügen

#### `addSensor(sensor mySensor)`

Fügt einen einzelnen Sensor hinzu.

**Parameter:**
- `mySensor` (sensor): Sensor-Objekt

**Seiteneffekt:** Fügt Sensor automatisch zur typspezifischen Liste hinzu (ids_type0, ids_type1, etc.)

**Beispiel:**
```csharp
var mySensors = new sensors();

// Verschiedene Sensor-Typen
mySensors.addSensor(new VFA_sensor("F1_3"));           // Typ 0
mySensors.addSensor(new HRT_sensor("F1"));             // Typ 1
mySensors.addSensor(new TS_sensor("F1_2"));            // Typ 7
mySensors.addSensor(new pH_fit_sensor());              // Typ 8
```

#### `addSensorArray(sensor_array mySensorArray)`

Fügt ein Sensor-Array hinzu.

**Parameter:**
- `mySensorArray` (sensor_array): Sensor-Array-Objekt

**Beispiel:**
```csharp
var Q_array = new sensor_array("Q");
Q_array.addSensor(new Q_sensor("maize"));
Q_array.addSensor(new Q_sensor("manure"));
mySensors.addSensorArray(Q_array);
```

### Sensor-Zugriff

#### `get(string id)`

Holt Sensor nach ID.

**Parameter:**
- `id` (string): Sensor-ID

**Rückgabe:**
- `sensor`: Sensor-Objekt

**Ausnahmen:**
- `exception`: Unbekannte Sensor-ID

**Beispiel:**
```csharp
sensor vfa_sensor = mySensors.get("VFA_F1_3");
```

#### `get(string id, string id_in_array)`

Holt Sensor aus Sensor-Array.

**Parameter:**
- `id` (string): Sensor-Array-ID
- `id_in_array` (string): Sensor-ID innerhalb des Arrays

**Rückgabe:**
- `sensor`: Sensor-Objekt

**Ausnahmen:**
- `exception`: Unbekannte Sensor-ID

**Beispiel:**
```csharp
// Holt Q_sensor für Mais aus Q-Array
sensor q_maize = mySensors.get("Q", "Q_maize");
```

#### `getArray(string id)`

Holt Sensor-Array nach ID.

**Parameter:**
- `id` (string): Sensor-Array-ID

**Rückgabe:**
- `sensor_array`: Sensor-Array-Objekt

**Ausnahmen:**
- `exception`: Unbekannte Sensor-Array-ID

**Beispiel:**
```csharp
sensor_array q_array = mySensors.getArray("Q");
```

#### `getIDsOfArray(string id)`

Holt IDs aller Sensoren in einem Array.

**Parameter:**
- `id` (string): Sensor-Array-ID

**Rückgabe:**
- `string[]`: Array mit Sensor-IDs

**Ausnahmen:**
- `exception`: Unbekannte Sensor-Array-ID

**Beispiel:**
```csharp
string[] q_ids = mySensors.getIDsOfArray("Q");
// z.B. ["Q_maize", "Q_manure", "Q_grass"]
```

#### `exist(string id)` / `exist(string id, string id_in_array)`

Prüft ob Sensor existiert.

**Rückgabe:**
- `bool`: true wenn vorhanden

**Beispiel:**
```csharp
if (mySensors.exist("pH_F1_3"))
{
    double ph = mySensors.getCurrentMeasurementD("pH_F1_3");
}
```

#### `getNumSensors()` / `getNumSensorsD()`

Gibt Anzahl der Sensoren zurück.

**Rückgabe:**
- `int` / `double`: Anzahl der Sensoren

---

## Sensor-Netzwerk erstellen

### `create_sensor_network(plant myPlant, substrates mySubstrates, double[,] plant_network, double[,] plant_network_max)`

Erstellt automatisch ein vollständiges Sensor-Netzwerk für eine Biogasanlage.

**Parameter:**
- `myPlant` (plant): Anlagen-Objekt
- `mySubstrates` (substrates): Substrat-Liste
- `plant_network` (double[,]): Fermenter-Verbindungsmatrix
- `plant_network_max` (double[,]): Max. Flüsse zwischen Fermentern

**Rückgabe:**
- `sensors`: Vollständiges Sensor-Objekt mit allen Sensoren

**Erstellt automatisch:**
- Pro Fermenter:
  - VFA_TAC_sensor, aceto_hydro_sensor, AcVsPro_sensor
  - HRT_sensor, faecal_sensor, inhibition_sensor
  - energyProdMicro_sensor, biogas_sensor
  - VFA_sensor, VFAmatrix_sensor (für _2 und _3)
  - Sva_sensor, Sbu_sensor, Spro_sensor, Sac_sensor
  - VS_sensor, Q_sensor
  - NH3_sensor, NH4_sensor, Norg_sensor, TKN_sensor, Ntot_sensor
  - pH_sensor, biomassAciAce_sensor, biomassMeth_sensor
  - TAC_sensor, SS_COD_sensor, VS_COD_sensor
  - heatConsumption_sensor, stirrer_sensor
  - TS_sensor, OLR_sensor, density_sensor
  - ADMstate_sensor, ADMstream_sensor, ADMintvars_sensor, ADMparams_sensor

- Für Speicher/Mixer:
  - SS_COD_sensor, VS_COD_sensor, Q_sensor für finalstorage_2
  - SS_COD_sensor, VS_COD_sensor, Q_sensor, VS_sensor für total_mix_2

- Substrat-Sensoren:
  - substrate_sensor (cost)
  - Q_sensor-Array für alle Substrate
  - substrateparams_sensor pro Substrat

- BHKW-Sensoren:
  - energyProduction_sensor pro BHKW
  - energyProdSum_sensor

- Transport-Sensoren:
  - pumpEnergy_sensor pro Pumpe
  - pumpEnergy_sensor, transportEnergy_sensor pro Substrat-Transport

- Fitness-Sensoren:
  - fitness_sensor
  - AcVsPro_fit_sensor, VFA_fit_sensor, VFA_TAC_fit_sensor
  - TS_fit_sensor, pH_fit_sensor, OLR_fit_sensor
  - TAC_fit_sensor, HRT_fit_sensor, N_fit_sensor
  - CH4_fit_sensor, SS_COD_fit_sensor, VS_COD_fit_sensor
  - gasexcess_fit_sensor, setpoint_fit_sensor
  - manurebonus_sensor, udot_sensor

- Gesamt-Sensoren:
  - total_biogas_sensor

**Beispiel:**
```csharp
var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");

// Netzwerk-Matrizen definieren
double[,] plant_network = /* ... */;
double[,] plant_network_max = /* ... */;

// Sensor-Netzwerk erstellen
var mySensors = sensors.create_sensor_network(
    plant, 
    substrates,
    plant_network,
    plant_network_max
);

// Jetzt sind alle Sensoren verfügbar
double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
double vfa = mySensors.getCurrentMeasurementD("VFA_F1_3");
// ...
```

---

## Messungen durchführen

Die `sensors`-Klasse unterstützt verschiedene `measure()`-Signaturen für unterschiedliche Sensor-Typen.

### Typ 0 & 1: Stream-Sensoren

#### `measure(double time, string id, double[] x)`

Misst Stream-basierte Werte (z.B. NH3, pH, VFA).

**Parameter:**
- `time` (double): Simulationszeit [d]
- `id` (string): Sensor-ID
- `x` (double[]): Zustandsvektor oder Stream

**Rückgabe:**
- `physValue`: Erster Messwert

**Beispiel:**
```csharp
double[] stream = /* ADM-Stream */;
physValue pH = mySensors.measure(5.0, "pH_F1_3", stream);
Console.WriteLine($"pH: {pH.Value}");
```

#### `measure(double time, string id, double[] x, out double value)`

Version mit double-Ausgabe.

**Beispiel:**
```csharp
double ph_value;
mySensors.measure(5.0, "pH_F1_3", stream, out ph_value);
```

#### `measureVec(double time, string id, double[] x)`

Misst Vektor-Werte.

**Rückgabe:**
- `physValue[]`: Messwert-Vektor

**Beispiel:**
```csharp
physValue[] vfa_components = mySensors.measureVec(5.0, "VFAmatrix_F1_3", stream);
// vfa_components[0] = Acetat
// vfa_components[1] = Propionat
// vfa_components[2] = Butyrat
```

#### Mit Parametern

```csharp
measure(double time, string id, double[] x, params double[] par)
measureVec(double time, string id, double[] x, params double[] par)
```

**Beispiel (HRT_sensor):**
```csharp
double Vliq = 2500.0;  // m³
physValue hrt = mySensors.measure(5.0, "HRT_F1", stream, Vliq);
Console.WriteLine($"HRT: {hrt.Value} d");
```

### Typ 2: Einfache Parameter-Sensoren

#### `measure(double time, string id, double param)`

Misst einfache Parameter.

**Parameter:**
- `param` (double): Zu messender Parameter

**Beispiel:**
```csharp
double fitness = 0.85;
physValue fit = mySensors.measure(5.0, "fitness", fitness);
```

### Typ 3: Substrat-abhängige Sensoren

#### `measure(double time, string id, double[] x, substrates mySubstrates)`

Misst mit Substrat-Informationen.

**Beispiel:**
```csharp
var substrates = new substrates("substrates.xml");
double[] stream = /* ... */;

physValue cost = mySensors.measure(
    5.0, 
    "substrate_cost", 
    stream, 
    substrates
);
```

#### Mit Volumenstrom

```csharp
measure(double time, string id, double[] x, substrates mySubstrates, double[] Q)
```

**Parameter:**
- `Q` (double[]): Volumenstrom der Substrate [m³/d]

**Beispiel:**
```csharp
double[] Q = {100.0, 50.0};  // Mais, Gülle
physValue vs = mySensors.measure(5.0, "VS_total_mix_2", stream, substrates, Q);
```

### Typ 4: Pumpen-Sensoren

#### `measure(double time, string id, plant myPlant, double u, double par)`

Misst Pumpen-Energie.

**Parameter:**
- `u` (double): Volumenstrom [m³/d]
- `par` (double): Zusatzparameter

**Beispiel:**
```csharp
double Q_pump = 150.0;  // m³/d
double value;
mySensors.measure(5.0, "pumpEnergy_P1", plant, Q_pump, 0.0, out value);
Console.WriteLine($"Pumpenenergie: {value} kWh/d");
```

### Typ 5: BHKW-Sensoren

#### `measure(double time, string id, plant myPlant, double[] u)`

Misst BHKW-Energie.

**Parameter:**
- `u` (double[]): Biogasstrom [m³/d]

**Beispiel:**
```csharp
double[] biogas = {10.0, 500.0, 200.0};  // H2, CH4, CO2
mySensors.measure(5.0, "energyProduction_CHP1", plant, biogas);
```

### Typ 6: Heizungs-Sensoren

#### `measureVec(double time, string id, plant myPlant, substrates mySubstrates, double[] Q)`

Misst Heizenergie.

**Parameter:**
- `Q` (double[]): Substrat-Volumenströme [m³/d]

**Beispiel:**
```csharp
double[] Q = {100.0, 50.0};
physValue[] heat = mySensors.measureVec(
    5.0, 
    "heatConsumption_F1", 
    plant, 
    substrates, 
    Q
);
```

### Typ 7: Prozess-Sensoren

#### `measure(double time, string id, double[] x, plant myPlant, substrates mySubstrates, sensors mySensors, double[] Q)`

Misst Prozessparameter (TS, OLR, Dichte).

**Parameter:**
- `x` (double[]): Zustandsvektor
- `Q` (double[]): Volumenströme [m³/d] (Substrate + Fermenter)

**Beispiel:**
```csharp
double[] x = /* ADM-Zustand */;
double[] Q = {100.0, 50.0, 0.0, 0.0};  // 2 Substrate, 2 Fermenter

double ts_value;
mySensors.measure(
    5.0, 
    "TS_F1_2", 
    x, 
    plant, 
    substrates, 
    mySensors, 
    Q, 
    out ts_value
);
Console.WriteLine($"TS: {ts_value} % FM");
```

#### Mit Netzwerk-Matrizen

```csharp
measure(double time, string id, double[] x, plant myPlant, substrates mySubstrates,
        sensors mySensors, double[,] substrate_network, double[,] plant_network, 
        string digester_id)
```

**Beispiel:**
```csharp
double olr;
mySensors.measure(
    5.0,
    "OLR_F1",
    x,
    plant,
    substrates,
    mySensors,
    substrate_network,
    plant_network,
    "F1",
    out olr
);
Console.WriteLine($"OLR: {olr} kg VS/(m³·d)");
```

### Typ 8: Fitness-Sensoren

#### `measure(double time, string id, plant myPlant, fitness_params myFitnessParams, double par)`

Misst Fitness-Werte für Optimierung.

**Parameter:**
- `myFitnessParams` (fitness_params): Fitness-Parameter
- `par` (double): Zusatzparameter

**Beispiel:**
```csharp
var fitnessParams = new fitness_params("fitness.xml");
double par = 0.0;
double fitness;

mySensors.measure(5.0, "pH_fit", plant, fitnessParams, par, out fitness);
Console.WriteLine($"pH Fitness: {fitness}");
```

### Typ 9: Substrat-Bonus-Sensoren

#### `measure(double time, string id, substrates mySubstrates, double par)`

Misst Substrat-bezogene Boni (z.B. Gülle-Bonus).

**Beispiel:**
```csharp
double manurebonus;
mySensors.measure(5.0, "manurebonus", substrates, 0.0, out manurebonus);
```

### Typ-spezifische Batch-Messungen

#### `measure_type0(double time, double[] x, string digester_id, int in_out)`

Misst alle Typ-0-Sensoren für einen Fermenter.

**Parameter:**
- `x` (double[]): Stream-Vektor
- `digester_id` (string): Fermenter-ID
- `in_out` (int): 2 für Eingang, 3 für Ausgang

**Beispiel:**
```csharp
// Alle Sensoren für F1 Ausgang (_3) messen
mySensors.measure_type0(5.0, stream, "F1", 3);
```

#### `measure_type1(double time, double[] x, string digester_id, params double[] par)`

Misst alle Typ-1-Sensoren (hauptsächlich HRT).

#### `measure_type7(double time, double[] x, plant myPlant, substrates mySubstrates, sensors mySensors, double[,] substrate_network, double[,] plant_network, string digester_id)`

Misst alle Typ-7-Sensoren (TS, OLR, Dichte).

#### `measure_type8(double time, plant myPlant, fitness_params myFitnessParams, double par)`

Misst alle Fitness-Sensoren.

**Beispiel:**
```csharp
var fitnessParams = new fitness_params("fitness.xml");
mySensors.measure_type8(5.0, plant, fitnessParams, 0.0);
```

### Stream-Messungen

#### `measureVecStream(double[] time, string id, double[,] x)`

Misst über mehrere Zeitpunkte.

**Parameter:**
- `time` (double[]): Zeitvektor [d]
- `x` (double[,]): Matrix [Dimension × Zeitpunkte]

**Ausnahmen:**
- `exception`: time.Length != x.GetLength(1)

**Beispiel:**
```csharp
double[] time = {0.0, 1.0, 2.0, 3.0};
double[,] streams = /* 34×4 Matrix */;

mySensors.measureVecStream(time, "pH_F1_3", streams);
```

---

## Messwerte abrufen

### Aktueller Messwert

#### `getCurrentMeasurement(string id)`

Holt den letzten Messwert.

**Rückgabe:**
- `physValue`: Letzter Messwert

**Beispiel:**
```csharp
physValue pH = mySensors.getCurrentMeasurement("pH_F1_3");
Console.WriteLine($"Aktueller pH: {pH.Value}");
```

#### `getCurrentMeasurementD(string id, out double value)`

Version mit double-Ausgabe.

**Beispiel:**
```csharp
double ph_value;
mySensors.getCurrentMeasurementD("pH_F1_3", out ph_value);
```

#### Mit Genauigkeit

```csharp
getCurrentMeasurement(string id, int digits)
getCurrentMeasurement(string id, int digits, string unit)
```

**Beispiel:**
```csharp
// Auf 2 Dezimalstellen runden
physValue pH = mySensors.getCurrentMeasurement("pH_F1_3", 2);

// Auf 1 Dezimalstelle runden und in °C konvertieren
physValue T = mySensors.getCurrentMeasurement("T_F1", 1, "°C");
```

#### Mit Rauschen

```csharp
getCurrentMeasurement(string id, bool noisy)
getCurrentMeasurementD(string id, bool noisy, out double value)
```

**Parameter:**
- `noisy` (bool): Wenn true, Rauschen hinzufügen (falls `apply_real_sensor` aktiviert war)

**Beispiel:**
```csharp
// Verrauschter Messwert (realistischer Sensor)
physValue pH_noisy = mySensors.getCurrentMeasurement("pH_F1_3", true);
```

#### Vektor-Messwerte

```csharp
getCurrentMeasurementVector(string id)
getCurrentMeasurementVectorD(string id, out double[] values)
```

**Beispiel:**
```csharp
// VFA-Komponenten
physValue[] vfa = mySensors.getCurrentMeasurementVector("VFAmatrix_F1_3");
Console.WriteLine($"Acetat: {vfa[0].Value}");
Console.WriteLine($"Propionat: {vfa[1].Value}");
Console.WriteLine($"Butyrat: {vfa[2].Value}");
```

#### Indizierter Zugriff

```csharp
getCurrentMeasurementDind(string id, int index)
getCurrentMeasurementDind(string id, int index, int digits)
getCurrentMeasurementDind(string id, int index, bool noisy)
```

**Parameter:**
- `index` (int): Index im Vektor (0-basiert)

**Ausnahmen:**
- `exception`: Ungültiger Index

**Beispiel:**
```csharp
// Nur Acetat (Index 0)
double acetat = mySensors.getCurrentMeasurementDind("VFAmatrix_F1_3", 0);
```

#### Parameter-spezifischer Abruf

```csharp
getCurrentMeasurement(string id, string id_in_array, string param)
getCurrentMeasurementD(string id, string id_in_array, string param, out double value)
```

**Beispiel:**
```csharp
// Spezifischer Substrat-Parameter
double ts_maize;
mySensors.getCurrentMeasurementD("substrateparams", "maize", "TS", out ts_maize);
```

### Messwert zu bestimmter Zeit

#### `getMeasurementAt(string id, double t)`

Holt Messwert zu Zeitpunkt t.

**Parameter:**
- `t` (double): Simulationszeit [d]

**Rückgabe:**
- `physValue`: Messwert zu Zeit t

**Ausnahmen:**
- `exception`: Unbekannte Sensor-ID

**Beispiel:**
```csharp
// pH am Tag 10
physValue pH_day10 = mySensors.getMeasurementAt("pH_F1_3", 10.0);
```

#### Überladungen

```csharp
getMeasurementAt(string id, double t, out double value)
getMeasurementAt(string id, string id_in_array, double t)
getMeasurementAt(string id, string id_in_array, double t, int index, bool noisy)
getMeasurementDAt(string id, string id_in_array, double t, int index, bool noisy)
```

**Beispiel:**
```csharp
// Q für Mais am Tag 5, Index 0
double q_maize = mySensors.getMeasurementDAt("Q", "Q_maize", 5.0, 0, false);
```

#### Vektor-Messwerte

```csharp
getMeasurementVectorAt(string id, double t)
getMeasurementVectorAt(string id, double t, out double[] values)
```

**Beispiel:**
```csharp
double[] vfa_day10;
mySensors.getMeasurementVectorAt("VFAmatrix_F1_3", 10.0, out vfa_day10);
```

#### Mehrere Substrate

```csharp
getMeasurementsAt(string id, string id_in_array, double t, substrates mySubstrates)
getMeasurementsAt(string id, string id_in_array, double t, substrates mySubstrates, out double[] values)
```

**Beispiel:**
```csharp
// Alle Q-Werte für alle Substrate am Tag 5
double[] Q_all;
mySensors.getMeasurementsAt("Q", "Q", 5.0, substrates, out Q_all);
// Q_all[0] = Q für Substrat 1
// Q_all[1] = Q für Substrat 2
// ...
```

### Gesamter Messverlauf

#### `getMeasurementStream(string id)`

Holt kompletten Messverlauf.

**Rückgabe:**
- `physValue[]`: Alle Messungen

**Beispiel:**
```csharp
physValue[] pH_stream = mySensors.getMeasurementStream("pH_F1_3");
for (int i = 0; i < pH_stream.Length; i++)
{
    Console.WriteLine($"Messung {i}: {pH_stream[i].Value}");
}
```

#### Überladungen

```csharp
getMeasurementStream(string id, out double[] values)
getMeasurementStream(string id, int index)
getMeasurementStream(string id, int index, out double[] values)
getMeasurementStream(string id, string id_in_array, int index)
getMeasurementStream(string id, string id_in_array, string param)
```

**Beispiel:**
```csharp
// Nur Acetat-Verlauf (Index 0)
double[] acetat_stream;
mySensors.getMeasurementStream("VFAmatrix_F1_3", 0, out acetat_stream);
```

#### Mehrdimensionale Streams

```csharp
getMeasurementStreams(string id, out string[] symbols_units)
```

**Rückgabe:**
- `double[,]`: Matrix [Messungen × Dimension]
- `symbols_units` (out string[]): Einheiten/Symbole für jede Dimension

**Beispiel:**
```csharp
string[] units;
double[,] vfa_streams = mySensors.getMeasurementStreams("VFAmatrix_F1_3", out units);

// vfa_streams[t, 0] = Acetat zu Zeit t
// vfa_streams[t, 1] = Propionat zu Zeit t
// vfa_streams[t, 2] = Butyrat zu Zeit t

Console.WriteLine($"Dimension 0: {units[0]}");  // z.B. "Sac_F1_3_g/l"
```

#### Alle aktuellen Messungen

```csharp
getCurrentMeasurements(out string[] symbols_units)
getCurrentMeasurements(bool noisy, out string[] symbols_units)
```

**Rückgabe:**
- `double[]`: Verkettete Messwerte aller Sensoren
- `symbols_units` (out string[]): Entsprechende Symbole/Einheiten

**Beispiel:**
```csharp
string[] labels;
double[] all_values = mySensors.getCurrentMeasurements(out labels);

for (int i = 0; i < all_values.Length; i++)
{
    Console.WriteLine($"{labels[i]}: {all_values[i]}");
}
```

### Zeit-Informationen

#### `getCurrentTime()`

Holt aktuelle Simulationszeit.

**Rückgabe:**
- `double`: Zeit [d]

**Beispiel:**
```csharp
double t_current = mySensors.getCurrentTime();
Console.WriteLine($"Aktuelle Zeit: {t_current} Tage");
```

#### Überladungen

```csharp
getCurrentTime(int digits)
getCurrentTime(string id)
getCurrentTime(string id, string id_in_array)
getPreviousTime()
```

**Beispiel:**
```csharp
double t_prev = mySensors.getPreviousTime();
double t_curr = mySensors.getCurrentTime();
double dt = t_curr - t_prev;
Console.WriteLine($"Zeitschritt: {dt} Tage");
```

#### `getTimeStream()` / `getTimeStream(string id)`

Holt kompletten Zeitvektor.

**Rückgabe:**
- `double[]`: Zeitpunkte aller Messungen [d]

**Beispiel:**
```csharp
double[] time = mySensors.getTimeStream();
double[] pH_values;
mySensors.getMeasurementStream("pH_F1_3", out pH_values);

// Zeitreihe plotten
for (int i = 0; i < time.Length; i++)
{
    Console.WriteLine($"t={time[i]:F1} d: pH={pH_values[i]:F2}");
}
```

### Spezielle Abruf-Methoden

#### `getArrayMeasurementDAt(substrates mySubstrates, string id_sensor_array, string s_operator, double t, int index, bool noisy)`

Aggregiert Messwerte eines Sensor-Arrays.

**Parameter:**
- `mySubstrates` (substrates): Substrat-Liste
- `id_sensor_array` (string): Array-ID
- `s_operator` (string): "mean" oder "sum"
- `t` (double): Simulationszeit [d]
- `index` (int): Vektor-Index
- `noisy` (bool): Rauschen aktivieren

**Rückgabe:**
- `double`: Aggregierter Wert

**Beispiel:**
```csharp
// Summe aller Q-Werte zu Zeit 5.0
double Q_total = mySensors.getArrayMeasurementDAt(
    substrates,
    "Q",
    "sum",
    5.0,
    0,
    false
);
Console.WriteLine($"Gesamt-Volumenstrom: {Q_total} m³/d");
```

#### `getMeasurementDAt(plant myPlant, string sensor_id, string s_operator, double t, int index, bool noisy)`

Aggregiert Messwerte über BHKWs oder Fermenter.

**Parameter:**
- `s_operator` (string): "chps_sum", "chps_mean", "digesters_sum", "digesters_mean"

**Beispiel:**
```csharp
// Durchschnittlicher pH aller Fermenter
double pH_mean = mySensors.getMeasurementDAt(
    plant,
    "pH",
    "digesters_mean",
    5.0,
    0,
    false
);
```

#### `getCurrentMeasurementDind(plant myPlant, string sensor_id, string s_operator, int index, bool noisy)`

Wie oben, aber für aktuellen Zeitpunkt.

#### `getMeasurementStream(plant myPlant, string sensor_id, string s_operator, int index, bool noisy, out double[] values_op)`

Holt aggregierten Messverlauf.

**Beispiel:**
```csharp
double[] energy_total;
mySensors.getMeasurementStream(
    plant,
    "energyProduction",
    "chps_sum",
    0,
    false,
    out energy_total
);

Console.WriteLine($"Gesamt-Energieproduktion:");
for (int i = 0; i < energy_total.Length; i++)
{
    Console.WriteLine($"  Messung {i}: {energy_total[i]:F1} kWh/d");
}
```

---

## Daten-Verwaltung

### Daten löschen

#### `deleteDataFromSensor(string id, string id_in_array)`

Löscht alle Messwerte eines Sensors.

**Ausnahmen:**
- `exception`: Unbekannte Sensor-ID

**Beispiel:**
```csharp
mySensors.deleteDataFromSensor("pH_F1_3", "");
```

#### `deleteDataFromAllSensors()`

Löscht alle Messwerte aller Sensoren.

**Ausnahmen:**
- `exception`: Liste nicht leer nach Löschung

**Beispiel:**
```csharp
// Reset für neue Simulation
mySensors.deleteDataFromAllSensors();
```

### Daten-Status

#### `isEmpty()`

Prüft ob Sensoren Daten enthalten.

**Rückgabe:**
- `bool`: true wenn keine Daten vorhanden

**Hinweis:** Prüft nur den ersten Sensor - alle sollten synchron sein.

**Beispiel:**
```csharp
if (mySensors.isEmpty())
{
    Console.WriteLine("Keine Messungen vorhanden");
}
```

---

## Parameter-Verwaltung

### Parameter abrufen

#### `get_param_of(string id, string symbol)`

Holt physValue-Parameter als double.

**Ausnahmen:**
- `exception`: Unbekannte Sensor-ID
- `exception`: Unbekannter Parameter
- `exception`: Konvertierung zu double fehlgeschlagen

**Beispiel:**
```csharp
double sampling = mySensors.get_param_of("pH_F1_3", "sampling_time");
```

#### `get_param_of_s(string id, string symbol)`

Holt Parameter als String.

#### `get_param_of_d(string id, string symbol)`

Holt Parameter als double.

#### `get_param_of_i(string id, string symbol)`

Holt Parameter als int.

#### Index-basiert

```csharp
get_param_of(int index, string symbol)
get_param_of_s(int index, string symbol)
get_param_of_d(int index, string symbol)
```

**Hinweis:** Index ist 1-basiert.

**Beispiel:**
```csharp
// Parameter des ersten Sensors
double param = mySensors.get_param_of(1, "some_parameter");
```

#### physValue-Parameter

```csharp
get_physValue_param(string id, int index, string param)
```

**Parameter:**
- `index` (int): Dimensions-Index (0-basiert)
- `param` (string): "Unit", "Label", oder "Symbol"

**Rückgabe:**
- `string`: Inhalt des Parameters

**Beispiel:**
```csharp
string unit = mySensors.get_physValue_param("pH_F1_3", 0, "Unit");
Console.WriteLine($"pH Einheit: {unit}");
```

### Parameter setzen

#### `set_params_of(string id, string symbol, double value)`

Setzt double-Parameter.

**Ausnahmen:**
- `exception`: Unbekannte Sensor-ID
- `exception`: Unbekannter Parameter

**Beispiel:**
```csharp
mySensors.set_params_of("pH_F1_3", "sampling_time", 0.25);
```

#### Überladungen

```csharp
set_params_of(string id, string symbol, string value)
set_params_of(string id, string symbol, physValue value)
set_params_of(int index, string symbol, double value)
set_params_of(int index, string symbol, string value)
set_params_of(int index, string symbol, physValue value)
```

---

## Spezielle Berechnungen

### Fitness-Berechnungen

#### `measure_optim_params(double time, plant myPlant, fitness_params myFitnessParams, substrates mySubstrates, double par)`

Misst alle Optimierungs-Parameter.

**Parameter:**
- `time` (double): Simulationszeit [d]
- `myPlant` (plant): Anlagen-Objekt
- `myFitnessParams` (fitness_params): Fitness-Parameter
- `mySubstrates` (substrates): Substrat-Liste
- `par` (double): Zusatzparameter

**Misst:**
- Substratkosten
- Gülle-Bonus
- Alle Typ-8-Fitness-Sensoren

**Beispiel:**
```csharp
var fitnessParams = new fitness_params("fitness.xml");

mySensors.measure_optim_params(
    10.0,
    plant,
    fitnessParams,
    substrates,
    0.0
);

// Fitness-Werte abrufen
double pH_fit = mySensors.getCurrentMeasurementD("pH_fit");
double vfa_fit = mySensors.getCurrentMeasurementD("VFA_fit");
double overall_fit = mySensors.getCurrentMeasurementD("fitness");

Console.WriteLine($"pH Fitness: {pH_fit}");
Console.WriteLine($"VFA Fitness: {vfa_fit}");
Console.WriteLine($"Gesamt-Fitness: {overall_fit}");
```

#### `calcFitnessDigester_min_max(plant myPlant, sensors mySensors, string var_id, string min_max, fitness_params myFitnessParams, string append_var_id, bool use_tukey)`

Berechnet Fitness für min/max-Grenzverletzungen.

**Parameter:**
- `var_id` (string): Variable ("pH", "TS", "VFA", ...)
- `min_max` (string): "min", "max", oder "min_max"
- `append_var_id` (string): "_2" oder "_3" (Eingang/Ausgang)
- `use_tukey` (bool): Tukey-Funktion verwenden (erlaubt Werte > 1)

**Rückgabe:**
- `double`: Fitness-Wert (0 = gut, >0 = Grenze verletzt)

**Formel (ohne Tukey):**
```
fitness = Σ(verletzt_i) / n_digester
verletzt_i = 1 wenn Grenze überschritten, 0 sonst
```

**Formel (mit Tukey):**
```
fitness = Σ(tukey(Abstand_i)) / n_digester
tukey(x) = Tukey-Biweight-Funktion
```

**Beispiel:**
```csharp
// pH soll zwischen pH_min und pH_max liegen
double pH_penalty = sensors.calcFitnessDigester_min_max(
    plant,
    mySensors,
    "pH",           // Variable
    "min_max",      // Min und Max prüfen
    fitnessParams,
    "_3",           // Fermenter-Ausgang
    false           // Einfache 0/1-Strafe
);

if (pH_penalty > 0)
{
    Console.WriteLine($"pH-Grenzen verletzt in {pH_penalty * 100:F0}% der Fermenter");
}
```

---

## XML-Verwaltung

### Laden

#### `sensors(string XMLfile, plant myPlant)`

Lädt Sensoren aus XML (bereits im Konstruktor beschrieben).

#### `getParamsFromXMLReader(ref XmlTextReader reader, plant myPlant)`

Liest Sensoren aus XML-Reader.

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader
- `myPlant` (plant): Anlagen-Objekt für Sensor-Kontext

**Gelesene Elemente:**
- `<sampling_time>`: Abtastzeit
- `<sensor id="..." spec="...">`: Einzelne Sensoren
- `<sensor_array id="...">`: Sensor-Arrays

**Beispiel:**
```csharp
XmlTextReader reader = new XmlTextReader("sensors.xml");
var sensors = new sensors();
sensors.getParamsFromXMLReader(ref reader, plant);
reader.Close();
```

### Speichern

#### `saveAsXML(string XMLfile)`

Speichert alle Sensoren in XML-Datei.

**Beispiel:**
```csharp
mySensors.saveAsXML("sensors_config.xml");
```

#### `getParamsAsXMLString()`

Gibt Sensor-Konfiguration als XML-String zurück.

**Rückgabe:**
- `string`: XML-String

**XML-Struktur:**
```xml
<?xml version="1.0" encoding="utf-8"?>
<sensors>
    <sampling_time>0.5</sampling_time>
    <sensor id="pH_F1_3" spec="pH_sensor">
        ...
    </sensor>
    <sensor_array id="Q">
        <sensor id="Q_maize" spec="Q_sensor">
            ...
        </sensor>
        ...
    </sensor_array>
</sensors>
```

### Ausgabe

#### `print()`

Gibt formatierte Sensor-Übersicht aus.

**Rückgabe:**
- `string`: Formatierter String

**Beispielausgabe:**
```
   ----------   SENSORS   ----------   
sampling time= 0.5 
pH_F1_3: 7.2
VFA_F1_3: 2500.0 mg/l
HRT_F1: 45.5 d
...
   ----------     END SENSORS     ----------   
```

**Beispiel:**
```csharp
Console.WriteLine(mySensors.print());
```

---

## Anwendungsbeispiele

### Beispiel 1: Sensor-Netzwerk erstellen und verwenden

```csharp
using biogas;
using science;

// Komponenten laden
var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");

// Netzwerk-Matrizen (vereinfacht)
double[,] substrate_network = {
    {1.0, 0.0},  // Substrat 1 zu Fermenter 1 und 2
    {0.5, 0.5}   // Substrat 2 zu Fermenter 1 und 2
};

double[,] plant_network = {
    {0, 0},
    {0, 0}
};

double[,] plant_network_max = {
    {double.PositiveInfinity, double.PositiveInfinity},
    {double.PositiveInfinity, double.PositiveInfinity}
};

// Automatisches Sensor-Netzwerk erstellen
var mySensors = sensors.create_sensor_network(
    plant,
    substrates,
    plant_network,
    plant_network_max
);

Console.WriteLine($"Sensoren erstellt: {mySensors.getNumSensors()}");
Console.WriteLine("\nVerfügbare Sensoren:");
foreach (string id in mySensors.getIDs())
{
    Console.WriteLine($"  - {id}");
}
```

### Beispiel 2: Simulation mit Messungen

```csharp
using biogas;
using science;

var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");
var mySensors = sensors.create_sensor_network(/* ... */);

// Simulation
double dt = 0.5;  // 12 Stunden
for (double t = 0; t < 30; t += dt)
{
    // ADM-Simulation liefert Stream
    double[] stream_in = /* ADM F1 Eingang */;
    double[] stream_out = /* ADM F1 Ausgang */;
    
    // Messungen durchführen
    // Typ 0: Stream-Sensoren
    mySensors.measure_type0(t, stream_in, "F1", 2);   // Eingang
    mySensors.measure_type0(t, stream_out, "F1", 3);  // Ausgang
    
    // Typ 1: HRT
    double Vliq = plant.getDigesterParam("F1", "Vliq");
    mySensors.measure_type1(t, stream_out, "F1", Vliq);
    
    // Typ 7: TS, OLR, Dichte
    double[] Q = {100.0, 50.0, 0.0, 0.0};  // Substrate + Fermenter
    mySensors.measure_type7(
        t,
        stream_in,
        plant,
        substrates,
        mySensors,
        substrate_network,
        plant_network,
        "F1"
    );
    
    // Werte abrufen
    if (t % 1.0 == 0)  // Täglich ausgeben
    {
        double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
        double vfa = mySensors.getCurrentMeasurementD("VFA_F1_3");
        double ts = mySensors.getCurrentMeasurementD("TS_F1_2");
        double olr = mySensors.getCurrentMeasurementD("OLR_F1");
        
        Console.WriteLine($"\nTag {t}:");
        Console.WriteLine($"  pH: {pH:F2}");
        Console.WriteLine($"  VFA: {vfa:F1} mg/l");
        Console.WriteLine($"  TS: {ts:F2} % FM");
        Console.WriteLine($"  OLR: {olr:F2} kg VS/(m³·d)");
    }
}

// Zeitreihen plotten
double[] time = mySensors.getTimeStream();
double[] pH_values;
mySensors.getMeasurementStream("pH_F1_3", out pH_values);

Console.WriteLine("\npH-Verlauf:");
for (int i = 0; i < time.Length; i += 10)
{
    Console.WriteLine($"t={time[i]:F1} d: pH={pH_values[i]:F2}");
}
```

### Beispiel 3: Optimierung mit Fitness-Sensoren

```csharp
using biogas;
using biooptim;

var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");
var mySensors = sensors.create_sensor_network(/* ... */);
var fitnessParams = new fitness_params("fitness.xml");

// Optimierungsschleife
double best_fitness = double.MaxValue;
double[] best_Q = null;

for (double Q_maize = 50; Q_maize <= 150; Q_maize += 10)
{
    for (double Q_manure = 50; Q_manure <= 150; Q_manure += 10)
    {
        // Simulation mit dieser Fütterung
        double[] Q = {Q_maize, Q_manure};
        
        // ... ADM-Simulation ...
        
        // Fitness messen
        mySensors.measure_optim_params(
            30.0,  // Tag 30
            plant,
            fitnessParams,
            substrates,
            0.0
        );
        
        // Gesamt-Fitness abrufen
        double fitness = mySensors.getCurrentMeasurementD("fitness");
        
        // Komponenten analysieren
        double pH_fit = mySensors.getCurrentMeasurementD("pH_fit");
        double vfa_fit = mySensors.getCurrentMeasurementD("VFA_fit");
        double ts_fit = mySensors.getCurrentMeasurementD("TS_fit");
        
        if (fitness < best_fitness)
        {
            best_fitness = fitness;
            best_Q = (double[])Q.Clone();
            
            Console.WriteLine($"\nNeues Optimum gefunden:");
            Console.WriteLine($"  Q_Mais: {Q_maize} m³/d");
            Console.WriteLine($"  Q_Gülle: {Q_manure} m³/d");
            Console.WriteLine($"  Gesamt-Fitness: {fitness:F4}");
            Console.WriteLine($"    pH: {pH_fit:F4}");
            Console.WriteLine($"    VFA: {vfa_fit:F4}");
            Console.WriteLine($"    TS: {ts_fit:F4}");
        }
    }
}

Console.WriteLine($"\n=== Optimierungsergebnis ===");
Console.WriteLine($"Beste Fütterung:");
Console.WriteLine($"  Mais: {best_Q[0]} m³/d");
Console.WriteLine($"  Gülle: {best_Q[1]} m³/d");
Console.WriteLine($"  Fitness: {best_fitness:F4}");
```

### Beispiel 4: Energie-Bilanz überwachen

```csharp
using biogas;
using science;

var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");
var mySensors = sensors.create_sensor_network(/* ... */);

// Simulation über 30 Tage
for (double t = 0; t < 30; t += 0.5)
{
    // ... ADM-Simulation ...
    
    // BHKW-Energie messen
    double[] biogas = /* aus ADM */;
    mySensors.measure(t, "energyProduction_CHP1", plant, biogas);
    
    // Heizenergie messen
    double[] Q = {100.0, 50.0};
    physValue[] heat = mySensors.measureVec(
        t,
        "heatConsumption_F1",
        plant,
        substrates,
        Q
    );
    
    // Pumpenenergie messen
    double Q_pump = 150.0;
    mySensors.measure(t, "pumpEnergy_P1", plant, Q_pump, 0.0);
}

// Energie-Bilanz auswerten
double[] time = mySensors.getTimeStream();
double[] P_el;
double[] P_heat;
double[] P_pump;

mySensors.getMeasurementStream("energyProduction_CHP1", 0, out P_el);
mySensors.getMeasurementStream("heatConsumption_F1", 0, out P_heat);
mySensors.getMeasurementStream("pumpEnergy_P1", 0, out P_pump);

// Statistiken
double total_el = 0;
double total_heat = 0;
double total_pump = 0;

for (int i = 0; i < P_el.Length; i++)
{
    total_el += P_el[i] * 0.5;    // × dt
    total_heat += P_heat[i] * 0.5;
    total_pump += P_pump[i] * 0.5;
}

Console.WriteLine("Energie-Bilanz (30 Tage):");
Console.WriteLine($"  Stromproduktion: {total_el:F1} kWh");
Console.WriteLine($"  Heizenergie: {total_heat:F1} kWh");
Console.WriteLine($"  Pumpenenergie: {total_pump:F1} kWh");
Console.WriteLine($"  Netto-Strom: {(total_el - total_pump):F1} kWh");

// Wirkungsgrad
double heat_ratio = total_heat / total_el;
Console.WriteLine($"\nWärmebedarf: {heat_ratio:P1} der Stromproduktion");
```

### Beispiel 5: Multi-Fermenter-Monitoring

```csharp
using biogas;
using science;

var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");
var mySensors = sensors.create_sensor_network(/* ... */);

// Simulation
double t = 10.0;  // Tag 10

// ... ADM-Simulationen für alle Fermenter ...

// Alle Typ-0-Sensoren für alle Fermenter
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    string id = plant.getDigesterID(i);
    double[] stream_out = /* ADM Ausgang */;
    
    mySensors.measure_type0(t, stream_out, id, 3);
}

// Fermenter-Vergleich
Console.WriteLine("Fermenter-Status (Tag 10):");
Console.WriteLine("ID\tpH\tVFA\tTS\tOLR");
Console.WriteLine("".PadRight(50, '-'));

for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    string id = plant.getDigesterID(i);
    
    double pH = mySensors.getCurrentMeasurementD($"pH_{id}_3");
    double vfa = mySensors.getCurrentMeasurementD($"VFA_{id}_3");
    double ts = mySensors.getCurrentMeasurementD($"TS_{id}_2");
    double olr = mySensors.getCurrentMeasurementD($"OLR_{id}");
    
    Console.WriteLine($"{id}\t{pH:F2}\t{vfa:F0}\t{ts:F1}\t{olr:F2}");
}

// Durchschnittswerte
double pH_avg = mySensors.getCurrentMeasurementD(
    plant,
    "pH",
    "digesters_mean",
    false
);

double vfa_total = mySensors.getCurrentMeasurementD(
    plant,
    "VFA",
    "digesters_sum",
    false
);

Console.WriteLine("\nDurchschnitt:");
Console.WriteLine($"  pH: {pH_avg:F2}");
Console.WriteLine($"  VFA gesamt: {vfa_total:F0} mg/l");
```

### Beispiel 6: Substrat-Optimierung

```csharp
using biogas;
using science;

var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");
var mySensors = sensors.create_sensor_network(/* ... */);

// Verschiedene Substrat-Mischungen testen
var scenarios = new Dictionary<string, double[]>
{
    {"100% Mais", new double[] {150.0, 0.0, 0.0}},
    {"100% Gülle", new double[] {0.0, 200.0, 0.0}},
    {"50/50 Mix", new double[] {75.0, 100.0, 0.0}},
    {"Optimal-Mix", new double[] {80.0, 100.0, 20.0}}
};

Console.WriteLine("Substrat-Szenario-Vergleich:\n");

foreach (var scenario in scenarios)
{
    Console.WriteLine($"{scenario.Key}:");
    
    // Simulation mit dieser Mischung
    double[] Q = scenario.Value;
    
    // ... ADM-Simulation ...
    
    // Prozessparameter messen
    double[] stream_out = /* ... */;
    mySensors.measure_type0(30.0, stream_out, "F1", 3);
    mySensors.measure_type7(
        30.0,
        stream_out,
        plant,
        substrates,
        mySensors,
        substrate_network,
        plant_network,
        "F1"
    );
    
    // Ergebnisse
    double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
    double vfa = mySensors.getCurrentMeasurementD("VFA_F1_3");
    double ts = mySensors.getCurrentMeasurementD("TS_F1_2");
    double olr = mySensors.getCurrentMeasurementD("OLR_F1");
    
    // Substratkosten
    double[] x = new double[1];
    double cost;
    mySensors.measure(30.0, "substrate_cost", x, substrates, Q, out cost);
    
    Console.WriteLine($"  pH: {pH:F2}");
    Console.WriteLine($"  VFA: {vfa:F1} mg/l");
    Console.WriteLine($"  TS: {ts:F2} % FM");
    Console.WriteLine($"  OLR: {olr:F2} kg VS/(m³·d)");
    Console.WriteLine($"  Kosten: {cost:F2} €/d");
    
    // Stabilität prüfen
    bool stable = pH >= 6.8 && pH <= 7.5 && vfa < 3000;
    Console.WriteLine($"  Stabil: {(stable ? "Ja" : "Nein")}");
    Console.WriteLine();
}
```

### Beispiel 7: Datenexport und -analyse

```csharp
using biogas;
using science;
using System.IO;

var mySensors = new sensors("sensors.xml", plant);

// Simulation bereits durchgeführt, Daten vorhanden

// Zeitreihen extrahieren
double[] time = mySensors.getTimeStream();
string[] labels;
double[,] all_streams = mySensors.getMeasurementStreams("VFAmatrix_F1_3", out labels);

// CSV-Export
using (StreamWriter writer = new StreamWriter("vfa_data.csv"))
{
    // Header
    writer.Write("Zeit [d]");
    foreach (string label in labels)
    {
        writer.Write($",{label}");
    }
    writer.WriteLine();
    
    // Daten
    for (int i = 0; i < time.Length; i++)
    {
        writer.Write($"{time[i]:F2}");
        for (int j = 0; j < all_streams.GetLength(1); j++)
        {
            writer.Write($",{all_streams[i, j]:F4}");
        }
        writer.WriteLine();
    }
}

Console.WriteLine("Daten exportiert nach vfa_data.csv");

// Statistiken
Console.WriteLine("\nVFA-Statistiken:");
for (int j = 0; j < labels.Length; j++)
{
    double min = double.MaxValue;
    double max = double.MinValue;
    double sum = 0;
    
    for (int i = 0; i < time.Length; i++)
    {
        double val = all_streams[i, j];
        min = Math.Min(min, val);
        max = Math.Max(max, val);
        sum += val;
    }
    
    double mean = sum / time.Length;
    
    Console.WriteLine($"{labels[j]}:");
    Console.WriteLine($"  Min: {min:F2}");
    Console.WriteLine($"  Max: {max:F2}");
    Console.WriteLine($"  Mean: {mean:F2}");
}
```

---

## Sensor-Typen-Übersicht

### Typ 0: Stream-Sensoren (ohne Parameter)

**Messsignatur:** `doMeasurement(double[] x)`

**Beispiele:**
- `Sva_sensor`, `Sbu_sensor`, `Spro_sensor`, `Sac_sensor`
- `VFA_sensor`, `VFAmatrix_sensor`
- `NH3_sensor`, `NH4_sensor`, `Norg_sensor`
- `pH_sensor`, `TAC_sensor`
- `VS_sensor`, `SS_COD_sensor`, `VS_COD_sensor`
- `AcVsPro_sensor`

### Typ 1: Stream-Sensoren (mit Parametern)

**Messsignatur:** `doMeasurement(double[] x, params double[] par)`

**Beispiele:**
- `HRT_sensor` (Parameter: Vliq)

### Typ 2: Parameter-Sensoren

**Messsignatur:** `doMeasurement(double param)`

**Beispiele:**
- `fitness_sensor`

### Typ 3: Substrat-abhängige Sensoren

**Messsignatur:** `doMeasurement(double[] x, substrates mySubstrates, double[] Q, params double[] par)`

**Beispiele:**
- `substrate_sensor`
- `VS_sensor` (für total_mix)

### Typ 4: Pumpen-Sensoren

**Messsignatur:** `doMeasurement(plant myPlant, double u, params double[] par)`

**Beispiele:**
- `pumpEnergy_sensor`
- `transportEnergy_sensor`

### Typ 5: BHKW-Sensoren

**Messsignatur:** `doMeasurement(plant myPlant, double[] u, string param, params double[] par)`

**Beispiele:**
- `energyProduction_sensor`
- `total_biogas_sensor`

### Typ 6: Heizungs-Sensoren

**Messsignatur:** `doMeasurement(plant myPlant, substrates mySubstrates, double[] Q, params double[] par)`

**Beispiele:**
- `heatConsumption_sensor`

### Typ 7: Prozess-Sensoren

**Messsignatur:** `doMeasurement(double[] x, plant myPlant, substrates mySubstrates, sensors mySensors, double[] Q, params double[] par)`

**Beispiele:**
- `TS_sensor`
- `OLR_sensor`
- `density_sensor`
- `stirrer_sensor`

### Typ 8: Fitness-Sensoren

**Messsignatur:** `doMeasurement(plant myPlant, fitness_params myFitnessParams, sensors mySensors, params double[] par)`

**Beispiele:**
- `AcVsPro_fit_sensor`
- `VFA_fit_sensor`
- `VFA_TAC_fit_sensor`
- `TS_fit_sensor`
- `pH_fit_sensor`
- `OLR_fit_sensor`
- `TAC_fit_sensor`
- `HRT_fit_sensor`
- `N_fit_sensor`
- `CH4_fit_sensor`
- `SS_COD_fit_sensor`
- `VS_COD_fit_sensor`
- `gasexcess_fit_sensor`
- `setpoint_fit_sensor`

### Typ 9: Substrat-Bonus-Sensoren

**Messsignatur:** `doMeasurement(substrates mySubstrates, sensors mySensors, params double[] par)`

**Beispiele:**
- `manurebonus_sensor`
- `udot_sensor`

---

## Häufige Fehler und Lösungen

### Problem 1: "Unknown sensor id"

```csharp
// FALSCH: Sensor existiert nicht
double pH = mySensors.getCurrentMeasurementD("pH_F1");  // Exception!

// RICHTIG: Vollständige Sensor-ID verwenden
double pH = mySensors.getCurrentMeasurementD("pH_F1_3");

// Oder erst prüfen
if (mySensors.exist("pH_F1_3"))
{
    double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
}
```

### Problem 2: Keine Messungen vorhanden

```csharp
// FALSCH: Abruf ohne Messung
var mySensors = new sensors();
mySensors.addSensor(new pH_sensor("F1_3"));
double pH = mySensors.getCurrentMeasurementD("pH_F1_3");  // Exception!

// RICHTIG: Erst messen
double[] stream = /* ... */;
mySensors.measure(5.0, "pH_F1_3", stream);
double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
```

### Problem 3: Index außerhalb des Bereichs

```csharp
// FALSCH: 0-basierte Indexierung für Vektor-Zugriff
double acetat = mySensors.getCurrentMeasurementDind("VFAmatrix_F1_3", 1);  // Propionat statt Acetat!

// RICHTIG: Index 0 für erstes Element
double acetat = mySensors.getCurrentMeasurementDind("VFAmatrix_F1_3", 0);

// ABER: 1-basierte Indexierung für get_param_of
double param = mySensors.get_param_of(1, "symbol");  // Erster Sensor
```

### Problem 4: Falscher Sensor-Typ

```csharp
// FALSCH: Falsche measure()-Signatur
double[] stream = /* ... */;
mySensors.measure(5.0, "HRT_F1", stream);  // HRT braucht Vliq-Parameter!

// RICHTIG: Mit Parameter
double Vliq = 2500.0;
mySensors.measure(5.0, "HRT_F1", stream, Vliq);
```

### Problem 5: Sensor-Array vs. Einzelsensor

```csharp
// FALSCH: Array-Sensor wie Einzelsensor verwenden
sensor q_sensor = mySensors.get("Q");  // Exception!

// RICHTIG: Array holen
sensor_array q_array = mySensors.getArray("Q");

// Oder Sensor aus Array holen
sensor q_maize = mySensors.get("Q", "Q_maize");
```

### Problem 6: Zeit-Inkonsistenzen

```csharp
// PROBLEM: Messungen zu verschiedenen Zeiten
mySensors.measure(5.0, "pH_F1_3", stream1);
mySensors.measure(10.0, "VFA_F1_3", stream2);

double t_pH = mySensors.getCurrentTime("pH_F1_3");    // 5.0
double t_VFA = mySensors.getCurrentTime("VFA_F1_3");  // 10.0

// BESSER: Alle Sensoren zur gleichen Zeit messen
mySensors.measure(5.0, "pH_F1_3", stream);
mySensors.measure(5.0, "VFA_F1_3", stream);
```

---

## Performance-Tipps

### 1. Batch-Messungen nutzen

```csharp
// Langsam: Einzelne Messungen
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    string id = plant.getDigesterID(i);
    mySensors.measure(t, $"pH_{id}_3", stream);
    mySensors.measure(t, $"VFA_{id}_3", stream);
    mySensors.measure(t, $"TS_{id}_2", stream);
}

// Schneller: Typ-spezifische Batch-Messungen
mySensors.measure_type0(t, stream, "F1", 3);  // Alle Typ-0 für F1_3
mySensors.measure_type7(t, stream, plant, substrates, mySensors,
                        substrate_network, plant_network, "F1");
```

### 2. Direkte Wert-Abrufe

```csharp
// Langsam: physValue erstellen und konvertieren
physValue pH_pv = mySensors.getCurrentMeasurement("pH_F1_3");
double pH = pH_pv.Value;

// Schneller: Direkt als double
double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
```

### 3. Existenz vorher prüfen

```csharp
// Ineffizient: Exception abfangen
try
{
    double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
}
catch
{
    // Sensor existiert nicht
}

// Besser: Vorher prüfen
if (mySensors.exist("pH_F1_3"))
{
    double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
}
```

### 4. Sensor-Arrays wiederverwenden

```csharp
// Ineffizient: Array jedes Mal holen
for (int i = 0; i < 100; i++)
{
    sensor_array q_array = mySensors.getArray("Q");
    // ... verwenden ...
}

// Besser: Einmal holen
sensor_array q_array = mySensors.getArray("Q");
for (int i = 0; i < 100; i++)
{
    // ... verwenden ...
}
```

### 5. Vektor-Zugriffe optimieren

```csharp
// Ineffizient: Einzelne Indizes
double sac = mySensors.getCurrentMeasurementDind("VFAmatrix_F1_3", 0);
double spro = mySensors.getCurrentMeasurementDind("VFAmatrix_F1_3", 1);
double sbu = mySensors.getCurrentMeasurementDind("VFAmatrix_F1_3", 2);

// Besser: Ganzen Vektor holen
double[] vfa;
mySensors.getCurrentMeasurementVectorD("VFAmatrix_F1_3", out vfa);
double sac = vfa[0];
double spro = vfa[1];
double sbu = vfa[2];
```

---

## Zusammenfassung der wichtigsten Methoden

### Sensor-Verwaltung

```csharp
// Hinzufügen
mySensors.addSensor(sensor mySensor)
mySensors.addSensorArray(sensor_array mySensorArray)

// Zugriff
sensor mySensors.get(string id)
sensor mySensors.get(string id, string id_in_array)
sensor_array mySensors.getArray(string id)

// Prüfen
bool mySensors.exist(string id)
int mySensors.getNumSensors()
```

### Messungen

```csharp
// Typ 0/1: Stream
physValue mySensors.measure(double time, string id, double[] x)
physValue[] mySensors.measureVec(double time, string id, double[] x, params double[] par)

// Typ 7: Prozess
void mySensors.measure(double time, string id, double[] x, plant myPlant, 
                       substrates mySubstrates, sensors mySensors, double[] Q, out double value)

// Typ 8: Fitness
void mySensors.measure_type8(double time, plant myPlant, fitness_params myFitnessParams, double par)

// Batch
void mySensors.measure_type0(double time, double[] x, string digester_id, int in_out)
```

### Messwert-Abruf

```csharp
// Aktuell
physValue mySensors.getCurrentMeasurement(string id)
void mySensors.getCurrentMeasurementD(string id, out double value)
physValue[] mySensors.getCurrentMeasurementVector(string id)

// Zu Zeit t
physValue mySensors.getMeasurementAt(string id, double t)
physValue[] mySensors.getMeasurementVectorAt(string id, double t)

// Gesamter Verlauf
physValue[] mySensors.getMeasurementStream(string id)
double[,] mySensors.getMeasurementStreams(string id, out string[] symbols_units)
double[] mySensors.getTimeStream()
```

### Daten-Verwaltung

```csharp
// Löschen
void mySensors.deleteDataFromSensor(string id, string id_in_array)
void mySensors.deleteDataFromAllSensors()

// Status
bool mySensors.isEmpty()

// XML
void mySensors.saveAsXML(string XMLfile)
string mySensors.print()
```

---

## TODOs

Laut Quellcode:

### sensors.cs
- Evtl. weitere Sensoren in `create_sensor_network` hinzufügen

### sensors_measure_type.cs
- Type 0 und Type 1 zusammenfassen (geht nicht solange von MATLAB-Sammelsensor aufgerufen wird)

### sensors_private.cs
- `getPumpedInputFlowForFermenter` macht nicht-gültige Annahme (aber jetzt OK)

---

## Best Practices

### 1. Sensor-Netzwerk verwenden

```csharp
// GUT: Automatisches Netzwerk
var mySensors = sensors.create_sensor_network(
    plant, substrates, plant_network, plant_network_max
);

// VERMEIDEN: Manuelles Hinzufügen aller Sensoren
var mySensors = new sensors();
mySensors.addSensor(new pH_sensor("F1_3"));
mySensors.addSensor(new VFA_sensor("F1_3"));
// ... hunderte Zeilen ...
```

### 2. Konsistente Mess-Zeitpunkte

```csharp
// GUT: Alle Sensoren synchron
double t = 5.0;
mySensors.measure_type0(t, stream, "F1", 3);
mySensors.measure_type7(t, stream, plant, substrates, mySensors,
                        substrate_network, plant_network, "F1");

// VERMEIDEN: Verschiedene Zeitpunkte
mySensors.measure(5.0, "pH_F1_3", stream1);
mySensors.measure(5.5, "VFA_F1_3", stream2);  // Inkonsistent!
```

### 3. Sampling-Zeit beachten

```csharp
// GUT: Respektiere sampling_time
mySensors.sampling_time = 0.5;  // 12 Stunden

for (double t = 0; t < 30; t += 0.5)
{
    mySensors.measure(t, "pH_F1_3", stream);
}

// SUBOPTIMAL: Zu häufig messen
for (double t = 0; t < 30; t += 0.01)  // Alle 14.4 min
{
    mySensors.measure(t, "pH_F1_3", stream);  // Wird nur alle 0.5d gespeichert
}
```

### 4. Fehlerbehandlung

```csharp
// GUT: Robuster Code
try
{
    if (mySensors.exist("pH_F1_3"))
    {
        double pH = mySensors.getCurrentMeasurementD("pH_F1_3");
        if (pH >= 6.5 && pH <= 8.0)
        {
            // Normal
        }
    }
}
catch (exception ex)
{
    Console.WriteLine($"Fehler beim pH-Abruf: {ex.Message}");
}
```

### 5. XML-Persistenz

```csharp
// GUT: Konfiguration speichern
var mySensors = sensors.create_sensor_network(/* ... */);
mySensors.saveAsXML("sensors_config.xml");

// Später laden
var loaded_sensors = new sensors("sensors_config.xml", plant);
```

---

## Siehe auch

- **biogas.sensor**: Basis-Sensor-Klasse
- **biogas.sensor_array**: Sensor-Array-Klasse
- **biogas.plant**: Anlagen-Verwaltung
- **biogas.substrates**: Substrat-Verwaltung
- **biooptim.fitness_params**: Fitness-Parameter für Optimierung
- Spezifische Sensor-Klassen (pH_sensor, VFA_sensor, etc.)

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*