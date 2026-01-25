# Plant Package API Documentation

## Übersicht

Das `biogas.plant` Namespace enthält die Hauptklasse zur Modellierung einer kompletten Biogasanlage. Die `plant`-Klasse integriert alle Komponenten (Fermenter, BHKWs, Pumpen, Substrate) und stellt zentrale Methoden zur Verwaltung und Simulation bereit.

---

## Klasse: `plant`

Definiert die gesamte Biogasanlage. Sie enthält Fermenter, BHKWs, Pumpen/Transport-Einheiten und Finanzinformationen.

### Konstruktoren

#### `plant()`

Erstellt eine leere Anlage mit initialisierten physValue-Objekten (Standardwerte).

#### `plant(string XMLfile)`

Liest die gesamte Anlage aus einer XML-Datei.

**Parameter:**
- `XMLfile` (string): Pfad zur XML-Datei

**Gelesene Komponenten:**
- Plant-Basisparameter (id, name, Tout, g, construct_year)
- Digesters (Liste von Fermentern)
- CHPs (Liste von BHKWs)
- Transportation (Pumpen und Substrat-Transporte)
- Finances (Finanzparameter)

---

### Eigenschaften

#### Identifikation

```csharp
public string id              // Eindeutige ID der Anlage (read-only)
public string name            // Name der Anlage (read-only)
```

#### Physikalische Parameter

```csharp
public physValue g            // Erdbeschleunigung [m/s²]
                              // Standard: 9.81 m/s²
public physValue Tout         // Umgebungstemperatur [°C]
                              // Standard: 10 °C
```

#### Wirtschaftlich

```csharp
public int construct_year     // Baujahr der Anlage (z.B. 2009, 2012)
                              // Wichtig für EEG-Vergütung
```

#### Komponenten

```csharp
public digesters myDigesters           // Liste der Fermenter
public chps myCHPs                     // Liste der BHKWs
public transportation myTransportation // Pumpen und Transporte
public finances myFinances             // Finanzparameter
```

---

### Methoden

#### Datenmanagement

##### `print()`

Gibt die gesamte Anlage formatiert aus.

**Rückgabe:**
- `string`: Formatierter String mit allen Komponenten

**Beispielausgabe:**
```
   ----------   PLANT:   Biogasanlage Musterhausen   ----------   
id: plant_001
construction year: 2012
g: 9.81 m/s²			Tout: 10.0 °C
   ----------   DIGESTER:   Hauptfermenter   ----------   
...
   ----------   CHP:   BHKW 1   ----------   
...
   ----------   TRANSPORTATION   ----------   
...
   ----------   FINANCES   ----------   
...
   ----------     END PLANT     ----------   
```

##### `saveAsXML(string XMLfile)`

Speichert die gesamte Anlage in eine XML-Datei.

**Parameter:**
- `XMLfile` (string): Ziel-Dateipfad

**XML-Struktur:**
```xml
<?xml version="1.0" encoding="utf-8"?>
<plant id="plant_001">
    <name>Biogasanlage Musterhausen</name>
    <construct_year>2012</construct_year>
    <physValue symbol="g">...</physValue>
    <physValue symbol="Tout">...</physValue>
    <digesters>...</digesters>
    <chps>...</chps>
    <transportation>...</transportation>
    <finances>...</finances>
</plant>
```

##### `set_params_of(params object[] symbols)`

Setzt Parameter der Anlage.

**Syntax:**
```csharp
plant.set_params_of(
    "name", "Meine Anlage",
    "Tout", 12.0,
    "construct_year", 2012
);
```

**Ausnahmen:**
- `exception`: Unbekannter Parameter

##### `get_params_of(out object[] variables, params string[] symbols)`

Holt Parameter als Objekte.

**Ausnahmen:**
- `exception`: Unbekannter Parameter
- `exception`: Keine Eingabe

---

### Fermenter-Verwaltung

#### Fermenter hinzufügen/entfernen

##### `addDigester(digester myDigester)`

Fügt einen Fermenter zur Anlage hinzu.

**Parameter:**
- `myDigester` (digester): Fermenter-Objekt

**Seiteneffekt:** Erstellt automatisch einen `substrate_transport` für den Fermenter.

##### `deleteDigester(int index)`

Löscht Fermenter (index ist 1-basiert).

**Parameter:**
- `index` (int): Fermenter-Index (1-basiert)

**Seiteneffekt:** Löscht auch den zugehörigen `substrate_transport`.

**Ausnahmen:**
- `exception`: Ungültiger Index

#### Fermenter-Zugriff

##### `getDigester(int index)` / `getDigesterByID(string id)`

Holt Fermenter-Objekt.

**Rückgabe:**
- `digester`: Fermenter-Objekt

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID

##### `getDigesterByName(string name, out string id, out int index, out digester myDigester)`

Sucht Fermenter nach Name.

**Parameter:**
- `name` (string): Fermenter-Name
- `id` (out string): Fermenter-ID
- `index` (out int): 1-basierter Index
- `myDigester` (out digester): Fermenter-Objekt

**Ausnahmen:**
- `exception`: Unbekannter Name

##### Überladungen

```csharp
public void getDigesterByName(string name, out int index)
public void getDigesterByName(string name, out string id, out int index)
```

##### `getDigesterID(int index)` / `getDigesterIndex(string id)`

Konvertiert zwischen Index und ID.

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID

##### `getDigesterName(string id)` / `getDigesterName(int index)`

Holt Fermenter-Name.

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID/Konvertierung fehlgeschlagen

##### `getNumDigesters()` / `getNumDigestersD()`

Gibt Anzahl der Fermenter zurück.

**Rückgabe:**
- `int` / `double`: Anzahl der Fermenter

##### `containsDigester(string digester_id)`

Prüft ob Fermenter-ID existiert.

**Rückgabe:**
- `bool`: true wenn vorhanden

#### Fermenter-Parameter

##### `getDigesterParam(int index, string param)` / `getDigesterParam(string id, string param)`

Holt physValue-Parameter als double.

