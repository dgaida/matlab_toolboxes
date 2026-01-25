# Digesters Package API Documentation

## Übersicht

Das `biogas.digesters` Namespace enthält Klassen zur Modellierung und Simulation von Fermentern (Digestern) in Biogasanlagen. Es umfasst die Definition von Fermentern, deren Heizungen und Rührwerken.

---

## Klasse: `digester`

Definiert einen Fermenter auf einer Biogasanlage. Jeder Fermenter hat eine Heizung (die ein- oder ausgeschaltet sein kann) und wird durch ein Anaerobic Digestion Model (ADM) modelliert.

### Konstruktoren

#### `digester()`

Erstellt einen initialisierten Fermenter mit Standardwerten, aber ohne Name und ID.

#### `digester(string id, string name)`

Erstellt einen Fermenter mit ID und Name und Standardwerten.

**Parameter:**
- `id` (string): Eindeutige ID des Fermenters
- `name` (string): Beschreibender Name

**Standardwerte:**
- Vtot: 3500 m³
- Vliq: 3000 m³
- Vliq_max: 3000 m³
- Vgas: 400 m³
- Vgas_max: 400 m³
- T: 40 °C
- Durchmesser: 20 m
- k_wall: 0.4 W/(m²·K)
- k_roof: 0.25 W/(m²·K)
- k_ground: 1.9 W/(m²·K)
- Heizungseffizienz: 0.4 (immer eingeschaltet)

#### `digester(string XMLfile)`

Liest Fermenter aus XML-Datei.

**Parameter:**
- `XMLfile` (string): Pfad zur XML-Datei

#### `digester(ref XmlTextReader reader, string id)`

Konstruktor für das Lesen aus XML (wird von `digesters`-Klasse verwendet).

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader
- `id` (string): ID des Fermenters

---

### Eigenschaften

#### Identifikation

```csharp
public string id              // Eindeutige ID (read-only)
public string name            // Beschreibender Name (read-only)
```

#### Volumina

```csharp
public physValue Vliq         // Aktuelles Flüssigkeitsvolumen [m³]
public physValue Vliqmax      // Max. Flüssigkeitsvolumen [m³]
public physValue Vgas         // Aktuelles Gasraumvolumen [m³]
public physValue Vgasmax      // Max. Gasraumvolumen [m³]
private physValue Vtot        // Gesamtvolumen [m³]
```

#### Geometrie

```csharp
public physValue diam         // Durchmesser [m] (zylindrischer Fermenter)
public physValue height       // Höhe des Tanks [m] (berechnet)
public physValue h_roof       // Max. Höhe des Daches [m] (berechnet)
public physValue Awall        // Wandfläche [m²] (berechnet)
public physValue Aroof        // Dachfläche [m²] (berechnet, Kugelkappe)
public physValue Aground      // Bodenfläche [m²] (berechnet)
```

**Berechnete Geometrie:**

```csharp
// Tankhöhe
height = 4 × Vliq / (π × diam²)

// Dachhöhe (Kugelkappe)
h_roof = komplexe Formel basierend auf Vgas und diam

// Wandfläche
Awall = π × diam × height

// Dachfläche (Kugelkalotte)
Aroof = π × (diam²/4 + h_roof²)

// Bodenfläche
Aground = π × diam² / 4
```

#### Thermische Eigenschaften

```csharp
public physValue T            // Fermentertemperatur [°C]
public physValue k_wall       // Wärmedurchgangskoeff. Wand [W/(m²·K)]
public physValue k_roof       // Wärmedurchgangskoeff. Dach [W/(m²·K)]
public physValue k_ground     // Wärmedurchgangskoeff. Boden [W/(m²·K)]
```

**Typische Werte für k_wall:** 0.3 - 1.0 W/(m²·K)

#### Akkumulation

```csharp
public double accum_s         // Akkumulation löslicher Stoffe [100%]
public double accum_x         // Akkumulation partikulärer Stoffe [100%]
```

- 1.0 = keine Akkumulation
- 0.0 = totale Akkumulation (kein Auslauf)

#### Komponenten

```csharp
public heating heating        // Heizung des Fermenters
public stirrers mixers        // Rührwerke des Fermenters
public ADM AD_Model           // Anaerobic Digestion Model
```

