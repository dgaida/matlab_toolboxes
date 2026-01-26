# Sensor Config API Documentation

## Übersicht

Die `sensor_config`-Klasse definiert die Konfiguration für realistische Sensormessungen mit Rauschen, Drift, Kalibrierung und Messbereichsbegrenzung. Jeder Sensor kann eine oder mehrere `sensor_config`-Instanzen haben (eine pro Dimension).

Die Klasse ist als partielle Klasse über mehrere Dateien verteilt:
- `sensor_config.cs`: Hauptmethoden und Rauschgenerierung
- `sensor_config_constructor.cs`: Konstruktoren
- `sensor_config_properties.cs`: Felder und Eigenschaften
- `sensor_config_get_params.cs`: Parameter-Getter
- `sensor_config_set_params.cs`: Parameter-Setter

---

## Namespace

```csharp
namespace biogas
```

---

## Klassendeklaration

```csharp
public partial class sensor_config : set_get_interface
```

**Basisklassen:**
- `set_get_interface`: Interface für Parameter-Verwaltung

---

## Eigenschaften

### Identifikation

#### `index` (Private Field)

```csharp
private int index;
```

Index der Messdimension im Sensor (0, 1, 2, ...).

**Beispiel:**
- VFAmatrix_sensor hat 4 Dimensionen → 4 sensor_config-Objekte mit Index 0-3

### Sensor-Verhalten

#### `apply_real_sensor` (Property, read-only)

```csharp
public bool apply_real_sensor { get; }
```

Aktiviert/deaktiviert realistische Sensor-Simulation.

**Werte:**
- `true`: Rauschen, Drift und Kalibrierung werden angewendet
- `false`: Ideale Messwerte (Standard)

**Beispiel:**
```csharp
var config = new sensor_config(0);
config.set_params_of("apply_real_sensor", true);

bool is_realistic = config.apply_real_sensor;  // true
```

### Rausch-Parameter

#### `T_fil` (Private Field)

```csharp
private double T_fil = 0.257;
```

Zeitkonstante des Sensor-Filters [min].

**Hintergrund:**
- Modelliert 2. Ordnung Tiefpassfilter: `1 / (1 + sT)²`
- Basiert auf Rieger et al., WST 2003

**Standard:** 0.257 min (ca. 15.4 Sekunden)

#### `noise_level` (Private Field)

```csharp
private double noise_level = 0.025;
```

Relative Standardabweichung des Rauschens [-].

**Werte:**
- 0.0 = kein Rauschen
- 0.025 = 2.5% Rauschen (Standard)
- 0.05 = 5% Rauschen

**Berechnung:**
```
noise = noise_val * y_max * noise_level
```

**Quelle:** Rieger et al., WST 2003

**Beispiel:**
```csharp
config.set_params_of("noise_level", 0.05);  // 5% Rauschen
```

#### `noise_arr` (Private Field)

```csharp
private double[] noise_arr = { 0.3462, 0.9943, 1.6424, ... };
```

Vorgenerierte Normalverteilung (μ=0, σ=1) für deterministisches Rauschen.

**Länge:** 120 Werte

**Verwendung:**
- Index basiert auf Zeit: `noise_arr[((int)Math.Floor(t / 2)) % noise_arr.Length]`
- Neuer Wert alle 2 Tage (bei Division durch 2)

### Messbereich

#### `y_min` (Private Field)

```csharp
private double y_min = 0;
```

Minimaler Messwert [unit].

**Beispiele:**
- pH: 0
- TS: 0 % FM
- VFA: 0 mg/l

#### `y_max` (Private Field)

```csharp
private double y_max = 100;
```

Maximaler Messwert [unit].

**Beispiele:**
- pH: 14
- TS: 100 % FM
- VFA: 10000 mg/l

**Wichtig:** Messwerte werden auf [y_min, y_max] begrenzt!

### Drift-Parameter

#### `drift` (Private Field)

```csharp
private double drift = 0.5;
```

Sensor-Drift [unit/d].

**Beispiele:**
- pH: 0.01 pH/d
- VFA: 10 mg/(l·d)

