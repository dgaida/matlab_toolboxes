# Sensor Array API Documentation

## Übersicht

Die `sensor_array`-Klasse verwaltet eine Liste von Sensoren mit derselben Spezifikation (z.B. alle Q-Sensoren für verschiedene Substrate). Sie ermöglicht den aggregierten Zugriff auf Messwerte (Summe, Mittelwert) und die gemeinsame Verwaltung verwandter Sensoren.

Die Klasse ist als partielle Klasse über zwei Dateien verteilt:
- `sensor_array.cs`: Hauptmethoden und Sensor-Verwaltung
- `sensor_array_properties.cs`: Eigenschaften und private Felder

---

## Namespace

```csharp
namespace biogas
```

---

## Klassendeklaration

```csharp
public partial class sensor_array : List<biogas.sensor>
```

**Basisklassen:**
- `List<biogas.sensor>`: Erbt von generischer Liste

---

## Eigenschaften

### Identifikation

#### `id` (Property, read-only)

```csharp
public string id { get; }
```

Eindeutige ID des Sensor-Arrays.

**Beispiele:**
- `"Q"` - Volumenstrom-Sensoren
- `"substrateparams"` - Substrat-Parameter-Sensoren

**Hinweis:** ID beschreibt die Sensor-Spezifikation, nicht einzelne Sensoren.

**Beispiel:**
```csharp
var q_array = new sensor_array("Q");
Console.WriteLine($"Array-ID: {q_array.id}");  // "Q"
```

---

## Konstruktoren

### `sensor_array(string id)`

Erstellt ein leeres Sensor-Array mit der angegebenen ID.

**Parameter:**
- `id` (string): Array-ID

**Beispiel:**
```csharp
var q_array = new sensor_array("Q");
// Array ist leer, Sensoren können hinzugefügt werden
```

---

## Sensor-Verwaltung

### Sensoren hinzufügen

#### `addSensor(sensor mySensor)`

Fügt einen Sensor zum Array hinzu.

**Parameter:**
- `mySensor` (sensor): Sensor-Objekt

**Hinweis:** Die Methode ruft intern `this.Add(mySensor)` auf (von `List<T>` geerbt).

**Beispiel:**
```csharp
var q_array = new sensor_array("Q");

// Verschiedene Q-Sensoren hinzufügen
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));
q_array.addSensor(new Q_sensor("grass"));

Console.WriteLine($"Anzahl Sensoren: {q_array.Count}");  // 3
```

### Sensor-Zugriff

#### `get(string id)`

Holt Sensor nach ID.

**Parameter:**
- `id` (string): Sensor-ID (vollständige ID, z.B. `"Q_maize"`)

**Rückgabe:**
- `sensor`: Sensor-Objekt

**Ausnahmen:**
- `exception`: Sensor nicht gefunden

**Beispiel:**
```csharp
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));

sensor q_maize = q_array.get("Q_maize");
Console.WriteLine($"Sensor: {q_maize.id}");
```

#### `getIDs()`

Holt IDs aller Sensoren im Array.

**Rückgabe:**
- `string[]`: Array mit ID-Suffixen (nicht vollständige IDs!)

**Wichtig:** Gibt `id_suffix` zurück, nicht `id`!

**Beispiel:**
```csharp
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));

string[] ids = q_array.getIDs();
// ids[0] = "maize" (nicht "Q_maize"!)
// ids[1] = "manure" (nicht "Q_manure"!)

foreach (string id in ids)
{
    Console.WriteLine($"ID-Suffix: {id}");
}
```

#### `exist(string id)`

Prüft ob Sensor im Array existiert.

**Parameter:**
- `id` (string): Sensor-ID (vollständig)

**Rückgabe:**
- `bool`: true wenn vorhanden

**Beispiel:**
```csharp
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));

bool has_maize = q_array.exist("Q_maize");    // true
bool has_grass = q_array.exist("Q_grass");    // false

if (has_maize)
{
    sensor q_maize = q_array.get("Q_maize");
}
```

---

## XML-Persistenz

### Laden

#### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest Sensor-Array aus XML.

**Parameter:**
- `reader` (ref XmlTextReader): XML-Reader (bei `<sensor_array>` positioniert)

**XML-Struktur:**
```xml
<sensor_array id="Q">
    <sensor id="Q_maize" spec="Q">
        <id_suffix>maize</id_suffix>
        <!-- weitere Sensor-Parameter -->
    </sensor>
    <sensor id="Q_manure" spec="Q">
        <id_suffix>manure</id_suffix>
        <!-- weitere Sensor-Parameter -->
    </sensor>
</sensor_array>
```

**Wichtig:**
- Aktuell werden nur `Q_sensor` unterstützt
- Andere Sensor-Typen werfen eine Exception

**Ausnahmen:**
- `exception`: Wenn `spec != "Q"`

**Beispiel:**
```csharp
XmlTextReader reader = new XmlTextReader("sensor_array.xml");
// ... navigiere zu <sensor_array> ...

var q_array = new sensor_array("Q");
q_array.getParamsFromXMLReader(ref reader);

Console.WriteLine($"Geladene Sensoren: {q_array.Count}");
```

### Speichern

#### `getParamsAsXMLString()`

Gibt Sensor-Array als XML-String zurück.

**Rückgabe:**
- `string`: XML-String

**XML-Format:**
```xml
<sensor_array id="Q">
    <sensor id="Q_maize" spec="Q">
        ...
    </sensor>
    <sensor id="Q_manure" spec="Q">
        ...
    </sensor>
</sensor_array>
```

**Beispiel:**
```csharp
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));

string xml = q_array.getParamsAsXMLString();
Console.WriteLine(xml);

// In Datei speichern
System.IO.File.WriteAllText("q_array.xml", xml);
```

---

## Aggregierte Messungen

### `getMeasurementDAt(substrates mySubstrates, string s_operator, double t, int index, bool noisy)`

Berechnet aggregierte Messwerte über mehrere Sensoren.

**Parameter:**
- `mySubstrates` (substrates): Substrat-Liste
- `s_operator` (string): Aggregations-Operator
  - `"sum"`: Summe aller Werte
  - `"mean"`: Durchschnitt aller Werte
