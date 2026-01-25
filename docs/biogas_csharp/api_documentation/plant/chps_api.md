# CHPs Package API Documentation

## Übersicht

Das `biogas.chps` Namespace enthält Klassen zur Modellierung und Simulation von Blockheizkraftwerken (BHKWs/CHPs - Combined Heat and Power) in Biogasanlagen. Es umfasst die Definition von einzelnen BHKWs und deren Verwaltung in Listen.

---

## Klasse: `chp`

Definiert ein Blockheizkraftwerk (BHKW) zur kombinierten Strom- und Wärmeerzeugung aus Biogas.

### Konstruktoren

#### `chp()`

Erstellt ein initialisiertes BHKW mit Standardwerten, ohne Name und ID.

#### `chp(string id, string name)`

Erstellt ein BHKW mit ID und Name und Standardwerten.

**Parameter:**
- `id` (string): Eindeutige ID des BHKWs
- `name` (string): Beschreibender Name

**Standardwerte:**
- P_elektrisch: 250 kW
- P_thermisch: 500 kW
- η_elektrisch: 0.4 (40%)
- η_thermisch: 0.45 (45%)

#### `chp(string XMLfile)`

Liest BHKW aus XML-Datei.

**Parameter:**
- `XMLfile` (string): Pfad zur XML-Datei

#### `chp(ref XmlTextReader reader, string id)`

Konstruktor für das Lesen aus XML (wird von `chps`-Klasse verwendet).

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader
- `id` (string): ID des BHKWs

---

### Eigenschaften

#### Identifikation

```csharp
public string id              // Eindeutige ID (read-only)
public string name            // Beschreibender Name (read-only)
```

#### Leistungen

```csharp
public physValue Pel          // Elektrische Leistung [kW]
public physValue Ptherm       // Thermische Leistung [kW]
```

#### Wirkungsgrade

```csharp
public double eta_el          // Elektrischer Wirkungsgrad [100%]
private double eta_therm      // Thermischer Wirkungsgrad [100%]
```

**Hinweis:** `eta_therm` beinhaltet auch Wärmeverluste beim Transport über Rohre.

---

### Methoden

#### Datenmanagement

##### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest Parameter aus XML-Reader.

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader

**Rückgabe:**
- `bool`: true bei Erfolg, false bei Fehler

##### `getParamsAsXMLString()`

Gibt Parameter als XML-String zurück.

**Rückgabe:**
- `string`: XML-formatierter String

**XML-Format:**
```xml
<chp id="chp_1">
    <name>BHKW 1</name>
    <physValue symbol="Pel">
        <value>250</value>
        <unit>kW</unit>
    </physValue>
    <physValue symbol="Ptherm">
        <value>500</value>
        <unit>kW</unit>
    </physValue>
    <eta_el>0.4</eta_el>
    <eta_therm>0.45</eta_therm>
</chp>
```

##### `print()`

Gibt formatierte Konsolenausgabe zurück.

**Rückgabe:**
- `string`: Formatierter String

**Beispielausgabe:**
```
   ----------   CHP:   BHKW 1   ----------   
id: chp_1
  Pel= 250.0 kW				Ptherm= 500.0 kW
  eta_el= 0.40 [100 %]		eta_therm= 0.45 [100 %]
   ---------- ---------- ---------- ----------   
```

##### `set_params_of(params object[] symbols)`

Setzt Parameter.

**Syntax:**
```csharp
chp.set_params_of(
    "Pel", 300.0,
    "eta_el", 0.42,
    "Ptherm", 550.0
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

#### Biogasverbrennung

##### `burnBiogas(double[] u, out physValue P_el_kWh_d, out physValue P_therm_kWh_d)`

Berechnet elektrische und thermische Energie aus Biogasverbrennung.

**Parameter:**
- `u` (double[]): Biogasstrom-Vektor [m³/d]
  - Mindestens `BioGas.n_gases` Elemente
  - Position der Gase: `BioGas.pos_ch4`, `BioGas.pos_h2`, `BioGas.pos_co2`
- `P_el_kWh_d` (out physValue): Elektrische Energie [kWh/d]
- `P_therm_kWh_d` (out physValue): Thermische Energie [kWh/d]

**Formel:**
```
// Energieinhalt des Biogases
energy = Q_ch4 × H_ch4 + Q_h2 × H_h2  [kWh/d]

