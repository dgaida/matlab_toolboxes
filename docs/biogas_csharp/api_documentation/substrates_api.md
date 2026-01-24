# Substrates Package API Documentation

## Übersicht

Das `biogas` Namespace (substrates) enthält Klassen zur Definition und Verwaltung von Substraten für Biogasanlagen, einschließlich ihrer physikochemischen Eigenschaften und Berechnungsmethoden.

## Klassen

### `substrate`

Definiert die physikochemischen Eigenschaften eines Substrats für Biogasanlagen.

#### Konstruktoren

##### `substrate()`

Erstellt ein initialisiertes Substrat mit Standardwerten.

##### `substrate(string id, string name)`

Erstellt ein Substrat mit ID und Name.

**Parameter:**
- `id` (string): ID des Substrats
- `name` (string): Name des Substrats

##### `substrate(substrate template)`

Erstellt eine Kopie des Template-Substrats.

##### `substrate(string XMLfile)`

Liest Substrat aus XML-Datei.

**Parameter:**
- `XMLfile` (string): Pfad zur XML-Datei

#### Eigenschaften

##### Identifikation

```csharp
public string id              // Eindeutige ID
public string name            // Beschreibender Name
public string substrate_class // Klasse (z.B. "Mais (GPS) (EK I)")
```

##### Weender-Analyse (Extended)

```csharp
private physValue RF          // Rohfaser [% TS]
private physValue RP          // Rohprotein [% TS]
private physValue RL          // Rohfett [% TS]
private physValue NDF         // Neutral Detergent Fiber [% TS]
private physValue ADF         // Acid Detergent Fiber [% TS]
private physValue ADL         // Acid Detergent Lignin [% TS]
```

##### Physikalische Eigenschaften

```csharp
private physValue COD_S       // CSB des Filtrats [gCOD/l]
private physValue SIin        // Lösliche Inerte [kgCOD/m³]
private physValue pH          // pH-Wert [-]
private physValue T           // Temperatur [°C]
private physValue TS          // Trockensubstanz [% FM]
private physValue VS          // Organische Trockensubstanz [% TS]
private physValue D_VS        // Abbaugrad [100 %]
```

##### Fettsäuren

```csharp
private physValue Sac         // Essigsäure + Acetat [g/l]
private physValue Sbu         // Buttersäure + Butyrat [g/l]
private physValue Spro        // Propionsäure + Propionat [g/l]
private physValue Sva         // Valeriansäure + Valerat [g/l]
```

##### Stickstoff und Puffer

```csharp
private physValue Snh4        // Ammonium-Stickstoff [g/l]
private physValue TAC         // Gesamtalkalinität [mmol/l]
```

##### Anaerobic Digestion Parameter

```csharp
private physValue kdis        // Desintegrationsrate [1/d]
private physValue khyd_ch     // Hydrolyse Kohlenhydrate [1/d]
private physValue khyd_pr     // Hydrolyse Proteine [1/d]
private physValue khyd_li     // Hydrolyse Lipide [1/d]
private physValue km_c4       // Max. Aufnahmerate C4 [1/d]
private physValue km_pro      // Max. Aufnahmerate Propionat [1/d]
private physValue km_ac       // Max. Aufnahmerate Acetat [1/d]
private physValue km_h2       // Max. Aufnahmerate Wasserstoff [1/d]
```

##### Wirtschaftlich

```csharp
private physValue cost        // Substratkosten [€/m³]
private physValue age         // Alter des Substrats [d]
```

##### Substratklassen

```csharp
public static List<string> classes  // Verfügbare Substratklassen
public bool ismanure                // Ist Gülle/Mist
public bool belongsToMaisDeckel     // Mais-/Getreidedeckel relevant
```

#### Wichtige Methoden

##### Datenverwaltung

###### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest Substratparameter aus XML.

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader

**Rückgabe:**
- `bool`: true bei Erfolg

###### `saveAsXML(string XMLfile)`

Speichert Substrat in XML-Datei.

###### `print()`

Gibt Substratparameter formatiert aus.

**Rückgabe:**
- `string`: Formatierter String

###### `copy()`

Erstellt eine Kopie des Substrats.

**Rückgabe:**
- `substrate`: Identische Kopie

##### Parameter setzen/abrufen

###### `set_params_of(params object[] symbols)`

Setzt Parameter.

**Syntax:**
```csharp
substrate.set_params_of("TS", 30.0, "VS", 90.0, "pH", 7.5);
```

###### `get_params_of(out object[] variables, params string[] symbols)`

Holt Parameter als Objekte.

**Ausnahmen:**
- `exception`: Unbekannter Parameter