**Beispiel:**
```csharp
double Vliq = plant.getDigesterParam(1, "Vliq");
double T = plant.getDigesterParam("F1", "T");
```

##### `getDigesterParamD(int index, string param)` / `getDigesterParamD(string id, string param)`

Holt double-Parameter.

##### `setDigesterParam(int index, string symbol, physValue value)`

Setzt physValue-Parameter.

##### `setDigesterParam(int index, string symbol, double value)`

Setzt double-Parameter.

##### `setDigesterParam(string id, string symbol, ...)`

Überladungen für ID-basierte Parametersetzer.

#### ADM-Parameter

##### `getDefaultADMparams(string id)` / `getDefaultADMparams(int index)`

Holt Standard-ADM-Parameter.

**Rückgabe:**
- `double[]`: ADM-Parametervektor

**Hinweis:** Wenn `getADMparams()` zuvor aufgerufen wurde, werden die zuletzt aktualisierten Parameter zurückgegeben.

##### `getADMparameter(string id, int pos, out double value)` / `getADMparameter(int index, int pos, out double value)`

Holt einzelnen ADM-Parameter an Position.

**Parameter:**
- `id`/`index`: Fermenter-Identifikation
- `pos` (int): Parameter-Position (1-basiert)
- `value` (out double): Parameterwert

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID/Ungültige Position

##### `setADMparameter(string id, int pos, double value)` / `setADMparameter(int index, int pos, double value)`

Setzt einzelnen ADM-Parameter.

##### `setDefaultADMparams(string id, double[] ADM1params)` / `setDefaultADMparams(int index, double[] ADM1params)`

Setzt gesamten ADM-Parametervektor.

**Ausnahmen:**
- `exception`: Vektor hat nicht die korrekte Dimension

##### `getDigester_gui_handle(int index)` / `getDigester_gui_handle(string name)`

Holt MATLAB GUI-Handle (für MATLAB-Integration).

##### `setDigester_gui_handle(int index, double gui_handle)` / `setDigester_gui_handle(string name, double gui_handle)`

Setzt MATLAB GUI-Handle.

---

### BHKW-Verwaltung

#### BHKW hinzufügen/entfernen

##### `addCHP(chp myCHP)`

Fügt BHKW zur Anlage hinzu.

##### `deleteCHP(int index)`

Löscht BHKW (index ist 1-basiert).

**Ausnahmen:**
- `exception`: Ungültiger Index

#### BHKW-Zugriff

##### `getCHP(int index)` / `getCHPByID(string id)`

Holt BHKW-Objekt.

**Rückgabe:**
- `chp`: BHKW-Objekt

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID

##### `getCHPID(int index)` / `getCHPIndex(string id)`

Konvertiert zwischen Index und ID.

##### `getCHPName(string id)` / `getCHPName(int index)`

Holt BHKW-Name.

##### `getNumCHPs()` / `getNumCHPsD()`

Gibt Anzahl der BHKWs zurück.

##### `containsCHP(string chp_id)`

Prüft ob BHKW-ID existiert.

#### BHKW-Parameter

##### `getCHPParam(int index, string param)` / `getCHPParam(string id, string param)`

Holt physValue-Parameter als double.

##### `getCHPParamD(string id, string param)`

Holt double-Parameter.

##### `setCHPParam(int index, string symbol, physValue value)`

Setzt physValue-Parameter.

##### `setCHPParam(int index, string symbol, double value)`

Setzt double-Parameter.

##### `setCHPParam(string id, string symbol, ...)`

Überladungen für ID-basierte Parametersetzer.

#### BHKW-Berechnungen

##### `burnBiogas(string chp_id, double[] u, out physValue P_el_kWh_d, out physValue P_therm_kWh_d)`

Verbrennt Biogas in spezifischem BHKW.

**Parameter:**
- `chp_id` (string): BHKW-ID
- `u` (double[]): Biogasstrom [m³/d] (H2, CH4, CO2)
- `P_el_kWh_d` (out physValue): Elektrische Energie [kWh/d]
- `P_therm_kWh_d` (out physValue): Thermische Energie [kWh/d]

**Ausnahmen:**
- `exception`: Unbekannte BHKW-ID

##### `burnBiogas(string chp_id, double[] u, out double P_el_kWh_d, out double P_therm_kWh_d)`

Version mit double-Ausgabe.

##### `getMaxElPower()` / `getMaxElEnergy()`

Berechnet maximale elektrische Leistung/Energie der Anlage.

**Rückgabe:**
- `physValue`: Maximale Leistung [kW] oder Energie [kWh/d]

**Formel:**
```
P_el_max = Σ(P_el_i)  [kW]
E_el_max = P_el_max × 24  [kWh/d]
```

**Ausnahmen (getMaxElEnergy):**
- `exception`: Berechnung fehlgeschlagen

##### `getElPowerEquiv(double volflowrateCH4, out double Pel_kWh_d)`

Berechnet elektrische Energie aus Methanvolumenstrom.

**Parameter:**
- `volflowrateCH4` (double): Methanstrom [m³/d]
- `Pel_kWh_d` (out double): Elektrische Energie [kWh/d]

**Formel:**
```
Pel = min(Q_ch4 × η_el_mean × H_ch4, E_el_max)
```

---

### Pumpen-Verwaltung

#### Pumpen hinzufügen/entfernen

##### `addPump(pump myPump)`

Fügt Pumpe zur Anlage hinzu.

##### `deletePump(string id)` / `deletePump(int index)`

Löscht Pumpe.

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID

#### Pumpen-Zugriff

##### `getPump(int index)` / `getPumpByID(string id)`

Holt Pumpen-Objekt.

**Rückgabe:**
- `pump`: Pumpen-Objekt

##### `getPumpID(int index)` / `getPumpIndex(string id)`

Konvertiert zwischen Index und ID.

##### `getNumPumps()` / `getNumPumpsD()`

Gibt Anzahl der Pumpen zurück.

##### `containsPump(string pump_id)`

Prüft ob Pumpen-ID existiert.