#### Statische Eigenschaften

```csharp
public static physValue kp    // Proportionale Regelkonstante für Gasausgleich
                              // Standard: 10000 m³/(m³·d)
```

---

### Methoden

#### Datenmanagement

##### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest Parameter aus XML-Reader.

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader

**Rückgabe:**
- `bool`: true bei Erfolg

##### `getParamsAsXMLString()`

Gibt Parameter als XML-String zurück.

**Rückgabe:**
- `string`: XML-formatierter String

**XML-Format:**
```xml
<digester id="fermenter_1">
    <name>Hauptfermenter</name>
    <physValue symbol="Vtot">...</physValue>
    <physValue symbol="Vliq">...</physValue>
    <!-- weitere Parameter -->
    <heating>...</heating>
    <stirrers>...</stirrers>
</digester>
```

##### `print()`

Gibt formatierte Konsolenausgabe zurück.

**Rückgabe:**
- `string`: Formatierter String

**Beispielausgabe:**
```
   ----------   DIGESTER:   Hauptfermenter   ----------   
id: fermenter_1
  Vtot= 3500 m³			Vliq= 3000 m³			Vgas= 400 m³
  Vliqmax= 3000 m³		Vgasmax= 400 m³			T= 40.0 °C
  diam= 20.0 m			hwall= 9.5 m			hroof= 1.3 m
  Awall= 597.9 m²		Aroof= 319.2 m²			Aground= 314.2 m²
  k_wall= 0.40 W/(m²·K)	k_roof= 0.25 W/(m²·K)	k_ground= 1.90 W/(m²·K)
  accum_x= 1.00			accum_s= 1.00
   ----------   HEATING   ----------   
...
   ----------   STIRRER   ----------   
...
```

##### `set_params_of(params object[] symbols)`

Setzt Parameter.