// Elektrische Energie
P_el = min(η_el × energy, Pel × 24)   [kWh/d]

// Thermische Energie
P_therm = min(η_therm × energy, Ptherm × 24)  [kWh/d]
```

**Hinweis:** CH4 und H2 werden verbrannt; CO2 trägt nicht zur Energieproduktion bei.

**Ausnahmen:**
- `exception`: Einheiten-Problem

##### `burnBiogas(double[] u, out physValue P_el_kWh_d, out physValue P_el_kW, out physValue P_therm_kWh_d, out physValue P_therm_kW)`

Erweiterte Version mit zusätzlichen Leistungen in kW.

**Zusätzliche Ausgabeparameter:**
- `P_el_kW` (out physValue): Elektrische Leistung [kW]
- `P_therm_kW` (out physValue): Thermische Leistung [kW]

**Umrechnung:**
```
P [kW] = P [kWh/d] / 24
```

---

#### Methanverbrauch

##### `getMaxMethaneConsumption(out double maxMethane)`

Berechnet maximalen Methanverbrauch basierend auf elektrischer Leistung.

**Parameter:**
- `maxMethane` (out double): Max. Methanverbrauch [m³/d]

**Formel:**
```
maxMethane = Pel [kW] / η_el / H_ch4 [kWh/m³] × 24 [h/d]
```

**Annahme:** CH4 ist das einzige energieerzeugende Gas.

##### `getMaxMethaneConsumption(out physValue maxMethane)`

Version mit physValue-Ausgabe.

**Rückgabe:**
- `maxMethane` (out physValue): Max. Methanverbrauch [m³/d]

---

### Anwendungsbeispiele

#### BHKW erstellen und konfigurieren

```csharp
// Neues BHKW mit Standardwerten
var chp = new chp("CHP1", "BHKW Hauptgebäude");

// Parameter anpassen
chp.set_params_of(
    "Pel", 500.0,      // 500 kW elektrisch
    "Ptherm", 600.0,   // 600 kW thermisch
    "eta_el", 0.42,    // 42% elektrischer Wirkungsgrad
    "eta_therm", 0.48  // 48% thermischer Wirkungsgrad
);

// Ausgabe
Console.WriteLine(chp.print());

// Speichern
var xml = chp.getParamsAsXMLString();
File.WriteAllText("chp_config.xml", xml);
```

#### Biogasverbrennung simulieren

```csharp
var chp = new chp("CHP1", "BHKW 1");
chp.set_params_of("Pel", 250.0, "eta_el", 0.40);

// Biogasstrom (CH4, CO2, H2)
double[] biogas = new double[BioGas.n_gases];
biogas[BioGas.pos_ch4 - 1] = 600.0;  // 600 m³/d CH4
biogas[BioGas.pos_co2 - 1] = 300.0;  // 300 m³/d CO2
biogas[BioGas.pos_h2 - 1] = 5.0;     // 5 m³/d H2

// Verbrennung
physValue P_el, P_therm;
chp.burnBiogas(biogas, out P_el, out P_therm);

Console.WriteLine($"Elektrische Energie: {P_el.Value:F1} {P_el.Unit}");
Console.WriteLine($"Thermische Energie: {P_therm.Value:F1} {P_therm.Unit}");

// Mit Leistungen in kW
physValue P_el_kW, P_therm_kW;
chp.burnBiogas(biogas, out P_el, out P_el_kW, out P_therm, out P_therm_kW);
Console.WriteLine($"Elektrische Leistung: {P_el_kW.Value:F1} kW");
Console.WriteLine($"Thermische Leistung: {P_therm_kW.Value:F1} kW");
```

#### Maximalen Methanverbrauch berechnen

```csharp
var chp = new chp("CHP1", "BHKW 1");
chp.set_params_of("Pel", 500.0, "eta_el", 0.42);

// Maximaler Methanverbrauch
double maxCH4;
chp.getMaxMethaneConsumption(out maxCH4);

Console.WriteLine($"Maximaler CH4-Verbrauch: {maxCH4:F1} m³/d");

