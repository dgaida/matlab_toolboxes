# Sensor Base Class API Documentation

## Übersicht

Die abstrakte Klasse `sensor` ist die Basisklasse für alle Sensoren in der Biogasanlagen-Simulation. Sie definiert die grundlegende Struktur für Messwerterfassung, -speicherung und -abruf. Die Klasse ist als partielle Klasse über mehrere Dateien verteilt:

- `sensor.cs`: Hauptklasse mit Konstruktoren und Basismethoden
- `sensor_properties.cs`: Eigenschaften und private Felder
- `sensor_measure.cs`: Messmethoden (`measure`, `doMeasurement`)
- `sensor_getMeasurements.cs`: Messwert-Abrufmethoden
- `sensor_get_params.cs`: Parameter-Getter
- `sensor_set_params.cs`: Parameter-Setter

---

## Namespace

```csharp
namespace biogas
```

---

## Klassendeklaration

```csharp
public abstract partial class sensor : set_get_interface
```

**Basisklassen:**
- `set_get_interface`: Interface für Parameter-Verwaltung

---

## Eigenschaften

### Identifikation

#### `id` (Property, read-only)

```csharp
public string id { get; }
```

Eindeutige Sensor-ID. Format: `{spec}_{id_suffix}`

**Beispiele:**
- `"HRT_F1"` - HRT-Sensor für Fermenter 1
- `"pH_F1_3"` - pH-Sensor für Fermenter 1, Ausgang
- `"VFA_F1_2"` - VFA-Sensor für Fermenter 1, Eingang

#### `spec` (Abstract Property, read-only)

```csharp
abstract public string spec { get; }
```

Sensor-Spezifikation (Typ-Name). Muss von abgeleiteten Klassen implementiert werden.

**Beispiele:**
- `"HRT"` - Hydraulische Verweilzeit
- `"pH"` - pH-Wert
- `"VFA"` - Flüchtige Fettsäuren

#### `id_suffix` (Property, read-only)

```csharp
public string id_suffix { get; }
```

Suffix der Sensor-ID, typischerweise:
- Fermenter-ID: `"F1"`, `"F2"`, ...
- Mit In/Out: `"F1_2"` (Eingang), `"F1_3"` (Ausgang)
- Spezielle IDs: `"substratemix"`, `"storagetank"`

#### `name` (Property, read-only)

```csharp
public string name { get; }
```

Beschreibender Name des Sensors.

**Beispiel:**
```csharp
"pH sensor F1_3"
"HRT sensor F1"
```

### Sensor-Eigenschaften

#### `dimension` (Property, read-only)

```csharp
public int dimension { get; }
```

Anzahl der gleichzeitig gemessenen Werte. Standard: 1

**Beispiele:**
- `1`: Skalarer Sensor (pH, HRT, TS)
- `2`: NH4_sensor (Snh4, NH4_total)
- `4`: VFAmatrix_sensor (Sva, Sbu, Spro, Sac)
- `64+n_gases`: ADMintvars_sensor

#### `type` (Property, read-only)

```csharp
public int type { get; }
```

Sensor-Typ bestimmt die `doMeasurement`-Signatur:

| Type | Signatur | Beispiele |
|------|----------|-----------|
| 0 | `doMeasurement(double[] x)` | VFA, pH, Sac |
| 1 | `doMeasurement(double[] x, params double[] par)` | HRT |
| 2 | `doMeasurement(double param)` | fitness |
| 3 | `doMeasurement(double[] x, substrates, double[] Q, ...)` | substrate, VS |
| 4 | `doMeasurement(plant, double u, ...)` | pumpEnergy |
| 5 | `doMeasurement(plant, double[] u, string param, ...)` | energyProduction |
| 6 | `doMeasurement(plant, substrates, double[] Q, ...)` | heatConsumption |
| 7 | `doMeasurement(double[] x, plant, substrates, sensors, double[] Q, ...)` | TS, OLR |
| 8 | `doMeasurement(plant, fitness_params, sensors, ...)` | pH_fit, VFA_fit |
| 9 | `doMeasurement(substrates, sensors, ...)` | manurebonus |