**Syntax:**
```csharp
digester.set_params_of(
    "Vliq", 3000.0,
    "T", 40.0,
    "k_wall", 0.4
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

#### ADM-bezogene Methoden

##### `getADMparams(double t, sensors mySensors, substrates mySubstrates, double[] substrate_network_digester)`

Gibt ADM-Parameter zurück, abhängig von der aktuellen Substratfütterung.

**Parameter:**
- `t` (double): Aktuelle Simulationszeit [d]
- `mySensors` (sensors): Sensor-Objekt
- `mySubstrates` (substrates): Substrat-Liste
- `substrate_network_digester` (double[]): Substrat-Netzwerk für Fermenter

**Rückgabe:**
- `double[]`: ADM-Parametervektor

**Abhängige Parameter:**
- XC-Fraktionen (fCH_XC, fLI_XC, ...)
- Desintegrationsrate: kdis
- Hydrolyseraten: khyd_ch, khyd_pr, khyd_li

**Achtung:** Ändert die Werte der ADM-Parameter!

##### `getADMparams(double t, double[] Q, double QdigesterIn, substrates mySubstrates)`

Alternative Methode mit direkter Angabe der Volumenströme.

**Parameter:**
- `t` (double): Simulationszeit [d]
- `Q` (double[]): Substratströme [m³/d]
- `QdigesterIn` (double): Gesamt-Volumenstrom in Fermenter [m³/d]
- `mySubstrates` (substrates): Substrat-Liste

**Rückgabe:**
- `double[]`: ADM-Parametervektor

**Hinweis:** Funktioniert nur wenn Simulation bei t=0 startet.

##### `getDefaultADMparams()`

Gibt Standard-ADM-Parameter zurück (nicht substratabhängig).

**Rückgabe:**
- `double[]`: ADM-Parametervektor

**Hinweis:** Wenn `getADMparams()` zuvor aufgerufen wurde, werden die zuletzt aktualisierten Parameter zurückgegeben.

##### `getADMparameter(int pos, out double value)`

Holt einzelnen ADM-Parameter an Position.

**Parameter:**
- `pos` (int): Position (1-basiert, 1 bis ADMparams.numParams)
- `value` (out double): Parameterwert

**Ausnahmen:**
- `exception`: Ungültige Position

##### `setADMparameter(int pos, double value)`

Setzt einzelnen ADM-Parameter.

**Parameter:**
- `pos` (int): Position (1-basiert)
- `value` (double): Neuer Wert

**Ausnahmen:**
- `exception`: Ungültige Position

##### `setADMparameter(int pos1, double value1, int pos2, double value2)`

Setzt zwei ADM-Parameter gleichzeitig.

##### `setDefaultADMparams(double[] ADM1params)`

Setzt Standard-ADM-Parameterdvektor.

**Parameter:**
- `ADM1params` (double[]): ADM-Parametervektor

**Ausnahmen:**
- `exception`: Vektor hat nicht die korrekte Dimension

##### `get_gui_handle()` / `set_gui_handle(double gui_handle)`

Für MATLAB-Integration (GUI-Handle des ADM-Blocks).

---

#### Energieberechnungen

##### `calcHeatLossDueToRadiation(physValue pT_ambient)`

Berechnet Wärmeverlust durch Strahlung durch die Fermenteroberfläche.

**Parameter:**
- `pT_ambient` (physValue): Umgebungstemperatur [°C]

**Rückgabe:**
- `physValue`: Wärmeverlust [W]

**Formel:**
```
P_rad_wall = Awall × k_wall × (T_digester - T_ambient)
P_rad_roof = Aroof × k_roof × (T_digester - T_ambient)
P_rad_ground = Aground × k_ground × (T_digester - T_ambient)
P_rad_sum = P_rad_wall + P_rad_roof + P_rad_ground
```

**Hinweis:** Temperaturdifferenz wird in Kelvin berechnet!

##### `calcThermalEnergyBalance(double[] Q, substrates mySubstrates, physValue T_ambient, sensors mySensors)`

Berechnet thermische Energiebilanz des Fermenters.

**Parameter:**
- `Q` (double[]): Substratfütterung [m³/d]
- `mySubstrates` (substrates): Substrat-Liste
- `T_ambient` (physValue): Umgebungstemperatur [°C]
- `mySensors` (sensors): Sensor-Objekt

**Rückgabe:**
- `double`: Energiebilanz [kWh/d]

**Berücksichtigte Prozesse:**

**Wärmesenken (negativ):**
1. Substrataufheizung
2. Strahlungsverluste

**Wärmequellen (positiv):**
1. Mikrobiologische Aktivität
2. Rührwerksdissipation

**Formel:**
```
balance = -P_substrates - P_radiation + P_micros + P_stirrer
```

**Ausnahmen:**
- `exception`: Q.Length < mySubstrates.Count
- `exception`: Energieberechnung fehlgeschlagen

##### `calcThermalEnergyBalance(double[] Q, substrates mySubstrates, physValue T_ambient, sensors mySensors, out physValue Psubsheat, out physValue Pradloss, out physValue Pmicros, out physValue Pstirdiss)`

Erweiterte Version mit einzelnen Komponenten als Ausgabe.

**Ausgabeparameter:**
- `Psubsheat` (out physValue): Substrataufheizung [kWh/d]
- `Pradloss` (out physValue): Strahlungsverluste [kWh/d]
- `Pmicros` (out physValue): Mikrobiologische Wärme [kWh/d]
- `Pstirdiss` (out physValue): Rührwerksdissipation [kWh/d]

##### `calcHeatPower(double[] Q, substrates mySubstrates, physValue T_ambient, sensors mySensors)`

Berechnet thermische/elektrische Leistung der Heizung.

**Rückgabe:**
- `double`: Benötigte Heizleistung [kWh/d]

**Logik:**
- Wenn Bilanz < 0: Heizung kompensiert Verlust
- Wenn Bilanz ≥ 0: Rückgabe = 0 (keine Heizung nötig)

**Ausnahmen:**
- `exception`: Q.Length != mySubstrates.Count
- `exception`: Effizienz ist Null

##### `calcCostsForHeating(physValue pP_loss, double sell_heat, double cost_elEnergy)`

Berechnet Heizkosten.

**Parameter:**
- `pP_loss` (physValue): Wärmeverlust [W oder kWh/d]
- `sell_heat` (double): Virtueller Preis für Wärmeverkauf [€/kWh]
- `cost_elEnergy` (double): Stromkosten [€/kWh]

**Rückgabe:**
- `double`: Kosten [€/d]

**Logik:**
- Thermische Heizung: Entgangener Gewinn (verkaufte Wärme)
- Elektrische Heizung: Stromkosten
- Wenn pP_loss < 0: Rückgabe = 0 (keine Kosten)

**Ausnahmen:**
- `exception`: Effizienz ist Null

##### `calcStirrerPower(sensors mySensors)`

Berechnet elektrische Leistung aller Rührwerke.

**Parameter:**
- `mySensors` (sensors): Sensor-Objekt (für TS-Messung)

**Rückgabe:**
- `physValue`: Elektrische Leistung [kWh/d]

**Ausnahmen:**
- `exception`: Berechnung fehlgeschlagen

##### `calcStirrerDissipation(sensors mySensors)`

Berechnet dissipierte Leistung der Rührwerke (Wärmequelle).

**Rückgabe:**
- `physValue`: Dissipationsleistung [kWh/d]

**Hinweis:** Mechanische Leistung = Dissipierte Leistung (wird vollständig in Wärme umgewandelt).

---

#### Prozessparameter

##### `static calcTS(double[] x, substrates mySubstrates, double[] Q)`

Berechnet TS-Gehalt im Fermenter aus ADM-Zustandsvektor.

**Parameter:**
- `x` (double[]): ADM-Zustandsvektor
- `mySubstrates` (substrates): Substrat-Liste oder Schlamm
- `Q` (double[]): Substratströme [m³/d]

**Rückgabe:**
- `physValue`: TS-Gehalt [% FM]

**Formel:**
```
TS = ρ_substrate × TS_digester × (VS_digester/VS_substrate) × COD_factor
```

**Ausnahmen:**
- `exception`: Q.Length < mySubstrates.Count
- `exception`: TS-Wert außerhalb der Grenzen

**Wichtig:** Berechnet nur Steady-State korrekt, da Aschegehalt im Fermenter nicht berücksichtigt wird!

##### `static calcVS(double[] x, substrates mySubstrates, double[] Q, out physValue TS)`

Berechnet VS-Gehalt im Fermenter.

**Rückgabe:**
- `physValue`: VS-Gehalt [% TS]

**Annahme:** Aschegehalt im Fermenter = Aschegehalt der Substrate

##### `static calcVS(double[] x, substrates mySubstrates, double[] Q)`

Vereinfachte Version ohne TS-Ausgabe.

##### `static calcAsh(double[] x, string digester_id, sensors mySensors, substrates mySubstrates, double[] Q, plant myPlant)`

Berechnet Aschegehalt im Fermenter.

**Rückgabe:**
- `physValue`: Asche [% TS]

##### `calcOLR(double[] x, substrates mySubstrates, double[] Q, double Qsum)`

Berechnet Organische Raumbelastung (OLR).

**Parameter:**
- `x` (double[]): ADM-Zustandsvektor
- `mySubstrates` (substrates): Substrat-Liste
- `Q` (double[]): Substratströme [m³/d]
- `Qsum` (double): Gesamt-Volumenstrom [m³/d]

**Rückgabe:**
- `physValue`: OLR [kgVS/(m³·d)]

**Formel:**
```
OLR = Qsum × ρ × VS / Vliq
```

##### `calcCH4Yield(double[] x, physValue pQ, physValue pVS, physValue pTS, physValue prho)`

Berechnet Methanausbeute.

**Parameter:**
- `x` (double[]): ADM-Zustandsvektor
- `pQ` (physValue): Gesamtzulauf [m³/d]
- `pVS` (physValue): VS-Gehalt [% TS]
- `pTS` (physValue): TS-Gehalt [% FM]
- `prho` (physValue): Dichte [kg/m³]

**Rückgabe:**
- `physValue`: CH4-Ausbeute [m³/kg VS]

**Formel:**
```
CH4_yield = Qgas_ch4 / (Q × ρ × VS)
```

##### `calcCH4ProductionRate(double[] x)`

Berechnet volumetrische Methanproduktionsrate.

**Rückgabe:**
- `physValue`: Produktionsrate [1/d]

**Formel:**
```
CH4_rate = Qgas_ch4 / Vliq
```

##### `static calcHRT(double[] Q, physValue Vliq)`

Berechnet Hydraulische Verweilzeit (HRT).

**Parameter:**
- `Q` (double[]): Volumenströme [m³/d]
- `Vliq` (physValue): Flüssigkeitsvolumen [m³]

**Rückgabe:**
- `physValue`: HRT [d]

**Formel:**
```
HRT = Vliq / Σ(Q)
```

**Überladungen:**
```csharp
public static physValue calcHRT(physValue[] Q, physValue Vliq)
public static physValue calcHRT(double Q, physValue Vliq)
public static physValue calcHRT(physValue pQ, physValue pVliq)
```

---

### Anwendungsbeispiele

#### Fermenter erstellen und konfigurieren

```csharp
// Neuer Fermenter mit Standardwerten
var fermenter = new digester("F1", "Hauptfermenter");