// Mit physValue
physValue maxCH4_phys;
chp.getMaxMethaneConsumption(out maxCH4_phys);
Console.WriteLine($"Max. CH4: {maxCH4_phys.printValue()}");
```

---

## Klasse: `chps`

Liste von BHKWs (erbt von `List<chp>`).

### Konstruktoren

```csharp
public chps()  // Leere Liste
```

### Eigenschaften

```csharp
public List<string> ids  // Liste der BHKW-IDs
```

---

### Methoden

#### Verwaltung

##### `addCHP(chp myCHP)`

Fügt BHKW zur Liste hinzu.

**Parameter:**
- `myCHP` (chp): BHKW-Objekt

##### `deleteCHP(string id)` / `deleteCHP(int index)`

Löscht BHKW (index ist 1-basiert).

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

##### `get(string id)` / `get(int index)`

Holt BHKW (index ist 1-basiert).

**Rückgabe:**
- `chp`: BHKW-Objekt

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

##### `getByID(string id, out int index)`

Holt BHKW und Index.

**Parameter:**
- `id` (string): BHKW-ID
- `index` (out int): 1-basierter Index

##### `getIndexByID(string id)`

Gibt Index des BHKWs zurück.

##### `contains(string id)` / `static contains(chps myCHPs, string id)`

Prüft ob ID in Liste enthalten ist.

##### `getNumCHPs()` / `getNumCHPsD()`

Gibt Anzahl der BHKWs zurück.

---

#### BHKW-Simulation

##### `static run(double t, double[] u, sensors mySensors, plant myPlant)`

Simuliert alle BHKWs der Anlage.

**Parameter:**
- `t` (double): Simulationszeit [d]
- `u` (double[]): Biogasströme aller Fermenter [m³/d]
  - Dimension: `n_digesters × n_gases`
- `mySensors` (sensors): Sensor-Objekt
- `myPlant` (plant): Anlagen-Objekt

**Rückgabe:**
- `double[]`: Elektrische Leistung pro BHKW + Biogas-Überschuss
  - Dimension: `n_chps + 1`
  - `[0...n_chps-1]`: Elektrische Leistung [kW]
  - `[n_chps]`: Biogas-Überschuss [m³/d]

**Standard-Gas-Aufteilung:** "threshold"

##### `static run(double t, double[] u, sensors mySensors, plant myPlant, string gas2chpsplittype)`

Erweiterte Version mit Aufteilungsstrategie.

**Parameter:**
- `gas2chpsplittype` (string): "threshold", "one2one", "fiftyfifty"

**Gas-Aufteilungsstrategien:**

1. **"threshold"**: Sequentielle Befüllung
   - BHKW 1 wird zuerst gefüllt bis Kapazität erreicht
   - Dann BHKW 2, usw.
   - Überschuss wird abgefackelt

2. **"one2one"**: 1:1-Zuordnung
   - Fermenter 1 → BHKW 1
   - Fermenter 2 → BHKW 2
   - usw.

3. **"fiftyfifty"**: Gleichverteilung
   - Biogas wird gleichmäßig auf alle BHKWs verteilt

**Funktionsablauf:**
```
1. Gesamtbiogas berechnen und aufteilen
2. Für jedes BHKW:
   - Zugewiesenes Biogas verbrennen
   - Elektrische Energie berechnen
   - In kW umrechnen
3. Überschuss berechnen
4. Energieproduktion messen
```

---

#### Berechnungen für gesamte Anlage

##### `getTotalPel()`

Berechnet Gesamt-Elektrische Leistung aller BHKWs.

**Rückgabe:**
- `physValue`: Summe der elektrischen Leistungen [kW]

**Formel:**
```
Pel_sum = Σ(Pel_i)
```

##### `getMeanEtaEl()`

Berechnet mittleren elektrischen Wirkungsgrad.

**Rückgabe:**
- `double`: Mittlerer Wirkungsgrad [100%]

**Formel:**
```
η_el_mean = Σ(η_el_i) / n_chps
```

##### `getElPowerEquiv(double volflowrateCH4, out double Pel_kWh_d)`

Berechnet elektrische Leistung aus Methanvolumenstrom.

**Parameter:**
- `volflowrateCH4` (double): Methanvolumenstrom [m³/d]
- `Pel_kWh_d` (out double): Elektrische Energie [kWh/d]

**Formel:**
```
Pel_theo = Q_ch4 × η_el_mean × H_ch4  [kWh/d]
Pel = min(Pel_theo, Pel_total × 24)   [kWh/d]
```

---

#### Datenmanagement

##### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest alle BHKWs aus XML.

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader

**Liest bis zum End-Tag `</chps>`**

##### `getParamsAsXMLString()`

Gibt alle BHKWs als XML-String zurück.

**Format:**
```xml
<chps>
    <chp id="chp_1">...</chp>
    <chp id="chp_2">...</chp>