**Berechnung:**
```
int_drift += drift * delta_t
```

#### `int_drift` (Private Field)

```csharp
private double int_drift = 0;
```

Integrierter Drift-Wert [unit] (nur intern).

**Initialisierung:** Wird bei t ≤ 1 d auf 0 gesetzt.

### Kalibrierungs-Parameter

#### `dT_calib` (Private Field)

```csharp
private double dT_calib = 7;
```

Kalibrierungsintervall [d].

**Beispiele:**
- 7 d = wöchentlich
- 1 d = täglich
- 30 d = monatlich

#### `t_calib` (Private Field)

```csharp
private double t_calib = 60;
```

Dauer einer Kalibrierung [min].

**Während Kalibrierung:**
- Sensor gibt 0 aus
- Drift wird zurückgesetzt

#### `is_in_calib` (Private Field)

```csharp
private bool is_in_calib = false;
```

Aktueller Kalibrierungsstatus (nur intern).

**Werte:**
- `true`: Sensor wird gerade kalibriert
- `false`: Normaler Betrieb

### Memory-Parameter

#### `int_memory` (Private Field)

```csharp
private double int_memory = 0;
```

Integrierter Memory-Wert [unit] (nur intern).

**Initialisierung:** Wird bei t ≤ 1 d auf 0 gesetzt.

---

## Konstruktoren

### `sensor_config(int index)`

Standard-Konstruktor mit Default-Werten.

**Parameter:**
- `index` (int): Index der Dimension (0, 1, 2, ...)

**Default-Werte:**
- `apply_real_sensor`: false
- `T_fil`: 0.257 min
- `noise_level`: 0.025 (2.5%)
- `y_min`: 0
- `y_max`: 100
- `drift`: 0.5
- `dT_calib`: 7 d
- `t_calib`: 60 min

**Beispiel:**
```csharp
var config = new sensor_config(0);
```

### `sensor_config(sensor_config template, int index)`

Copy-Konstruktor.

**Parameter:**
- `template` (sensor_config): Vorlage
- `index` (int): Index für neue Instanz

**Beispiel:**
```csharp
var template = new sensor_config(0);
template.set_params_of("noise_level", 0.05);

// Kopie mit gleichem Setup, aber anderem Index
var config2 = new sensor_config(template, 1);
```

---

## Öffentliche Methoden

### Reset

#### `reset()`

Setzt Integrale und Kalibrierungsstatus zurück.

**Seiteneffekte:**
- `int_memory = 0`
- `int_drift = 0`
- `is_in_calib = false`

**Verwendung:** Wird automatisch bei t ≤ 1 d in `addMeasurement` aufgerufen.

**Beispiel:**
```csharp
config.reset();
```

---

## XML-Persistenz

### Laden

#### `getParamsFromXMLReader(ref XmlTextReader reader, int index)`

Liest Konfiguration aus XML.

**Parameter:**
- `reader` (ref XmlTextReader): XML-Reader (bei `<sensor_config>` positioniert)
- `index` (int): Index der Dimension

**Gelesene Elemente:**
- `<apply_real_sensor>`: bool
- `<noise_level>`: double
- `<y_min>`: double
- `<y_max>`: double
- `<drift>`: double
- `<dT_calib>`: double
- `<t_calib>`: double

**XML-Struktur:**
```xml
<sensor_config index="0">
    <apply_real_sensor>1</apply_real_sensor>
    <noise_level>0.05</noise_level>
    <y_min>0</y_min>
    <y_max>14</y_max>
    <drift>0.01</drift>
    <dT_calib>7</dT_calib>
    <t_calib>60</t_calib>
</sensor_config>
```

**Beispiel:**
```csharp
XmlTextReader reader = new XmlTextReader("sensor.xml");
// ... navigiere zu <sensor_config> ...
var config = new sensor_config(0);
config.getParamsFromXMLReader(ref reader, 0);
```

### Speichern

#### `getParamsAsXMLString()`

Gibt Konfiguration als XML-String zurück.

**Rückgabe:**
- `string`: XML-String