// Parameter anpassen
fermenter.set_params_of(
    "Vliq", 2500.0,
    "Vgas", 500.0,
    "T", 42.0,
    "k_wall", 0.35
);

// Heizung konfigurieren
fermenter.heating.set_params_of("eta", 0.85, "status", true);

// Rührwerk hinzufügen
var stirrer = new stirrer("S1", 0);
stirrer.set_params_of(
    "eta_mixer", 0.7,
    "diameter", 3.5,
    "rotspeed", 0.2,
    "runtime", 20
);
fermenter.mixers.addStirrer(stirrer);

// Speichern
fermenter.saveAsXML("fermenter_config.xml");
```

#### Energiebilanz berechnen

```csharp
var fermenter = new digester("fermenter.xml");
var substrates = new substrates("substrates.xml");
var sensors = new sensors();

// Substratfütterung
double[] Q = {80.0, 120.0};  // m³/d

// Umgebungstemperatur
var T_ambient = new physValue(10, "°C");

// Einzelne Komponenten
physValue P_subs, P_rad, P_micro, P_stirr;
double balance = fermenter.calcThermalEnergyBalance(
    Q, substrates, T_ambient, sensors,
    out P_subs, out P_rad, out P_micro, out P_stirr
);

Console.WriteLine($"Thermische Energiebilanz: {balance:F1} kWh/d");
Console.WriteLine($"  Substrataufheizung: {P_subs.Value:F1} kWh/d");
Console.WriteLine($"  Strahlungsverluste: {P_rad.Value:F1} kWh/d");
Console.WriteLine($"  Mikrobiologie: {P_micro.Value:F1} kWh/d");
Console.WriteLine($"  Rührwerk: {P_stirr.Value:F1} kWh/d");

