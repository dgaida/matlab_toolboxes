# Transportation Package API Documentation

## Übersicht

Das `biogas.transportation` Namespace enthält Klassen zur Modellierung von Transport- und Fördersystemen in Biogasanlagen. Dies umfasst Pumpen für Gärreste und Substrate-Transportsysteme für feste und flüssige Substrate.

Die Dokumentation zu den einzelnen Klassen (`pump`, `pumps`, `substrate_transport`, `substrate_transports`) finden Sie bereits in der separaten Datei `docs/biogas_csharp/api_documentation/plant/digesters_api.md` im Abschnitt "Transportation".

---

## Klasse: `transportation`

Hauptklasse zur Verwaltung aller Transportsysteme einer Biogasanlage (partial class).

### Konstruktoren

#### `transportation()`

Erstellt leeres Transportation-Objekt.

#### `transportation(ref XmlTextReader reader)`

Liest alle Transportsysteme aus XML.

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader

#### `transportation(string XMLfile)`

Liest alle Transportsysteme aus XML-Datei.

**Parameter:**
- `XMLfile` (string): Pfad zur XML-Datei

### Eigenschaften

#### Private Felder

```csharp
// Pumpen für Gärrestförderung
private pumps myPumps

// Substrate-Transportsysteme für Substratförderung
private substrate_transports mySubstrateTransports
```

---

## Pumpen-Verwaltung (`transportation_pump.cs`)

Methoden zur Verwaltung von Pumpen für Gärrestförderung zwischen Fermentern und zum Endlager.

### Pumpen hinzufügen/entfernen

#### `addPump(pump myPump)`

Fügt Pumpe zur Liste hinzu.

**Parameter:**
- `myPump` (pump): Pumpen-Objekt

#### `deletePump(string id)` / `deletePump(int index)`

Löscht Pumpe aus Liste.

**Parameter:**
- `id` (string): Pumpen-ID
- `index` (int): Pumpen-Index (1-basiert)

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

### Pumpen-Zugriff

#### `containsPump(string pump_id)`

Prüft ob Pumpe mit gegebener ID existiert.

**Rückgabe:**
- `bool`: true wenn vorhanden

#### `getNumPumps()` / `getNumPumpsD()`

Gibt Anzahl der Pumpen zurück.

**Rückgabe:**
- `int` / `double`: Anzahl der Pumpen

#### `getPumpID(int index)`

Gibt Pumpen-ID zurück (index 1-basiert).

**Rückgabe:**
- `string`: Pumpen-ID

**Ausnahmen:**
- `exception`: Ungültiger Index

#### `getPumpIndex(string id)`

Gibt Index der Pumpe zurück (1-basiert).

**Rückgabe:**
- `int`: Pumpen-Index

**Ausnahmen:**
- `exception`: Unbekannte ID

#### `getPumpByID(string id)` / `getPump(int index)`

Holt Pumpen-Objekt.

**Rückgabe:**
- `pump`: Pumpen-Objekt

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

#### `getPumpByID(string id, out int index)`

Holt Pumpe und Index.

**Parameter:**
- `id` (string): Pumpen-ID
- `index` (out int): 1-basierter Index

**Rückgabe:**
- `pump`: Pumpen-Objekt

**Obsolet (aber verfügbar):**
```csharp
[Obsolete("Use getPumpIndex(string) instead!")]
public int getPumpIndexByID(string id)
```

### Pumpen-Parameter

#### `getPumpParam(int index, string param)` / `getPumpParam(string id, string param)`

Holt physValue-Parameter als double.

**Parameter:**
- `index`/`id`: Pumpen-Identifikation
- `param` (string): Parameter-Name

**Rückgabe:**
- `double`: Parameter-Wert

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID
- `exception`: Unbekannter Parameter
- `exception`: Konvertierung nicht möglich

#### `getPumpParamD(string id, string param)`

Holt double-Parameter.

#### `setPumpParam(int index, string symbol, physValue value)` / `setPumpParam(int index, string symbol, double value)`

Setzt Parameter (index 1-basiert).

**Ausnahmen:**
- `exception`: Ungültiger Index
- `exception`: Unbekannter Parameter

#### `setPumpParam(string id, string symbol, string value)` / `setPumpParam(string id, string symbol, physValue value)` / `setPumpParam(string id, string symbol, double value)`