##### Berechnete Eigenschaften

###### `calcXc()`

Berechnet partikulären CSB des Substrats.

**Rückgabe:**
- `physValueBounded`: Partikulärer CSB [kgCOD/m³]

**Formel:**
```
Xc = ρ * TS * (
    RP * ThODpr +           // Proteine
    RL * ThODli +           // Lipide
    ADL * ThODl +           // Lignin
    (RF + NfE - ADL) * ThODch  // Kohlenhydrate
)
```

###### `calcXcIN()`

Berechnet XcIN (Eingangs-CSB ohne Bakterien und lösliche Komponenten).

**Rückgabe:**
- `physValue`: XcIN [kgCOD/m³]

**Formel:**
```
XcIN = Xc - Xbacteria - Xmethan - COD_SX
```

###### `calcTOC()`

Berechnet Gesamtkohlenstoff (Total Organic Carbon).

**Rückgabe:**
- `physValueBounded`: TOC [kgTOC/m³]

###### `calcBMP()`

Berechnet theoretisches Biogasmethanpotential.

**Rückgabe:**
- `physValue`: BMP [l/g FM]

**Formel:**
```
BMP = TS * (
    RP * BMPpr +
    RL * BMPli +
    ((RF + NfE - NDF) + (NDF - ADL) * d) * BMPch
) * Vm
```

wobei `d` der Abbaugrad von Cellulose/Hemicellulose ist.

###### `calcGasQuality()`

Berechnet Gasqualität (Methangehalt im Biogas).

**Rückgabe:**
- `physValue`: Methangehalt [%]

###### `calcTheoreticalOxygenDemand()`

Berechnet theoretischen Sauerstoffbedarf.

**Rückgabe:**
- `physValue`: ThOD [kgCOD/kg FM]

##### f-Faktoren

###### `calcfCh_Xc()`, `calcfPr_Xc()`, `calcfLi_Xc()`, `calcfXI_Xc()`, `calcfSI_Xc()`, `calcfXp_Xc()`

Berechnen Fraktionen der Komponenten in Xc.

**Rückgabe:**
- `double`: Fraktion (0-1)

**Beispiel:**
```csharp
double fCh = substrate.calcfCh_Xc();  // Kohlenhydrat-Fraktion
double fPr = substrate.calcfPr_Xc();  // Protein-Fraktion
double fLi = substrate.calcfLi_Xc();  // Lipid-Fraktion
```

**Hinweis**: `fSI_Xc()` gibt immer 0 zurück (lösliche Inerte werden separat behandelt).

##### Stickstoff und pH

###### `calcSnh3()`

Berechnet Ammoniak aus Ammonium und pH.

**Rückgabe:**
- `physValue`: NH3 [kmol/m³]

**Formel:**
```
Snh3 = 10^(pH - 9.25) * Snh4
```

###### `calc_pH()`

Berechnet pH aus TAC und NH4.

**Rückgabe:**
- `physValue`: pH [-]

###### `calcShco3()`

Berechnet Bicarbonat aus TAC und Säuren.

**Rückgabe:**
- `physValue`: HCO3 [kmol/m³]

###### `calcSco2()`

Berechnet CO2 aus HCO3 und pH.

**Rückgabe:**
- `physValue`: CO2 [kmol/m³]

##### Elementaranalyse

###### `calcC()`, `calcH()`, `calcO()`, `calcN()`, `calcS()`

Berechnen Elementgehalte.

**Rückgabe:**
- `physValue`: Element [g/kg FM]

###### `calcCtoNratio()`

Berechnet C/N-Verhältnis.

**Rückgabe:**
- `double`: C/N-Verhältnis

**Optimal für Kompostierung**: 20-30:1

##### Energie

###### `calcQuantityOfHeatPerDay(physValue Q, physValue Tend)`

Berechnet benötigte Wärmemenge zum Aufheizen.

**Parameter:**
- `Q` (physValue): Volumenstrom [m³/d]
- `Tend` (physValue): Zieltemperatur [°C]

**Rückgabe:**
- `physValue`: Wärmeenergie [kWh/d]

**Formel:**
```
Qtherm = Q * c_th * (Tend - Tsubstrat)
```

##### Berechnete Ableitungen

###### `calcNfE()`, `calcCell()`, `calcHemCell()`, `calcADF()`, `calcNDF()`, `calcNFC()`

Berechnen verschiedene Faserfraktionen.

###### `calcSpecificHeat()`, `calcDensity()`

Berechnen thermische Eigenschaften.

###### `calcVS(physValue TS, physValue ash)`

Berechnet VS aus TS und Asche.

---