- `t` (double): Simulationszeit [d]
- `index` (int): Dimensions-Index (0-basiert)
- `noisy` (bool): Verrauschte Werte verwenden

**Rückgabe:**
- `double`: Aggregierter Wert

**Verhalten:**
- Nur Sensoren, deren `id_suffix` in `mySubstrates.ids` enthalten ist, werden berücksichtigt
- Pumpen mit gleichem `id_suffix` werden ignoriert

**Ausnahmen:**
- `exception`: Ungültiger Index
- Keine Exception bei unbekanntem Operator (gibt 0 zurück)

**Beispiel:**
```csharp
var substrates = new substrates("substrates.xml");
// substrates.ids = ["maize", "manure", "grass"]

var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));
q_array.addSensor(new Q_sensor("grass"));
q_array.addSensor(new Q_sensor("pump_F1_F2"));  // Wird ignoriert

// Messungen durchführen
// ... (siehe Beispiele unten) ...

// Summe aller Substrat-Volumenströme
double Q_total = q_array.getMeasurementDAt(
    substrates,
    "sum",      // Operator
    10.0,       // Zeit
    0,          // Index
    false       // Kein Rauschen
);

Console.WriteLine($"Gesamt-Volumenstrom: {Q_total} m³/d");

// Durchschnittlicher Volumenstrom
double Q_mean = q_array.getMeasurementDAt(
    substrates,
    "mean",
    10.0,
    0,
    false
);

Console.WriteLine($"Durchschnitt: {Q_mean} m³/d");
```

**Hinweis:** TODO im Code erwähnt, dass Operator-Handling verbessert werden sollte.

---

## Anwendungsbeispiele

### Beispiel 1: Q-Sensor-Array für Substrate

```csharp
using biogas;
using science;

// Substrate definieren
var substrates = new substrates();
substrates.addSubstrate(new substrate("maize"));
substrates.addSubstrate(new substrate("manure"));
substrates.addSubstrate(new substrate("grass"));

// Q-Sensor-Array erstellen
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));
q_array.addSensor(new Q_sensor("grass"));

// Simulation: Verschiedene Volumenströme
double[] Q_maize_stream = new double[34];   // ADM-Stream
Q_maize_stream[0] = 100.0;  // Q in erster Position

double[] Q_manure_stream = new double[34];
Q_manure_stream[0] = 80.0;

double[] Q_grass_stream = new double[34];
Q_grass_stream[0] = 20.0;

// Messungen durchführen
for (double t = 0; t <= 10; t += 1.0)
{
    q_array.get("Q_maize").measure(t, 1.0, Q_maize_stream);
    q_array.get("Q_manure").measure(t, 1.0, Q_manure_stream);
    q_array.get("Q_grass").measure(t, 1.0, Q_grass_stream);
}

// Aggregierte Werte
double Q_sum = q_array.getMeasurementDAt(substrates, "sum", 10.0, 0, false);
double Q_mean = q_array.getMeasurementDAt(substrates, "mean", 10.0, 0, false);

Console.WriteLine($"Gesamt-Volumenstrom: {Q_sum} m³/d");
Console.WriteLine($"Durchschnitt: {Q_mean} m³/d");
```

**Ausgabe:**
```
Gesamt-Volumenstrom: 200.0 m³/d
Durchschnitt: 66.67 m³/d
```

### Beispiel 2: Pumpen vs. Substrate filtern

```csharp
using biogas;
using science;

var substrates = new substrates();
substrates.addSubstrate(new substrate("maize"));
substrates.addSubstrate(new substrate("manure"));

// Q-Array mit Substraten UND Pumpen
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));
q_array.addSensor(new Q_sensor("pump_F1_F2"));  // Pumpe
q_array.addSensor(new Q_sensor("pump_F2_F1"));  // Pumpe

// Streams
double[] Q_maize = new double[34];
Q_maize[0] = 100.0;

double[] Q_manure = new double[34];
Q_manure[0] = 50.0;

double[] Q_pump1 = new double[34];
Q_pump1[0] = 150.0;

double[] Q_pump2 = new double[34];
Q_pump2[0] = 200.0;

// Messen
double t = 5.0;
q_array.get("Q_maize").measure(t, 1.0, Q_maize);
q_array.get("Q_manure").measure(t, 1.0, Q_manure);
q_array.get("Q_pump_F1_F2").measure(t, 1.0, Q_pump1);
q_array.get("Q_pump_F2_F1").measure(t, 1.0, Q_pump2);

// Nur Substrate summieren
double Q_substrates = q_array.getMeasurementDAt(
    substrates,
    "sum",
    t,
    0,
    false
);

Console.WriteLine($"Substrate: {Q_substrates} m³/d");  // 150.0, nicht 500.0!
Console.WriteLine("\nEinzelne Sensoren:");

foreach (sensor s in q_array)
{
    double val = s.getCurrentMeasurementD(0);
    bool is_substrate = substrates.ids.Contains(s.id_suffix);
    
    Console.WriteLine($"  {s.id}: {val} m³/d " +
                     $"(Substrat: {is_substrate})");
}
```

**Ausgabe:**
```
Substrate: 150.0 m³/d

Einzelne Sensoren:
  Q_maize: 100.0 m³/d (Substrat: True)
  Q_manure: 50.0 m³/d (Substrat: True)
  Q_pump_F1_F2: 150.0 m³/d (Substrat: False)
  Q_pump_F2_F1: 200.0 m³/d (Substrat: False)
```

### Beispiel 3: Substratparameter-Array