</chps>
```

##### `print()`

Gibt alle BHKWs formatiert aus.

---

#### Parameter-Zugriff

##### `get_param_of_s(int index, string symbol)` / `get_param_of_s(string id, string symbol)`

Holt String-Parameter.

**Rückgabe:**
- `string`: Parameterwert

**Ausnahmen:**
- `exception`: Ungültiger Index/Unbekannte ID
- `exception`: Unbekannter Parameter
- `exception`: Konvertierung nicht möglich

##### `get_param_of_d(int index, string symbol)` / `get_param_of_d(string id, string symbol)`

Holt double-Parameter.

##### `get_param_of(int index, string symbol)` / `get_param_of(string id, string symbol)`

Holt physValue-Parameter als double.

##### `set_params_of(int index, string symbol, string value)`

Setzt String-Parameter.

##### `set_params_of(int index, string symbol, physValue value)`

Setzt physValue-Parameter.

##### `set_params_of(int index, string symbol, double value)`

Setzt double-Parameter.

##### `set_params_of(string id, string symbol, ...)`

Überladungen für ID-basierte Parametersetzer.

---

### Anwendungsbeispiele

#### BHKW-Liste verwalten

```csharp
// Liste erstellen
var chps = new chps();

// BHKWs hinzufügen
var chp1 = new chp("CHP1", "BHKW Hauptgebäude");
chp1.set_params_of("Pel", 500.0, "eta_el", 0.42);

var chp2 = new chp("CHP2", "BHKW Nebengebäude");
chp2.set_params_of("Pel", 250.0, "eta_el", 0.40);

chps.addCHP(chp1);
chps.addCHP(chp2);

// Anzahl
Console.WriteLine($"Anzahl BHKWs: {chps.getNumCHPs()}");

// Zugriff
var myCHP = chps.get("CHP1");
var myCHP2 = chps.get(2);  // 1-basiert!

// Iteration
foreach (var c in chps)
{
    Console.WriteLine($"{c.name}: {c.Pel.Value} kW");
}

// Gesamtleistung
var totalPel = chps.getTotalPel();
Console.WriteLine($"Gesamt Pel: {totalPel.Value} kW");

// Mittlerer Wirkungsgrad
double meanEta = chps.getMeanEtaEl();
Console.WriteLine($"Mittlerer η_el: {meanEta:P0}");
```

#### BHKW-Simulation durchführen

```csharp
var chps = new chps();
// ... BHKWs hinzufügen ...

var plant = new plant("plant.xml");
var sensors = new sensors();

// Biogasströme von 2 Fermentern (je 3 Gase)
double[] u = {
    5.0, 300.0, 150.0,   // Fermenter 1: H2, CH4, CO2 [m³/d]
    3.0, 250.0, 125.0    // Fermenter 2: H2, CH4, CO2 [m³/d]
};

// Simulation
double t = 1.0;  // Tag 1
double[] output = chps.run(t, u, sensors, plant, "threshold");

// Ausgabe interpretieren
int n_chps = plant.getNumCHPs();
for (int i = 0; i < n_chps; i++)
{
    Console.WriteLine($"BHKW {i+1}: {output[i]:F1} kW");
}
Console.WriteLine($"Biogas-Überschuss: {output[n_chps]:F1} m³/d");
```

#### Elektrische Leistung aus Methan berechnen

```csharp
var chps = new chps();
// ... BHKWs konfigurieren ...

// Verfügbares Methan
double Q_ch4 = 800.0;  // m³/d

// Elektrische Leistung berechnen
double Pel;
chps.getElPowerEquiv(Q_ch4, out Pel);

