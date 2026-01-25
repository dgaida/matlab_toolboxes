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
// GUT: Try-Catch für