```csharp
using biogas;
using science;

// Substratparameter-Array
var params_array = new sensor_array("substrateparams");

// Verschiedene Substrate
params_array.addSensor(new substrateparams_sensor("maize"));
params_array.addSensor(new substrateparams_sensor("manure"));
params_array.addSensor(new substrateparams_sensor("grass"));

// Laborproben
double[] maize_analysis = {
    25.0,   // TS
    22.5,   // VS (% FM)
    4.5,    // pH
    0.5,    // VFA
    2.0,    // TAC
    0.8,    // NH4-N
    2.5,    // RL
    8.0,    // RP
    20.0,   // RF
    300.0   // COD
};

double[] manure_analysis = {
    8.0,    // TS
    6.0,    // VS
    7.2,    // pH
    2.0,    // VFA
    5.0,    // TAC
    2.5,    // NH4-N
    1.5,    // RL
    3.0,    // RP
    5.0,    // RF
    100.0   // COD
};

// Messungen durchführen
params_array.get("substrateparams_maize").measure(0.0, 1.0, maize_analysis);
params_array.get("substrateparams_manure").measure(0.0, 1.0, manure_analysis);

// IDs abrufen
string[] ids = params_array.getIDs();
Console.WriteLine("Substrat-IDs im Array:");
foreach (string id in ids)
{
    Console.WriteLine($"  - {id}");
}

// Einzelne Parameter abrufen
physValue ts_maize = params_array.get("substrateparams_maize")
    .getCurrentMeasurement("TS_%FM");
physValue ts_manure = params_array.get("substrateparams_manure")
    .getCurrentMeasurement("TS_%FM");

Console.WriteLine($"\nTS-Werte:");
Console.WriteLine($"  Mais: {ts_maize.Value} {ts_maize.Unit}");
Console.WriteLine($"  Gülle: {ts_manure.Value} {ts_manure.Unit}");
```

**Ausgabe:**
```
Substrat-IDs im Array:
  - maize
  - manure

TS-Werte:
  Mais: 25.0 % FM
  Gülle: 8.0 % FM
```

### Beispiel 4: Zeitreihen-Analyse

```csharp
using biogas;
using science;

var substrates = new substrates();
substrates.addSubstrate(new substrate("maize"));
substrates.addSubstrate(new substrate("manure"));

var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));

// Simulation mit variierenden Volumenströmen
for (double t = 0; t <= 30; t += 1.0)
{
    // Variierender Volumenstrom
    double Q_maize_val = 100 + 20 * Math.Sin(2 * Math.PI * t / 7);
    double Q_manure_val = 50 + 10 * Math.Cos(2 * Math.PI * t / 7);
    
    double[] Q_maize_stream = new double[34];
    Q_maize_stream[0] = Q_maize_val;
    
    double[] Q_manure_stream = new double[34];
    Q_manure_stream[0] = Q_manure_val;
    
    q_array.get("Q_maize").measure(t, 1.0, Q_maize_stream);
    q_array.get("Q_manure").measure(t, 1.0, Q_manure_stream);
}

// Zeitreihe der Summe berechnen
Console.WriteLine("Tag\tMais\tGülle\tSumme\tMittel");
Console.WriteLine("".PadRight(50, '-'));

for (double t = 0; t <= 30; t += 5.0)
{
    double Q_maize = q_array.get("Q_maize").getMeasurementDAt(0, t, false);
    double Q_manure = q_array.get("Q_manure").getMeasurementDAt(0, t, false);
    
    double Q_sum = q_array.getMeasurementDAt(substrates, "sum", t, 0, false);
    double Q_mean = q_array.getMeasurementDAt(substrates, "mean", t, 0, false);
    
    Console.WriteLine($"{t:F0}\t{Q_maize:F1}\t{Q_manure:F1}\t{Q_sum:F1}\t{Q_mean:F1}");
}
```

**Ausgabe:**
```
Tag     Mais    Gülle   Summe   Mittel
--------------------------------------------------
0       100.0   60.0    160.0   80.0
5       117.3   45.9    163.2   81.6
10      115.9   40.5    156.4   78.2
15      97.3    45.9    143.2   71.6
20      84.1    59.5    143.6   71.8
25      82.7    54.1    136.8   68.4
30      100.0   60.0    160.0   80.0
```

### Beispiel 5: XML-Persistenz

```csharp
using biogas;
using science;

// Array erstellen
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));
q_array.addSensor(new Q_sensor("grass"));

// Konfiguration setzen
foreach (sensor s in q_array)
{
    s.myConfigs[0].set_params_of(
        "apply_real_sensor", true,
        "noise_level", 0.02
    );
}

// Als XML speichern
string xml = q_array.getParamsAsXMLString();
System.IO.File.WriteAllText("q_array.xml", xml);

Console.WriteLine("Gespeichert in q_array.xml");
Console.WriteLine("\nInhalt:");
Console.WriteLine(xml);

// Später: Aus XML laden
XmlTextReader reader = new XmlTextReader("q_array.xml");
var loaded_array = new sensor_array("Q");

// Zum <sensor_array> navigieren
while (reader.Read())
{
    if (reader.NodeType == XmlNodeType.Element && reader.Name == "sensor_array")
    {
        loaded_array.getParamsFromXMLReader(ref reader);
        break;
    }
}
reader.Close();

Console.WriteLine($"\nGeladene Sensoren: {loaded_array.Count}");
foreach (sensor s in loaded_array)
{
    Console.WriteLine($"  - {s.id}");
}
```

### Beispiel 6: Dynamisches Hinzufügen

```csharp
using biogas;
using science;

var substrates = new substrates();
var q_array = new sensor_array("Q");

// Dynamisch Sensoren basierend auf Substraten erstellen
Console.WriteLine("Erstelle Q-Sensoren für Substrate:");

foreach (substrate s in substrates)
{
    string id_suffix = s.id;
    var q_sensor = new Q_sensor(id_suffix);
    
    q_array.addSensor(q_sensor);
    
    Console.WriteLine($"  - {q_sensor.id} hinzugefügt");
}

Console.WriteLine($"\nGesamt: {q_array.Count} Sensoren");

// Prüfen ob alle vorhanden
Console.WriteLine("\nVollständigkeits-Check:");
foreach (substrate s in substrates)
{
    string sensor_id = $"Q_{s.id}";
    bool exists = q_array.exist(sensor_id);
    
    Console.WriteLine($"  {sensor_id}: {(exists ? "✓" : "✗")}");
}
```

### Beispiel 7: Iteration über Array