---

## Konstruktoren

### `sensor(string id, string name, string id_suffix)`

Erstellt Sensor mit minimalen Angaben (Dimension = 1).

**Parameter:**
- `id` (string): Sensor-ID
- `name` (string): Beschreibender Name
- `id_suffix` (string): ID-Suffix

**Beispiel:**
```csharp
public class pH_sensor : sensor
{
    public pH_sensor(string id_suffix) :
        base($"pH_{id_suffix}", $"pH sensor {id_suffix}", id_suffix)
    {
        _type = 91;
    }
}
```

### `sensor(string id, string name, string id_suffix, int dimension)`

Erstellt Sensor mit angegebener Dimension.

**Parameter:**
- `id` (string): Sensor-ID
- `name` (string): Beschreibender Name
- `id_suffix` (string): ID-Suffix
- `dimension` (int): Anzahl gleichzeitiger Messungen

**Beispiel:**
```csharp
public class VFAmatrix_sensor : sensor
{
    public VFAmatrix_sensor(string id_suffix) :
        base($"VFAmatrix_{id_suffix}", 
             $"VFA matrix sensor {id_suffix}", 
             id_suffix, 
             4)  // Sva, Sbu, Spro, Sac
    {
        _type = 0;
    }
}
```

### `sensor(ref XmlTextReader reader, string id)` / `sensor(ref XmlTextReader reader, string id, int dimension)`

Erstellt Sensor aus XML-Reader.

**Parameter:**
- `reader` (ref XmlTextReader): XML-Reader (bereits bei `<sensor>` positioniert)
- `id` (string): Sensor-ID
- `dimension` (int): Anzahl Messungen (optional, Standard: 1)

**XML-Struktur:**
```xml
<sensor id="pH_F1_3" spec="pH">
    <id_suffix>F1_3</id_suffix>
    <name>pH sensor F1_3</name>
    <dimension>1</dimension>
    <sensor_config index="0">
        <!-- Sensor-Konfiguration -->
    </sensor_config>
</sensor>
```

**Beispiel:**
```csharp
XmlTextReader reader = new XmlTextReader("sensors.xml");
// ... navigiere zu <sensor> ...
var pH_sensor = new pH_sensor(ref reader, "pH_F1_3");
```

### `sensor(string XMLfile)`

Erstellt Sensor aus XML-Datei.

**Parameter:**
- `XMLfile` (string): Pfad zur XML-Datei

**Beispiel:**
```csharp
var sensor = new pH_sensor("pH_F1_3.xml");
```

---

## Messmethoden

### Typ 0/1: Stream-Sensoren

#### `measure(double time, double deltatime, double[] x, params double[] par)`

Misst Stream-basierte Werte (pH, VFA, NH4, etc.).

**Parameter:**
- `time` (double): Aktuelle Simulationszeit [d]
- `deltatime` (double): Minimale Zeit seit letzter Messung [d]
- `x` (double[]): Zustandsvektor oder Stream
- `par` (params double[]): Optionale Parameter

**Rückgabe:**
- `physValue[]`: Messwert-Vektor

**Verhalten:**
- Messung nur wenn `time - getCurrentTime() >= deltatime`
- Sonst: Rückgabe des letzten Messwertes

**Beispiel:**
```csharp
// pH-Sensor (Typ 0)
double[] stream = /* ADM-Stream */;
physValue[] pH = pH_sensor.measure(5.0, 0.5, stream);

// HRT-Sensor (Typ 1, mit Parameter)
double Vliq = 2500.0;  // m³
physValue[] hrt = hrt_sensor.measure(5.0, 0.5, stream, Vliq);
```