#### Pumpen-Parameter

##### `getPumpParam(int index, string param)` / `getPumpParam(string id, string param)`

Holt physValue-Parameter als double.

##### `getPumpParamD(string id, string param)`

Holt double-Parameter.

##### `setPumpParam(int index, string symbol, ...)`

Setzt Parameter (verschiedene Überladungen).

---

### Substrat-Transport-Verwaltung

#### Transport hinzufügen/entfernen

##### `addSubstrateTransport(substrate_transport mySubstrateTransport)`

Fügt Substrat-Transport zur Anlage hinzu.

##### `deleteSubstrateTransport(string id)` / `deleteSubstrateTransport(int index)`

Löscht Substrat-Transport.

#### Transport-Zugriff

##### `getSubstrateTransport(int index)` / `getSubstrateTransportByID(string id)`

Holt Substrat-Transport-Objekt.

**Rückgabe:**
- `substrate_transport`: Transport-Objekt

##### `getSubstrateTransportID(int index)` / `getSubstrateTransportIndex(string id)`

Konvertiert zwischen Index und ID.

##### `getNumSubstrateTransports()` / `getNumSubstrateTransportsD()`

Gibt Anzahl der Substrat-Transporte zurück.

##### `containsSubstrateTransport(string substrate_transport_id)`

Prüft ob Substrat-Transport-ID existiert.

#### Transport-Parameter

##### `getSubstrateTransportParam(int index, string param)` / `getSubstrateTransportParam(string id, string param)`

Holt physValue-Parameter als double.

##### `getSubstrateTransportParamD(string id, string param)`

Holt double-Parameter.

##### `setSubstrateTransportParam(int index, string symbol, ...)`

Setzt Parameter (verschiedene Überladungen).

---

### Energie-Berechnungen

#### Heizung

##### `calcCostsForHeating(string digester_id, physValue pP_loss, double sell_heat, double cost_elEnergy)`

Berechnet Heizkosten für spezifischen Fermenter.

**Parameter:**
- `digester_id` (string): Fermenter-ID
- `pP_loss` (physValue): Wärmeverlust [W oder kWh/d]
- `sell_heat` (double): Virtueller Wärmeverkaufspreis [€/kWh]
- `cost_elEnergy` (double): Stromkosten [€/kWh]

**Rückgabe:**
- `double`: Kosten [€/d]

**Ausnahmen:**
- `exception`: Unbekannte Fermenter-ID
- `exception`: Effizienz ist Null

##### `calcCostsForHeating_Total(physValue pP_loss, double sell_heat, double cost_elEnergy)`

Berechnet Gesamt-Heizkosten für alle Fermenter.

**Rückgabe:**
- `double`: Gesamt-Kosten [€/d]

##### `calcHeatPower(string digester_id, double[] Q, substrates mySubstrates, physValue T_ambient, sensors mySensors)`

Berechnet benötigte Heizleistung für spezifischen Fermenter.

**Parameter:**
- `digester_id` (string): Fermenter-ID
- `Q` (double[]): Substratfütterung [m³/d]
- `mySubstrates` (substrates): Substrat-Liste
- `T_ambient` (physValue): Umgebungstemperatur [°C]
- `mySensors` (sensors): Sensor-Objekt

**Rückgabe:**
- `double`: Heizleistung [kWh/d]

**Ausnahmen:**
- `exception`: Unbekannte Fermenter-ID
- `exception`: Q.Length != mySubstrates.Count
- `exception`: Effizienz ist Null

##### `calcThermalEnergyBalance(string digester_id, double[] Q, substrates mySubstrates, sensors mySensors)`

Berechnet thermische Energiebilanz für spezifischen Fermenter.

**Parameter:**
- `digester_id` (string): Fermenter-ID
- `Q` (double[]): Substratfütterung [m³/d]
- `mySubstrates` (substrates): Substrat-Liste
- `mySensors` (sensors): Sensor-Objekt

**Rückgabe:**
- `double`: Energiebilanz [kWh/d]

**Hinweis:** Nutzt `plant.Tout` als Umgebungstemperatur.

---

### Wirtschaftliche Berechnungen

##### `getVerguetung(double Pel, bool var)`

Berechnet EEG-Vergütung für die Anlage.

**Parameter:**
- `Pel` (double): Elektrische Leistung [kW]
- `var` (bool): Für EEG 2009: Gülle-Bonus aktiviert

**Rückgabe:**
- `double`: Vergütung [€/kWh]

**Abhängigkeiten:**
- `construct_year`: Bestimmt EEG-Version (2009, 2012, ...)
- BHKW-Leistung
- Substrat-Klassen (über myFinances)

**Hinweis:** Details siehe `finances`-Klasse.

---

### Anwendungsbeispiele

#### Anlage erstellen und konfigurieren

```csharp
// Neue Anlage
var plant = new plant();
plant.set_params_of(
    "id", "plant_001",
    "name", "Biogasanlage Musterhausen",
    "Tout", 12.0,
    "construct_year", 2012
);

// Fermenter hinzufügen
var fermenter1 = new digester("F1", "Hauptfermenter");
fermenter1.set_params_of("Vliq", 2500.0, "T", 42.0);
plant.addDigester(fermenter1);

var fermenter2 = new digester("F2", "Nachfermenter");
fermenter2.set_params_of("Vliq", 1500.0, "T", 40.0);
plant.addDigester(fermenter2);

// BHKWs hinzufügen
var chp1 = new chp("CHP1", "BHKW 1");
chp1.set_params_of("Pel", 500.0, "eta_el", 0.42);
plant.addCHP(chp1);

var chp2 = new chp("CHP2", "BHKW 2");
chp2.set_params_of("Pel", 250.0, "eta_el", 0.40);
plant.addCHP(chp2);

// Speichern
plant.saveAsXML("plant_config.xml");
```

#### Anlage aus XML laden und inspizieren