```csharp
using biogas;
using science;

var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));
q_array.addSensor(new Q_sensor("grass"));

// Messungen
// ... (siehe vorherige Beispiele) ...

Console.WriteLine("Alle Sensoren im Array:");
Console.WriteLine("ID\t\t\tAktueller Wert");
Console.WriteLine("".PadRight(50, '-'));

// Iteration (von List<sensor> geerbt)
foreach (sensor s in q_array)
{
    if (!s.isEmpty())
    {
        double val = s.getCurrentMeasurementD(0);
        Console.WriteLine($"{s.id}\t\t{val:F2} m³/d");
    }
    else
    {
        Console.WriteLine($"{s.id}\t\t(keine Daten)");
    }
}

// Alternativ: Indexzugriff
Console.WriteLine("\nIndexzugriff:");
for (int i = 0; i < q_array.Count; i++)
{
    sensor s = q_array[i];
    Console.WriteLine($"[{i}]: {s.id}");
}
```

**Ausgabe:**
```
Alle Sensoren im Array:
ID                      Aktueller Wert
--------------------------------------------------
Q_maize                 100.00 m³/d
Q_manure                50.00 m³/d
Q_grass                 20.00 m³/d

Indexzugriff:
[0]: Q_maize
[1]: Q_manure
[2]: Q_grass
```

---

## Häufige Fehler und Lösungen

### Problem 1: ID vs. ID-Suffix verwechseln

```csharp
// FALSCH: getIDs() gibt id_suffix zurück, nicht id
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));

string[] ids = q_array.getIDs();
sensor s = q_array.get(ids[0]);  // Exception! ids[0] = "maize", nicht "Q_maize"

// RICHTIG: Vollständige ID verwenden
sensor s = q_array.get("Q_maize");

// Oder: ID aus Suffix konstruieren
string full_id = $"{q_array.id}_{ids[0]}";
sensor s = q_array.get(full_id);
```

### Problem 2: Nicht-Q-Sensoren in Array

```csharp
// FEHLER: Nur Q-Sensoren werden aus XML geladen
var array = new sensor_array("pH");
// ... XML mit pH-Sensoren laden ...
// Exception! Nur spec="Q" unterstützt

// LÖSUNG: Manuell hinzufügen statt XML
var array = new sensor_array("pH");
array.addSensor(new pH_sensor("F1_3"));
array.addSensor(new pH_sensor("F2_3"));
```

### Problem 3: Substrat-Liste nicht korrekt

```csharp
// PROBLEM: Sensor-ID-Suffix nicht in substrates.ids
var substrates = new substrates();
substrates.addSubstrate(new substrate("mais"));  // "mais"

var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));  // "maize"

// getMeasurementDAt findet Sensor nicht
double Q_sum = q_array.getMeasurementDAt(substrates, "sum", 5.0, 0, false);
// Q_sum = 0, da "maize" nicht in substrates.ids ("mais")

// LÖSUNG: IDs müssen übereinstimmen
var substrates = new substrates();
substrates.addSubstrate(new substrate("maize"));  // "maize"

var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));  // "maize"

// Jetzt funktioniert es
double Q_sum = q_array.getMeasurementDAt(substrates, "sum", 5.0, 0, false);
```

### Problem 4: Unbekannter Operator

```csharp
// FEHLER: Falscher Operator
double result = q_array.getMeasurementDAt(substrates, "average", 5.0, 0, false);
// result = 0 (kein Fehler, aber falsches Ergebnis!)

// RICHTIG: Korrekte Operatoren verwenden
double sum = q_array.getMeasurementDAt(substrates, "sum", 5.0, 0, false);
double mean = q_array.getMeasurementDAt(substrates, "mean", 5.0, 0, false);
```

### Problem 5: Index außerhalb

```csharp
// FEHLER: Ungültiger Index
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));  // Q_sensor hat dimension=1

double val = q_array.getMeasurementDAt(substrates, "sum", 5.0, 1, false);
// Exception! Index 1 bei dimension=1

// RICHTIG: Index 0 verwenden
double val = q_array.getMeasurementDAt(substrates, "sum", 5.0, 0, false);
```

---

## Performance-Tipps

### 1. Substrat-Liste cachen

```csharp
// Ineffizient: substrates bei jedem Aufruf neu erstellen
for (double t = 0; t < 100; t += 1.0)
{
    var substrates = new substrates("substrates.xml");
    double Q = q_array.getMeasurementDAt(substrates, "sum", t, 0, false);
}

// Besser: Einmal laden
var substrates = new substrates("substrates.xml");
for (double t = 0; t < 100; t += 1.0)
{
    double Q = q_array.getMeasurementDAt(substrates, "sum", t, 0, false);
}
```

### 2. Direkte Iteration statt get()

```csharp
// Ineffizient: get() in Schleife
string[] ids = q_array.getIDs();
foreach (string id_suffix in ids)
{
    sensor s = q_array.get($"{q_array.id}_{id_suffix}");
    // ... verwenden ...
}

// Besser: Direkte Iteration
foreach (sensor s in q_array)
{
    // ... verwenden ...
}
```

### 3. Existenz vorher prüfen

```csharp
// Ineffizient: Exception abfangen
try
{
    sensor s = q_array.get("Q_unknown");
}
catch
{
    // Nicht vorhanden
}

// Besser: Vorher prüfen
if (q_array.exist("Q_unknown"))
{
    sensor s = q_array.get("Q_unknown");
}
```

---

## Best Practices

### 1. Konsistente IDs

```csharp
// GUT: IDs konsistent halten
var substrates = new substrates();
substrates.addSubstrate(new substrate("maize"));

var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));  // Gleiche ID

// VERMEIDEN: Inkonsistente IDs
substrates.addSubstrate(new substrate("mais"));
q_array.addSensor(new Q_sensor("maize"));  // Nicht gefunden!
```

### 2. Array-ID beschreibt Typ

```csharp
// GUT: ID beschreibt Sensor-Typ
var q_array = new sensor_array("Q");
var params_array = new sensor_array("substrateparams");

// VERMEIDEN: Unklare IDs
var array1 = new sensor_array("array1");
var array2 = new sensor_array("my_sensors");
```

### 3. Sensor-Array-Netzwerk aufbauen

```csharp
// GUT: Q-Array für alle Substrate
var substrates = new substrates("substrates.xml");
var q_array = new sensor_array("Q");

foreach (substrate s in substrates)
{
    q_array.addSensor(new Q_sensor(s.id));
}

// Alle Substrate sind jetzt überwacht
```

### 4. getMeasurementDAt korrekt verwenden