### `sludge`

Spezielle Substrat-Klasse für Gärrest (erbt von `substrate`).

#### Konstruktoren

##### `sludge(substrates mySubstrates, double[] Q, double TS)`

Erstellt Gärrest aus gewichtetem Mittel der Substrate.

**Parameter:**
- `mySubstrates` (substrates): Liste der Eingangsubstrate
- `Q` (double[]): Volumenströme [m³/d]
- `TS` (double): TS-Gehalt [% FM]

##### `sludge(substrates mySubstrates, double[] Q, double TS, double VS)`

Mit zusätzlicher VS-Spezifikation.

**Parameter:**
- `VS` (double): VS-Gehalt [% TS]

**Eigenschaften:**
- RF, RP, RL, ADL: Gewichtetes Mittel der Eingangsubstrate
- VS: Entweder aus Eingangsubstraten oder spezifiziert
- Dichte: 1000 kg/m³

---

### `substrates`

Liste von Substraten (erbt von `List<substrate>`).

#### Konstruktoren

##### `substrates()`

Erstellt leere Substratliste.

##### `substrates(substrate mySubstrate)`

Erstellt Liste mit einem Substrat.

##### `substrates(substrates template)`

Kopiert Substratliste.

##### `substrates(string XMLfile)`

Liest Substrate aus XML.

#### Methoden

##### Verwaltung

###### `addSubstrate(substrate mySubstrate)`

Fügt Substrat zur Liste hinzu.

###### `deleteSubstrate(string id)` / `deleteSubstrate(int index)`

Löscht Substrat.

###### `get(string id)` / `get(int index)`

Holt Substrat (index ist 1-basiert).

**Rückgabe:**
- `substrate`: Substrat-Objekt

**Ausnahmen:**
- `exception`: Unbekannte ID oder ungültiger Index

###### `getByName(string name, out string id, out int index)`

Sucht Substrat nach Name.

###### `getID(int index)` / `getName(int index)`

Holt ID oder Name (index 1-basiert).

###### `getNumSubstrates()`

Gibt Anzahl der Substrate zurück.

##### Gewichtete Berechnungen

###### `get_weighted_mean_of(double[] Q, string param, out physValue mean_param)`

Berechnet gewichtetes Mittel eines Parameters.

**Parameter:**
- `Q` (double[]): Volumenströme [m³/d]
- `param` (string): Parameter-Name
- `mean_param` (out physValue): Mittelwert

**Formel:**
```
mean = Σ(Q[i] * param[i]) / Σ(Q[i])
```

###### `get_weighted_sum_of(double[] Q, string param, out physValue w_sum)`

Berechnet gewichtete Summe.

###### `calcfFactors(double[] Q, out double fCH_XC, ...)`

Berechnet gewichtete Mittel aller f-Faktoren.

###### `calcHydrolysisParams(double[] Q, out double khyd_ch, ...)`

Berechnet gewichtete Hydrolyseparameter.

###### `calcDisintegrationParam(double[] Q)`

Berechnet gewichteten Desintegrationsparameter.

###### `calcMaxUptakeRateParams(double[] Q, ...)`

Berechnet gewichtete max. Aufnahmeraten.

##### Energie

###### `calcQuantityOfHeatPerDay(double[] Q, physValue Tend)`

Berechnet Wärmebedarf für alle Substrate.

**Rückgabe:**
- `physValue[]`: Wärmebedarf pro Substrat [kWh/d]

###### `calcSumQuantityOfHeatPerDay(double[] Q, physValue Tend)`

Berechnet Gesamt-Wärmebedarf.

**Rückgabe:**
- `physValue`: Summe [kWh/d]

##### Persistenz

###### `saveAsXML(string XMLfile)`

Speichert alle Substrate in XML.

###### `print()`

Gibt alle Substrate formatiert aus.

## Substratklassen (EEG-Kategorien)

### Einsatzstoffklasse 0 (EK 0)
- Getreideabfälle, Glycerin, Grünschnitt, etc.

### Einsatzstoffklasse I (EK I)
- Mais (GPS), Getreide, Gras, Körnermais, etc.

### Einsatzstoffklasse II (EK II)
- Gülle, Mist, Stroh, Landschaftspflegematerial

## Anwendungsbeispiele

### Substrat erstellen und konfigurieren

