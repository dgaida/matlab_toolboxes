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

Gibt Sensor-Konfiguration als XML-String zurück.

**Rückgabe:**
- `string`: XML-String mit Sensor-Konfiguration

**XML-Struktur:**
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
        <drift_rate>0.001</drift_rate>
        <sampling_time>0.5</sampling_time>
    </sensor_config>
</sensor>
```

**Beispiel:**
```csharp
string xml = sensor.getParamsAsXMLString();
Console.WriteLine(xml);

// In Datei speichern
System.IO.File.WriteAllText("sensor_config.xml", xml);
```

### Ausgabe

#### `print()` (Virtual)

Gibt formatierte Sensor-Information aus.

**Rückgabe:**
- `string`: Formatierter String mit Sensor-Details

**Ausgabeformat:**
```
   ----------   Sensor   pH sensor F1_3   ----------   
id: pH_F1_3
   ---------- ---------- ---------- ----------   
```

**Beispiel:**
```csharp
Console.WriteLine(sensor.print());
```

---

## Private Felder und Eigenschaften

### Private Felder

#### `_id` (Private Field)

```csharp
private string _id = "";
```

Eindeutige Sensor-ID. Format: `{spec}_{id_suffix}`

#### `_id_suffix` (Private Field)

```csharp
private string _id_suffix = "";
```

ID-Suffix des Sensors (Fermenter-ID, etc.)

#### `_name` (Private Field)

```csharp
private string _name = "";
```

Beschreibender Name des Sensors.

#### `_dimension` (Private Field)

```csharp
private int _dimension = 1;
```

Anzahl gleichzeitig gemessener Werte.

#### `time` (Private Field)

```csharp
private List<double> time = new List<double>();
```

Zeitvektor aller Messungen [d].

**Hinweis:** Könnte als `physValue` implementiert werden (TODO).

#### `values` (Private Field)

```csharp
private List<physValue[]> values = new List<physValue[]>();
```

Liste aller Messwert-Vektoren (ohne Rauschen).

#### `values_noise` (Private Field)

```csharp
private List<physValue[]> values_noise = new List<physValue[]>();
```

Liste aller Messwert-Vektoren (mit Rauschen).

**Hinweis:** Identisch mit `values` wenn `apply_real_sensor = false`.

#### `myConfigs` (Private Field)

```csharp
private sensor_config[] myConfigs;
```

Array mit Sensor-Konfigurationen (eine pro Dimension).

### Protected Felder

#### `_type` (Protected Field)

```csharp
protected int _type = 0;
```

Sensor-Typ (bestimmt `doMeasurement`-Signatur).

**Werte:** 0-9 (siehe Typ-Übersicht oben)

---

## Private Methoden

### `addMeasurement(double t, physValue[] value)`

Fügt neue Messung zur internen Liste hinzu.

**Parameter:**
- `t` (double): Messzeit [d]
- `value` (physValue[]): Messwert-Vektor

**Seiteneffekte:**
- Fügt `value` zu `values` hinzu
- Fügt verrauschten Wert zu `values_noise` hinzu (über `sensor_config.getNoisyMeasurement`)
- Fügt `t` zu `time` hinzu

**Interne Logik:**
```csharp
double last_t = time.Count > 0 ? time[time.Count - 1] : 0;
physValue[] last_signals = values.Count > 0 ? values[values.Count - 1] : new physValue[0];

values.Add(value);
values_noise.Add(sensor_config.getNoisyMeasurement(t, last_t, value, last_signals, myConfigs));
time.Add(t);
```

**Hinweis:** Diese Methode wird automatisch von allen `measure()`-Methoden aufgerufen.

---

## Sensor-Konfiguration (sensor_config)

Jeder Sensor hat ein oder mehrere `sensor_config`-Objekte (eines pro Dimension).

### Wichtige sensor_config-Parameter

```csharp
sensor.myConfigs[index].apply_real_sensor    // bool: Rauschen aktivieren
sensor.myConfigs[index].noise_level          // double: Rausch-Stärke
sensor.myConfigs[index].y_min                // double: Minimaler Messwert
sensor.myConfigs[index].y_max                // double: Maximaler Messwert
sensor.myConfigs[index].drift_rate           // double: Sensor-Drift
sensor.myConfigs[index].sampling_time        // double: Abtastzeit [d]
```

**Beispiel:**
```csharp
// Sensor-Konfiguration setzen
var pH_sensor = new pH_sensor("F1_3");
pH_sensor.myConfigs[0].apply_real_sensor = true;
pH_sensor.myConfigs[0].noise_level = 0.05;  // 5% Rauschen
pH_sensor.myConfigs[0].y_min = 0.0;
pH_sensor.myConfigs[0].y_max = 14.0;
```

---

## Anwendungsbeispiele

### Beispiel 1: Einfacher Sensor

```csharp
using biogas;
using science;