```csharp
// Laden
var plant = new plant("plant_config.xml");

// Übersicht
Console.WriteLine(plant.print());

// Statistik
Console.WriteLine($"\nAnlagen-Übersicht:");
Console.WriteLine($"  Fermenter: {plant.getNumDigesters()}");
Console.WriteLine($"  BHKWs: {plant.getNumCHPs()}");
Console.WriteLine($"  Pumpen: {plant.getNumPumps()}");
Console.WriteLine($"  Substrate-Transporte: {plant.getNumSubstrateTransports()}");

// Max. Leistung
var maxPel = plant.getMaxElPower();
Console.WriteLine($"  Max. el. Leistung: {maxPel.Value} kW");

// Baujahr
Console.WriteLine($"  Baujahr: {plant.construct_year}");
```

#### Fermenter-Parameter verwalten

```csharp
var plant = new plant("plant.xml");

// Fermenter-Namen auflisten
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    string name = plant.getDigesterName(i);
    double Vliq = plant.getDigesterParam(i, "Vliq");
    double T = plant.getDigesterParam(i, "T");
    
    Console.WriteLine($"Fermenter {i}: {name}");
    Console.WriteLine($"  Vliq: {Vliq} m³");
    Console.WriteLine($"  T: {T} °C");
}

// Temperatur aller Fermenter auf 42°C setzen
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    plant.setDigesterParam(i, "T", 42.0);
}

// Spezifischen Fermenter finden
string id;
int index;
plant.getDigesterByName("Hauptfermenter", out id, out index);
Console.WriteLine($"Hauptfermenter hat ID: {id}, Index: {index}");
```

#### BHKW-Betrieb simulieren

```csharp
var plant = new plant("plant.xml");

// Biogasstrom (aus Fermenter-Simulation)
double[] biogas = new double[BioGas.n_gases];
biogas[BioGas.pos_ch4 - 1] = 800.0;  // m³/d
biogas[BioGas.pos_co2 - 1] = 400.0;
biogas[BioGas.pos_h2 - 1] = 10.0;

// BHKW 1 betreiben
physValue P_el, P_therm;
plant.burnBiogas("CHP1", biogas, out P_el, out P_therm);

Console.WriteLine($"BHKW 1 Produktion:");
Console.WriteLine($"  Elektrisch: {P_el.Value:F1} kWh/d");
Console.WriteLine($"  Thermisch: {P_therm.Value:F1} kWh/d");

// Maximale Leistung prüfen
var maxEl = plant.getMaxElEnergy();
double auslastung = P_el.Value / maxEl.Value * 100;
Console.WriteLine($"  Auslastung: {auslastung:F1}%");
```

#### Energie-Bilanz berechnen

```csharp
var plant = new plant("plant.xml");
var substrates = new substrates("substrates.xml");
var sensors = new sensors();

// Substratfütterung für Fermenter 1
double[] Q = {100.0, 50.0};  // m³/d

// Energiebilanz
double balance = plant.calcThermalEnergyBalance(
    "F1", Q, substrates, sensors
);

Console.WriteLine($"Thermische Energiebilanz:");
Console.WriteLine($"  {balance:F1} kWh/d");

if (balance < 0)
{
    // Heizung nötig
    double heatPower = plant.calcHeatPower(
        "F1", Q, substrates, plant.Tout, sensors
    );
    Console.WriteLine($"  Heizleistung: {heatPower:F1} kWh/d");
    
    // Kosten
    double costs = plant.calcCostsForHeating(
        "F1",
        new physValue(heatPower, "kWh/d"),
        0.08,   // 8 ct/kWh Wärmeverkauf
        0.25    // 25 ct/kWh Strom
    );
    Console.WriteLine($"  Heizkosten: {costs:F2} €/d");
}
else
{
    Console.WriteLine("  Keine Heizung nötig (Wärmeüberschuss)");
}
```

#### EEG-Vergütung berechnen

```csharp
var plant = new plant("plant.xml");

// Aktuelle elektrische Leistung
double Pel = 500.0;  // kW

// Vergütung (ohne Gülle-Bonus)
double verguetung = plant.getVerguetung(Pel, false);
Console.WriteLine($"EEG-Vergütung: {verguetung:F4} €/kWh");

// Mit Gülle-Bonus (nur EEG 2009)
if (plant.construct_year == 2009)
{
    double verguetung_bonus = plant.getVerguetung(Pel, true);
    Console.WriteLine($"Mit Gülle-Bonus: {verguetung_bonus:F4} €/kWh");
}

// Jahreserlös schätzen
double jahresstunden = 8000;  // Volllaststunden
double jahresertrag = Pel * jahresstunden * verguetung;
Console.WriteLine($"\nGeschätzter Jahreserlös:");
Console.WriteLine($"  {jahresertrag:N0} €/Jahr");
```

#### ADM-Parameter für alle Fermenter setzen

```csharp
var plant = new plant("plant.xml");

// Desintegrationsrate für alle Fermenter setzen
int pos_kdis = 1;
double kdis_new = 0.3;

for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    plant.setADMparameter(i, pos_kdis, kdis_new);
    
    double kdis;
    plant.getADMparameter(i, pos_kdis, out kdis);
    
    string name = plant.getDigesterName(i);
    Console.WriteLine($"{name}: kdis = {kdis} 1/d");
}
```

#### Fermenter und zugehörige Transporte verwalten

```csharp
var plant = new plant();

// Fermenter hinzufügen (erstellt automatisch substrate_transport)
var fermenter = new digester("F1", "Fermenter 1");
plant.addDigester(fermenter);

// Zugehöriger Transport wurde automatisch erstellt
string transport_id = "substratemix_F1";
bool exists = plant.containsSubstrateTransport(transport_id);
Console.WriteLine($"Transport {transport_id} existiert: {exists}");

// Transport-Parameter setzen
plant.setSubstrateTransportParam(
    transport_id,
    "pump_id",
    "P1"
);

// Fermenter löschen (löscht auch den Transport)
plant.deleteDigester(1);
exists = plant.containsSubstrateTransport(transport_id);
Console.WriteLine($"Nach Löschung existiert Transport: {exists}");
```

---

## TODOs