// Benötigte Heizleistung
double heatPower = fermenter.calcHeatPower(Q, substrates, T_ambient, sensors);
Console.WriteLine($"Heizleistung: {heatPower:F1} kWh/d");

// Kosten berechnen
double costs = fermenter.calcCostsForHeating(
    new physValue(heatPower, "kWh/d"),
    0.08,  // 8 ct/kWh Wärmeverkauf
    0.25   // 25 ct/kWh Strom
);
Console.WriteLine($"Heizkosten: {costs:F2} €/d");
```

#### Prozessparameter überwachen

```csharp
var fermenter = new digester("fermenter.xml");
var substrates = new substrates("substrates.xml");

// ADM-Zustand (Beispiel)
double[] x = new double[ADM.n_state];
// ... x wird durch Simulation gefüllt ...

// Substratfütterung
double[] Q = {100.0, 50.0};
double Q_total = 150.0;

// TS und VS berechnen
physValue TS;
physValue VS = digester.calcVS(x, substrates, Q, out TS);

Console.WriteLine($"TS: {TS.Value:F2} % FM");
Console.WriteLine($"VS: {VS.Value:F2} % TS");

// OLR berechnen
physValue OLR = fermenter.calcOLR(x, substrates, Q, Q_total);
Console.WriteLine($"OLR: {OLR.Value:F2} {OLR.Unit}");

// HRT berechnen
physValue HRT = digester.calcHRT(Q, fermenter.Vliq);
Console.WriteLine($"HRT: {HRT.Value:F1} d");

// Methanausbeute
var VS_percent = new physValue(95, "% TS");
var TS_percent = new physValue(8, "% FM");
var rho = new physValue(1000, "kg/m³");
var Q_phys = new physValue(Q_total, "m³/d");