// Sensor erstellen
var pH_sensor = new pH_sensor("F1_3");

// Simulation
for (double t = 0; t < 10; t += 0.5)
{
    // ADM-Stream simulieren
    double[] stream = new double[34];
    stream[19] = 1e-7;  // H+ Konzentration für pH 7
    
    // Messen
    physValue[] pH_values = pH_sensor.measure(t, 0.5, stream);
    
    Console.WriteLine($"t={t:F1} d: pH={pH_values[0].Value:F2}");
}

// Gesamten Verlauf abrufen
double[] time = pH_sensor.getTimeStream();
physValue[] pH_stream = pH_sensor.getMeasurementStream(0);

Console.WriteLine($"\nGesamt-Messungen: {time.Length}");
```

**Ausgabe:**
```
t=0.0 d: pH=7.00
t=0.5 d: pH=7.00
t=1.0 d: pH=7.00
...
t=9.5 d: pH=7.00

Gesamt-Messungen: 20
```

### Beispiel 2: Mehrdimensionaler Sensor

```csharp
using biogas;
using science;

// VFA-Matrix-Sensor (4 Dimensionen)
var vfa_sensor = new VFAmatrix_sensor("F1_3");

// Simulation
double[] stream = /* ADM-Stream mit VFA-Werten */;

physValue[] vfa = vfa_sensor.measure(5.0, 0.5, stream);

Console.WriteLine("VFA-Komponenten:");
Console.WriteLine($"Valeriansäure: {vfa[0].Value:F2} {vfa[0].Unit}");
Console.WriteLine($"Buttersäure: {vfa[1].Value:F2} {vfa[1].Unit}");
Console.WriteLine($"Propionsäure: {vfa[2].Value:F2} {vfa[2].Unit}");
Console.WriteLine($"Essigsäure: {vfa[3].Value:F2} {vfa[3].Unit}");

// Einzelne Komponente abrufen
physValue acetat = vfa_sensor.getCurrentMeasurement(3);  // Index 3 = Sac
Console.WriteLine($"\nAcetat: {acetat.Value:F2} {acetat.Unit}");

// Gesamten Verlauf einer Komponente
physValue[] acetat_stream = vfa_sensor.getMeasurementStream(3);
```

### Beispiel 3: Sensor mit Parametern

```csharp
using biogas;
using science;

// HRT-Sensor (benötigt Vliq-Parameter)
var hrt_sensor = new HRT_sensor("F1");

// Fermenter-Volumen
double Vliq = 2500.0;  // m³

// Simulation
for (double t = 0; t < 30; t += 1.0)
{
    double[] stream = /* ADM-Stream */;
    
    // Mit Parameter messen
    physValue[] hrt = hrt_sensor.measure(t, 1.0, stream, Vliq);
    
    Console.WriteLine($"Tag {t:F0}: HRT = {hrt[0].Value:F1} d");
    
    // Warnung bei zu kurzer HRT
    if (hrt[0].Value < 20.0)
    {
        Console.WriteLine("  WARNUNG: HRT zu kurz!");
    }
}
```

### Beispiel 4: Realistischer Sensor mit Rauschen

```csharp
using biogas;
using science;

// Sensor mit Rauschen erstellen
var pH_sensor = new pH_sensor("F1_3");

// Rauschen aktivieren
pH_sensor.myConfigs[0].apply_real_sensor = true;
pH_sensor.myConfigs[0].noise_level = 0.05;  // 5% Rauschen
pH_sensor.myConfigs[0].drift_rate = 0.001;  // Langsamer Drift

// Simulation
double[] stream = new double[34];
stream[19] = 1e-7;  // pH 7.0

for (double t = 0; t < 10; t += 0.5)
{
    pH_sensor.measure(t, 0.5, stream);
}