Laut Quellcode:

### Wärmebilanz

- Wenn Fermenter nicht geheizt wird, dann gibt es Wärmeverluste im Fermenter, welche sich auf die Fermentertemperatur auswirken → wird bisher noch nicht berücksichtigt
- Wenn im Fermenter mehr Wärme produziert wird als verloren geht, wird nicht geheizt, trotzdem steigt die Temperatur an → wird bisher nicht modelliert

---

## Best Practices

### 1. Initialisierung

```csharp
// Bevorzugt: Aus XML laden
var plant = new plant("plant_config.xml");

// Alternative: Programmatisch erstellen
var plant = new plant();
plant.set_params_of("id", "plant_001", "name", "Meine Anlage");
// ... Komponenten hinzufügen ...
plant.saveAsXML("plant_config.xml");  // Für spätere Verwendung
```

### 2. Parameter-Zugriff

```csharp
// GUT: Über plant-Methoden zugreifen
double Vliq = plant.getDigesterParam("F1", "Vliq");

// VERMEIDEN: Direkt auf Komponenten zugreifen (wenn möglich)
// var fermenter = plant.myDigesters.get("F1");
// double Vliq = fermenter.Vliq.Value;
// → Besser plant-Methoden nutzen für einheitliche API
```

### 3. Komponenten-Verwaltung

```csharp
// GUT: Konsistenz wahren
var fermenter = new digester("F1", "Fermenter 1");
plant.addDigester(fermenter);
// → Erstellt automatisch substrate_transport

// VERMEIDEN: Direkt auf Listen zugreifen
// plant.myDigesters.addDigester(fermenter);
// → Fehlt substrate_transport!
```

### 4. Fehlerbehandlung

```csharp
// GUT: Try-Catch für kritische Operationen
try
{
    double balance = plant.calcThermalEnergyBalance(
        "F1", Q, substrates, sensors
    );
    
    if (balance < 0)
    {
        double heatPower = plant.calcHeatPower(
            "F1", Q, substrates, plant.Tout, sensors
        );
        Console.WriteLine($"Heizleistung: {heatPower:F1} kWh/d");
    }
}
catch (exception ex)
{
    Console.WriteLine($"Energieberechnung fehlgeschlagen: {ex.Message}");
    // Fallback-Strategie
}

// VERMEIDEN: Unbehandelte Exceptions
// var balance = plant.calcThermalEnergyBalance(...);  // Kann werfen!
```

### 5. Konsistente ID-Verwaltung

```csharp
// GUT: IDs dokumentieren und konsistent nutzen
var plant = new plant();

// Fermenter-IDs nach Schema
plant.addDigester(new digester("F1", "Hauptfermenter"));
plant.addDigester(new digester("F2", "Nachfermenter"));

// BHKW-IDs nach Schema
plant.addCHP(new chp("CHP1", "BHKW Hauptgebäude"));
plant.addCHP(new chp("CHP2", "BHKW Nebengebäude"));

// Substrat-Transporte werden automatisch erstellt:
// "substratemix_F1", "substratemix_F2"

// Zugriff dann konsistent über IDs
double vliq_f1 = plant.getDigesterParam("F1", "Vliq");
double pel_chp1 = plant.getCHPParam("CHP1", "Pel");
```

### 6. XML-Persistenz

```csharp
// GUT: Regelmäßig speichern
var plant = new plant();
// ... Konfiguration ...
plant.saveAsXML("plant_config.xml");

// Später laden
var loaded_plant = new plant("plant_config.xml");

// Änderungen speichern
loaded_plant.set_params_of("Tout", 15.0);
loaded_plant.saveAsXML("plant_config_updated.xml");

// TIPP: Versionierung verwenden
string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
plant.saveAsXML($"plant_config_{timestamp}.xml");
```

---

## Erweiterte Anwendungsbeispiele

### Beispiel 1: Vollständige Anlagen-Simulation

```csharp
using biogas;
using science;

// Anlage laden
var plant = new plant("plant_config.xml");
var substrates = new substrates("substrates.xml");
var sensors = new sensors();

// Substratfütterung definieren
double[] Q_maize = {80.0, 0.0};      // 80 m³/d Mais in F1
double[] Q_manure = {0.0, 120.0};    // 120 m³/d Gülle in F2

// Simulationsschleife
for (double t = 0; t < 365; t += 1)  // 1 Jahr, täglich
{
    // 1. Fermenter-Berechnungen
    foreach (var fermenter in plant.myDigesters)
    {
        // TS/VS berechnen (aus ADM-Zustand)
        double[] x = /* ADM-Simulation liefert x */;
        double[] Q = (fermenter.id == "F1") ? Q_maize : Q_manure;
        
        physValue TS;
        var VS = digester.calcVS(x, substrates, Q, out TS);
        
        // Energiebilanz
        double balance = plant.calcThermalEnergyBalance(
            fermenter.id, Q, substrates, sensors
        );
        
        // Bei Bedarf heizen
        if (balance < 0)
        {
            double heatPower = plant.calcHeatPower(
                fermenter.id, Q, substrates, plant.Tout, sensors
            );
            // Heizung aktivieren...
        }
        
        // Prozessparameter loggen
        Console.WriteLine($"Tag {t}, {fermenter.name}:");
        Console.WriteLine($"  TS: {TS.Value:F2} % FM");
        Console.WriteLine($"  VS: {VS.Value:F2} % TS");
        Console.WriteLine($"  Balance: {balance:F1} kWh/d");
    }
    
    // 2. Biogasproduktion zusammenführen
    double[] biogas_total = BioGas.merge_streams(
        /* Biogasströme aller Fermenter */,
        plant.getNumDigesters()
    );
    
    // 3. BHKWs betreiben
    physValue P_el_total = new physValue(0, "kWh/d");
    foreach (var chp in plant.myCHPs)
    {
        physValue P_el, P_therm;
        plant.burnBiogas(chp.id, biogas_total, out P_el, out P_therm);
        P_el_total = P_el_total + P_el;
        
        Console.WriteLine($"  {chp.name}: {P_el.Value:F1} kWh/d");
    }
    
    // 4. Wirtschaftlichkeit
    double verguetung = plant.getVerguetung(
        P_el_total.convertUnit("kW").Value,
        false
    );
    double erloes = P_el_total.Value * verguetung;
    
    Console.WriteLine($"Tageserlös: {erloes:F2} €");
    Console.WriteLine("---");
}
```