**Hinweis:**
- Typ 0: Ruft `doMeasurement(double[] x)` auf
- Typ 1: Ruft `doMeasurement(double[] x, params double[] par)` auf

### Typ 2: Parameter-Sensoren

#### `measure(double time, double deltatime, double param)`

Misst einfache Parameter.

**Parameter:**
- `param` (double): Zu messender Wert

**Beispiel:**
```csharp
// Fitness-Sensor
double fitness_value = 0.85;
physValue[] fitness = fitness_sensor.measure(10.0, 1.0, fitness_value);
```

### Typ 3: Substrat-abhängige Sensoren

#### `measure(double time, double deltatime, double[] x, substrates mySubstrates, double[] Q, params double[] par)`

Misst mit Substrat-Informationen.

**Parameter:**
- `x` (double[]): Zustandsvektor
- `mySubstrates` (substrates): Substrat-Liste
- `Q` (double[]): Substrat-Volumenströme [m³/d]
- `par` (params double[]): Optionale Parameter

**Beispiel:**
```csharp
// VS-Sensor für Substrat-Mix
double[] stream = /* ... */;
double[] Q = {100.0, 50.0};  // Mais, Gülle
physValue[] vs = vs_sensor.measure(5.0, 0.5, stream, substrates, Q);
```

#### `measure(double time, double deltatime, substrates mySubstrates, double[] Q, params double[] par)`

Vereinfachte Version ohne Zustandsvektor.

### Typ 4: Pumpen-Sensoren

#### `measure(double time, double deltatime, plant myPlant, double u, params double[] par)`

Misst Pumpen-Energie.

**Parameter:**
- `myPlant` (plant): Anlagen-Objekt
- `u` (double): Volumenstrom [m³/d]
- `par` (params double[]): Parameter (z.B. Dichte)

**Beispiel:**
```csharp
// Pumpen-Energie
double Q_pump = 150.0;  // m³/d
double rho = 1000.0;    // kg/m³
physValue[] energy = pump_sensor.measure(5.0, 0.5, plant, Q_pump, rho);
```

### Typ 5: BHKW-Sensoren

#### `measure(double time, double deltatime, plant myPlant, double[] u, string param, params double[] par)`

Misst BHKW-bezogene Werte.

**Parameter:**
- `u` (double[]): Biogasstrom oder Zustandsvektor
- `param` (string): String-Parameter

**Beispiel:**
```csharp
// BHKW-Energieproduktion
double[] biogas = {5.0, 450.0, 200.0};  // H2, CH4, CO2
physValue[] energy = chp_sensor.measure(
    5.0, 
    0.5, 
    plant, 
    biogas, 
    "CHP1"
);
```

### Typ 6: Heizungs-Sensoren

#### `measure(double time, double deltatime, plant myPlant, substrates mySubstrates, double[] Q, params double[] par)`

Misst Heizenergie.

**Parameter:**
- `Q` (double[]): Substrat-Volumenströme [m³/d]

**Beispiel:**
```csharp
// Heizenergie-Bedarf
double[] Q = {100.0, 50.0};
physValue[] heat = heat_sensor.measure(
    5.0, 
    0.5, 
    plant, 
    substrates, 
    Q
);
```

### Typ 7: Prozess-Sensoren

#### `measure(double time, double deltatime, double[] x, plant myPlant, substrates mySubstrates, sensors mySensors, double[] Q, params double[] par)`

Misst komplexe Prozessparameter (TS, OLR, Dichte).

**Parameter:**
- `x` (double[]): Zustandsvektor
- `mySensors` (sensors): Sensor-Sammlung (für cross-sensor-Zugriff)
- `Q` (double[]): Volumenströme [m³/d]
  - Erste `n_substrate` Elemente: Substrat-Ströme
  - Nächste Elemente: Fermenter-Rezirkulation

