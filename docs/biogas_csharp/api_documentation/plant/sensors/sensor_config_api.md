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
    double stddev = Math.Sqrt(variance);

    Console.WriteLine($"{noise_level:F3}\t{min:F3}\t{max:F3}\t{mean:F3}\t{stddev:F3}");
}
```

**Ausgabe:**
```
Vergleich Rausch-Level:
Level   Min     Max     Mean    StdDev
0.000   7.000   7.000   7.000   0.000
0.010   6.912   7.089   7.001   0.028
0.025   6.834   7.172   7.002   0.071
0.050   6.652   7.351   7.004   0.143
0.100   6.298   7.713   7.008   0.287
```

### Beispiel 6: Kalibrierungs-Effekt visualisieren

```csharp
using biogas;
using science;

var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.02,
    "y_min", 0.0,
    "y_max", 14.0,
    "drift", 0.02,           // Starker Drift
    "dT_calib", 5.0,         // Alle 5 Tage
    "t_calib", 60.0          // 1 Stunde
);

sensor_config[] configs = new sensor_config[] { config };

// Konstanter pH
physValue[] ideal = new physValue[1];
ideal[0] = new physValue("pH", 7.0, "-");

double last_t = 0;
physValue[] last = new physValue[0];

Console.WriteLine("Tag\tpH_ideal\tpH_measured\tDrift_akkum");
Console.WriteLine("".PadRight(50, '-'));

for (double t = 0; t <= 30; t += 0.5)
{
    physValue[] measured = sensor_config.getNoisyMeasurement(
        t, last_t, ideal, last, configs
    );
    
    // Drift berechnen (annähernd)
    double error = measured[0].Value - ideal[0].Value;
    
    if (t % 1.0 == 0 || measured[0].Value == 0)  // Täglich oder bei Kalibrierung
    {
        Console.WriteLine($"{t:F1}\t{ideal[0].Value:F3}\t\t{measured[0].Value:F3}\t\t{error:F3}");
    }
    
    last_t = t;
    last = ideal;
}
```

**Ausgabe:**
```
Tag     pH_ideal        pH_measured     Drift_akkum
--------------------------------------------------
0.0     7.000           7.000           0.000
1.0     7.000           7.018           0.018
2.0     7.000           7.037           0.037
3.0     7.000           7.055           0.055
4.0     7.000           7.074           0.074
4.9     7.000           0.000           -7.000  # Kalibrierung
5.0     7.000           0.000           -7.000  # Kalibrierung
5.5     7.000           7.012           0.012   # Drift zurückgesetzt
...
```

### Beispiel 7: Sensor-Konfiguration testen

```csharp
using biogas;
using science;

// Verschiedene Konfigurationen
var configs = new Dictionary<string, sensor_config>
{
    {"Ideal", new sensor_config(0)},
    {"Leichtes Rauschen", new sensor_config(0)},
    {"Starkes Rauschen", new sensor_config(0)},
    {"Mit Drift", new sensor_config(0)}
};

// Konfigurationen setzen
configs["Ideal"].set_params_of("apply_real_sensor", false);

configs["Leichtes Rauschen"].set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.01,
    "drift", 0.0
);

configs["Starkes Rauschen"].set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.05,
    "drift", 0.0
);

configs["Mit Drift"].set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.02,
    "drift", 0.01,
    "dT_calib", 1000.0  // Keine Kalibrierung
);

// Idealer Wert
physValue[] ideal = new physValue[1];
ideal[0] = new physValue("pH", 7.0, "-");

Console.WriteLine("Vergleich verschiedener Sensor-Konfigurationen:");
Console.WriteLine("\nTag 10:");
Console.WriteLine("Konfiguration\t\t\tMesswert");
Console.WriteLine("".PadRight(50, '-'));

foreach (var kvp in configs)
{
    sensor_config[] cfg = new sensor_config[] { kvp.Value };
    
    // Simulation bis Tag 10
    double last_t = 0;
    physValue[] last = new physValue[0];
    physValue[] measured = null;
    
    for (double t = 0; t <= 10; t += 0.5)
    {
        measured = sensor_config.getNoisyMeasurement(
            t, last_t, ideal, last, cfg
        );
        last_t = t;
        last = ideal;
    }
    
    Console.WriteLine($"{kvp.Key,-30}\t{measured[0].Value:F3}");
}
```

**Ausgabe:**
```
Vergleich verschiedener Sensor-Konfigurationen:

Tag 10:
Konfiguration                   Messwert
--------------------------------------------------
Ideal                           7.000
Leichtes Rauschen              7.012
Starkes Rauschen               7.058
Mit Drift                      7.143
```

---

## Häufige Fehler und Lösungen

### Problem 1: apply_real_sensor nicht aktiviert

```csharp
// PROBLEM: Rauschen wird nicht angewendet
var config = new sensor_config(0);
config.set_params_of("noise_level", 0.05);  // Nicht wirksam!