Console.WriteLine($"Aus {Q_ch4} m³/d CH4 werden {Pel:F1} kWh/d erzeugt");

// Vergleich mit Maximalleistung
var Pel_max = chps.getTotalPel().convertUnit("kWh/d");
Console.WriteLine($"Maximale Leistung: {Pel_max.Value:F1} kWh/d");
Console.WriteLine($"Auslastung: {Pel/Pel_max.Value:P0}");
```

#### Parameter für mehrere BHKWs setzen

```csharp
var chps = new chps("chps_config.xml");

// Parameter für BHKW 1 ändern
chps.set_params_of(1, "Pel", 550.0);
chps.set_params_of(1, "eta_el", 0.43);

// Parameter für BHKW mit ID "CHP2" ändern
chps.set_params_of("CHP2", "Ptherm", 600.0);

// Parameter abrufen
double pel = chps.get_param_of(1, "Pel");
string name = chps.get_param_of_s("CHP2", "name");

Console.WriteLine($"BHKW 1 Pel: {pel} kW");
Console.WriteLine($"BHKW 2 Name: {name}");
```

---

## TODOs

Laut Quellcode:

### In `chp.cs`

- Falls elektrischer Wirkungsgrad unbekannt, gibt es eine Formel aus AD Profit Calculator:
  ```
  η_el = 0.19138 × P_max^0.0868
  ```
  wobei P_max die maximale elektrische Leistung in kW ist.

### In `chps.cs`

- `run()`-Methode und `gas2chpsplittype` klären
- Die Idee soll sein, einen Biogasspeicher in der Größe der Gasphase der Fermenter zu modellieren, in den das produzierte Biogas reingeht und aus dem die BHKWs das Biogas in der entsprechenden Menge abgreifen
- Damit wird es möglich, erst wenn die Gasphase voll ist, das überschüssige Gas abzufackeln
- Stillzeiten der BHKWs sind damit besser modellierbar

---

## Best Practices

### 1. Wirkungsgrad-Wahl

```csharp
// Typische Werte für moderne BHKWs
// Kleine BHKWs (< 250 kW):
chp.set_params_of("eta_el", 0.38, "eta_therm", 0.50);

// Mittlere BHKWs (250-500 kW):
chp.set_params_of("eta_el", 0.40, "eta_therm", 0.48);

// Große BHKWs (> 500 kW):
chp.set_params_of("eta_el", 0.42, "eta_therm", 0.46);
```

### 2. Leistungsauslegung

```csharp
// Verhältnis P_therm/P_el typischerweise 1.0 - 1.5
double ratio = Ptherm / Pel;
if (ratio < 0.8 || ratio > 2.0)
{
    Console.WriteLine("Warnung: Ungewöhnliches Leistungsverhältnis!");
}

// Gesamtwirkungsgrad sollte > 80% sein
double eta_total = eta_el + eta_therm;
if (eta_total < 0.80)
{
    Console.WriteLine("Warnung: Niedriger Gesamtwirkungsgrad!");
}
```

### 3. Biogasqualität prüfen

```csharp
// Methananteil sollte > 50% sein für effizienten Betrieb
double ch4_content = biogas[BioGas.pos_ch4 - 1];
double total_biogas = ch4_content + biogas[BioGas.pos_co2 - 1];
double ch4_percent = ch4_content / total_biogas * 100;

if (ch4_percent < 50)
{
    Console.WriteLine($"Warnung: Niedriger CH4-Gehalt: {ch4_percent:F1}%");
}
```

### 4. Fehlerbehandlung

```csharp
try
{
    physValue P_el, P_therm;
    chp.burnBiogas(biogas, out P_el, out P_therm);
}
catch (exception ex)
{
    Console.WriteLine($"BHKW-Fehler: {ex.Message}");
    // Fallback: BHKW steht still
    P_el = new physValue(0, "kWh/d");
    P_therm = new physValue(0, "kWh/d");
}
```

---

## Siehe auch

- **biogas.BioGas**: Biogaszusammensetzung und Verbrennung
- **biogas.chemistry**: Heizwerte (H_ch4, H_h2)
- **biogas.plant**: Anlagenintegration
- **biogas.digesters**: Biogasproduktion
- **biogas.sensors**: Messdatenerfassung

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*