**Beispiel:**
```csharp
// TS-Sensor
double[] x = /* ADM-Zustand */;
double[] Q = {100.0, 50.0, 0.0, 0.0};  // 2 Substrate, 2 Fermenter
physValue[] ts = ts_sensor.measure(
    5.0,
    0.5,
    x,
    plant,
    substrates,
    mySensors,
    Q
);
```

### Typ 8: Fitness-Sensoren

#### `measure(double time, double deltatime, plant myPlant, fitness_params myFitnessParams, sensors mySensors, params double[] par)`

Misst Fitness-Werte für Optimierung.

**Parameter:**
- `myFitnessParams` (fitness_params): Fitness-Parameter
- `mySensors` (sensors): Sensor-Sammlung

**Beispiel:**
```csharp
// pH-Fitness
var fitnessParams = new fitness_params("fitness.xml");
physValue[] fit = pH_fit_sensor.measure(
    5.0,
    0.5,
    plant,
    fitnessParams,
    mySensors,
    0.0
);
```

### Typ 9: Substrat-Bonus-Sensoren

#### `measure(double time, double deltatime, substrates mySubstrates, sensors mySensors, params double[] par)`

Misst Substrat-bezogene Boni.

**Beispiel:**
```csharp
// Gülle-Bonus
physValue[] bonus = manurebonus_sensor.measure(
    5.0,
    0.5,
    substrates,
    mySensors,
    0.0
);
```

---

## doMeasurement-Methoden (Abstract/Virtual)

Diese Methoden müssen/können von abgeleiteten Klassen überschrieben werden.

### `doMeasurement(double[] x, params double[] par)` (Abstract)

**Hauptmethode** - muss von allen Sensoren implementiert werden.

**Parameter:**
- `x` (double[]): Zustandsvektor oder Stream
- `par` (params double[]): Optionale Parameter

**Rückgabe:**
- `physValue[]`: Messwert-Vektor mit `dimension` Elementen