```csharp
// Neues Substrat erstellen
var maize = new substrate("maize_001", "Maissilage");

// Grundparameter setzen
maize.set_params_of(
    "TS", 32.0,          // 32% TS
    "VS", 95.0,          // 95% VS von TS
    "pH", 4.5,
    "RF", 20.0,          // Rohfaser
    "RP", 8.0,           // Rohprotein
    "RL", 3.0,           // Rohfett
    "ADL", 2.5,          // Lignin
    "D_VS", 0.75,        // 75% abbaubar
    "substrate_class", "Mais (GPS) (EK I)",
    "cost", 35.0         // 35 €/m³
);

// Berechnungen
double xc = maize.calcXc().Value;
double bmp = maize.calcBMP().Value;
double gasQuality = maize.calcGasQuality().Value;

Console.WriteLine($"CSB: {xc:F1} kgCOD/m³");
Console.WriteLine($"BMP: {bmp:F2} l/g FM");
Console.WriteLine($"Gasqualität: {gasQuality:F1} % CH4");

// Speichern
maize.saveAsXML("maize_silage.xml");
```

### Substratliste verwalten

```csharp
// Liste erstellen
var substrates = new substrates();

// Substrate hinzufügen
var maize = new substrate("maize", "Maissilage");
var manure = new substrate("manure", "Rindergülle");
substrates.addSubstrate(maize);
substrates.addSubstrate(manure);

// Oder aus XML laden
var loadedSubstrates = new substrates("substrates_config.xml");

// Zugriff
var substrate1 = substrates.get(1);  // 1-basiert
var substrate2 = substrates.get("manure");

// Iteration
foreach (var sub in substrates)
{
    Console.WriteLine($"{sub.name}: {sub.get_param_of("TS")} % TS");
}

// Speichern
substrates.saveAsXML("all_substrates.xml");
```

### Gewichtete Berechnungen

```csharp
var substrates = new substrates();
// ... Substrate hinzufügen ...

// Volumenströme definieren
double[] Q = {100.0, 50.0, 30.0};  // m³/d pro Substrat

// Gewichtetes Mittel berechnen
physValue meanTS;
substrates.get_weighted_mean_of(Q, "TS", out meanTS);
Console.WriteLine($"Mittlere TS: {meanTS.Value} {meanTS.Unit}");

// f-Faktoren berechnen
double fCh, fPr, fLi, fXI, fSI, fXp;
substrates.calcfFactors(Q, out fCh, out fPr, out fLi, 
                           out fXI, out fSI, out fXp);

Console.WriteLine($"f_Ch_Xc: {fCh:F3}");
Console.WriteLine($"f_Pr_Xc: {fPr:F3}");
Console.WriteLine($"f_Li_Xc: {fLi:F3}");
Console.WriteLine($"Summe: {(fCh + fPr + fLi + fXI + fSI + fXp):F3}");

// Hydrolyseparameter
double khyd_ch, khyd_pr, khyd_li;
substrates.calcHydrolysisParams(Q, out khyd_ch, 
                                   out khyd_pr, out khyd_li);

Console.WriteLine($"k_hyd,ch: {khyd_ch:F2} 1/d");
Console.WriteLine($"k_hyd,pr: {khyd_pr:F2} 1/d");
Console.WriteLine($"k_hyd,li: {khyd_li:F2} 1/d");
```

### Wärmebedarfsberechnung

```csharp
var substrates = new substrates("substrates.xml");
double[] Q = {100.0, 50.0};  // m³/d
var Tend = new physValue("T", 40.0, "°C");

// Wärmebedarf pro Substrat
physValue[] heatPerSubstrate = substrates.calcQuantityOfHeatPerDay(Q, Tend);
for (int i = 0; i < heatPerSubstrate.Length; i++)
{
    Console.WriteLine($"Substrat {i+1}: {heatPerSubstrate[i].Value:F1} kWh/d");
}

// Gesamt-Wärmebedarf
physValue totalHeat = substrates.calcSumQuantityOfHeatPerDay(Q, Tend);
Console.WriteLine($"Gesamt: {totalHeat.Value:F1} kWh/d");
```

### Gärrest erstellen

```csharp
// Eingangsubstrate
var substrates = new substrates();
substrates.addSubstrate(new substrate("maize", "Mais"));
substrates.addSubstrate(new substrate("manure", "Gülle"));

// Volumenströme
double[] Q = {80.0, 120.0};  // m³/d

// Gärrest mit 8% TS und gemitteltem VS
var sludge = new biogas.sludge(substrates, Q, 8.0);

Console.WriteLine($"Gärrest TS: {sludge.get_param_of("TS")} %");
Console.WriteLine($"Gärrest VS: {sludge.get_param_of("VS")} % TS");
```

### Elementaranalyse