Setzt Parameter per ID.

**Ausnahmen:**
- `exception`: Unbekannte ID
- `exception`: Unbekannter Parameter

---

## Substrat-Transport-Verwaltung (`transportation_substrate_transport.cs`)

Methoden zur Verwaltung von Substrat-Transportsystemen.

### Substrate-Transporte hinzufügen/entfernen

#### `addSubstrateTransport(substrate_transport mySubstrateTransport)`

Fügt Substrat-Transport zur Liste hinzu.

**Parameter:**
- `mySubstrateTransport` (substrate_transport): Substrat-Transport-Objekt

#### `deleteSubstrateTransport(string id)` / `deleteSubstrateTransport(int index)`

Löscht Substrat-Transport aus Liste.

**Parameter:**
- `id` (string): Substrat-Transport-ID
- `index` (int): Index (1-basiert)

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

### Substrat-Transport-Zugriff

#### `containsSubstrateTransport(string substrate_transport_id)`

Prüft ob Substrat-Transport existiert.

**Rückgabe:**
- `bool`: true wenn vorhanden

#### `getNumSubstrateTransports()` / `getNumSubstrateTransportsD()`

Gibt Anzahl der Substrat-Transporte zurück.

#### `getSubstrateTransportID(int index)`

Gibt Substrat-Transport-ID zurück (index 1-basiert).

**Rückgabe:**
- `string`: Substrat-Transport-ID

**Ausnahmen:**
- `exception`: Ungültiger Index

#### `getSubstrateTransportIndex(string id)`

Gibt Index des Substrat-Transports zurück.

**Rückgabe:**
- `int`: Index (1-basiert)

**Ausnahmen:**
- `exception`: Unbekannte ID

#### `getSubstrateTransportByID(string id)` / `getSubstrateTransport(int index)`

Holt Substrat-Transport-Objekt.

**Rückgabe:**
- `substrate_transport`: Substrat-Transport-Objekt

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

#### `getSubstrateTransportByID(string id, out int index)`

Holt Substrat-Transport und Index.

**Obsolet (aber verfügbar):**
```csharp
[Obsolete("Use getSubstrateTransportIndex(string) instead!")]
public int getSubstrateTransportIndexByID(string id)
```

### Substrat-Transport-Parameter

#### `getSubstrateTransportParam(int index, string param)` / `getSubstrateTransportParam(string id, string param)`

Holt physValue-Parameter als double.

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID
- `exception`: Unbekannter Parameter
- `exception`: Konvertierung nicht möglich

#### `getSubstrateTransportParamD(string id, string param)`

Holt double-Parameter.

#### `setSubstrateTransportParam(int index, string symbol, physValue value)` / `setSubstrateTransportParam(int index, string symbol, double value)`

Setzt Parameter (index 1-basiert).

#### `setSubstrateTransportParam(string id, string symbol, string value)` / `setSubstrateTransportParam(string id, string symbol, physValue value)` / `setSubstrateTransportParam(string id, string symbol, double value)`

Setzt Parameter per ID.

---

## Datenmanagement (`transportation.cs`)

### XML-Persistenz

#### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest alle Transportsysteme aus XML.

**XML-Struktur:**
```xml
<transportation>
    <pumps>
        <pump id="fermenter1_fermenter2">...</pump>
        <pump id="fermenter2_storagetank">...</pump>
    </pumps>
    <substrate_transports>
        <substrate_transport>...</substrate_transport>
    </substrate_transports>
</transportation>
```

#### `getParamsAsXMLString()`

Gibt alle Transportsysteme als XML-String zurück.

**Rückgabe:**
- `string`: XML-formatierter String

#### `print()`

Gibt alle Transportsysteme formatiert aus.

**Rückgabe:**
- `string`: Formatierter String mit allen Pumpen und Substrat-Transporten

---

## Anwendungsbeispiele

### Transportation-Objekt erstellen und verwalten