// Ideale vs. verrauschte Werte
double[] time = pH_sensor.getTimeStream();
physValue[] pH_ideal = pH_sensor.getMeasurementStream(0, false);
physValue[] pH_noisy = pH_sensor.getMeasurementStream(0, true);

Console.WriteLine("Zeit\tIdeal\tVerrauscht");
for (int i = 0; i < time.Length; i++)
{
    Console.WriteLine($"{time[i]:F1}\t{pH_ideal[i].Value:F3}\t{pH_noisy[i].Value:F3}");
}
```

**Ausgabe:**
```
Zeit    Ideal   Verrauscht
0.0     7.000   7.023
0.5     7.000   6.975
1.0     7.000   7.041
1.5     7.000   6.982
...
```

### Beispiel 5: Sensor-Zeitreihe analysieren

```csharp
using biogas;
using science;
using System.Linq;

var vfa_sensor = new VFA_sensor("F1_3");

// Simulation über 30 Tage
for (double t = 0; t < 30; t += 0.5)
{
    double[] stream = /* ADM-Stream */;
    vfa_sensor.measure(t, 0.5, stream);
}

// Zeitreihe auswerten
double[] time = vfa_sensor.getTimeStream();
physValue[] vfa_stream = vfa_sensor.getMeasurementStream(0);

// In double-Array konvertieren
double[] vfa_values = vfa_stream.Select(pv => pv.Value).ToArray();

// Statistiken
double min = vfa_values.Min();
double max = vfa_values.Max();
double mean = vfa_values.Average();
double std = Math.Sqrt(vfa_values.Select(v => Math.Pow(v - mean, 2)).Average());

Console.WriteLine("VFA-Statistiken:");
Console.WriteLine($"  Min: {min:F1} mg/l");
Console.WriteLine($"  Max: {max:F1} mg/l");
Console.WriteLine($"  Mean: {mean:F1} mg/l");
Console.WriteLine($"  StdDev: {std:F1} mg/l");

// Überschreitungen zählen
int warnings = vfa_values.Count(v => v > 3000);
Console.WriteLine($"\nWarnungen (VFA > 3000 mg/l): {warnings}");

// Kritische Zeitpunkte finden
Console.WriteLine("\nKritische Zeitpunkte:");
for (int i = 0; i < vfa_values.Length; i++)
{
    if (vfa_values[i] > 3000)
    {
        Console.WriteLine($"  Tag {time[i]:F1}: {vfa_values[i]:F1} mg/l");
    }
}
```

### Beispiel 6: Messwert zu bestimmter Zeit

```csharp
using biogas;
using science;

var pH_sensor = new pH_sensor("F1_3");

// Simulation
for (double t = 0; t <= 30; t += 0.5)
{
    double[] stream = /* ... */;
    pH_sensor.measure(t, 0.5, stream);
}

// Werte zu bestimmten Zeitpunkten
double[] times_of_interest = {0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0};

Console.WriteLine("pH zu bestimmten Zeitpunkten:");
foreach (double t in times_of_interest)
{
    physValue pH = pH_sensor.getMeasurementAt(0, t);
    Console.WriteLine($"Tag {t:F0}: pH = {pH.Value:F2}");
}

// Nächstliegende Messung
physValue pH_day_7_3 = pH_sensor.getMeasurementAt(0, 7.3);  // Findet Messung bei t=7.0 oder t=7.5
```

### Beispiel 7: Sensor persistieren und laden

```csharp
using biogas;
using science;

// Sensor erstellen und konfigurieren
var pH_sensor = new pH_sensor("F1_3");
pH_sensor.myConfigs[0].apply_real_sensor = true;
pH_sensor.myConfigs[0].noise_level = 0.05;
pH_sensor.myConfigs[0].y_min = 0.0;
pH_sensor.myConfigs[0].y_max = 14.0;

// Als XML speichern
string xml = pH_sensor.getParamsAsXMLString();
System.IO.File.WriteAllText("pH_sensor_config.xml", xml);

Console.WriteLine("Sensor gespeichert in pH_sensor_config.xml");
Console.WriteLine(xml);

// Später: Sensor aus XML laden
var loaded_sensor = new pH_sensor("pH_sensor_config.xml");