**Beispiel (Implementierung):**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
{
    physValue[] values = new physValue[dimension];
    
    // Beispiel: pH-Wert aus H+ berechnen
    if (x[19] > 0)  // x[19] = H+ Konzentration
        values[0] = new physValue("pH", -Math.Log10(x[19]), "-");
    else
        values[0] = new physValue("pH", 0, "-");
    
    return values;
}
```

### `doMeasurement(double param)` (Virtual)

Typ 2: Einfache Parameter.

**Standard-Implementierung:** Wirft Exception

### `doMeasurement(double[] x, substrates mySubstrates, double[] Q, params double[] par)` (Virtual)

Typ 3: Substrat-abhängig.

**Standard-Implementierung:** Wirft Exception

### `doMeasurement(plant myPlant, double u, params double[] par)` (Virtual)

Typ 4: Pumpen-Sensoren.

**Standard-Implementierung:** Wirft Exception

### `doMeasurement(plant myPlant, double[] u, string param, params double[] par)` (Virtual)

Typ 5: BHKW-Sensoren.

**Standard-Implementierung:** Wirft Exception

### `doMeasurement(plant myPlant, substrates mySubstrates, double[] Q, params double[] par)` (Virtual)

Typ 6: Heizungs-Sensoren.

**Standard-Implementierung:** Wirft Exception

### `doMeasurement(double[] x, plant myPlant, substrates mySubstrates, sensors mySensors, double[] Q, params double[] par)` (Virtual)

Typ 7: Prozess-Sensoren.

**Standard-Implementierung:** Wirft Exception

### `doMeasurement(plant myPlant, fitness_params myFitnessParams, sensors mySensors, params double[] par)` (Virtual)

Typ 8: Fitness-Sensoren.

**Standard-Implementierung:** Wirft Exception

### `doMeasurement(substrates mySubstrates, sensors mySensors, params double[] par)` (Virtual)

Typ 9: Substrat-Bonus-Sensoren.

**Standard-Implementierung:** Wirft Exception

---

## Messwert-Abruf

### Aktueller Messwert

#### `getCurrentTime()`

Gibt die Zeit der letzten Messung zurück.

**Rückgabe:**
- `double`: Zeit [d], oder `-∞` wenn keine Messung vorhanden

**Beispiel:**
```csharp
double t = sensor.getCurrentTime();
if (t > 0)
{
    Console.WriteLine($"Letzte Messung: Tag {t}");
}
```

#### `getPreviousTime()`

Gibt die vorletzte Messzeit zurück.

**Rückgabe:**
- `double`: Zeit [d], oder `getCurrentTime() - 1` wenn nur eine Messung, oder `-∞` wenn keine

#### `getCurrentMeasurement()`

Holt den aktuellsten Messwert (erste Dimension).

**Rückgabe:**
- `physValue`: Aktueller Messwert

**Beispiel:**
```csharp
physValue pH = pH_sensor.getCurrentMeasurement();
Console.WriteLine($"pH: {pH.Value}");
```

#### `getCurrentMeasurement(bool noisy)`

Holt Messwert mit/ohne Rauschen.

**Parameter:**
- `noisy` (bool): Wenn true, gibt verrauschten Wert zurück (falls `apply_real_sensor` aktiviert)

**Beispiel:**
```csharp
physValue pH_ideal = sensor.getCurrentMeasurement(false);
physValue pH_real = sensor.getCurrentMeasurement(true);
```

#### `getCurrentMeasurement(int index)` / `getCurrentMeasurement(int index, bool noisy)`

Holt Messwert einer bestimmten Dimension.

**Parameter:**
- `index` (int): 0-basierter Index (0 bis `dimension-1`)
- `noisy` (bool): Rauschen aktivieren

**Ausnahmen:**
- `exception`: Wenn `index >= dimension` oder `< 0`

**Beispiel:**
```csharp
// VFAmatrix_sensor (dimension = 4)
physValue sva = sensor.getCurrentMeasurement(0);   // Valeriansäure
physValue sbu = sensor.getCurrentMeasurement(1);   // Buttersäure
physValue spro = sensor.getCurrentMeasurement(2);  // Propionsäure
physValue sac = sensor.getCurrentMeasurement(3);   // Essigsäure
```

#### `getCurrentMeasurementVector()` / `getCurrentMeasurementVector(bool noisy)`

Holt kompletten Messwert-Vektor.

**Rückgabe:**
- `physValue[]`: Vektor mit `dimension` Elementen

**Beispiel:**
```csharp
physValue[] vfa = vfa_matrix_sensor.getCurrentMeasurementVector();
foreach (var component in vfa)
{
    Console.WriteLine($"{component.Symbol}: {component.Value} {component.Unit}");
}
```

### Messwert zu bestimmter Zeit

#### `getMeasurementAt(double t)` / `getMeasurementAt(double t, bool noisy)`

Holt Messwert zum Zeitpunkt t (erste Dimension).

**Parameter:**
- `t` (double): Simulationszeit [d]
- `noisy` (bool): Rauschen aktivieren

**Rückgabe:**
- `physValue`: Messwert zu Zeit t

**Verhalten:**
- Findet nächstliegende gespeicherte Messung zu Zeit t
- Wenn t zwischen zwei Messungen liegt, wird die frühere genommen

**Beispiel:**
```csharp
physValue pH_day10 = sensor.getMeasurementAt(10.0);
Console.WriteLine($"pH am Tag 10: {pH_day10.Value}");
```

#### `getMeasurementAt(int index, double t)` / `getMeasurementAt(int index, double t, bool noisy)`

Holt Messwert einer Dimension zu Zeit t.

#### `getMeasurementDAt(int index, double t, bool noisy)`

Wie `getMeasurementAt`, aber direkt als double.

**Beispiel:**
```csharp
double sac_day5 = sensor.getMeasurementDAt(3, 5.0, false);
```

#### `getMeasurementVectorAt(double t)` / `getMeasurementVectorAt(double t, bool noisy)`

Holt kompletten Vektor zu Zeit t.

**Rückgabe:**
- `physValue[]`: Messwert-Vektor zu Zeit t

**Beispiel:**
```csharp
physValue[] vfa_day10 = sensor.getMeasurementVectorAt(10.0);
```

### Gesamter Messverlauf

#### `getMeasurementStream(int index)` / `getMeasurementStream(int index, bool noisy)`

Holt alle Messungen einer Dimension.

**Parameter:**
- `index` (int): Dimensions-Index (0-basiert)
- `noisy` (bool): Rauschen aktivieren

**Rückgabe:**
- `physValue[]`: Array aller Messungen

**Beispiel:**
```csharp
// pH-Verlauf über gesamte Simulation
physValue[] pH_stream = pH_sensor.getMeasurementStream(0);