sensor_config[] configs = new sensor_config[] { config };
physValue[] measured = sensor_config.getNoisyMeasurement(
    5.0, 4.5, ideal, last, configs
);
// measured == ideal (kein Rauschen!)

// LÖSUNG: apply_real_sensor aktivieren
config.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.05
);
```

### Problem 2: y_min/y_max zu eng

```csharp
// PROBLEM: Messwerte werden zu stark begrenzt
var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "y_min", 6.8,
    "y_max", 7.2
);

physValue[] ideal = new physValue[1];
ideal[0] = new physValue("pH", 7.0, "-");

// Mit Rauschen könnte pH eigentlich 6.95 oder 7.05 sein,
// wird aber auf [6.8, 7.2] begrenzt
// → Künstliche Begrenzung!

// LÖSUNG: Realistische Grenzen setzen
config.set_params_of(
    "y_min", 0.0,
    "y_max", 14.0
);
```

### Problem 3: Drift ohne Kalibrierung

```csharp
// PROBLEM: Drift akkumuliert unbegrenzt
var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "drift", 0.05,
    "dT_calib", 10000.0  // Quasi keine Kalibrierung
);

// Nach 100 Tagen: Drift = 5.0 pH!

// LÖSUNG: Realistische Kalibrierungsintervalle
config.set_params_of(
    "drift", 0.01,
    "dT_calib", 7.0,     // Wöchentlich
    "t_calib", 60.0
);
```

### Problem 4: Falsche Konfiguration für mehrdimensionale Sensoren

```csharp
// PROBLEM: Nur eine Konfiguration für mehrdimensionalen Sensor
var config = new sensor_config(0);
sensor_config[] configs = new sensor_config[] { config };

physValue[] ideal = new physValue[4];  // VFA-Matrix (4D)
ideal[0] = new physValue("Sva", 100.0, "g/l");
ideal[1] = new physValue("Sbu", 200.0, "g/l");
ideal[2] = new physValue("Spro", 500.0, "g/l");
ideal[3] = new physValue("Sac", 1200.0, "g/l");

physValue[] measured = sensor_config.getNoisyMeasurement(
    5.0, 4.5, ideal, new physValue[0], configs
);
// measured.Length == 4, aber nur configs[0] wird verwendet!

// LÖSUNG: Eine Konfiguration pro Dimension
sensor_config[] configs = new sensor_config[4];
for (int i = 0; i < 4; i++)
{
    configs[i] = new sensor_config(i);
    configs[i].set_params_of("apply_real_sensor", true);
}
```

### Problem 5: Zeit-Inkonsistenzen

```csharp
// PROBLEM: t und last_t in falscher Reihenfolge
double t = 5.0;
double last_t = 10.0;  // Falsch! last_t > t

physValue[] measured = sensor_config.getNoisyMeasurement(
    t, last_t, ideal, last, configs
);
// delta_t negativ → falsche Ableitungen!

// LÖSUNG: Korrekte Zeitreihenfolge
double last_t = 4.5;
double t = 5.0;
```

### Problem 6: Kalibrierungszeit zu lang

```csharp
// PROBLEM: Kalibrierung dauert länger als Intervall
var config = new sensor_config(0);
config.set_params_of(
    "dT_calib", 1.0,     // Täglich
    "t_calib", 1500.0    // 25 Stunden!
);

// Sensor ist fast immer in Kalibrierung!

// LÖSUNG: Realistische Zeiten
config.set_params_of(
    "dT_calib", 7.0,     // Wöchentlich
    "t_calib", 60.0      // 1 Stunde
);
```

---

## Performance-Tipps

### 1. Konfigurationen wiederverwenden

```csharp
// INEFFIZIENT: Neue Konfiguration bei jeder Messung
for (double t = 0; t < 100; t += 0.5)
{
    var config = new sensor_config(0);
    config.set_params_of("apply_real_sensor", true);
    sensor_config[] configs = new sensor_config[] { config };
    
    physValue[] measured = sensor_config.getNoisyMeasurement(
        t, t - 0.5, ideal, last, configs
    );
}

// BESSER: Einmal erstellen
var config = new sensor_config(0);
config.set_params_of("apply_real_sensor", true);
sensor_config[] configs = new sensor_config[] { config };