Console.WriteLine($"\nGeladener Sensor:");
Console.WriteLine($"  ID: {loaded_sensor.id}");
Console.WriteLine($"  Name: {loaded_sensor.name}");
Console.WriteLine($"  Rauschen: {loaded_sensor.myConfigs[0].apply_real_sensor}");
Console.WriteLine($"  Noise Level: {loaded_sensor.myConfigs[0].noise_level}");
```

### Beispiel 8: Custom Sensor erstellen

```csharp
using biogas;
using science;

/// <summary>
/// Custom Sensor: Misst das Verhältnis VFA/TS
/// </summary>
public class VFA_TS_sensor : sensor
{
    public VFA_TS_sensor(string id_suffix) :
        base($"VFA_TS_{id_suffix}", 
             $"VFA/TS ratio sensor {id_suffix}", 
             id_suffix)
    {
        _type = 0;  // Stream-Sensor
    }
    
    public override string spec 
    { 
        get { return "VFA_TS"; } 
    }
    
    protected override physValue[] doMeasurement(double[] x, params double[] par)
    {
        physValue[] values = new physValue[1];
        
        // VFA aus ADM-Stream berechnen
        physValue vfa = ADMstate.calcVFAOfADMstate(x, "gHAceq/l");
        
        // TS müsste separat berechnet werden - hier vereinfacht
        double ts = 10.0;  // Annahme: 10% TS
        
        // Verhältnis berechnen
        double ratio = vfa.Value / ts;
        
        values[0] = new physValue("VFA_TS", ratio, "gHAceq/(l·%TS)", 
                                  "VFA to TS ratio");
        
        return values;
    }
}

// Verwendung
var custom_sensor = new VFA_TS_sensor("F1_3");
double[] stream = /* ADM-Stream */;
physValue[] ratio = custom_sensor.measure(5.0, 0.5, stream);

Console.WriteLine($"VFA/TS: {ratio[0].Value:F2} {ratio[0].Unit}");
```

---

## Häufige Fehler und Lösungen

### Problem 1: Dimension-Inkonsistenz

```csharp
// FEHLER: doMeasurement gibt falschen Vektor zurück
protected override physValue[] doMeasurement(double[] x, params double[] par)
{
    physValue[] values = new physValue[2];  // Dimension = 2 deklariert
    values[0] = new physValue("val1", 5.0, "unit");
    // values[1] nicht gesetzt!
    return values;  // NullReferenceException später!
}

// LÖSUNG: Alle Elemente setzen
protected override physValue[] doMeasurement(double[] x, params double[] par)
{
    physValue[] values = new physValue[dimension];
    for (int i = 0; i < dimension; i++)
    {
        values[i] = new physValue($"val{i}", i * 1.0, "unit");
    }
    return values;
}
```

### Problem 2: Sampling-Zeit ignoriert

```csharp
// PROBLEM: Messung bei jeder Zeit, unabhängig von deltatime
for (double t = 0; t < 10; t += 0.01)  // Alle 14.4 Minuten
{
    sensor.measure(t, 0.5, stream);  // deltatime = 0.5 Tage (12 Stunden)
}
// Nur ~20 Messungen gespeichert (alle 0.5 Tage)

// BESSER: Zeitschritt an deltatime anpassen
for (double t = 0; t < 10; t += 0.5)  // Alle 12 Stunden
{
    sensor.measure(t, 0.5, stream);
}
```

### Problem 3: Index-Zugriff außerhalb der Grenzen

```csharp
// FEHLER: Falscher Index
var vfa_sensor = new VFAmatrix_sensor("F1_3");  // dimension = 4
vfa_sensor.measure(5.0, 0.5, stream);

physValue val = vfa_sensor.getCurrentMeasurement(4);  // Exception! Index 0-3

// LÖSUNG: 0-basierte Indizierung
physValue sva = vfa_sensor.getCurrentMeasurement(0);  // OK
physValue sbu = vfa_sensor.getCurrentMeasurement(1);  // OK
physValue spro = vfa_sensor.getCurrentMeasurement(2);  // OK
physValue sac = vfa_sensor.getCurrentMeasurement(3);  // OK
```

### Problem 4: Falsche doMeasurement-Signatur

```csharp
// FEHLER: Sensor-Typ nicht mit doMeasurement übereinstimmend
public class MyCustomSensor : sensor
{
    public MyCustomSensor(string id_suffix) : base(...)
    {
        _type = 0;  // Typ 0: doMeasurement(double[] x)
    }
    