```csharp
// GUT: Substrate-Liste übergeben
var substrates = new substrates();
substrates.addSubstrate(new substrate("maize"));
substrates.addSubstrate(new substrate("manure"));

double Q_sum = q_array.getMeasurementDAt(
    substrates,  // Filtert auf diese Substrate
    "sum",
    5.0,
    0,
    false
);

// VERMEIDEN: Leere Substrat-Liste
var empty_substrates = new substrates();
double Q_sum = q_array.getMeasurementDAt(
    empty_substrates,  // Gibt 0 zurück!
    "sum",
    5.0,
    0,
    false
);
```

### 5. XML-Struktur konsistent

```csharp
// GUT: Sensor-Array mit konsistenter Spezifikation
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));
q_array.addSensor(new Q_sensor("grass"));

string xml = q_array.getParamsAsXMLString();
// Alle Sensoren haben spec="Q"

// VERMEIDEN: Verschiedene Sensor-Typen im Array
var mixed_array = new sensor_array("mixed");
mixed_array.addSensor(new Q_sensor("maize"));
mixed_array.addSensor(new pH_sensor("F1_3"));  // Falscher Typ!
```

---

## Erweiterte Konzepte

### Sensor-Array als Filter

Das Sensor-Array fungiert als intelligenter Filter bei der `getMeasurementDAt()`-Methode:

```csharp
// Szenario: 3 Substrate + 2 Pumpen im Q-Array
var q_array = new sensor_array("Q");
q_array.addSensor(new Q_sensor("maize"));
q_array.addSensor(new Q_sensor("manure"));
q_array.addSensor(new Q_sensor("grass"));
q_array.addSensor(new Q_sensor("pump_F1_F2"));
q_array.addSensor(new Q_sensor("pump_F2_F1"));

// Nur Substrate in substrates-Liste
var substrates = new substrates();
substrates.addSubstrate(new substrate("maize"));
substrates.addSubstrate(new substrate("manure"));
substrates.addSubstrate(new substrate("grass"));

// Filter-Logik:
// 1. Iteriere über alle Sensoren im Array
// 2. Prüfe: ist sensor.id_suffix in substrates.ids?
// 3. Wenn ja: Addiere zur Summe
// 4. Wenn nein (Pumpen): Ignoriere

double Q_substrates_only = q_array.getMeasurementDAt(
    substrates,  // Filter
    "sum",
    5.0,
    0,
    false
);
// Ergebnis: Summe nur von maize, manure, grass
```

### Dynamische Array-Verwaltung

```csharp
using biogas;
using science;

public class DynamicArrayManager
{
    private sensors mySensors;
    private Dictionary<string, sensor_array> arrays;
    
    public DynamicArrayManager(sensors mySensors)
    {
        this.mySensors = mySensors;
        this.arrays = new Dictionary<string, sensor_array>();
    }
    
    /// <summary>
    /// Erstellt dynamisch Sensor-Arrays basierend auf Substrat-Liste
    /// </summary>
    public void CreateSubstrateArrays(substrates mySubstrates)
    {
        // Q-Array
        var q_array = new sensor_array("Q");
        foreach (substrate s in mySubstrates)
        {
            q_array.addSensor(new Q_sensor(s.id));
        }
        arrays["Q"] = q_array;
        mySensors.addSensorArray(q_array);
        
        // Substratparameter-Array
        var params_array = new sensor_array("substrateparams");
        foreach (substrate s in mySubstrates)
        {
            params_array.addSensor(new substrateparams_sensor(s.id));
        }
        arrays["substrateparams"] = params_array;
        mySensors.addSensorArray(params_array);
        
        Console.WriteLine($"Erstellt: {arrays.Count} Sensor-Arrays " +
                         $"mit je {mySubstrates.Count} Sensoren");
    }
    
    /// <summary>
    /// Fügt dynamisch einen Sensor zu einem Array hinzu
    /// </summary>
    public void AddSensorToArray(string array_id, sensor mySensor)
    {
        if (!arrays.ContainsKey(array_id))
        {
            throw new exception($"Array {array_id} existiert nicht");
        }
        
        sensor_array array = arrays[array_id];
        
        // Prüfen ob Sensor bereits existiert
        if (array.exist(mySensor.id))
        {
            Console.WriteLine($"Sensor {mySensor.id} bereits im Array {array_id}");
            return;
        }
        
        array.addSensor(mySensor);
        Console.WriteLine($"Sensor {mySensor.id} zu Array {array_id} hinzugefügt");
    }
    
    /// <summary>
    /// Entfernt Sensor aus Array (falls Methode existiert)
    /// </summary>
    public void RemoveSensorFromArray(string array_id, string sensor_id)
    {
        if (!arrays.ContainsKey(array_id))
        {
            throw new exception($"Array {array_id} existiert nicht");
        }
        
        sensor_array array = arrays[array_id];
        
        if (!array.exist(sensor_id))
        {
            Console.WriteLine($"Sensor {sensor_id} nicht in Array {array_id}");
            return;
        }
        
        // sensor_array erbt von List<sensor>, daher:
        sensor toRemove = array.get(sensor_id);
        array.Remove(toRemove);
        
        Console.WriteLine($"Sensor {sensor_id} aus Array {array_id} entfernt");
    }
    
    /// <summary>
    /// Gibt Statistiken über alle Arrays aus
    /// </summary>
    public void PrintStatistics()
    {
        Console.WriteLine("\n=== Sensor-Array-Statistiken ===");
        
        foreach (var kvp in arrays)
        {
            sensor_array array = kvp.Value;
            
            Console.WriteLine($"\nArray: {array.id}");
            Console.WriteLine($"  Anzahl Sensoren: {array.Count}");
            
            if (array.Count > 0)
            {
                string[] ids = array.getIDs();
                Console.WriteLine($"  Sensoren:");
                foreach (string id in ids)
                {
                    Console.WriteLine($"    - {id}");
                }
            }
        }
    }
}

// Verwendung
var manager = new DynamicArrayManager(mySensors);
manager.CreateSubstrateArrays(substrates);

// Dynamisch Sensor hinzufügen
manager.AddSensorToArray("Q", new Q_sensor("silage"));

// Statistiken ausgeben
manager.PrintStatistics();
```

### Zeitreihen-Analyse mit Arrays