### Beispiel 2: Prozess-Optimierung

```csharp
using biogas;
using science;

// Anlage laden
var plant = new plant("plant_config.xml");
var substrates = new substrates("substrates.xml");
var sensors = new sensors();

// Optimierungsparameter
double[] Q_range = {50, 100, 150, 200};  // m³/d zu testen
double best_Q = 0;
double best_profit = double.MinValue;

// Für jeden Betriebspunkt
foreach (double Q_test in Q_range)
{
    double[] Q = {Q_test, 0.0};  // Beispiel: nur ein Substrat
    
    // Energiebilanz
    double balance = plant.calcThermalEnergyBalance(
        "F1", Q, substrates, sensors
    );
    
    // Heizkosten
    double heatCosts = 0;
    if (balance < 0)
    {
        double heatPower = plant.calcHeatPower(
            "F1", Q, substrates, plant.Tout, sensors
        );
        heatCosts = plant.calcCostsForHeating(
            "F1",
            new physValue(heatPower, "kWh/d"),
            0.08, 0.25
        );
    }
    
    // Substratkosten
    double substratCosts = Q * substrates.get(1).get_param_of("cost");
    
    // Biogasproduktion schätzen (vereinfacht)
    double bmp = substrates.get(1).calcBMP().Value;  // l/g FM
    double ts = substrates.get(1).get_param_of("TS");  // % FM
    double rho = substrates.get(1).get_param_of("rho");  // kg/m³
    
    double biogas_m3d = Q * (ts/100) * rho * bmp / 1000;
    double ch4_content = substrates.get(1).calcGasQuality().Value / 100;
    double ch4_m3d = biogas_m3d * ch4_content;
    
    // Stromproduktion
    double pel_kwhd;
    plant.getElPowerEquiv(ch4_m3d, out pel_kwhd);
    
    double verguetung = plant.getVerguetung(pel_kwhd / 24, false);
    double erloes = pel_kwhd * verguetung;
    
    // Gewinn
    double profit = erloes - heatCosts - substratCosts;
    
    Console.WriteLine($"\nQ = {Q_test} m³/d:");
    Console.WriteLine($"  Biogas: {biogas_m3d:F1} m³/d");
    Console.WriteLine($"  CH4: {ch4_m3d:F1} m³/d");
    Console.WriteLine($"  Strom: {pel_kwhd:F1} kWh/d");
    Console.WriteLine($"  Erlös: {erloes:F2} €/d");
    Console.WriteLine($"  Heizkosten: {heatCosts:F2} €/d");
    Console.WriteLine($"  Substratkosten: {substratCosts:F2} €/d");
    Console.WriteLine($"  Gewinn: {profit:F2} €/d");
    
    if (profit > best_profit)
    {
        best_profit = profit;
        best_Q = Q_test;
    }
}

Console.WriteLine($"\n=== Optimum ===");
Console.WriteLine($"Beste Fütterung: {best_Q} m³/d");
Console.WriteLine($"Bester Gewinn: {best_profit:F2} €/d");
```

### Beispiel 3: Multi-Fermenter-Betrieb

```csharp
using biogas;
using science;

var plant = new plant("plant_config.xml");
var substrates = new substrates("substrates.xml");
var sensors = new sensors();

// Substratverteilung auf Fermenter
var distribution = new Dictionary
{
    {"F1", new double[] {100, 0}},     // Mais
    {"F2", new double[] {0, 150}},     // Gülle
    {"F3", new double[] {50, 50}}      // Mix
};

// Für jeden Fermenter
double total_heat = 0;
var biogas_streams = new List();

foreach (var kvp in distribution)
{
    string fermenter_id = kvp.Key;
    double[] Q = kvp.Value;
    
    // Fermenter-Informationen
    string name = plant.getDigesterName(fermenter_id);
    double vliq = plant.getDigesterParam(fermenter_id, "Vliq");
    double temp = plant.getDigesterParam(fermenter_id, "T");
    
    Console.WriteLine($"\n{name} ({fermenter_id}):");
    Console.WriteLine($"  Vliq: {vliq} m³, T: {temp}°C");
    Console.WriteLine($"  Fütterung: {Q[0]} m³/d Mais, {Q[1]} m³/d Gülle");
    
    // HRT berechnen
    var HRT = digester.calcHRT(Q, new physValue(vliq, "m³"));
    Console.WriteLine($"  HRT: {HRT.Value:F1} d");
    
    // Heizleistung
    double heatPower = plant.calcHeatPower(
        fermenter_id, Q, substrates, plant.Tout, sensors
    );
    total_heat += heatPower;
    Console.WriteLine($"  Heizleistung: {heatPower:F1} kWh/d");
    
    // Biogasproduktion (aus ADM-Simulation)
    double[] biogas = /* ADM liefert Biogasstrom */;
    biogas_streams.Add(biogas);
    
    double total_biogas = biogas[0] + biogas[1] + biogas[2];
    double ch4_percent = biogas[1] / total_biogas * 100;
    Console.WriteLine($"  Biogas: {total_biogas:F1} m³/d");
    Console.WriteLine($"  CH4-Gehalt: {ch4_percent:F1} %");
}

Console.WriteLine($"\n=== Gesamt-Anlage ===");
Console.WriteLine($"Gesamt-Heizleistung: {total_heat:F1} kWh/d");

// Biogas zusammenführen
double[] total_biogas_stream = new double[BioGas.n_gases];
foreach (var stream in biogas_streams)
{
    for (int i = 0; i < BioGas.n_gases; i++)
    {
        total_biogas_stream[i] += stream[i];
    }
}

double total_ch4 = total_biogas_stream[BioGas.pos_ch4 - 1];
Console.WriteLine($"Gesamt CH4: {total_ch4:F1} m³/d");

// Stromproduktion
double pel_total;
plant.getElPowerEquiv(total_ch4, out pel_total);
Console.WriteLine($"Stromproduktion: {pel_total:F1} kWh/d");

var maxEl = plant.getMaxElEnergy();
double auslastung = pel_total / maxEl.Value * 100;
Console.WriteLine($"BHKW-Auslastung: {auslastung:F1} %");
```