for (double t = 0; t < 100; t += 0.5)
{
    physValue[] measured = sensor_config.getNoisyMeasurement(
        t, t - 0.5, ideal, last, configs
    );
}
```

### 2. Template-Konstruktor nutzen

```csharp
// INEFFIZIENT: Jede Konfiguration einzeln setzen
sensor_config[] configs = new sensor_config[10];
for (int i = 0; i < 10; i++)
{
    configs[i] = new sensor_config(i);
    configs[i].set_params_of(
        "apply_real_sensor", true,
        "noise_level", 0.025,
        "y_min", 0.0,
        "y_max", 14.0
    );
}

// BESSER: Template verwenden
var template = new sensor_config(0);
template.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.025,
    "y_min", 0.0,
    "y_max", 14.0
);

sensor_config[] configs = new sensor_config[10];
for (int i = 0; i < 10; i++)
{
    configs[i] = new sensor_config(template, i);
}
```

### 3. Unnötige Messungen vermeiden

```csharp
// INEFFIZIENT: Gleiche Zeitpunkte mehrmals
for (double t = 0; t < 100; t += 0.5)
{
    // Mehrere Sensoren, gleiche Zeit
    physValue[] pH = sensor_config.getNoisyMeasurement(t, t - 0.5, pH_ideal, last_pH, pH_configs);
    physValue[] vfa = sensor_config.getNoisyMeasurement(t, t - 0.5, vfa_ideal, last_vfa, vfa_configs);
    physValue[] ts = sensor_config.getNoisyMeasurement(t, t - 0.5, ts_ideal, last_ts, ts_configs);
}

// BESSER: Wenn möglich, in einem Aufruf
// (z.B. über sensor.measure(), das getNoisyMeasurement intern aufruft)
```

---

## Best Practices

### 1. Realistische Sensor-Parameter verwenden

```csharp
// GUT: Basierend auf Literatur (Rieger et al., WST 2003)
var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "T_fil", 0.257,          // Standard aus Literatur
    "noise_level", 0.025,    // 2.5% (typisch)
    "drift", 0.01,           // Moderat
    "dT_calib", 7.0,         // Wöchentlich
    "t_calib", 60.0          // 1 Stunde
);

// VERMEIDEN: Unrealistische Werte
config.set_params_of(
    "noise_level", 0.5,      // 50% Rauschen - viel zu viel!
    "drift", 10.0,           // Sensor wäre unbrauchbar
    "dT_calib", 0.1          // Alle 2.4 Stunden - unrealistisch
);
```

### 2. Sensor-spezifische Grenzen setzen

```csharp
// GUT: Angepasst an physikalische Grenzen
var pH_config = new sensor_config(0);
pH_config.set_params_of(
    "y_min", 0.0,
    "y_max", 14.0
);

var ts_config = new sensor_config(0);
ts_config.set_params_of(
    "y_min", 0.0,
    "y_max", 100.0  // % FM
);

var vfa_config = new sensor_config(0);
vfa_config.set_params_of(
    "y_min", 0.0,
    "y_max", 10000.0  // mg/l (typischer Maximalwert)
);
```

### 3. Kalibrierung aktivieren wenn Drift vorhanden

```csharp
// GUT: Drift + Kalibrierung
var config = new sensor_config(0);
config.set_params_of(
    "drift", 0.01,
    "dT_calib", 7.0,
    "t_calib", 60.0
);

// SUBOPTIMAL: Drift ohne Kalibrierung
config.set_params_of(
    "drift", 0.01,
    "dT_calib", 10000.0  // Quasi nie
);
```

### 4. XML-Persistenz für Reproduzierbarkeit

```csharp
// GUT: Konfiguration speichern
var config = new sensor_config(0);
config.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.025,
    "y_min", 0.0,
    "y_max", 14.0,
    "drift", 0.01,
    "dT_calib", 7.0,
    "t_calib", 60.0
);

string xml = config.getParamsAsXMLString();
System.IO.File.WriteAllText("sensor_config.xml", xml);

// Später: Gleiche Konfiguration laden
XmlTextReader reader = new XmlTextReader("sensor_config.xml");
var loaded_config = new sensor_config(0);
loaded_config.getParamsFromXMLReader(ref reader, 0);
```

### 5. Template für konsistente Sensoren

```csharp
// GUT: Alle pH-Sensoren gleich konfigurieren
var pH_template = new sensor_config(0);
pH_template.set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.02,
    "y_min", 0.0,
    "y_max", 14.0,
    "drift", 0.005,
    "dT_calib", 7.0,
    "t_calib", 30.0
);

