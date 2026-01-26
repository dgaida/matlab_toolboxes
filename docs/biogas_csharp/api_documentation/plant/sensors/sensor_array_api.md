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
var params_array = new sensor_array("