### Beispiel 4: Szenario-Vergleich

```csharp
using biogas;
using science;

// Basis-Anlage
var plant_base = new plant("plant_base.xml");

// Szenario 1: Größerer Fermenter
var plant_s1 = new plant("plant_base.xml");
plant_s1.setDigesterParam("F1", "Vliq", 3500.0);

// Szenario 2: Zusätzliches BHKW
var plant_s2 = new plant("plant_base.xml");
var chp_new = new chp("CHP3", "BHKW 3");
chp_new.set_params_of("Pel", 250.0, "eta_el", 0.40);
plant_s2.addCHP(chp_new);

// Szenario 3: Bessere Isolierung
var plant_s3 = new plant("plant_base.xml");
for (int i = 1; i <= plant_s3.getNumDigesters(); i++)
{
    plant_s3.setDigesterParam(i, "k_wall", 0.25);
    plant_s3.setDigesterParam(i, "k_roof", 0.15);
}

// Szenarien vergleichen
var scenarios = new Dictionary
{
    {"Basis", plant_base},
    {"Größerer Fermenter", plant_s1},
    {"Zusätzliches BHKW", plant_s2},
    {"Bessere Isolierung", plant_s3}
};

var substrates = new substrates("substrates.xml");
var sensors = new sensors();
double[] Q = {100, 50};

Console.WriteLine("Szenario-Vergleich:\n");

foreach (var scenario in scenarios)
{
    Console.WriteLine($"{scenario.Key}:");
    
    // Max. Leistung
    var maxPel = scenario.Value.getMaxElPower();
    Console.WriteLine($"  Max. el. Leistung: {maxPel.Value:F1} kW");
    
    // Heizkosten
    double heatCosts = 0;
    for (int i = 1; i <= scenario.Value.getNumDigesters(); i++)
    {
        string id = scenario.Value.getDigesterID(i);
        double heat = scenario.Value.calcHeatPower(
            id, Q, substrates, scenario.Value.Tout, sensors
        );
        heatCosts += scenario.Value.calcCostsForHeating(
            id, new physValue(heat, "kWh/d"), 0.08, 0.25
        );
    }
    Console.WriteLine($"  Heizkosten: {heatCosts:F2} €/d");
    
    // Investitionskosten (vereinfacht)
    double invest = 0;
    if (scenario.Key.Contains("Größerer"))
        invest = 200000;  // 200k € für größeren Fermenter
    else if (scenario.Key.Contains("BHKW"))
        invest = 150000;  // 150k € für BHKW
    else if (scenario.Key.Contains("Isolierung"))
        invest = 50000;   // 50k € für bessere Isolierung
    
    Console.WriteLine($"  Investition: {invest:F0} €");
    
    // ROI (sehr vereinfacht)
    if (invest > 0)
    {
        double savings_per_year = (scenarios["Basis"] ? 
            /* Basis-Heizkosten */ - heatCosts : 0) * 365;
        double roi_years = invest / savings_per_year;
        Console.WriteLine($"  ROI: {roi_years:F1} Jahre");
    }
    
    Console.WriteLine();
}
```

### Beispiel 5: Wartung und Monitoring

```csharp
using biogas;
using science;

var plant = new plant("plant_config.xml");

// Anlagen-Inspektion
Console.WriteLine("=== Anlagen-Inspektion ===\n");

// Fermenter-Status
Console.WriteLine("Fermenter:");
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    string name = plant.getDigesterName(i);
    string id = plant.getDigesterID(i);
    double vliq = plant.getDigesterParam(i, "Vliq");
    double temp = plant.getDigesterParam(i, "T");
    
    // Rührwerke
    var fermenter = plant.getDigester(i);
    int numStirrer = fermenter.mixers.getNumStirrers();
    
    Console.WriteLine($"  {name} ({id}):");
    Console.WriteLine($"    Vliq: {vliq} m³, T: {temp}°C");
    Console.WriteLine($"    Rührwerke: {numStirrer}");
    
    // Heizung
    bool heatingOn = fermenter.heating.status;
    double heatingEta = fermenter.heating.eta;
    Console.WriteLine($"    Heizung: {(heatingOn ? "An" : "Aus")}, η={heatingEta:P0}");
}

// BHKW-Status
Console.WriteLine("\nBHKWs:");
for (int i = 1; i <= plant.getNumCHPs(); i++)
{
    string name = plant.getCHPName(i);
    string id = plant.getCHPID(i);
    double pel = plant.getCHPParam(i, "Pel");
    double eta_el = plant.getCHPParamD(i, "eta_el");
    
    Console.WriteLine($"  {name} ({id}):");
    Console.WriteLine($"    Pel: {pel} kW, η_el={eta_el:P0}");
}

// Gesamt-Übersicht
Console.WriteLine("\nGesamt:");
var maxPel = plant.getMaxElPower();
Console.WriteLine($"  Max. el. Leistung: {maxPel.Value} kW");
Console.WriteLine($"  Baujahr: {plant.construct_year}");
Console.WriteLine($"  Umgebungstemperatur: {plant.Tout.Value}°C");

// Warnungen
Console.WriteLine("\nWarnungen:");
bool warnings = false;

// Temperatur-Check
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    double temp = plant.getDigesterParam(i, "T");
    if (temp < 35 || temp > 45)
    {
        string name = plant.getDigesterName(i);
        Console.WriteLine($"  {name}: Temperatur außerhalb Optimum (35-45°C)!");
        warnings = true;
    }
}

// Heizungs-Check
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    var fermenter = plant.getDigester(i);
    if (fermenter.heating.eta < 0.5)
    {
        Console.WriteLine($"  {fermenter.name}: Niedriger Heizungswirkungsgrad!");
        warnings = true;
    }
}

if (!warnings)
{
    Console.WriteLine("  Keine Warnungen.");
}
```