```csharp
using biogas;

// Neues Transportation-Objekt
var transportation = new transportation();

// Pumpe für Gärrest-Transfer hinzufügen
var pump1 = new pump("fermenter1", "fermenter2");
pump1.set_params_of(
    "h_lift", 2.0,        // 2m Höhenunterschied
    "d_horizontal", 15.0, // 15m horizontale Distanz
    "eta", 0.75,          // 75% Wirkungsgrad
    "d_pipe", 0.15,       // 150mm Rohr
    "k_pipe", 0.1         // 0.1mm Rauheit
);
transportation.addPump(pump1);

// Pumpe zum Endlager
var pump2 = new pump("fermenter2", "storagetank");
pump2.set_params_of(
    "h_lift", 1.5,
    "d_horizontal", 20.0,
    "eta", 0.75
);
transportation.addPump(pump2);

// Substrat-Transport für Fermenter 1
var subTransport = new substrate_transport("substratemix", "fermenter1");
subTransport.set_params_of(
    "name_solids", "Schubboden mit Eindrückschnecke",
    "energy_per_ton", 0.92,  // kWh/t
    "h_lift", 1.0,
    "eta", 0.70
);
transportation.addSubstrateTransport(subTransport);

Console.WriteLine(transportation.print());
```

### Aus XML laden

```csharp
// Aus Datei laden
var transportation = new transportation("transportation_config.xml");

Console.WriteLine($"Anzahl Pumpen: {transportation.getNumPumps()}");
Console.WriteLine($"Anzahl Substrat-Transporte: {transportation.getNumSubstrateTransports()}");

// Iteration über alle Pumpen
for (int i = 1; i <= transportation.getNumPumps(); i++)
{
    string id = transportation.getPumpID(i);
    double h_lift = transportation.getPumpParam(i, "h_lift");
    
    Console.WriteLine($"Pumpe {id}: Hubhöhe {h_lift} m");
}
```

### Parameter ändern

```csharp
var transportation = new transportation("config.xml");

// Pumpen-Parameter ändern
transportation.setPumpParam(1, "eta", 0.80);
transportation.setPumpParam("fermenter1_fermenter2", "h_lift", 2.5);

// Substrat-Transport-Parameter ändern
transportation.setSubstrateTransportParam(1, "energy_per_ton", 0.85);

// Speichern
string xml = transportation.getParamsAsXMLString();
System.IO.File.WriteAllText("transportation_updated.xml", xml);
```

### Energieverbrauch berechnen

```csharp
using biogas;
using science;

var transportation = new transportation("config.xml");
var plant = new biogas.plant("plant.xml");
var sensors = new biogas.sensors();

// Pumpe betreiben
double t = 1.0;  // Tag 1
double u = 100.0;  // m³/d Gärrest
double Q_pump;

string pump_id = "fermenter1_fermenter2";
double P_pump = pump.run(
    t, sensors, u, 
    "fermenter1", "fermenter2",
    plant, out Q_pump
);

Console.WriteLine($"Pumpe {pump_id}:");
Console.WriteLine($"  Durchsatz: {Q_pump:F1} m³/d");
Console.WriteLine($"  Energieverbrauch: {P_pump:F2} kWh/d");

// Substrat-Transport betreiben
var substrates = new biogas.substrates("substrates.xml");
double[,] substrate_network = /* ... */;

double P_substrate = substrate_transport.run(
    t, sensors,
    "substratemix", "fermenter1",
    plant, substrates, substrate_network
);

Console.WriteLine($"\nSubstrat-Transport:");
Console.WriteLine($"  Energieverbrauch: {P_substrate:F2} kWh/d");
```

### Energieverbrauch für alle Transportsysteme

```csharp
using biogas;

var transportation = new transportation("config.xml");
var plant = new biogas.plant("plant.xml");
var sensors = new biogas.sensors();
var substrates = new biogas.substrates("substrates.xml");

double t = 1.0;
double total_energy = 0;

// Alle Pumpen
for (int i = 1; i <= transportation.getNumPumps(); i++)
{
    var pump = transportation.getPump(i);
    
    // Durchsatz aus Sensoren holen
    double Q;
    sensors.getMeasurementAt("Q", "Q_" + pump.id, t, out Q);
    
    double Q_pump;
    double P = biogas.pump.run(
        t, sensors, Q,
        pump.unit_start, pump.unit_destiny,
        plant, out Q_pump
    );
    
    total_energy += P;
    Console.WriteLine($"{pump.id}: {P:F2} kWh/d");
}

// Alle Substrat-Transporte
for (int i = 1; i <= transportation.getNumSubstrateTransports(); i++)
{
    var transport = transportation.getSubstrateTransport(i);
    
    double[,] substrate_network = /* ... */;
    
    double P = substrate_transport.run(
        t, sensors,
        transport.unit_start, transport.unit_destiny,
        plant, substrates, substrate_network
    );
    
    total_energy += P;
    Console.WriteLine($"{transport.id}: {P:F2} kWh/d");
}

Console.WriteLine($"\nGesamt-Energieverbrauch: {total_energy:F2} kWh/d");
```