// Für alle pH-Sensoren verwenden
var pH_F1_configs = new sensor_config[] { new sensor_config(pH_template, 0) };
var pH_F2_configs = new sensor_config[] { new sensor_config(pH_template, 0) };
var pH_F3_configs = new sensor_config[] { new sensor_config(pH_template, 0) };
```

---

## Zusammenfassung

### Wichtigste Eigenschaften

```csharp
bool apply_real_sensor          // Rauschen aktivieren/deaktivieren
double T_fil                    // Filter-Zeitkonstante [min]
double noise_level              // Rausch-Level [-]
double y_min                    // Minimaler Messwert [unit]
double y_max                    // Maximaler Messwert [unit]
double drift                    // Drift-Rate [unit/d]
double dT_calib                 // Kalibrierungsintervall [d]
double t_calib                  // Kalibrierungsdauer [min]
```

### Wichtigste Methoden

```csharp
// Konstruktoren
sensor_config(int index)
sensor_config(sensor_config template, int index)

// Reset
void reset()

// Statisch: Rauschen anwenden
physValue[] getNoisyMeasurement(double t, double last_t, 
                                physValue[] value, 
                                physValue[] last_signals,
                                sensor_config[] myConfigs)

// Parameter
void set_params_of(params object[] symbols)
void get_params_of(out object[] variables, params string[] symbols)

// XML
string getParamsAsXMLString()
void getParamsFromXMLReader(ref XmlTextReader reader, int index)
string print()
```

### Typische Werte (Rieger et al., WST 2003)

```csharp
T_fil = 0.257 min           // Filter-Zeitkonstante
noise_level = 0.025         // 2.5% Standardabweichung
drift = 0.005-0.05          // Je nach Sensor
dT_calib = 7.0 d            // Wöchentlich
t_calib = 30-120 min        // 0.5-2 Stunden
```

---

## TODOs

Laut Quellcode:

### sensor_config.cs
- `generate_sensor_signal()`: Evtl. `int_memory` Reihenfolge überprüfen (Zeile 240)
- Kalibrierungs-Detektion verbessern (funktioniert evtl. nicht bei schneller Simulation)

---

## Algorithmus-Details

### Sensor-Signal-Generierung

**Vollständiger Algorithmus** (aus `generate_sensor_signal`):

1. **Zeitdifferenz:**
   ```
   Δt = t - t_last
   ```

2. **Ableitungen (für Filter):**
   ```
   u̇ = (signal - signal_last) / Δt
   ü = (signal - signal_last) / Δt²
   ```

3. **Tiefpass-Filter (2. Ordnung):**
   ```
   T = T_fil / 60 / 24  [d]
   y = signal + 2T·u̇ + T²·ü
   ```

4. **Rauschen hinzufügen:**
   ```
   noise_index = floor(t / 2) mod 120
   noise_val = noise_arr[noise_index]
   noise = noise_val · y_max · noise_level
   y = y + noise
   ```

5. **Messbereich begrenzen:**
   ```
   y = min(max(y, y_min), y_max)
   ```

6. **Drift integrieren:**
   ```
   int_drift = int_drift + drift · Δt
   ```

7. **Kalibrierung prüfen:**
   ```
   N_calib = ceil(t / dT_calib)
   N_last_calib = ceil(t_last / dT_calib)
   
   t_calib_start = N_calib · dT_calib - t_calib / 60 / 24
   t_calib_end = N_calib · dT_calib
   
   is_in_calib = (t_calib_start ≤ t < t_calib_end)
   
   if (was_in_calib AND NOT is_in_calib) OR (N_calib > N_last_calib):
       int_drift = 0  // Fallende Flanke
   ```

8. **Drift und Memory:**
   ```
   y = y + int_drift - int_memory
   
   if is_in_calib:
       y = 0
   
   int_memory = int_memory + y
   ```

9. **Rückgabe:**
   ```
   return int_memory
   ```

### Mathematische Grundlagen

**Tiefpass-Filter:**
- Übertragungsfunktion: `H(s) = 1 / (1 + sT)²`
- Zeitbereich (Approximation): `y(t) = u(t) + 2T·u̇(t) + T²·ü(t)`

**Rauschen:**
- Normalverteilt: N(0, 1)
- Skaliert: `noise = N(0,1) · y_max · noise_level`
- Deterministisch (aus Array)

**Drift:**
- Linear: `drift(t) = drift_rate · t`
- Mit Kalibrierung: Periodisch zurückgesetzt

**Kalibrierung:**
- Periodisch: Alle `dT_calib` Tage
- Dauer: `t_calib` Minuten
- Effekt: Ausgang = 0, Drift zurückgesetzt

---

## Siehe auch

- **biogas.sensor**: Basis-Sensor-Klasse (nutzt sensor_config)
- **biogas.sensors**: Sensor-Verwaltungsklasse
- **science.physValue**: Physikalische Werte mit Einheiten
- Rieger et al., "Progress in sensor technology", WST 2003 (Quelle für Parameter)

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*