---

## Zusammenfassung der Wichtigsten Methoden

### Fermenter-Verwaltung

```csharp
// Hinzufügen/Löschen
plant.addDigester(digester myDigester)
plant.deleteDigester(int index)

// Zugriff
digester plant.getDigester(int index)
digester plant.getDigesterByID(string id)
int plant.getNumDigesters()

// Parameter
double plant.getDigesterParam(string id, string param)
void plant.setDigesterParam(string id, string param, double value)

// ADM
double[] plant.getDefaultADMparams(string id)
void plant.setADMparameter(string id, int pos, double value)
```

### BHKW-Verwaltung

```csharp
// Hinzufügen/Löschen
plant.addCHP(chp myCHP)
plant.deleteCHP(int index)

// Zugriff
chp plant.getCHP(int index)
chp plant.getCHPByID(string id)
int plant.getNumCHPs()

// Parameter
double plant.getCHPParam(string id, string param)
void plant.setCHPParam(string id, string param, double value)

// Betrieb
void plant.burnBiogas(string chp_id, double[] u, out physValue P_el, out physValue P_therm)
physValue plant.getMaxElPower()
```

### Energie-Berechnungen

```csharp
// Thermische Bilanz
double plant.calcThermalEnergyBalance(string id, double[] Q, substrates subs, sensors sens)
double plant.calcHeatPower(string id, double[] Q, substrates subs, physValue T_amb, sensors sens)
double plant.calcCostsForHeating(string id, physValue P_loss, double sell, double cost)

// Elektrisch
void plant.getElPowerEquiv(double Q_ch4, out double Pel)
double plant.getVerguetung(double Pel, bool var)
```

### Datenmanagement

```csharp
// Laden/Speichern
var plant = new plant(string XMLfile)
void plant.saveAsXML(string XMLfile)

// Ausgabe
string plant.print()

// Parameter
void plant.set_params_of(params object[] symbols)
void plant.get_params_of(out object[] vars, params string[] symbols)
```

---

## Häufige Fehler und Lösungen

### Problem 1: "Index out of bounds"

```csharp
// FALSCH: 0-basierte Indexierung
var fermenter = plant.getDigester(0);  // Exception!

// RICHTIG: 1-basierte Indexierung
var fermenter = plant.getDigester(1);  // Erster Fermenter
```

### Problem 2: "Unknown parameter"

```csharp
// FALSCH: Falscher Parameter-Name
double temp = plant.getDigesterParam("F1", "Temperature");  // Exception!

// RICHTIG: Korrekter Parameter-Name
double temp = plant.getDigesterParam("F1", "T");
```

### Problem 3: "Efficiency is zero"

```csharp
// FALSCH: Wirkungsgrad nicht gesetzt
var heating = new heating();  // eta = 0
// ... später ...
heating.compensateHeatLoss(...);  // Exception: Division durch Null!

// RICHTIG: Wirkungsgrad setzen
var heating = new heating(0.85);
// oder
var heating = new heating();
heating.set_params_of("eta", 0.85);
```

### Problem 4: Inconsistent units

```csharp
// FALSCH: Einheiten-Mismatch
var T1 = new physValue(40, "°C");
var T2 = new physValue(313, "K");
var diff = T1 - T2;  // Exception: Einheiten nicht kompatibel!

// RICHTIG: Vor Verwendung konvertieren
var T2_celsius = T2.convertUnit("°C");
var diff = T1 - T2_celsius;
```

### Problem 5: Fermenter ohne Transport

```csharp
// FALSCH: Manuell Fermenter zur Liste hinzufügen
plant.myDigesters.addDigester(fermenter);  // Kein substrate_transport!

// RICHTIG: plant-Methode nutzen
plant.addDigester(fermenter);  // Erstellt automatisch substrate_transport
```

---

## Performance-Tipps

### 1. XML-Caching

```csharp
// Langsam: Bei jedem Zugriff laden
for (int i = 0; i < 1000; i++)
{
    var plant = new plant("plant.xml");
    // ... Berechnungen ...
}

// Schneller: Einmal laden
var plant = new plant("plant.xml");
for (int i = 0; i < 1000; i++)
{
    // ... Berechnungen mit plant ...
}
```

### 2. Batch-Parameter-Zugriff

```csharp
// Langsam: Einzelne Zugriffe
for (int i = 1; i <= plant.getNumDigesters(); i++)
{
    double vliq = plant.getDigesterParam(i, "Vliq");
    double temp = plant.getDigesterParam(i, "T");
    // ...
}

// Schneller: Direkt auf Objekt zugreifen
foreach (var fermenter in plant.myDigesters)
{
    double vliq = fermenter.Vliq.Value;
    double temp = fermenter.T.Value;
    // ...
}
```

### 3. Wiederverwendung von Berechnungen

```csharp
// Ineffizient: Mehrfachberechnungen
double balance1 = plant.calcThermalEnergyBalance("F1", Q, subs, sens);
double heatPower = plant.calcHeatPower("F1", Q, subs, T_amb, sens);

// Besser: Mit Komponenten-Ausgabe
physValue P_subs, P_rad, P_micro, P_stirr;
double balance = plant.calcThermalEnergyBalance(
    "F1", Q, subs, sens,
    out P_subs, out P_rad, out P_micro, out P_stirr
);
// Komponenten verwenden statt neu berechnen
```

---

## Siehe auch

- **biogas.digesters**: Fermenter-Klassen
- **biogas.chps**: BHKW-Klassen
- **biogas.transportation**: Pumpen und Transporte
- **biogas.finances**: Wirtschaftlichkeitsberechnungen
- **biogas.substrates**: Substrat-Verwaltung
- **biogas.sensors**: Messdatenerfassung

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*