**Beispiel:**
```csharp
var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.05,
    "y_min", 0.0,
    "y_max", 14.0,
    "drift", 0.01,
    "dT_calib", 7.0,
    "t_calib", 60.0
);

string xml = config.getParamsAsXMLString();
Console.WriteLine(xml);
```

**Ausgabe:**
```xml
<sensor_config index="0">
    <apply_real_sensor>1</apply_real_sensor>
    <noise_level>0.050</noise_level>
    <y_min>0.0</y_min>
    <y_max>14.0</y_max>
    <drift>0.0</drift>
    <dT_calib>7.0</dT_calib>
    <t_calib>60.0</t_calib>
</sensor_config>
```

### Ausgabe

#### `print()`

Gibt formatierte Konfiguration aus.

**Rückgabe:**
- `string`: Formatierter String

**Beispiel:**
```csharp
Console.WriteLine(config.print());
```

**Ausgabe:**
```
  index= 0		apply_real_sensor= True		noise_level= 0.050 [100 %]
  y_min= 0.0 [unit]		y_max= 14.0 [unit]		drift= 0.0 [unit/d]
  dT_calib= 7.0 [d]		t_calib= 60.0 [min]
```

---

## Statische Methoden

### `getNoisyMeasurement(double t, double last_t, physValue[] value, physValue[] last_signals, sensor_config[] myConfigs)`

Wendet Rauschen und Drift auf Messwerte an.

**Parameter:**
- `t` (double): Aktuelle Simulationszeit [d]
- `last_t` (double): Zeit der letzten Messung [d]
- `value` (physValue[]): Ideale Messwerte
- `last_signals` (physValue[]): Letzte Messwerte (für Ableitungsapproximation)
- `myConfigs` (sensor_config[]): Konfigurationen (eine pro Dimension)

**Rückgabe:**
- `physValue[]`: Verrauschte Messwerte

**Ausnahmen:**
- Keine Exception bei `value.Length != myConfigs.Length` (für fitness_sensor)

**Verhalten:**
- Bei `t ≤ 1`: Integrale werden zurückgesetzt
- Bei `apply_real_sensor = false`: Rückgabe identisch zu `value`
- Bei `apply_real_sensor = true`: Rauschen und Drift werden angewendet

**Beispiel:**
```csharp
// Sensor-Konfigurationen
sensor_config[] configs = new sensor_config[1];
configs[0] = new sensor_config(0);
configs[0].set_params_of("apply_real_sensor", true);

// Messwerte
physValue[] ideal = new physValue[1];
ideal[0] = new physValue("pH", 7.0, "-");

physValue[] last = new physValue[0];  // Erste Messung

// Verrauschen
physValue[] noisy = sensor_config.getNoisyMeasurement(
    5.0,      // t
    4.5,      // last_t
    ideal,    // Ideale Werte
    last,     // Letzte Werte
    configs   // Konfigurationen
);

Console.WriteLine($"Ideal: {ideal[0].Value:F3}");
Console.WriteLine($"Noisy: {noisy[0].Value:F3}");
```

**Ausgabe:**
```
Ideal: 7.000
Noisy: 7.042
```

---

## Private Methoden

### `generate_sensor_signal(double signal, double last_signal, double t, double last_t)`

Generiert realistisches Sensorsignal mit Rauschen, Drift und Kalibrierung.

**Parameter:**
- `signal` (double): Aktueller roher Messwert
- `last_signal` (double): Letzter roher Messwert
- `t` (double): Aktuelle Zeit [d]
- `last_t` (double): Letzte Zeit [d]

**Rückgabe:**
- `double`: Simulierter Sensor-Messwert

**Algorithmus:**

**1. Zeitdifferenz berechnen:**
```csharp
double delta_t = t - last_t;  // [d]
```

**2. Ableitungen approximieren (für Filter):**
```csharp
// Erste Ableitung [unit/d]
double udot = (signal - last_signal) / delta_t;

// Zweite Ableitung [unit/d²]
double udotdot = (signal - last_signal) / (delta_t * delta_t);
```

**3. Tiefpass-Filter (2. Ordnung):**
```csharp
double y = signal + 2 * T_fil / 60 / 24 * udot 
                  + T_fil / 60 / 24 * T_fil / 60 / 24 * udotdot;
```