    // FALSCH: Typ 1 Signatur für Typ 0 Sensor
    protected override physValue[] doMeasurement(double[] x, params double[] par)
    {
        // ...
    }
}

// LÖSUNG: Korrekte Typ-Signatur verwenden
public class MyCustomSensor : sensor
{
    public MyCustomSensor(string id_suffix) : base(...)
    {
        _type = 1;  // Typ 1: doMeasurement(double[] x, params double[] par)
    }
    
    protected override physValue[] doMeasurement(double[] x, params double[] par)
    {
        // ...
    }
}
```

### Problem 5: Messwerte ohne Messung abrufen

```csharp
// FEHLER: Kein measure() aufgerufen
var sensor = new pH_sensor("F1_3");
physValue pH = sensor.getCurrentMeasurement();  // Exception oder 0-Vektor

// LÖSUNG: Erst messen
var sensor = new pH_sensor("F1_3");
double[] stream = /* ... */;
sensor.measure(5.0, 0.5, stream);
physValue pH = sensor.getCurrentMeasurement();  // OK
```

### Problem 6: physValue-Einheiten nicht beachtet

```csharp
// PROBLEM: Annahme über Einheit
var vfa_sensor = new VFA_sensor("F1_3");
vfa_sensor.measure(5.0, 0.5, stream);
physValue vfa = vfa_sensor.getCurrentMeasurement();

// Falsche Annahme: VFA ist in mg/l
double vfa_mg_l = vfa.Value;  // Aber vfa ist in gHAceq/l!

// BESSER: Einheit prüfen oder konvertieren
Console.WriteLine($"VFA: {vfa.Value} {vfa.Unit}");

// Oder: Einheit konvertieren
physValue vfa_converted = vfa.convertUnit("mg/l");  // Falls möglich
```

---

## Performance-Tipps

### 1. Unnötige Objekt-Erstellung vermeiden

```csharp
// LANGSAM: Neue physValue-Arrays bei jedem Zugriff
for (int i = 0; i < 1000; i++)
{
    physValue[] vfa = sensor.getCurrentMeasurementVector();
    double sum = vfa[0].Value + vfa[1].Value + vfa[2].Value + vfa[3].Value;
}

// SCHNELLER: Einmal holen
physValue[] vfa = sensor.getCurrentMeasurementVector();
for (int i = 0; i < 1000; i++)
{
    double sum = vfa[0].Value + vfa[1].Value + vfa[2].Value + vfa[3].Value;
}
```

### 2. getMeasurementStream() sparsam nutzen

```csharp
// LANGSAM: Stream bei jedem Zugriff kopieren
for (int i = 0; i < 100; i++)
{
    physValue[] stream = sensor.getMeasurementStream(0);
    double last = stream[stream.Length - 1].Value;
}

// SCHNELLER: getCurrentMeasurement() für letzten Wert
for (int i = 0; i < 100; i++)
{
    physValue last = sensor.getCurrentMeasurement(0);
}
```

### 3. Direkte double-Zugriffe nutzen

```csharp
// LANGSAM: physValue erstellen
physValue pH = sensor.getCurrentMeasurement(0);
double pH_val = pH.Value;
string pH_unit = pH.Unit;

// Wenn nur Wert benötigt wird:
double pH_val = sensor.getCurrentMeasurement(0).Value;
```

### 4. isEmpty() vor Zugriff prüfen

```csharp
// INEFFIZIENT: Exception handling
try
{
    physValue val = sensor.getCurrentMeasurement();
}
catch
{
    // Keine Daten
}

// BESSER: Vorher prüfen
if (!sensor.isEmpty())
{
    physValue val = sensor.getCurrentMeasurement();
}
```

---

## Best Practices

### 1. Aussagekräftige Sensor-IDs

```csharp
// GUT: Klare Struktur
var pH_in = new pH_sensor("F1_2");   // Fermenter 1, Eingang
var pH_out = new pH_sensor("F1_3");  // Fermenter 1, Ausgang
var vfa = new VFA_sensor("F1_3");

// VERMEIDEN: Unklare IDs
var sensor1 = new pH_sensor("a");
var sensor2 = new pH_sensor("b");
```

### 2. Dimension in Konstruktor setzen

```csharp
// GUT: Dimension im Konstruktor
public class MyMultiSensor : sensor
{
    public MyMultiSensor(string id_suffix) :
        base($"multi_{id_suffix}", 
             $"Multi sensor {id_suffix}", 
             id_suffix,
             5)  // 5 Dimensionen
    {
        _type = 0;
    }
    