### Transport-Netzwerk visualisieren

```csharp
using biogas;

var transportation = new transportation("config.xml");

Console.WriteLine("=== Transport-Netzwerk ===\n");

// Pumpen
Console.WriteLine("Gärrest-Pumpen:");
for (int i = 1; i <= transportation.getNumPumps(); i++)
{
    var pump = transportation.getPump(i);
    Console.WriteLine($"  {pump.unit_start} → {pump.unit_destiny}");
    Console.WriteLine($"    Hubhöhe: {pump.h_lift.Value} m");
    Console.WriteLine($"    Distanz: {pump.d_horizontal.Value} m");
    Console.WriteLine($"    η: {pump.eta:P0}");
}

// Substrat-Transporte
Console.WriteLine("\nSubstrat-Transporte:");
for (int i = 1; i <= transportation.getNumSubstrateTransports(); i++)
{
    var transport = transportation.getSubstrateTransport(i);
    Console.WriteLine($"  {transport.unit_start} → {transport.unit_destiny}");
    Console.WriteLine($"    Feststoffsystem: {transport.name_solids}");
    Console.WriteLine($"    Energiebedarf: {transport.energy_per_ton} kWh/t");
}
```

### Transport-Optimierung

```csharp
using biogas;

var transportation = new transportation("config.xml");

// Ziel: Energieverbrauch minimieren durch Optimierung der Rohrparameter

double bestEnergy = double.MaxValue;
double bestDiameter = 0;

// Verschiedene Rohrdurchmesser testen
double[] diameters = {0.10, 0.15, 0.20, 0.25};  // m

foreach (double d in diameters)
{
    // Parameter temporär ändern
    transportation.setPumpParam(1, "d_pipe", d);
    
    // Energieverbrauch berechnen
    double Q = 100.0;  // m³/d
    var plant = new biogas.plant("plant.xml");
    var sensors = new biogas.sensors();
    
    double Q_pump;
    double P = biogas.pump.run(
        1.0, sensors, Q,
        "fermenter1", "fermenter2",
        plant, out Q_pump
    );
    
    Console.WriteLine($"Durchmesser {d * 1000}mm: {P:F2} kWh/d");
    
    if (P < bestEnergy)
    {
        bestEnergy = P;
        bestDiameter = d;
    }
}

Console.WriteLine($"\nOptimaler Durchmesser: {bestDiameter * 1000}mm");
Console.WriteLine($"Energieverbrauch: {bestEnergy:F2} kWh/d");

// Optimalen Wert setzen
transportation.setPumpParam(1, "d_pipe", bestDiameter);
```

---

## Typische Anwendungsfälle

### 1. Gärrest-Transfer zwischen Fermentern

```
Fermenter 1 (Hauptfermenter)
     │
     │ Pumpe P1
     ↓
Fermenter 2 (Nachfermenter)
```

**Pumpe P1:**
- `unit_start`: "fermenter1"
- `unit_destiny`: "fermenter2"
- Typ: Exzenterschneckenpumpe
- η: 0.70 - 0.80

### 2. Gärrest zum Endlager

```
Fermenter 2 (Nachfermenter)
     │
     │ Pumpe P2
     ↓
Endlager (Lagune)
```

**Pumpe P2:**
- `unit_start`: "fermenter2"
- `unit_destiny`: "storagetank"
- Typ: Kreiselpumpe
- η: 0.75 - 0.85

### 3. Substrat-Zufuhr

```
Substratemix (Misch-Vorgrube)
     │
     │ Substrat-Transport S1
     ↓
Fermenter 1
```

**Substrat-Transport S1:**
- `unit_start`: "substratemix"
- `unit_destiny`: "fermenter1"
- Flüssig (TS < 11%): Pumpe
- Fest (TS ≥ 11%): Feststoffsystem (z.B. Schubboden)

---