**Hinweis:** `T_fil` in Minuten, daher Umrechnung zu Tagen.

**4. Rauschen generieren:**
```csharp
// Deterministisches Rauschen aus Array
int noise_index = ((int)Math.Floor(t / 2)) % noise_arr.Length;
double noise_val = noise_arr[noise_index];

// Skalieren
double noise = noise_val * y_max * noise_level;

// Hinzufügen
y += noise;
```

**5. Messbereich begrenzen:**
```csharp
y = Math.Min(Math.Max(y, y_min), y_max);
```

**6. Drift berechnen:**
```csharp
// Drift integrieren
int_drift += drift * delta_t;

// Kalibrierung prüfen
int Nt_calib = (int)Math.Ceiling(t / dT_calib);
bool was_in_calib = is_in_calib;

// Aktuell in Kalibrierung?
if ((Nt_calib * dT_calib - t_calib / 60 / 24 <= t) && 
    (t < dT_calib * Nt_calib))
{
    is_in_calib = true;
}
else
{
    is_in_calib = false;
}

int Nt_last_calib = (int)Math.Ceiling(last_t / dT_calib);

// Fallende Flanke oder Zeitraum-Wechsel
if ((was_in_calib && !is_in_calib) || (Nt_calib > Nt_last_calib))
{
    int_drift = 0;  // Drift zurücksetzen
}
```

**7. Drift und Memory anwenden:**
```csharp
// Summe
y += int_drift - int_memory;

// Während Kalibrierung: Ausgang = 0
if (is_in_calib)
    y = 0;

// Memory aktualisieren
int_memory += y;
```

**8. Rückgabe:**
```csharp
return int_memory;
```

**Quelle:** Basiert auf Rieger et al., WST 2003

---

## Parameter-Verwaltung

### Parameter abrufen

#### `get_params_of(out object[] variables, params string[] symbols)`

Holt mehrere Parameter.

**Parameter:**
- `variables` (out object[]): Ausgabe-Array
- `symbols` (params string[]): Parameter-Namen

**Verfügbare Parameter:**
- `"index"`: int - Dimensions-Index
- `"apply_real_sensor"`: bool - Rauschen aktiviert
- `"noise_level"`: double - Rausch-Level
- `"y_min"`: double - Minimaler Messwert
- `"y_max"`: double - Maximaler Messwert
- `"drift"`: double - Drift-Rate
- `"dT_calib"`: double - Kalibrierungsintervall
- `"t_calib"`: double - Kalibrierungsdauer

**Ausnahmen:**
- `exception`: Unbekannter Parameter
- `exception`: Keine Argumente übergeben

**Beispiel:**
```csharp
object[] params;
config.get_params_of(out params, 
    "index", 
    "apply_real_sensor", 
    "noise_level"
);

int index = (int)params[0];
bool realistic = (bool)params[1];
double noise = (double)params[2];

Console.WriteLine($"Index: {index}");
Console.WriteLine($"Realistic: {realistic}");
Console.WriteLine($"Noise: {noise}");
```

### Parameter setzen

#### `set_params_of(params object[] symbols)`

Setzt Parameter. Syntax: Paare von (Symbol, Wert).

**Parameter:**
- `symbols` (params object[]): Abwechselnd Symbol (string) und Wert

**Setbare Parameter:**
- `"index"`: int
- `"apply_real_sensor"`: bool
- `"noise_level"`: double
- `"y_min"`: double
- `"y_max"`: double
- `"drift"`: double
- `"dT_calib"`: double
- `"t_calib"`: double

**Ausnahmen:**
- `exception`: Unbekannter Parameter

**Beispiel:**
```csharp
config.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.05,
    "y_min", 0.0,
    "y_max", 14.0,
    "drift", 0.01,
    "dT_calib", 7.0,
    "t_calib", 60.0
);
```

---

## Anwendungsbeispiele

### Beispiel 1: Realistische pH-Messung