    protected override physValue[] doMeasurement(double[] x, params double[] par)
    {
        physValue[] values = new physValue[dimension];  // = 5
        // ...
        return values;
    }
}
```

### 3. Sinnvolle physValue-Attribute

```csharp
// GUT: Vollständige physValue
protected override physValue[] doMeasurement(double[] x, params double[] par)
{
    physValue[] values = new physValue[1];
    values[0] = new physValue(
        "pH",                  // Symbol
        7.2,                   // Value
        "-",                   // Unit
        "pH value"             // Label
    );
    return values;
}

// VERMEIDEN: Unvollständige physValue
values[0] = new physValue(7.2);  // Keine Symbol, Unit, Label
```

### 4. Konsistente Typ-Definitionen

```csharp
// GUT: Typ entspricht doMeasurement
public class MyStreamSensor : sensor
{
    public MyStreamSensor(string id_suffix) : base(...)
    {
        _type = 0;  // Stream-Sensor
    }
    
    protected override physValue[] doMeasurement(double[] x, params double[] par)
    {
        // Typ 0: nur x-Parameter
    }
}

public class MyParamSensor : sensor
{
    public MyParamSensor(string id_suffix) : base(...)
    {
        _type = 1;  // Mit Parametern
    }
    
    protected override physValue[] doMeasurement(double[] x, params double[] par)
    {
        // Typ 1: x und par nutzen
        double Vliq = par[0];
    }
}
```

### 5. XML-Persistenz nutzen

```csharp
// GUT: Konfiguration speichern
var sensor = new pH_sensor("F1_3");
sensor.myConfigs[0].apply_real_sensor = true;
sensor.myConfigs[0].noise_level = 0.05;

string xml = sensor.getParamsAsXMLString();
System.IO.File.WriteAllText("config.xml", xml);

// Später laden
var loaded = new pH_sensor("config.xml");
```

---

## Zusammenfassung

### Sensor-Erstellung

```csharp
// Minimal
public class MySensor : sensor
{
    public MySensor(string id_suffix) :
        base($"my_{id_suffix}", $"My sensor {id_suffix}", id_suffix)
    {
        _type = 0;
    }
    
    public override string spec { get { return "my"; } }
    
    protected override physValue[] doMeasurement(double[] x, params double[] par)
    {
        physValue[] values = new physValue[dimension];
        // ... Messung durchführen ...
        return values;
    }
}
```

### Sensor-Verwendung

```csharp
// Erstellen
var sensor = new MySensor("F1_3");

// Messen
double[] stream = /* ... */;
physValue[] measured = sensor.measure(5.0, 0.5, stream);

// Aktuellen Wert abrufen
physValue current = sensor.getCurrentMeasurement();

// Verlauf abrufen
double[] time = sensor.getTimeStream();
physValue[] stream = sensor.getMeasurementStream(0);
```

### Wichtigste Methoden

**Messen:**
- `measure(double time, double deltatime, double[] x, ...)`

**Abrufen:**
- `getCurrentMeasurement()` / `getCurrentMeasurement(int index)`
- `getMeasurementAt(double t)` / `getMeasurementAt(int index, double t)`
- `getMeasurementStream(int index)`
- `getTimeStream()`

**Verwaltung:**
- `deleteData()`
- `isEmpty()`
- `getParamsAsXMLString()`

---

## TODOs

Laut Quellcode:

### sensor.cs
- `time` als `physValue` implementieren (aktuell `List<double>`)
- Mehrdimensionale Daten: Alle skalaren Größen als Listen/Vektoren definieren (noise_level, y_min, etc.) - **Gelöst via sensor_config**

### sensor_properties.cs
- Evtl. weitere Properties für besseren Zugriff

---

## Siehe auch

- **biogas.sensors**: Sensor-Verwaltungsklasse
- **biogas.sensor_config**: Sensor-Konfigurationsklasse (Rauschen, Drift, etc.)
- **science.physValue**: Physikalische Werte mit Einheiten
- Spezifische Sensor-Implementierungen (pH_sensor, VFA_sensor, etc.)

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*