```csharp
var substrate = new substrate("substrate.xml");

// Elementgehalte
double C = substrate.calcC().Value;
double H = substrate.calcH().Value;
double O = substrate.calcO().Value;
double N = substrate.calcN().Value;
double S = substrate.calcS().Value;

Console.WriteLine($"C: {C:F1} g/kg FM");
Console.WriteLine($"H: {H:F1} g/kg FM");
Console.WriteLine($"O: {O:F1} g/kg FM");
Console.WriteLine($"N: {N:F1} g/kg FM");
Console.WriteLine($"S: {S:F1} g/kg FM");

// C/N-Verhältnis
double cnRatio = substrate.calcCtoNratio();
Console.WriteLine($"C/N: {cnRatio:F1}");

// Summenformel (molar)
var c_mol = substrate.get_C_of();
var h_mol = substrate.get_H_of();
var o_mol = substrate.get_O_of();
var n_mol = substrate.get_N_of();
var s_mol = substrate.get_S_of();

Console.WriteLine($"Summenformel: C{c_mol.Value:F2}H{h_mol.Value:F2}" +
                  $"O{o_mol.Value:F2}N{n_mol.Value:F2}S{s_mol.Value:F2}");
```

### Gaspotentialberechnung

```csharp
var substrate = new substrate("maize_silage.xml");

// Biogaspotential
var bmp = substrate.calcBMP();
Console.WriteLine($"BMP: {bmp.Value:F2} l/g FM");

// Gasqualität
var gasQuality = substrate.calcGasQuality();
Console.WriteLine($"CH4-Gehalt: {gasQuality.Value:F1} %");

// Erwartete Gasproduktion pro Komponente
var ch4Exp = substrate.calcBMP();        // Methan
var co2Exp = substrate.calcCO2exp();     // CO2
var nh3Exp = substrate.calcNH3exp();     // NH3
var h2sExp = substrate.calcH2Sexp();     // H2S

Console.WriteLine($"Erwartete Produktion (Buswell):");
Console.WriteLine($"  CH4: {ch4Exp.Value:F2} {ch4Exp.Unit}");
Console.WriteLine($"  CO2: {co2Exp.Value:F2} {co2Exp.Unit}");
Console.WriteLine($"  NH3: {nh3Exp.convertUnit("ml/g").Value:F2} ml/g FM");
Console.WriteLine($"  H2S: {h2sExp.convertUnit("ml/g").Value:F2} ml/g FM");
```

## XML-Format

```xml
<?xml version="1.0" encoding="utf-8"?>
<substrate id="maize_001">
    <name>Maissilage</name>
    <substrate_class>Mais (GPS) (EK I)</substrate_class>
    
    <Weender>
        <physValue symbol="RF">
            <value>20.0</value>
            <unit>% TS</unit>
        </physValue>
        <physValue symbol="RP">
            <value>8.0</value>
            <unit>% TS</unit>
        </physValue>
        <!-- weitere Weender-Parameter -->
    </Weender>
    
    <Phys>
        <physValue symbol="TS">
            <value>32.0</value>
            <unit>% FM</unit>
        </physValue>
        <physValue symbol="VS">
            <value>95.0</value>
            <unit>% TS</unit>
        </physValue>
        <physValue symbol="pH">
            <value>4.5</value>
            <unit>-</unit>
        </physValue>
        <!-- weitere physikalische Parameter -->
    </Phys>
    
    <AD>
        <physValue symbol="kdis">
            <value>0.25</value>
            <unit>1/d</unit>
        </physValue>
        <!-- weitere AD-Parameter -->
    </AD>
    
    <physValue symbol="cost">
        <value>35.0</value>
        <unit>€/m^3</unit>
    </physValue>
</substrate>
```

## Hinweise

- **Indexierung**: Bei `substrates`-Liste ist Index 1-basiert
- **Einheiten**: TS in % FM, VS in % TS, CSB in kgCOD/m³
- **Berechnung**: Viele Parameter werden automatisch berechnet wenn nicht gesetzt
- **f-Faktoren**: Summe sollte 1 ergeben (wird automatisch sichergestellt)
- **Gewichtung**: Bei Q=0 wird arithmetisches Mittel verwendet
- **Validierung**: Berechnete Werte werden auf Plausibilität geprüft

## Best Practices

1. **Parameter-Hierarchie**: RF, RP, RL, ADL, VS, TS sind Basis; Rest wird berechnet
2. **Messung vs. Berechnung**: Gemessene Werte bevorzugen, berechnete als Fallback
3. **Validierung**: Nach XML-Import Parameter prüfen
4. **Substratklasse**: Korrekte EEG-Klasse für Bonus-Berechnungen wichtig
5. **Alter**: Für Gülle/Mist Alter angeben (beeinflusst Bakteriengehalt)