```csharp
using biogas;
using science;

// Sensor-Konfiguration erstellen
var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.02,     // 2% Rauschen
    "y_min", 0.0,
    "y_max", 14.0,
    "drift", 0.005,          // 0.005 pH/d
    "dT_calib", 7.0,         // Wöchentliche Kalibrierung
    "t_calib", 30.0          // 30 min Kalibrierung
);

sensor_config[] configs = new sensor_config[] { config };

// Simulation
double last_t = 0;
physValue[] last_signal = new physValue[0];

for (double t = 0; t <= 30; t += 0.5)
{
    // Idealer pH-Wert
    physValue[] ideal = new physValue[1];
    ideal[0] = new physValue("pH", 7.2, "-");
    
    // Verrauschen
    physValue[] measured = sensor_config.getNoisyMeasurement(
        t,
        last_t,
        ideal,
        last_signal,
        configs
    );
    
    Console.WriteLine($"t={t:F1} d: Ideal={ideal[0].Value:F3}, " +
                     $"Measured={measured[0].Value:F3}");
    
    last_t = t;
    last_signal = ideal;
}
```

**Ausgabe:**
```
t=0.0 d: Ideal=7.200, Measured=7.200
t=0.5 d: Ideal=7.200, Measured=7.200
t=1.0 d: Ideal=7.200, Measured=7.217
t=1.5 d: Ideal=7.200, Measured=7.189
...
t=7.0 d: Ideal=7.200, Measured=0.000  # Kalibrierung
t=7.5 d: Ideal=7.200, Measured=7.208
...
```

### Beispiel 2: VFA-Sensor mit Drift

```csharp
using biogas;
using science;

// VFA-Sensor-Konfiguration
var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.03,     // 3% Rauschen
    "y_min", 0.0,
    "y_max", 10000.0,
    "drift", 10.0,           // 10 mg/(l·d) Drift
    "dT_calib", 14.0,        // Alle 2 Wochen
    "t_calib", 60.0
);

sensor_config[] configs = new sensor_config[] { config };

// Konstanter VFA-Wert
double vfa_true = 2000.0;  // mg/l

double last_t = 0;
physValue[] last_signal = new physValue[0];

for (double t = 0; t <= 30; t += 1.0)
{
    physValue[] ideal = new physValue[1];
    ideal[0] = new physValue("VFA", vfa_true, "mg/l");
    
    physValue[] measured = sensor_config.getNoisyMeasurement(
        t, last_t, ideal, last_signal, configs
    );
    
    double error = measured[0].Value - ideal[0].Value;
    
    Console.WriteLine($"Tag {t:F0}: VFA={measured[0].Value:F1} mg/l, " +
                     $"Fehler={error:F1} mg/l");
    
    last_t = t;
    last_signal = ideal;
}
```

**Ausgabe:**
```
Tag 0: VFA=2000.0 mg/l, Fehler=0.0 mg/l
Tag 1: VFA=2012.3 mg/l, Fehler=12.3 mg/l
Tag 2: VFA=2034.7 mg/l, Fehler=34.7 mg/l
...
Tag 13: VFA=2145.8 mg/l, Fehler=145.8 mg/l
Tag 14: VFA=0.0 mg/l, Fehler=-2000.0 mg/l  # Kalibrierung
Tag 15: VFA=2008.5 mg/l, Fehler=8.5 mg/l   # Drift zurückgesetzt
...
```

### Beispiel 3: Mehrdimensionaler Sensor

```csharp
using biogas;
using science;

// VFA-Matrix (4 Dimensionen)
sensor_config[] configs = new sensor_config[4];

for (int i = 0; i < 4; i++)
{
    configs[i] = new sensor_config(i);
    configs[i].set_params_of(
        "apply_real_sensor", true,
        "noise_level", 0.025,
        "y_min", 0.0,
        "y_max", 5000.0,
        "drift", 5.0,
        "dT_calib", 7.0,
        "t_calib", 60.0
    );
}

// Ideale Werte
physValue[] ideal = new physValue[4];
ideal[0] = new physValue("Sva", 100.0, "g/l");   // Valeriansäure
ideal[1] = new physValue("Sbu", 200.0, "g/l");   // Buttersäure
ideal[2] = new physValue("Spro", 500.0, "g/l");  // Propionsäure
ideal[3] = new physValue("Sac", 1200.0, "g/l");  // Essigsäure

physValue[] last = new physValue[0];

// Messen
physValue[] measured = sensor_config.getNoisyMeasurement(
    10.0, 9.5, ideal, last, configs
);

Console.WriteLine("VFA-Komponenten:");
for (int i = 0; i < 4; i++)
{
    Console.WriteLine($"{ideal[i].Symbol}: " +
                     $"Ideal={ideal[i].Value:F1}, " +
                     $"Measured={measured[i].Value:F1} {ideal[i].Unit}");
}
```