physValue CH4_yield = fermenter.calcCH4Yield(
    x, Q_phys, VS_percent, TS_percent, rho
);
Console.WriteLine($"CH4-Ausbeute: {CH4_yield.Value:F3} m³/kg VS");
```

#### ADM-Parameter verwalten

```csharp
var fermenter = new digester("F1", "Hauptfermenter");

// Standard-Parameter abrufen
double[] adm_params = fermenter.getDefaultADMparams();
Console.WriteLine($"ADM hat {adm_params.Length} Parameter");

// Einzelnen Parameter ändern
int pos_kdis = 1;  // Position der Desintegrationsrate
fermenter.setADMparameter(pos_kdis, 0.3);

// Mehrere Parameter gleichzeitig
int pos_khyd_ch = 2;
int pos_khyd_pr = 3;
fermenter.setADMparameter(
    pos_khyd_ch, 0.25,
    pos_khyd_pr, 0.20
);

// Parameter abrufen
double kdis;
fermenter.getADMparameter(pos_kdis, out kdis);
Console.WriteLine($"Desintegrationsrate: {kdis} 1/d");

// Substratabhängige Parameter berechnen
var sensors = new sensors();
var substrates = new substrates("substrates.xml");
double[] substrate_network = {80.0, 120.0};

double[] updated_params = fermenter.getADMparams(
    0.0,  // t = 0
    sensors,
    substrates,
    substrate_network
);
```

---

## Klasse: `digesters`

Liste von Fermentern (erbt von `List<digester>`).

### Konstruktoren

```csharp
public digesters()  // Leere Liste
```

### Methoden

#### Verwaltung

##### `addDigester(digester myDigester)`

Fügt Fermenter zur Liste hinzu.

##### `deleteDigester(string id)` / `deleteDigester(int index)`

Löscht Fermenter (index ist 1-basiert).

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

##### `get(string id)` / `get(int index)`

Holt Fermenter (index ist 1-basiert).

**Rückgabe:**
- `digester`: Fermenter-Objekt

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

##### `getByID(string id, out int index)`

Holt Fermenter und Index.

**Parameter:**
- `id` (string): Fermenter-ID
- `index` (out int): 1-basierter Index

##### `getIndexByID(string id)`

Gibt Index des Fermenters zurück.

##### `getByName(string name, out string id, out int index, out digester myDigester)`

Sucht Fermenter nach Name.

**Ausnahmen:**
- `exception`: Unbekannter Name

##### `contains(string id)`

Prüft ob ID in Liste enthalten ist.

##### `getNumDigesters()` / `getNumDigestersD()`

Gibt Anzahl der Fermenter zurück.

#### Energieberechnungen

##### `calcCostsForHeating(string digester_id, physValue pP_loss, double sell_heat, double cost_elEnergy)`

Berechnet Heizkosten für spezifischen Fermenter.

##### `calcHeatPower(string digester_id, double[] Q, substrates mySubstrates, physValue T_ambient, sensors mySensors)`

Berechnet Heizleistung für spezifischen Fermenter.

##### `calcThermalEnergyBalance(string digester_id, double[] Q, substrates mySubstrates, physValue T_ambient, sensors mySensors)`

Berechnet thermische Energiebilanz für spezifischen Fermenter.

#### ADM-bezogene Methoden

##### `getADMparams(int index, double t, sensors mySensors, substrates mySubstrates, double[] substrate_network_digester)`

Holt ADM-Parameter für Fermenter (index ist 1-basiert).

##### `getDefaultADMparams(string id)` / `getDefaultADMparams(int index)`

Holt Standard-ADM-Parameter.

##### `getADMparameter(string id, int pos, out double value)` / `getADMparameter(int index, int pos, out double value)`

Holt einzelnen ADM-Parameter.

##### `setADMparameter(string id, int pos, double value)` / `setADMparameter(int index, int pos, double value)`

Setzt einzelnen ADM-Parameter.

##### `setADMparameter(int index, int pos1, double value1, int pos2, double value2)`

Setzt zwei ADM-Parameter gleichzeitig.

##### `setDefaultADMparams(string id, double[] ADM1params)` / `setDefaultADMparams(int index, double[] ADM1params)`

Setzt Standard-ADM-Parametervektor.

##### `get_gui_handle(int index)` / `set_gui_handle(int index, double gui_handle)`

Für MATLAB-Integration.

#### Parameter-Zu