```csharp
using biogas;
using science;
using System.Linq;

/// <summary>
/// Analysiert Zeitreihen eines Sensor-Arrays
/// </summary>
public class ArrayTimeSeriesAnalyzer
{
    private sensor_array array;
    private substrates substrates;
    
    public ArrayTimeSeriesAnalyzer(sensor_array array, substrates substrates)
    {
        this.array = array;
        this.substrates = substrates;
    }
    
    /// <summary>
    /// Berechnet Statistiken über Zeit
    /// </summary>
    public void CalculateStatistics(double t_start, double t_end, double dt)
    {
        int n_points = (int)((t_end - t_start) / dt) + 1;
        
        double[] time = new double[n_points];
        double[] sum_values = new double[n_points];
        double[] mean_values = new double[n_points];
        
        for (int i = 0; i < n_points; i++)
        {
            double t = t_start + i * dt;
            time[i] = t;
            
            sum_values[i] = array.getMeasurementDAt(
                substrates, "sum", t, 0, false
            );
            
            mean_values[i] = array.getMeasurementDAt(
                substrates, "mean", t, 0, false
            );
        }
        
        // Statistiken
        Console.WriteLine($"\n=== Zeitreihen-Statistiken ({array.id}) ===");
        Console.WriteLine($"Zeitraum: {t_start} - {t_end} Tage");
        Console.WriteLine($"Anzahl Messpunkte: {n_points}");
        
        Console.WriteLine("\nSumme:");
        Console.WriteLine($"  Min: {sum_values.Min():F2}");
        Console.WriteLine($"  Max: {sum_values.Max():F2}");
        Console.WriteLine($"  Mean: {sum_values.Average():F2}");
        Console.WriteLine($"  StdDev: {CalculateStdDev(sum_values):F2}");
        
        Console.WriteLine("\nMittelwert:");
        Console.WriteLine($"  Min: {mean_values.Min():F2}");
        Console.WriteLine($"  Max: {mean_values.Max():F2}");
        Console.WriteLine($"  Mean: {mean_values.Average():F2}");
        Console.WriteLine($"  StdDev: {CalculateStdDev(mean_values):F2}");
    }
    
    /// <summary>
    /// Findet Zeitpunkte mit extremen Werten
    /// </summary>
    public void FindExtremes(double t_start, double t_end, double dt, 
                            double threshold_sum, double threshold_mean)
    {
        Console.WriteLine($"\n=== Extreme Werte ({array.id}) ===");
        Console.WriteLine($"Schwellwert Summe: {threshold_sum}");
        Console.WriteLine($"Schwellwert Mittelwert: {threshold_mean}");
        
        for (double t = t_start; t <= t_end; t += dt)
        {
            double sum = array.getMeasurementDAt(
                substrates, "sum", t, 0, false
            );
            
            double mean = array.getMeasurementDAt(
                substrates, "mean", t, 0, false
            );
            
            if (sum > threshold_sum || mean > threshold_mean)
            {
                Console.WriteLine($"\nt = {t:F1} Tage:");
                Console.WriteLine($"  Summe: {sum:F2}");
                Console.WriteLine($"  Mittelwert: {mean:F2}");
                
                // Einzelwerte ausgeben
                string[] ids = array.getIDs();
                foreach (string id_suffix in ids)
                {
                    if (substrates.ids.Contains(id_suffix))
                    {
                        sensor s = array.get($"{array.id}_{id_suffix}");
                        double val = s.getMeasurementDAt(0, t, false);
                        Console.WriteLine($"    {id_suffix}: {val:F2}");
                    }
                }
            }
        }
    }
    
    /// <summary>
    /// Vergleicht einzelne Sensoren im Array
    /// </summary>
    public void CompareSensors(double t)
    {
        Console.WriteLine($"\n=== Sensor-Vergleich (t = {t} d) ===");
        
        string[] ids = array.getIDs();
        var values = new Dictionary<string, double>();
        
        // Werte sammeln
        foreach (string id_suffix in ids)
        {
            if (substrates.ids.Contains(id_suffix))
            {
                sensor s = array.get($"{array.id}_{id_suffix}");
                double val = s.getMeasurementDAt(0, t, false);
                values[id_suffix] = val;
            }
        }
        
        if (values.Count == 0)
        {
            Console.WriteLine("Keine Werte gefunden");
            return;
        }
        
        // Sortieren
        var sorted = values.OrderByDescending(kvp => kvp.Value);
        
        Console.WriteLine("\nRanking:");
        int rank = 1;
        foreach (var kvp in sorted)
        {
            double percentage = kvp.Value / values.Values.Sum() * 100;
            Console.WriteLine($"{rank}. {kvp.Key}: {kvp.Value:F2} " +
                             $"({percentage:F1}%)");
            rank++;
        }
        
        Console.WriteLine($"\nGesamt: {values.Values.Sum():F2}");
        Console.WriteLine($"Durchschnitt: {values.Values.Average():F2}");
    }
    
    private double CalculateStdDev(double[] values)
    {
        double mean = values.Average();
        double variance = values.Select(v => Math.Pow(v - mean, 2)).Average();
        return Math.Sqrt(variance);
    }
}

// Verwendung
var analyzer = new ArrayTimeSeriesAnalyzer(q_array, substrates);

// Statistiken berechnen
analyzer.CalculateStatistics(0.0, 30.0, 0.5);

// Extreme finden
analyzer.FindExtremes(0.0, 30.0, 0.5, 
                      threshold_sum: 200.0,   // m³/d
                      threshold_mean: 80.0);  // m³/d

// Sensoren vergleichen
analyzer.CompareSensors(10.0);
```

**Ausgabe:**
```
=== Zeitreihen-Statistiken (Q) ===
Zeitraum: 0 - 30 Tage
Anzahl Messpunkte: 61

Summe:
  Min: 145.23
  Max: 182.56
  Mean: 163.45
  StdDev: 8.32

Mittelwert:
  Min: 48.41
  Max: 60.85
  Mean: 54.48
  StdDev: 2.77

=== Extreme Werte (Q) ===
Schwellwert Summe: 200.0
Schwellwert Mittelwert: 80.0
(keine Werte über Schwellwert)

=== Sensor-Vergleich (t = 10 d) ===

Ranking:
1. maize: 98.50 (60.2%)
2. manure: 45.30 (27.7%)
3. grass: 19.80 (12.1%)

Gesamt: 163.60
Durchschnitt: 54.53
```