for (int i = 0; i < pH_stream.Length; i++)
{
    Console.WriteLine($"Messung {i}: {pH_stream[i].Value}");
}
```

#### `getMeasurementStream()` / `getMeasurementStream(bool noisy)`

Holt alle Messungen aller Dimensionen.

**Rückgabe:**
- `List<physValue[]>`: Liste von Messwert-Vektoren

#### `getTimeStream()`

Holt Zeitvektor aller Messungen.

**Rückgabe:**
- `double[]`: Zeitpunkte [d]

**Beispiel:**
```csharp
double[] time = sensor.getTimeStream();
physValue[] pH_values = sensor.getMeasurementStream(0);

// Zeitreihe erstellen
for (int i = 0; i < time.Length; i++)
{
    Console.WriteLine($"t={time[i]:F1} d: pH={pH_values[i].Value:F2}");
}
```

### Spezial-Methoden (Virtual)

Diese Methoden sind für Sensoren mit spezieller Zugriffs-Logik (z.B. biogas_sensor).

#### `getCurrentMeasurement(string param)` / `getCurrentMeasurement(string param, bool noisy)`

Holt Messwert anhand eines String-Parameters.

**Standard-Implementierung:** Wirft Exception

**Beispiel (biogas_sensor):**
```csharp
// biogas_sensor überschreibt diese Methode
physValue total = biogas_sensor.getCurrentMeasurement("biogas_m3_d");
physValue ch4_percent = biogas_sensor.getCurrentMeasurement("CH4_%");
```

#### `getMeasurementStream(string param)` / `getMeasurementStream(string param, bool noisy)`

Holt Messverlauf anhand eines String-Parameters.

#### `getMeasurementAt(string param, double t)` / `getMeasurementAt(string param, double t, bool noisy)`

Holt Messwert zu Zeit t anhand eines String-Parameters.

---

## Daten-Verwaltung

### `deleteData()`

Löscht alle gespeicherten Messungen.

**Seiteneffekt:**
- Leert `time`, `values`, `values_noise` Listen
- Setzt `sensor_config` zurück

**Beispiel:**
```csharp
// Reset für neue Simulation
sensor.deleteData();
```

### `isEmpty()`

Prüft ob Sensor Messungen enthält.

**Rückgabe:**
- `bool`: true wenn keine Messungen vorhanden

**Beispiel:**
```csharp
if (sensor.isEmpty())
{
    Console.WriteLine("Keine Daten vorhanden");
}
else
{
    Console.WriteLine($"{sensor.getTimeStream().Length} Messungen gespeichert");
}
```

---

## Parameter-Verwaltung

### Parameter abrufen

#### `get_params_of(out physValue variable, string symbol)`

Holt Parameter als physValue.

**Parameter:**
- `variable` (out physValue): Ausgabe-Variable
- `symbol` (string): Parameter-Name

**Beispiel:**
```csharp
physValue sampling;
sensor.get_params_of(out sampling, "sampling_time");
```

#### `get_params_of(string symbol)`

Holt Parameter als physValue (Rückgabe-Version).

#### `get_param_of(string symbol)`

Holt Parameter als double.

#### `get_params_of(out physValue[] variables, params string[] symbols)`

Holt mehrere Parameter.

**Beispiel:**
```csharp
physValue[] params;
sensor.get_params_of(out params, "id", "dimension", "name");
```

#### `get_params_of(out object[] variables, params string[] symbols)` (Abstract)

Muss von abgeleiteten Klassen implementiert werden.

**Verfügbare Parameter (Standard):**
- `"id"`: Sensor-ID
- `"name"`: Sensor-Name
- `"dimension"`: Anzahl Dimensionen
- `"id_suffix"`: ID-Suffix

**Beispiel (Implementierung):**
```csharp
public override void get_params_of(out object[] variables, params string[] symbols)
{
    variables = new object[symbols.Length];
    
    for (int i = 0; i < symbols.Length; i++)
    {
        switch (symbols[i])
        {
            case "id":
                variables[i] = this.id;
                break;
            case "name":
                variables[i] = this.name;
                break;
            case "dimension":
                variables[i] = this.dimension;
                break;
            case "my_custom_param":
                variables[i] = this.my_custom_param;
                break;
            default:
                throw new exception($"Unknown parameter: {symbols[i]}");
        }
    }
}
```

#### `get_physValue_param(int index, string param)`

Holt physValue-Attribute eines Messwerts.

**Parameter:**
- `index` (int): Dimensions-Index (0-basiert)
- `param` (string): "Unit", "Label", oder "Symbol"

**Rückgabe:**
- `string`: Attribut-Wert

**Ausnahmen:**
- `exception`: Wenn keine Messungen vorhanden
- `exception`: Wenn index ungültig oder param unbekannt

**Beispiel:**
```csharp
string unit = sensor.get_physValue_param(0, "Unit");
string label = sensor.get_physValue_param(0, "Label");
string symbol = sensor.get_physValue_param(0, "Symbol");