## Energiebedarfs-Richtwerte

### Pumpen (flüssige Medien)

| Anwendung | Spez. Energiebedarf | Typischer η |
|-----------|---------------------|-------------|
| Gärrest-Transfer | 0.5 - 2 kWh/(m³·100m) | 0.70 - 0.85 |
| Substrat (dünnflüssig) | 0.3 - 1 kWh/(m³·100m) | 0.75 - 0.85 |
| Rezirkulation | 0.2 - 0.8 kWh/(m³·100m) | 0.80 - 0.90 |

### Feststoff-Transportsysteme

| System | Energiebedarf [kWh/t] |
|--------|----------------------|
| Schubboden | 0.38 |
| Schubboden + Eindrückschnecke | 0.92 |
| Vertikalmischer | 1.10 |
| Trichterzulauf + Dosierschnecke | 0.74 |
| Einpresssysteme | 1.07 - 3.30 |

---

## Best Practices

### 1. Pumpen-Auslegung

```csharp
// GUT: Ausreichend dimensionieren
var pump = new pump("F1", "F2");
pump.set_params_of(
    "d_pipe", 0.15,      // Ausreichender Durchmesser
    "eta", 0.75,         // Realistischer Wirkungsgrad
    "h_lift", 2.5        // Inkl. Sicherheitszuschlag
);

// VERMEIDEN: Unterdimensionierung
// d_pipe zu klein → hoher Druckverlust → hoher Energieverbrauch
```

### 2. Substrat-Klassifizierung

```csharp
// GUT: TS-Gehalt beachten
double TS = substrate.get_param_of("TS");

if (TS < 11)
{
    // Pumpbar → Pumpe nutzen
    var pump = new pump("substratemix", "fermenter1");
}
else
{
    // Fest → Feststoffsystem nutzen
    var transport = new substrate_transport("substratemix", "fermenter1");
    transport.set_params_of("name_solids", "Schubboden");
}
```

### 3. ID-Konvention

```csharp
// GUT: Konsistente ID-Bildung
string pump_id = pump.getid("fermenter1", "fermenter2");
// → "fermenter1_fermenter2"

var myPump = new pump("fermenter1", "fermenter2");
// myPump.id == "fermenter1_fermenter2"

// Zugriff später einfach:
transportation.getPumpByID("fermenter1_fermenter2");
```

### 4. Energieeffizienz überwachen

```csharp
// GUT: Regelmäßig Energieverbrauch tracken
double P_total = 0;

for (int i = 1; i <= transportation.getNumPumps(); i++)
{
    double P_pump = /* berechnet */;
    P_total += P_pump;
    
    // Warnschwelle
    if (P_pump > 100)  // kWh/d
    {
        string id = transportation.getPumpID(i);
        Console.WriteLine($"Warnung: Hoher Energieverbrauch bei {id}");
    }
}

Console.WriteLine($"Gesamt-Pumpenergie: {P_total:F1} kWh/d");
```

### 5. Wartung und Überwachung

```csharp
// GUT: Wirkungsgrad-Überwachung
double eta_nominal = 0.75;
double eta_actual = /* gemessen */;

if (eta_actual < 0.9 * eta_nominal)
{
    Console.WriteLine("Warnung: Pumpen-Wirkungsgrad gesunken!");
    Console.WriteLine("→ Wartung erforderlich");
}
```

---

## TODOs

Laut Quellcode:

### transportation.cs
- Weitere Transportsysteme könnten hinzugefügt werden (z.B. Förderbänder, Schneckenförderer)

### pump.cs
- Parameter sollten substratabhängig gemacht werden (K, nflow, alpha_T)
- Die Modellierung könnte noch verbessert werden für verschiedene Substrate

### substrate_transport.cs
- Bessere Modellierung der Aufteilung fest/flüssig basierend auf TS-Gehalt
- Mehr Feststoffsysteme könnten modelliert werden

---

## Siehe auch

- **biogas.pump**: Pumpen-Klasse (siehe digesters_api.md)
- **biogas.substrate_transport**: Substrat-Transport-Klasse (siehe digesters_api.md)
- **biogas.plant**: Plant-Integration mit transportation
- **biogas.digesters**: Fermenter als Quelle/Ziel
- **biogas.substrates**: TS-Gehalt für Transport-Auswahl

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*