**Ausgabe:**
```
VFA-Komponenten:
Sva: Ideal=100.0, Measured=102.3 g/l
Sbu: Ideal=200.0, Measured=195.7 g/l
Spro: Ideal=500.0, Measured=508.4 g/l
Sac: Ideal=1200.0, Measured=1187.2 g/l
```

### Beispiel 4: Kalibrierungs-Zeitplan

```csharp
using biogas;
using science;

var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "dT_calib", 7.0,     // Alle 7 Tage
    "t_calib", 120.0     // 2 Stunden Kalibrierung
);

sensor_config[] configs = new sensor_config[] { config };

// Idealer Wert
physValue[] ideal = new physValue[1];
ideal[0] = new physValue("pH", 7.0, "-");

physValue[] last = new physValue[0];

Console.WriteLine("Kalibrierungs-Zeitplan:");
Console.WriteLine("Tag\tIn Calib?\tMesswert");

for (double t = 0; t <= 30; t += 0.1)
{
    double last_t = t - 0.1;
    
    physValue[] measured = sensor_config.getNoisyMeasurement(
        t, last_t, ideal, last, configs
    );
    
    // Nur bei Kalibrierung oder Beginn ausgeben
    if (measured[0].Value == 0 || t == 0)
    {
        Console.WriteLine($"{t:F1}\tJa\t\t{measured[0].Value:F3}");
    }
    else if (t % 7 < 0.2 && t > 0)
    {
        Console.WriteLine($"{t:F1}\tNein\t\t{measured[0].Value:F3}");
    }
    
    last = ideal;
}
```

**Ausgabe:**
```
Kalibrierungs-Zeitplan:
Tag     In Calib?    Messwert
0.0     Ja           7.000
0.1     Nein         7.012
...
6.9     Ja           0.000
7.0     Ja           0.000
7.1     Nein         7.008
...
13.9    Ja           0.000
14.0    Ja           0.000
14.1    Nein         7.015
...
```

### Beispiel 5: Vergleich verschiedener Rausch-Level

```csharp
using biogas;
using science;

double[] noise_levels = { 0.0, 0.01, 0.025, 0.05, 0.1 };

Console.WriteLine("Vergleich Rausch-Level:");
Console.WriteLine("Level\tMin\tMax\tMean\tStdDev");

foreach (double noise_level in noise_levels)
{
    var config = new sensor_config(0);
    config.set_params_of(
        "apply_real_sensor", true,
        "noise_level", noise_level,
        "y_min", 0.0,
        "y_max", 14.0,
        "drift", 0.0,  // Kein Drift
        "dT_calib", 1000.0  // Keine Kalibrierung
    );
    
    sensor_config[] configs = new sensor_config[] { config };
    
    // Konstanter pH
    physValue[] ideal = new physValue[1];
    ideal[0] = new physValue("pH", 7.0, "-");
    
    // 100 Messungen
    List<double> measurements = new List<double>();
    physValue[] last = new physValue[0];
    
    for (double t = 1; t <= 100; t += 1.0)
    {
        physValue[] measured = sensor_config.getNoisyMeasurement(
            t, t - 1, ideal, last, configs
        );
        
        measurements.Add(measured[0].Value);
        last = ideal;
    }
    
    // Statistiken
    double min = measurements.Min();
    double max = measurements.Max();
    double mean = measurements.Average();
    double variance = measurements.Select(x => Math.Pow(x - mean, 2)).Average();
    double stddev = Math.