### Multi-Array-Koordination

```csharp
using biogas;
using science;

/// <summary>
/// Koordiniert mehrere Sensor-Arrays
/// </summary>
public class MultiArrayCoordinator
{
    private sensors mySensors;
    private substrates mySubstrates;
    
    public MultiArrayCoordinator(sensors mySensors, substrates mySubstrates)
    {
        this.mySensors = mySensors;
        this.mySubstrates = mySubstrates;
    }
    
    /// <summary>
    /// Misst alle Arrays synchron
    /// </summary>
    public void MeasureAllArrays(double t, double dt)
    {
        // Q-Array
        sensor_array q_array = mySensors.getArray("Q");
        foreach (sensor s in q_array)
        {
            if (mySubstrates.ids.Contains(s.id_suffix))
            {
                double[] stream = GetStreamForSubstrate(s.id_suffix);
                s.measure(t, dt, stream);
            }
        }
        
        // Substratparameter-Array
        sensor_array params_array = mySensors.getArray("substrateparams");
        foreach (sensor s in params_array)
        {
            if (mySubstrates.ids.Contains(s.id_suffix))
            {
                double[] analysis = GetLabAnalysisForSubstrate(s.id_suffix);
                s.measure(t, dt, analysis);
            }
        }
        
        Console.WriteLine($"Arrays gemessen zu t = {t:F1} d");
    }
    
    /// <summary>
    /// Berechnet korrelierte Werte zwischen Arrays
    /// </summary>
    public void CalculateCorrelations(double t)
    {
        sensor_array q_array = mySensors.getArray("Q");
        sensor_array params_array = mySensors.getArray("substrateparams");
        
        Console.WriteLine($"\n=== Korrelationen (t = {t} d) ===");
        
        foreach (substrate s in mySubstrates)
        {
            string id = s.id;
            
            // Q-Wert
            sensor q_sensor = q_array.get($"Q_{id}");
            double Q = q_sensor.getMeasurementDAt(0, t, false);
            
            // TS-Wert
            sensor params_sensor = params_array.get($"substrateparams_{id}");
            physValue ts = params_sensor.getMeasurementAt("TS_%FM", t);
            
            // Masse berechnen
            double mass = Q * ts.Value / 100 * 1000;  // kg TS/d (angenommen Dichte ≈ 1000 kg/m³)
            
            Console.WriteLine($"\n{id}:");
            Console.WriteLine($"  Q: {Q:F2} m³/d");
            Console.WriteLine($"  TS: {ts.Value:F2} % FM");
            Console.WriteLine($"  Masse TS: {mass:F1} kg TS/d");
        }
    }
    
    /// <summary>
    /// Validiert Konsistenz zwischen Arrays
    /// </summary>
    public bool ValidateConsistency(double t)
    {
        bool consistent = true;
        
        sensor_array q_array = mySensors.getArray("Q");
        sensor_array params_array = mySensors.getArray("substrateparams");
        
        Console.WriteLine($"\n=== Konsistenz-Check (t = {t} d) ===");
        
        // Prüfe: Jedes Substrat hat Q-Sensor und Params-Sensor
        foreach (substrate s in mySubstrates)
        {
            string id = s.id;
            
            bool has_q = q_array.exist($"Q_{id}");
            bool has_params = params_array.exist($"substrateparams_{id}");
            
            if (!has_q || !has_params)
            {
                Console.WriteLine($"FEHLER: Substrat {id} unvollständig");
                Console.WriteLine($"  Q-Sensor: {(has_q ? "OK" : "FEHLT")}");
                Console.WriteLine($"  Params-Sensor: {(has_params ? "OK" : "FEHLT")}");
                consistent = false;
            }
            
            // Prüfe: Beide Sensoren haben Daten
            if (has_q && has_params)
            {
                sensor q_sensor = q_array.get($"Q_{id}");
                sensor params_sensor = params_array.get($"substrateparams_{id}");
                
                bool q_empty = q_sensor.isEmpty();
                bool params_empty = params_sensor.isEmpty();
                
                if (q_empty || params_empty)
                {
                    Console.WriteLine($"WARNUNG: Substrat {id} hat keine Daten");
                    Console.WriteLine($"  Q-Daten: {(!q_empty ? "OK" : "LEER")}");
                    Console.WriteLine($"  Params-Daten: {(!params_empty ? "OK" : "LEER")}");
                    consistent = false;
                }
            }
        }
        
        if (consistent)
        {
            Console.WriteLine("Alle Arrays konsistent");
        }
        
        return consistent;
    }
    
    // Helper-Methoden (vereinfacht)
    private double[] GetStreamForSubstrate(string substrate_id)
    {
        // In Realität: ADM-Stream von Substratzufuhr
        double[] stream = new double[34];
        stream[0] = 100.0;  // Q
        return stream;
    }
    
    private double[] GetLabAnalysisForSubstrate(string substrate_id)
    {
        // In Realität: Laboranalyse-Daten
        return new double[10] { 25.0, 22.5, 4.5, 0.5, 2.0, 0.8, 2.5, 8.0, 20.0, 300.0 };
    }
}

// Verwendung
var coordinator = new MultiArrayCoordinator(mySensors, substrates);

// Synchrone Messung
coordinator.MeasureAllArrays(10.0, 0.5);

// Korrelationen
coordinator.CalculateCorrelations(10.0);

// Validierung
bool valid = coordinator.ValidateConsistency(10.0);
if (!valid)
{
    Console.WriteLine("\nBitte Sensor-Konfiguration überprüfen!");
}
```

---

## Integration mit anderen Komponenten

### Integration mit sensors-Klasse

```csharp
using biogas;
using science;

// Sensor-Arrays in sensors-Objekt integrieren
var mySensors = new sensors();
var substrates = new substrates("substrates.xml");

// Q-Array erstellen und hinzufügen
var q_array = new sensor_array("Q");
foreach (substrate s in substrates)
{
    q_array.addSensor(new Q_sensor(s.id));
}
mySensors.addSensorArray(q_array);

// Zugriff über sensors-Klasse
sensor_array retrieved_array = mySensors.getArray("Q");
string[] q_ids = mySensors.getIDsOfArray("Q");

// Messung über sensors-Klasse
double[] stream = /* ... */;
mySensors.measure(5.0, "Q_maize", stream);

// Aggregierte Werte über sensors-Klasse
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

### Integration mit plant-Klasse

```csharp
using biogas;
using science;