Console.WriteLine($"{symbol} [{unit}] - {label}");
```

### Parameter setzen

#### `set_params_of(params object[] symbols)` (Abstract)

Setzt Parameter. Muss von abgeleiteten Klassen implementiert werden.

**Syntax:** Paare von (Symbol, Wert)

**Beispiel (Implementierung):**
```csharp
public override void set_params_of(params object[] symbols)
{
    for (int i = 0; i < symbols.Length; i += 2)
    {
        switch ((string)symbols[i])
        {
            case "name":
                this._name = (string)symbols[i + 1];
                break;
            default:
                throw new exception($"Unknown parameter: {(string)symbols[i]}");
        }
    }
}
```

**Nutzung:**
```csharp
sensor.set_params_of("name", "Neuer Name");
```

---

## XML-Persistenz

### Laden

#### `getParamsFromXMLReader(ref XmlTextReader reader)` (Virtual)

Liest Sensor-Parameter aus XML.

**Parameter:**
- `reader` (ref XmlTextReader): XML-Reader (bei `<sensor>` positioniert)

**Gelesene Elemente:**
- `<id_suffix>`: ID-Suffix
- `<name>`: Sensor-Name
- `<dimension>`: Anzahl Dimensionen
- `<sensor_config index="...">`: Sensor-Konfigurationen

**Beispiel (XML):**
```xml
<sensor id="pH_F1_3" spec="pH">
    <id_suffix>F1_3</id_suffix>
    <name>pH sensor F1_3</name>
    <dimension>1</dimension>
    <sensor_config index="0">
        <apply_real_sensor>0</apply_real_sensor>
        <noise_level>0.05</noise_level>
        <y_min>0</y_min>
        <y_max>14</y_max>
    </sensor_config>
</sensor>
```

### Speichern

#### `getParamsAsXMLString()` (Virtual)

Gibt Sensor-Konfiguration als