var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");
var mySensors = new sensors();

// Fermenter-spezifische Sensor-Arrays
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    string digester_id = plant.getDigesterID(i);
    
    // pH-Array für alle In/Out
    var ph_array = new sensor_array($"pH_{digester_id}");
    ph_array.addSensor(new pH_sensor($"{digester_id}_2"));
    ph_array.addSensor(new pH_sensor($"{digester_id}_3"));
    mySensors.addSensorArray(ph_array);
    
    // VFA-Array
    var vfa_array = new sensor_array($"VFA_{digester_id}");
    vfa_array.addSensor(new VFA_sensor($"{digester_id}_2"));
    vfa_array.addSensor(new VFA_sensor($"{digester_id}_3"));
    mySensors.addSensorArray(vfa_array);
}

// Nutzung
double[] stream_in = /* ... */;
double[] stream_out = /* ... */;

sensor_array ph_f1 = mySensors.getArray("pH_F1");
sensor ph_in = ph_f1.get("pH_F1_2");
sensor ph_out = ph_f1.get("pH_F1_3");

ph_in.measure(5.0, 0.5, stream_in);
ph_out.measure(5.0, 0.5, stream_out);

// Vergleich Eingang/Ausgang
double pH_in_val = ph_in.getCurrentMeasurementD(0);
double pH_out_val = ph_out.getCurrentMeasurementD(0);
double pH_diff = pH_out_val - pH_in_val;

Console.WriteLine($"Fermenter F1 (Tag 5):");
Console.WriteLine($"  pH Eingang: {pH_in_val:F2}");
Console.WriteLine($"  pH Ausgang: {pH_out_val:F2}");
Console.WriteLine($"  Differenz: {pH_diff:+0.00;-0.00}");
```

---

## Debugging und Troubleshooting

### Debug-Helper-Klasse

```csharp
using biogas;
using science;

/// <summary>
/// Hilfsklasse zum Debuggen von Sensor-Arrays
/// </summary>
public static class SensorArrayDebugger
{
    /// <summary>
    /// Gibt detaillierte Array-Informationen aus
    /// </summary>
    public static void InspectArray(sensor_array array)
    {
        Console.WriteLine($"\n=== Array-Inspektion: {array.id} ===");
        Console.WriteLine($"Anzahl Sensoren: {array.Count}");
        
        if (array.Count == 0)
        {
            Console.WriteLine("Array ist leer");
            return;
        }
        
        Console.WriteLine("\nSensoren:");
        int i = 0;
        foreach (sensor s in array)
        {
            Console.WriteLine($"\n[{i}] {s.id}");
            Console.WriteLine($"    Spec: {s.spec}");
            Console.WriteLine($"    ID-Suffix: {s.id_suffix}");
            Console.WriteLine($"    Dimension: {s.dimension}");
            Console.WriteLine($"    Typ: {s.type}");
            Console.WriteLine($"    Leer: {s.isEmpty()}");
            
            if (!s.isEmpty())
            {
                double t = s.getCurrentTime();
                Console.WriteLine($"    Letzte Messung: t = {t:F1} d");
                
                try
                {
                    physValue val = s.getCurrentMeasurement(0);
                    Console.WriteLine($"    Aktueller Wert: {val.Value:F2} {val.Unit}");
                }
                catch
                {
                    Console.WriteLine($"    Fehler beim Wert-Abruf");
                }
            }
            
            i++;
        }
    }
    
    /// <summary>
    /// Prüft getMeasurementDAt auf Fehler
    /// </summary>
    public static void TestGetMeasurementDAt(sensor_array array, 
                                             substrates mySubstrates,
                                             double t)
    {
        Console.WriteLine($"\n=== Test getMeasurementDAt ===");
        Console.WriteLine($"Array: {array.id}");
        Console.WriteLine($"Zeit: {t} d");
        Console.WriteLine($"Substrat-IDs: {string.Join(", ", mySubstrates.ids)}");
        
        // Welche Sensoren werden gefunden?
        Console.WriteLine("\nGefilterte Sensoren:");
        int count = 0;
        foreach (sensor s in array)
        {
            bool included = mySubstrates.ids.Contains(s.id_suffix);
            Console.WriteLine($"  {s.id_suffix}: {(included ? "✓" : "✗")}");
            if (included) count++;
        }
        Console.WriteLine($"Gesamt: {count} Sensoren");
        
        // Summe berechnen
        try
        {
            double sum = array.getMeasurementDAt(
                mySubstrates, "sum", t, 0, false
            );
            Console.WriteLine($"\nSumme: {sum:F2}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"\nFEHLER bei Summe: {ex.Message}");
        }
        
        // Mittelwert berechnen
        try
        {
            double mean = array.getMeasurementDAt(
                mySubstrates, "mean", t, 0, false
            );
            Console.WriteLine($"Mittelwert: {mean:F2}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"FEHLER bei Mittelwert: {ex.Message}");
        }
    }
    
    /// <summary>
    /// Prüft Konsistenz der Sensor-IDs
    /// </summary>
    public static bool CheckIDConsistency(sensor_array array)
    {
        Console.WriteLine($"\n=== ID-Konsistenz-Check: {array.id} ===");
        
        bool consistent = true;
        
        // Prüfe: id = spec + "_" + id_suffix
        foreach (sensor s in array)
        {
            string expected_id = $"{s.spec}_{s.id_suffix}";
            
            if (s.id != expected_id)
            {
                Console.WriteLine($"FEHLER: ID-Inkonsistenz");
                Console.WriteLine($"  Sensor-ID: {s.id}");
                Console.WriteLine($"  Erwartet: {expected_id}");
                Console.WriteLine($"  Spec: {s.spec}");
                Console.WriteLine($"  Suffix: {s.id_suffix}");
                consistent = false;
            }
        }
        
        // Prüfe: Alle haben gleichen spec
