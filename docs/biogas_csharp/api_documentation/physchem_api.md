## Übersicht

Das `physchem` Paket enthält grundlegende Klassen für physikochemische Berechnungen im Kontext der Biogasanlagen-Simulation. Es umfasst drei Hauptnamespaces:

- **`biogas.chemistry`**: Chemische Berechnungen (Elementzusammensetzung, COD, Buswell-Gleichung)
- **`science`**: Physikalische Werte mit Einheiten (`physValue`, `physValueBounded`)
- **`science.math`**: Mathematische Hilfsfunktionen
- **`toolbox`**: Allgemeine Hilfsfunktionen (Exceptions, XML-Interface)

---

## Namespace: biogas.chemistry

### Klasse: `chemistry`

Definiert chemische Berechnungsmethoden für Biogasanlagen.

#### Konstanten

```csharp
// Molare Massen [g/mol]
private static physValue mol_mass_C = 12  // Kohlenstoff
private static physValue mol_mass_H = 1   // Wasserstoff
private static physValue mol_mass_O = 16  // Sauerstoff
private static physValue mol_mass_N = 14  // Stickstoff
private static physValue mol_mass_S = 32  // Schwefel

// Vordefinierte COD-Werte [gCOD/mol]
private static physValue COD_Sac   // Essigsäure
private static physValue COD_Spro  // Propionsäure
private static physValue COD_Sbu   // Buttersäure
private static physValue COD_Sva   // Valeriansäure

// Theoretische Sauerstoffbedarfe [gCOD/g]
public static physValue ThODch  // Kohlenhydrate
public static physValue ThODpr  // Proteine
public static physValue ThODli  // Lipide
public static physValue ThODl   // Lignin

// Spezifische Volumina [m³/kg] bei 1.013 bar, 21°C
private static physValue Vch4 = 1.48   // Methan
private static physValue Vco2 = 0.547  // CO2
private static physValue Vnh3 = 1.411  // Ammoniak
private static physValue Vh2s = 0.699  // Schwefelwasserstoff

// Heizwerte [kWh/m³]
public static physValue Hch4 = 39.8  // Methan (Brennwert)
public static physValue Hh2 = 11.7   // Wasserstoff (Brennwert)

// Weitere Konstanten
public static physValue pAtm = 1.04 bar        // Atmosphärendruck
public static physValue R = 0.08314 m³·bar/(kmol·K)  // Gaskonstante
public static physValue Vm = 24.465 l/mol      // Molvolumen (25°C)
```

#### Säure-Dissoziationskonstanten (pKs-Werte)

```csharp
public static double pK_S_ac = 4.76   // Essigsäure
public static double pK_S_pro = 4.88  // Propionsäure
public static double pK_S_bu = 4.82   // Buttersäure
public static double pK_S_va = 4.82   // Valeriansäure
```

---

### Elementzusammensetzung

#### `get_CHONS_of(string molecule, out physValue C, out physValue H, out physValue O, out physValue N, out physValue S)`

Gibt die elementare Zusammensetzung eines Moleküls zurück.

**Parameter:**
- `molecule` (string): Molekül-Symbol (z.B. "Sac", "Xpr", "Sch4")
- `C, H, O, N, S` (out physValue): Mol-Anteile [mol/mol]

**Unterstützte Moleküle:**

```csharp
// Reine Elemente
"C", "H", "O", "N", "S"

// Flüchtige Fettsäuren (VFAs)
"Sac", "Shac", "Sac_"      // Essigsäure/Acetat (C2H4O2)
"Spro", "Shpro", "Spro_"   // Propionsäure/Propionat (C3H6O2)
"Sbu", "Shbu", "Sbu_"      // Buttersäure/Butyrat (C4H8O2)
"Sva", "Shva", "Sva_"      // Valeriansäure/Valerat (C5H10O2)

// Gase
"Sch4"   // Methan (CH4)
"Sco2"   // CO2
"So2"    // O2
"Sh2"    // H2
"Sh2s"   // H2S
"Snh3"   // NH3
"Snh4"   // NH4
"Shco3"  // HCO3

// Substrate-Komponenten (löslich)
"Ssu"  // Monosaccharide (C6H12O6)
"Saa"  // Aminosäuren (Mittelwert von 20 proteinogenen AS)
"Sfa"  // Langkettige Fettsäuren (Mittelwert)

// Substrate-Komponenten (partikulär)
"Xch"     // Kohlenhydrate (C6H10O5)
"Xpr"     // Proteine (C5H7O2N)
"Xli"     // Lipide (C57H104O6)
"Lignin"  // Lignin (C10.92H14.24O5.76)

// Biomasse (ADM1)
"Xbio", "Xsu", "Xaa", "Xfa", "Xc4", "Xpro", "Xac", "Xh2"  // C5H7O2N
```

**Ausnahmen:**
- `exception`: Unbekanntes Molekül

**Beispiel:**
```csharp
physValue c, h, o, n, s;
chemistry.get_CHONS_of("Sac", out c, out h, out o, out n, out s);
// c = 2, h = 4, o = 2, n = 0, s = 0
```

#### Vereinfachte Zugriffsmethoden

```csharp
// Einzelne Elemente abrufen
public static physValue get_C_of(string molecule)
public static physValue get_H_of(string molecule)
public static physValue get_O_of(string molecule)
public static physValue get_N_of(string molecule)
public static physValue get_S_of(string molecule)

// Kombinationen
public static void get_CHON_of(string molecule, out C, out H, out O, out N)
public static void get_CHO_of(string molecule, out C, out H, out O)
public static void get_CH_of(string molecule, out C, out H)
```

---

### Molare Massen

#### `get_mol_mass_of(string molecule)`

Berechnet die molare Masse eines Moleküls.

**Parameter:**
- `molecule` (string): Molekül-Symbol

**Rückgabe:**
- `physValue`: Molare Masse [g/mol]

**Berechnung:**
```
M = c·MC + h·MH + o·MO + n·MN + s·MS
```

**Beispiel:**
```csharp
physValue M_ac = chemistry.get_mol_mass_of("Sac");
// M_ac = 2×12 + 4×1 + 2×16 = 60 g/mol
```

#### Massenanteile der Elemente

```csharp
// Absolute Massen [g/molecule]
public static physValue get_C_mass_of(string molecule)
public static physValue get_H_mass_of(string molecule)
public static physValue get_O_mass_of(string molecule)
public static physValue get_N_mass_of(string molecule)
public static physValue get_S_mass_of(string molecule)

// Relative Massen [g Element / g Molekül]
public static physValue get_C_rel_mass_of(string molecule)
public static physValue get_H_rel_mass_of(string molecule)
public static physValue get_O_rel_mass_of(string molecule)
public static physValue get_N_rel_mass_of(string molecule)
public static physValue get_S_rel_mass_of(string molecule)
```

**Beispiel:**
```csharp
physValue M_C = chemistry.get_C_mass_of("Sac");
// M_C = 2 × 12 = 24 g/mol

physValue rel_C = chemistry.get_C_rel_mass_of("Sac");
// rel_C = 24/60 = 0.4 = 40% C
```

---

### Chemical Oxygen Demand (COD)

#### `get_COD_of(string molecule)`

Berechnet den chemischen Sauerstoffbedarf eines Moleküls.

**Parameter:**
- `molecule` (string): Molekül-Symbol

**Rückgabe:**
- `physValue`: COD [gCOD/mol]

**Berechnung:**
```
COD = CH4_prod × COD_CH4
```
wobei CH4_prod aus der erweiterten Buswell-Gleichung stammt.

**Vordefinierte Werte** (für Performance):
- `"Sac"`, `"Shac"`, `"Sac_"`: COD_Sac
- `"Spro"`, `"Shpro"`, `"Spro_"`: COD_Spro
- `"Sbu"`, `"Shbu"`, `"Sbu_"`: COD_Sbu
- `"Sva"`, `"Shva"`, `"Sva_"`: COD_Sva
- `"Sch4"`: Berechnet aus Verbrennung

**Beispiel:**
```csharp
physValue COD_ac = chemistry.get_COD_of("Sac");
// Essigsäure: ~64 gCOD/mol
```

#### `calcTheoreticalOxygenDemand(string molecule)`

Berechnet den theoretischen Sauerstoffbedarf (ThOD).

**Rückgabe:**
- `physValue`: ThOD [gCOD/g]

**Formel:**
```
ThOD = COD / Mmolar
```

**Beispiel:**
```csharp
physValue ThOD_ch = chemistry.calcTheoreticalOxygenDemand("Xch");
// Kohlenhydrate: ~1.185 gCOD/g
```

---

### Buswell-Gleichung (Anaerobe Fermentation)

Die erweiterte Buswell-Gleichung berechnet die theoretische Biogasproduktion aus organischen Substanzen unter anaeroben Bedingungen.

#### `buswell_extended(string molecule, out physValue ch4, out physValue co2, out physValue nh3, out physValue h2s)`

Vollständige Buswell-Gleichung.

**Parameter:**
- `molecule` (string): Molekül-Symbol
- `ch4, co2, nh3, h2s` (out physValue): Gasproduktion [mol Gas/mol Molekül]

**Formel** für CcHhOoNnSs:
```
CH4 = c/2 + h/8 - o/4 - 3n/8 - s/4
CO2 = c/2 - h/8 + o/4 + 3n/8 + s/4
NH3 = n
H2S = s
```

**Vereinfachte Versionen:**
```csharp
public static physValue buswell_extended(string molecule)  // nur CH4
public static void buswell_extended(string molecule, out ch4)
public static void buswell_extended(string molecule, out ch4, out co2)
public static void buswell_extended(string molecule, out ch4, out co2, out nh3)
```

**Beispiel:**
```csharp
physValue ch4, co2, nh3, h2s;
chemistry.buswell_extended("Xch", out ch4, out co2, out nh3, out h2s);
// Kohlenhydrate (C6H10O5):
// CH4 = 6/2 + 10/8 - 5/4 = 3.0 mol/mol
// CO2 = 6/2 - 10/8 + 5/4 = 3.0 mol/mol
```

#### Biochemical Methane Potential (BMP)

```csharp
public static physValue calcBMP(string molecule)
```

Berechnet das biochemische Methanpotential.

**Rückgabe:**
- `physValue`: BMP [mol CH4/g Molekül]

**Formel:**
```
BMP = buswell_extended(molecule) / get_mol_mass_of(molecule)
```

#### Erwartete Gasproduktion

```csharp
public static physValue calcCO2exp(string molecule)   // mol CO2/g
public static physValue calcNH3exp(string molecule)   // mol NH3/g
public static physValue calcH2Sexp(string molecule)   // mol H2S/g
```

---

### Verbrennung (Combustion)

#### `combust(string molecule, out physValue o2, out physValue co2, out physValue h2o, out physValue nh3)`

Berechnet Verbrennungsprodukte eines Moleküls.

**Parameter:**
- `molecule` (string): Molekül-Symbol
- `o2` (out physValue): Verbrauchter O2 [mol/mol]
- `co2, h2o, nh3` (out physValue): Verbrennungsprodukte [mol/mol]

**Formel** für CcHhOoNn:
```
O2 = c + h/4 - o/2 - 3n/4
CO2 = c
H2O = h/2 - 3n/2
NH3 = n
```

**Vereinfachte Versionen:**
```csharp
public static void combust(string molecule, out o2)
public static void combust(string molecule, out o2, out co2)
public static void combust(string molecule, out o2, out co2, out h2o)
```

**Beispiel:**
```csharp
physValue o2, co2;
chemistry.combust("Sch4", out o2, out co2);
// CH4: O2 = 1 + 4/4 = 2 mol O2/mol CH4
//      CO2 = 1 mol CO2/mol CH4
```

#### Total Organic Carbon (TOC)

```csharp
public static physValue calcTOC(string molecule)
```

Berechnet den gesamten organischen Kohlenstoff.

**Rückgabe:**
- `physValue`: TOC [gC/g Molekül]

**Formel:**
```
TOC = (mol CO2 aus Verbrennung) × MC / Mmolar
```

---

### Gasvolumen-Berechnungen

#### Methode: `calcCH4vol(string molecule)`

Berechnet das erwartete Methanvolumen.

**Rückgabe:**
- `physValue`: CH4-Volumen [m³/mol Molekül]

**Formel:**
```
VCH4 = buswell_CH4 × MCH4 × Vch4
```

**Weitere Gasvoluina:**
```csharp
public static physValue calcCO2vol(string molecule)  // m³ CO2/mol
public static physValue calcNH3vol(string molecule)  // m³ NH3/mol
public static physValue calcH2Svol(string molecule)  // m³ H2S/mol
public static physValue calcBiogasvol(string molecule)  // Summe aller Gase
```

#### `calcGasQuality(string molecule)`

Berechnet die Biogasqualität (CH4-Anteil).

**Rückgabe:**
- `physValue`: CH4-Gehalt [%]

**Formel:**
```
Qualität = VCH4 / (VCH4 + VCO2 + VNH3 + VH2S) × 100%
```

**Beispiel:**
```csharp
physValue quality = chemistry.calcGasQuality("Xch");
// Kohlenhydrate: ~50% CH4 (da CH4 = CO2 = 3 mol/mol)
```

---

### Thermodynamische Eigenschaften

#### `calcSpecificHeat(string molecule, physValue T)`

Berechnet die spezifische Wärmekapazität.

**Parameter:**
- `molecule` (string): "H2O", "Xpr", "Xli", "Xch", "Ash"
- `T` (physValue): Temperatur [°C oder K]

**Rückgabe:**
- `physValue`: Spezifische Wärme [kJ/(kg·K)] oder [kJ/(m³·K)]

**Formeln** (temperaturabhängig):
```csharp
// Wasser
c_W = 4.1598 + 4.2091e-4 × T

// Proteine
c_pr = 1.6519 + 3.5790e-3 × T

// Lipide
c_li = 1.8707 + 2.7594e-3 × T

// Kohlenhydrate
c_ch = 1.8608 + 2.4311e-3 × T

// Asche
c_ash = 0.87567 + 2.0059e-3 × T
```

**Beispiel:**
```csharp
var T = new physValue(40, "°C");
physValue c_water = chemistry.calcSpecificHeat("H2O", T);
// c_water ≈ 4.176 kJ/(kg·K) bei 40°C
```

#### `calcDensity(string molecule, physValue T)`

Berechnet die Rohdichte.

**Rückgabe:**
- `physValue`: Dichte [kg/m³]

**Formeln** (temperaturabhängig):
```csharp
// Wasser
ρ_W = 1010.4 - 0.49437 × T

// Proteine
ρ_pr = 1305.7 - 1.1389 × T

// Lipide
ρ_li = 929.44 - 0.58598 × T

// Kohlenhydrate
ρ_ch = 1447.4 - 1.2229 × T

// Asche
ρ_ash = 1766.2 - 1.2039 × T
```

**Beispiel:**
```csharp
var T = new physValue(20, "°C");
physValue rho_water = chemistry.calcDensity("H2O", T);
// rho_water ≈ 1000.5 kg/m³ bei 20°C
```

---

## Namespace: science

### Klasse: `physValue`

Definiert einen physikalischen Wert mit Einheit, Symbol und Label.

#### Konstruktoren

```csharp
// Vollständig
public physValue(string symbol, double value, string unit, 
                 string label, string reference)

// Ohne Referenz
public physValue(string symbol, double value, string unit, string label)

// Ohne Label (wird aus Symbol abgeleitet)
public physValue(string symbol, double value, string unit)

// Nur Wert und Einheit (für temporäre Variablen)
public physValue(double value, string unit)

// Nur Symbol (Wert = 0, Einheit und Label aus Symbol)
[Obsolete] public physValue(string symbol, double value)
public physValue(string symbol)

// Standard (leer)
public physValue()

// Kopier-Konstruktor
public physValue(physValue template)
```

**Beispiele:**
```csharp
// Vollständig definiert
var mass = new physValue("m", 1000, "kg", "Masse des Fermenters", "Planungsdaten");

// Vereinfacht
var temp = new physValue("T", 40, "°C");

// Temporär
var result = new physValue(5.5, "m³/d");
```

#### Eigenschaften

```csharp
public string Symbol      // z.B. "T", "pH", "COD"
public string Unit        // z.B. "°C", "-", "kgCOD/m³"
public double Value       // Numerischer Wert
public string Label       // z.B. "Temperatur", "pH-Wert"
public string Reference   // Literaturangabe oder Quelle
```

**Hinweis:** Beim Setzen von `Symbol` wird automatisch ein passendes `Label` aus einer internen Tabelle geladen, falls verfügbar.

---

### Operatoren

#### Arithmetische Operatoren

```csharp
// Addition (gleiche Einheit erforderlich)
physValue operator+(physValue v1, physValue v2)

// Subtraktion (gleiche Einheit erforderlich)
physValue operator-(physValue v1, physValue v2)

// Unäres Minus
physValue operator-(physValue v)

// Multiplikation (Einheit wird multipliziert)
physValue operator*(physValue v1, physValue v2)
physValue operator*(double scalar, physValue v)
physValue operator*(physValue v, double scalar)

// Division (Einheit wird dividiert)
physValue operator/(physValue v1, physValue v2)
physValue operator/(double scalar, physValue v)
physValue operator/(physValue v, double scalar)
```

**Einheiten-Reduktion:**

Bei Multiplikation/Division werden Einheiten automatisch vereinfacht:

```csharp
var Q = new physValue(100, "m³/d");
var rho = new physValue(1000, "kg/m³");
var mass_flow = Q * rho;
// mass_flow.Unit = "kg/d" (m³ kürzt sich)

var c = new physValue(50, "kgCOD/m³");
var COD_load = Q * c;
// COD_load.Unit = "kgCOD/d"
```

#### Vergleichsoperatoren

```csharp
// Gleichheit (gleiche Einheit erforderlich)
bool operator==(physValue v1, physValue v2)
bool operator!=(physValue v1, physValue v2)

// Größer/Kleiner (gleiche Einheit erforderlich)
bool operator>(physValue v1, physValue v2)
bool operator<(physValue v1, physValue v2)
bool operator>=(physValue v1, physValue v2)
bool operator<=(physValue v1, physValue v2)
```

**Ausnahmen:**
- `exception`: Einheiten-Mismatch bei Addition, Subtraktion, Vergleich
- `exception`: Division durch Null

**Beispiel:**
```csharp
var T1 = new physValue("T", 40, "°C");
var T2 = new physValue("T", 35, "°C");
var deltaT = T1 - T2;
// deltaT = 5 °C

var m = new physValue(1000, "kg");
var V = new physValue(1, "m³");
var rho = m / V;
// rho = 1000 kg/m³
```

---

### Einheiten-Konvertierung

#### `convertUnit(string unit)`

Konvertiert die physValue in eine andere Einheit.

**Parameter:**
- `unit` (string): Ziel-Einheit (ohne Klammern)

**Rückgabe:**
- `physValue`: Neue physValue mit konvertiertem Wert

**Unterstützte Konvertierungen:**

##### Konzentrations-Einheiten

```csharp
// COD-Einheiten
"gCOD/l" ↔ "kgCOD/m³" ↔ "mol/l" ↔ "mmol/l" ↔ "g/l" ↔ "mg/l" ↔ "µg/l" ↔ "ng/l"

// Spezielle Äquivalente
"mol/l" → "gCaCO3eq/l"  // ×50 (CaCO3-Äquivalente)
"mol/l" → "gHAceq/l"    // ×60 (HAc-Äquivalente)
```

##### Volumenströme

```csharp
"m³/h" ↔ "m³/d"  // ×24
```

##### Spezifische Volumina

```csharp
"l/g" ↔ "m³/kg" ↔ "ml/g" ↔ "m³/g"
```

##### Prozent und Einheitslos

```csharp
"% TS" ↔ "100 %"  // ÷100
"% FM" ↔ "100 %" ↔ "g/kg"  // ÷100 oder ×10
```

##### Energie

```csharp
// Energie/Zeit
"kWh/d" ↔ "kW" ↔ "W"  // ÷24 oder ×1000

// Energie/Volumen
"MJ/m³" ↔ "kJ/m³" ↔ "kWh/m³" ↔ "MWh/m³"  // ÷3600 oder ×1000

// Spezifische Wärme
"kJ/(m³·K)" ↔ "kWh/(m³·K)"  // ÷3600
```

##### Temperatur

```csharp
"°C" ↔ "K"  // +273.15 oder -273.15
```

##### Druck

```csharp
"µbar" ↔ "mbar" ↔ "bar"  // ×1000 oder ÷1000
```

**Ausnahmen:**
- `exception`: Unbekannte Ausgangseinheit
- `exception`: Konvertierung nicht möglich
- `exception`: Division durch Null (bei Umrechnung)

**Beispiel:**
```csharp
var COD = new physValue("COD", 50, "kgCOD/m³");
var COD_gl = COD.convertUnit("g/l");
// COD_gl.Value = 50, COD_gl.Unit = "g/l"

var temp_C = new physValue("T", 40, "°C");
var temp_K = temp_C.convertUnit("K");
// temp_K.Value = 313.15, temp_K.Unit = "K"
```

---

### Mathematische Methoden (Vektoren)

#### `times(physValue[] v, double scalar)`

Multipliziert alle Elemente mit Skalar.

**Beispiel:**
```csharp
physValue[] conc = {new physValue(10, "g/l"), new physValue(20, "g/l")};
physValue[] doubled = physValue.times(conc, 2);
// doubled = {20 g/l, 40 g/l}
```

#### `plus(physValue[] v1, physValue[] v2)`

Addiert korrespondierende Elemente.

**Ausnahmen:**
- `exception`: Längen unterschiedlich
- `exception`: Einheiten nicht kompatibel

#### `sum(physValue[] inputs)`

Summiert alle Elemente.

**Ausnahmen:**
- `exception`: Einheiten nicht gleich
- `exception`: Array leer

#### `mean(physValue[] inputs)`

Arithmetisches Mittel.

```csharp
physValue mean = physValue.mean(values);
```

#### `min(physValue[] inputs)` / `max(physValue[] inputs)`

Minimum/Maximum.

**Beispiel:**
```csharp
physValue[] temps = {
    new physValue(35, "°C"),
    new physValue(40, "°C"),
    new physValue(38, "°C")
};
physValue max_temp = physValue.max(temps);
// max_temp = 40 °C
```

#### `round(physValue value, int digits)`

Rundet den Wert.

```csharp
var rounded = physValue.round(new physValue(3.14159, "m"), 2);
// rounded.Value = 3.14
```

#### Mathematische Funktionen

```csharp
public static physValue Pow(physValue value, int power)
public static physValue Pow(physValue value, int numerator, int denominator)
public static physValue Sqrt(physValue value)
```

**Beispiel:**
```csharp
var area = new physValue(100, "m²");
var side = physValue.Sqrt(area);
// side = 10 m^(1/2) ≈ 10 m

var volume = physValue.Pow(side, 3);
// volume = 1000 m^(3/2) ≈ 1000 m³ (Einheit wird angepasst)
```

---

### Ausgabe

#### `print(string delimiter)`

Formatierte Ausgabe.

```csharp
public string print()                    // 2 Dezimalstellen
public string print(string delimiter)    // Custom Format

public string printValue()               // Nur Wert + Einheit
public string printValue(string delimiter)
public string printValue(bool addBrackets)

public string printSymbolUnit()          // "Symbol [Einheit]"
```

**Beispiel:**
```csharp
var temp = new physValue("T", 40.567, "°C", "Fermenter-Temperatur");

Console.WriteLine(temp.print());
// "Fermenter-Temperatur: T= 40.57 °C"

Console.WriteLine(temp.print("0.0"));
// "Fermenter-Temperatur: T= 40.6 °C"

Console.WriteLine(temp.printValue());
// "40.57 °C"

Console.WriteLine(temp.printSymbolUnit());
// "T [°C]"
```

---

### XML-Persistenz

#### `getParamsAsXMLString()`

Gibt physValue als XML-String zurück.

```xml
<physValue symbol="T">
    <value>40.0</value>
    <unit>°C</unit>
    <label>Temperatur</label>
    <reference>Messung</reference>
</physValue>
```

#### `getParamsFromXMLReader(ref XmlTextReader reader, string symbol)`

Liest physValue aus XML.

**Rückgabe:**
- `bool`: true wenn erfolgreich

---

### Klasse: `physValueBounded`

Erweitert `physValue` um Grenzen (Bounds).

#### Konstruktoren

```csharp
// Mit Grenzen
public physValueBounded(string symbol, double value, string unit, 
                        string label, string reference, 
                        physValue lb, physValue ub)

// Ohne obere Grenze (UB = ∞)
public physValueBounded(string symbol, double value, string unit, 
                        string label, string reference, physValue lb)

// Ohne Grenzen (wie physValue)
public physValueBounded(string symbol, double value, string unit, 
                        string label, string reference)

// Aus physValue mit Grenzen
public physValueBounded(physValue template, double lb, double ub)

// Aus physValue (Grenzen = ±∞)
public physValueBounded(physValue template)
```

#### Eigenschaften

```csharp
public physValue LB   // Untere Grenze (Lower Bound)
public physValue UB   // Obere Grenze (Upper Bound)
```

#### Methoden

##### `setBounds(double min, double max)`

Setzt beide Grenzen.

##### `setLB(double min)` / `setUB(double max)`

Setzt einzelne Grenzen.

##### `isOutOfBounds()`

Prüft ob Wert außerhalb der Grenzen liegt.

**Rückgabe:**
- `bool`: true wenn Value < LB oder Value > UB

##### `printIsOutOfBounds()`

Wirft Exception wenn außerhalb der Grenzen.

**Ausnahmen:**
- `exception`: Wert außerhalb der Grenzen

**Beispiel:**
```csharp
var pH = new physValueBounded("pH", 7.5, "-");
pH.setBounds(6.0, 8.5);

if (pH.isOutOfBounds())
{
    Console.WriteLine("pH außerhalb des zulässigen Bereichs!");
}

// Oder mit Exception:
pH.printIsOutOfBounds();  // wirft Exception wenn außerhalb
```

---

## Namespace: science.math

### Klasse: `math`

Statische Klasse mit mathematischen Hilfsfunktionen.

#### Statistische Funktionen

##### `mean(double[] values)` / `mean(List<double> values)`

Arithmetisches Mittel.

##### `median(double[] values)` / `median(List<double> values)`

Median-Wert.

##### `sum(double[] values)` / `sum(double[,] values, int dim)`

Summe.

**Parameter (2D):**
- `dim`: 0 = Summe über Zeilen, 1 = Summe über Spalten

##### `min(double[] v, out int index)` / `max(double[] v, out int index)`

Minimum/Maximum mit Index.

**Beispiel:**
```csharp
double[] data = {3.5, 1.2, 5.8, 2.1};
int idx;
double min_val = math.min(data, out idx);
// min_val = 1.2, idx = 1
```

#### Vektor-Operationen

##### `zeros(int dim)` / `zeros(int rows, int cols)`

Erzeugt Null-Vektor/-Matrix.

##### `ones(int dim)`

Erzeugt Eins-Vektor.

##### `eye(int dim)` / `eye(int rows, int cols)`

Erzeugt Einheitsmatrix.

##### `diag(double[,] matrix)` / `diag(double[] vec)`

Diagonal-Vektor extrahieren oder Diagonalmatrix erstellen.

**Beispiel:**
```csharp
double[] v = {1, 2, 3};
double[,] D = math.diag(v);
// D = [1 0 0]
//     [0 2 0]
//     [0 0 3]

double[] d = math.diag(D);
// d = {1, 2, 3}
```

#### Matrix-Operationen

##### `transpose(double[,] mat)`

Transponiert Matrix.

##### `normalize(double[,] mat, int dim)`

Normalisiert Matrix entlang Dimension.

**Warnung:** Matrix wird verändert!

##### `concat(double[,] mat)`

Konkateniert Spalten zu einem Vektor.

##### Element-weise Operationen

```csharp
// Arithmetik
public static double[] plus(double[] v1, double[] v2)
public static double[] minus(double[] v1, double[] v2)
public static double[] times(double[] vec, double scalar)
public static double[] rdivide(double[] vec, double scalar)
public static double[] times(double[] v1, double[] v2)  // element-weise

// Matrix-Produkt
public static double mtimes(double[] v1, double[] v2)  // Skalarprodukt
public static double[] mtimes(double[,] mat, double[] v)  // Matrix × Vektor
```

##### Vergleiche

```csharp
public static bool[] gt(double[] v1, double[] v2)  // >
public static bool[] lt(double[] v1, double[] v2)  // <
public static bool any(bool[] v)   // irgendein true?
public static bool all(bool[] v)   // alle true?
public static bool[] not(bool[] v) // Negation
```

#### Matrix-Manipulation

##### `insert(double[,] mat1, double[,] mat2, int start_row, int start_col)`

Fügt mat2 in mat1 ein.

**Warnung:** mat1 wird verändert!

##### `insertColumn(double[,] mat, double[] vec, int start_row, int col)`

Fügt Spaltenvektor ein.

##### `insertRow(double[,] mat, double[] vec, int row, int start_col)`

Fügt Zeilenvektor ein.

##### `getrow(double[,] matrix, int row_index)` / `getcol(double[,] matrix, int col_index)`

Extrahiert Zeile/Spalte.

##### `getrows(double[] vec, int start_row, int end_row)`

Extrahiert Teilvektor.

##### `repmat(double[] vec, int factor)`

Wiederholt Vektor.

**Beispiel:**
```csharp
double[] v = {1, 2, 3};
double[] v_rep = math.repmat(v, 3);
// v_rep = {1, 2, 3, 1, 2, 3, 1, 2, 3}
```

#### Spezielle Funktionen

##### `tukeybiweight(double x, double C)`

Tukey's Biweight-Funktion (für robuste Regression).

**Parameter:**
- `x`: Argument
- `C`: Konstante (Standard: 4.6851)

**Formel:**
```
ρ(x) = { C²/6 × (1 - (1 - (x/C)²)³)  wenn |x| < C
       { C²/6                         wenn |x| ≥ C
```

---

## Namespace: toolbox

### Klasse: `exception`

Anwendungs-Exception mit automatischem Logging.

#### Konstruktor

```csharp
public exception(string message)
public exception(string message, string source)
```

**Funktionalität:**
- Erstellt Stack-Trace
- Loggt in `ErrorLog.txt`
- Gibt Fehler auf Konsole aus

**Beispiel:**
```csharp
if (value < 0)
{
    throw new exception("Wert darf nicht negativ sein!", "MyClass");
}
```

**Log-Format:**
```
Date and Time of Exception: 24.01.2026 14:30:15
Source of Exception: MyClass: method1, method2, method3

Error Message: toolbox.exception: Wert darf nicht negativ sein!
-------------------------------------------
```

---

### Klasse: `LogError`

Statische Klasse für Fehler-Logging.

#### Methode

##### `Log_Err(string strErrorSource, Exception Ex)`

Loggt Exception in Datei.

**Parameter:**
- `strErrorSource`: Quelle des Fehlers
- `Ex`: Exception-Objekt

**Datei:** `ErrorLog.txt` im Arbeitsverzeichnis

---

### Klasse: `xmlInterface`

Hilfsmethoden für XML-Serialisierung.

#### Methoden

##### `setXMLTag(string xmlTag, object value)`

Erzeugt XML-Tag mit Wert.

**Überladungen:**
```csharp
public static string setXMLTag(string xmlTag, bool value)
public static string setXMLTag(string xmlTag, double value)
public static string setXMLTag(string xmlTag, physValue value)
public static string setXMLTag(string xmlTag, string value)
public static string setXMLTag(string xmlTag, object value)
```

**Beispiel:**
```csharp
string xml = xmlInterface.setXMLTag("temperature", 40.5);
// <temperature>40.5</temperature>

string xml2 = xmlInterface.setXMLTag("enabled", true);
// <enabled>1</enabled>

var temp = new physValue("T", 40, "°C");
string xml3 = xmlInterface.setXMLTag("temp", temp);
// <temp>40</temp> (nur Value, nicht die Einheit!)
```

---

### Klasse: `set_get_interface`

Abstrakte Basis-Klasse für Parameter-Management.

#### Get-Methoden

```csharp
// Einzelner Parameter
public void get_params_of(out physValue variable, string symbol)
public physValue get_params_of(string symbol)
public double get_param_of(string symbol)

// Spezielle Typen
public double get_param_of_d(string symbol)  // double
public string get_param_of_s(string symbol)  // string
public bool get_param_of_b(string symbol)    // bool
public int get_param_of_i(string symbol)     // int

// Mehrere Parameter
public void get_params_of(out physValue[] variables, params string[] symbols)
public abstract void get_params_of(out object[] variables, params string[] symbols)
```

**Beispiel:**
```csharp
public class MyClass : set_get_interface
{
    private physValue temperature;
    private double pH;
    
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
        variables = new object[symbols.Length];
        for (int i = 0; i < symbols.Length; i++)
        {
            switch (symbols[i])
            {
                case "T":
                    variables[i] = temperature;
                    break;
                case "pH":
                    variables[i] = pH;
                    break;
                default:
                    throw new exception($"Unbekannter Parameter: {symbols[i]}");
            }
        }
    }
}

// Verwendung:
var obj = new MyClass();
physValue temp = obj.get_params_of("T");
double pH = obj.get_param_of("pH");
```

#### Set-Methoden

```csharp
// Einzelner Parameter
public void set_params_of(string symbol, physValue value)
public void set_params_of(string symbol, double value)
public void set_params_of(string symbol, string value)
public void set_params_of(string symbol, int value)
public void set_params_of(string symbol, bool value)

// Mehrere Parameter (Paare von Symbol, Wert)
public abstract void set_params_of(params object[] symbols)
```

**Syntax:**
```csharp
obj.set_params_of("T", 40.0, "pH", 7.5, "enabled", true);
```

---

## Anwendungsbeispiele

### Beispiel 1: COD-Berechnung für Substrat

```csharp
using biogas;
using science;

// Substrat-Zusammensetzung
double TS = 30;    // % FM
double VS = 95;    // % TS
double RP = 8;     // % TS (Rohprotein)
double RL = 3;     // % TS (Rohfett)
double RF = 18;    // % TS (Rohfaser)
double ADL = 2.5;  // % TS (Lignin)

// Berechnung der Nicht-Faser-Kohlenhydrate
double NfE = 100 - RP - RL - RF;  // % TS

// COD-Berechnung
double COD_pr = RP * chemistry.ThODpr.Value;
double COD_li = RL * chemistry.ThODli.Value;
double COD_lignin = ADL * chemistry.ThODl.Value;
double COD_ch = (RF + NfE - ADL) * chemistry.ThODch.Value;

double total_COD_percent = COD_pr + COD_li + COD_lignin + COD_ch;

// Umrechnung auf kgCOD/m³
double rho = 1000;  // kg/m³ (Dichte)
double COD_total = rho * (TS/100) * (total_COD_percent/100);

Console.WriteLine($"Gesamt-COD: {COD_total:F1} kgCOD/m³");
```

### Beispiel 2: Buswell-Gleichung für Kohlenhydrate

```csharp
using biogas;
using science;

// Kohlenhydrate: C6H10O5
physValue ch4, co2, nh3, h2s;
chemistry.buswell_extended("Xch", out ch4, out co2, out nh3, out h2s);

Console.WriteLine("Buswell-Gleichung für Kohlenhydrate (C6H10O5):");
Console.WriteLine($"CH4: {ch4.Value:F2} mol/mol");
Console.WriteLine($"CO2: {co2.Value:F2} mol/mol");
Console.WriteLine($"NH3: {nh3.Value:F2} mol/mol");
Console.WriteLine($"H2S: {h2s.Value:F2} mol/mol");

// Volumina berechnen
physValue vol_ch4 = chemistry.calcCH4vol("Xch");
physValue vol_co2 = chemistry.calcCO2vol("Xch");

Console.WriteLine($"\nGasvolumen pro mol Kohlenhydrate:");
Console.WriteLine($"CH4: {vol_ch4.Value:F3} m³/mol");
Console.WriteLine($"CO2: {vol_co2.Value:F3} m³/mol");

// Gasqualität
physValue quality = chemistry.calcGasQuality("Xch");
Console.WriteLine($"\nCH4-Gehalt: {quality.Value:F1}%");
```

### Beispiel 3: Einheiten-Konvertierung

```csharp
using science;

// COD in verschiedenen Einheiten
var COD = new physValue("COD", 50, "kgCOD/m³");

var COD_gl = COD.convertUnit("g/l");
Console.WriteLine($"COD: {COD_gl.Value} {COD_gl.Unit}");  // 50 g/l

var COD_mol = COD.convertUnit("mol/l");
Console.WriteLine($"COD: {COD_mol.Value:F3} {COD_mol.Unit}");  
// Hängt vom Molekül ab! Braucht Symbol-Information

// Temperatur-Konvertierung
var temp_C = new physValue("T", 40, "°C");
var temp_K = temp_C.convertUnit("K");
Console.WriteLine($"{temp_C.Value}°C = {temp_K.Value}K");  // 313.15K

// Energie-Konvertierung
var power_kW = new physValue(100, "kW");
var energy_day = power_kW.convertUnit("kWh/d");
Console.WriteLine($"{power_kW.Value} kW = {energy_day.Value} kWh/d");  // 2400 kWh/d
```

### Beispiel 4: Physikalische Berechnungen mit Einheiten

```csharp
using science;

// Volumenstrom und Konzentration
var Q = new physValue("Q", 100, "m³/d");
var c = new physValue("c", 50, "kgCOD/m³");

// COD-Fracht
var load = Q * c;
Console.WriteLine($"COD-Fracht: {load.Value} {load.Unit}");  // 5000 kgCOD/d

// Hydraulische Verweilzeit
var V = new physValue("V", 2000, "m³");
var HRT = V / Q;
Console.WriteLine($"HRT: {HRT.Value} {HRT.Unit}");  // 20 d

// Organische Raumbelastung
var OLR = load / V;
Console.WriteLine($"OLR: {OLR.Value} {OLR.Unit}");  // 2.5 kgCOD/(m³·d)
```

### Beispiel 5: Wärmebedarfsberechnung

```csharp
using biogas;
using science;

// Substrat-Parameter
var Q = new physValue("Q", 100, "m³/d");
var T_substrate = new physValue(15, "°C");
var T_fermenter = new physValue(40, "°C");

// Spezifische Wärmekapazität
var c_th = chemistry.calcSpecificHeat("H2O", T_substrate);
Console.WriteLine($"c_th: {c_th.Value:F2} {c_th.Unit}");

// Dichte
var rho = chemistry.calcDensity("H2O", T_substrate);
Console.WriteLine($"ρ: {rho.Value:F1} {rho.Unit}");

// Wärmebedarf
var deltaT = T_fermenter - T_substrate;
var heat_m3K = c_th * rho;  // kJ/(kg·K) × kg/m³ = kJ/(m³·K)
var heat_total = Q * heat_m3K * deltaT;
// m³/d × kJ/(m³·K) × K = kJ/d

var heat_kWh = heat_total.convertUnit("kWh/d");
Console.WriteLine($"\nWärmebedarf: {heat_kWh.Value:F1} kWh/d");
```

### Beispiel 6: Matrix-Operationen

```csharp
using science;

// Substrat-Ströme für 3 Fermenter, 4 Substrate
double[,] Q = new double[3, 4];
Q[0, 0] = 50; Q[0, 1] = 30; Q[0, 2] = 10; Q[0, 3] = 10;  // Fermenter 1
Q[1, 0] = 40; Q[1, 1] = 40; Q[1, 2] = 15; Q[1, 3] = 5;   // Fermenter 2
Q[2, 0] = 60; Q[2, 1] = 20; Q[2, 2] = 10; Q[2, 3] = 10;  // Fermenter 3

// Summe pro Fermenter (über Substrate)
double[] Q_fermenter = math.sum(Q, 1);  // dim=1: Spalten summieren
Console.WriteLine("Gesamtstrom pro Fermenter:");
for (int i = 0; i < Q_fermenter.Length; i++)
{
    Console.WriteLine($"Fermenter {i+1}: {Q_fermenter[i]} m³/d");
}

// Summe pro Substrat (über Fermenter)
double[] Q_substrate = math.sum(Q, 0);  // dim=0: Zeilen summieren
Console.WriteLine("\nGesamtstrom pro Substrat:");
for (int i = 0; i < Q_substrate.Length; i++)
{
    Console.WriteLine($"Substrat {i+1}: {Q_substrate[i]} m³/d");
}

// Normalisierung (Anteile pro Fermenter)
double[,] Q_normalized = math.normalize((double[,])Q.Clone(), 1);
Console.WriteLine("\nAnteile der Substrate in Fermenter 1:");
for (int i = 0; i < 4; i++)
{
    Console.WriteLine($"Substrat {i+1}: {Q_normalized[0,i]*100:F1}%");
}
```

---

## Best Practices

### 1. Einheiten-Konsistenz

```csharp
// GUT: Explizite Einheiten verwenden
var COD = new physValue("COD", 50, "kgCOD/m³");
var Q = new physValue("Q", 100, "m³/d");

// SCHLECHT: Einheiten vergessen
double COD = 50;  // Welche Einheit?
double Q = 100;   // m³/h oder m³/d?
```

### 2. Einheiten-Konvertierung

```csharp
// GUT: Vor Verwendung konvertieren
var COD_kgm3 = COD.convertUnit("kgCOD/m³");
var load = Q * COD_kgm3;

// VERMEIDEN: Implizite Annahmen
var load = Q.Value * COD.Value;  // Einheiten gehen verloren!
```

### 3. Fehlerbehandlung

```csharp
// GUT: Try-Catch für Konvertierungen
try
{
    var temp_K = temp_C.convertUnit("K");
}
catch (exception ex)
{
    Console.WriteLine($"Konvertierung fehlgeschlagen: {ex.Message}");
}

// GUT: Parameter-Validierung
if (pH < 0 || pH > 14)
{
    throw new exception("pH außerhalb des gültigen Bereichs!", "MyClass");
}
```

### 4. Bounded Values für Constraints

```csharp
// GUT: Bounds für Prozess-Parameter
var pH = new physValueBounded("pH", 7.5, "-");
pH.setBounds(6.0, 8.5);

if (pH.isOutOfBounds())
{
    // Warnung oder Korrekturmaßnahme
}
```

### 5. Mathematische Operationen

```csharp
// GUT: math-Klasse für Arrays nutzen
double[] data = {1.5, 2.3, 1.8, 2.1};
double avg = math.mean(data);
double med = math.median(data);

// VERMEIDEN: Manuelle Implementierung
double sum = 0;
for (int i = 0; i < data.Length; i++) sum += data[i];
double avg_manual = sum / data.Length;  // Fehleranfällig
```

---

## Hinweise

### Wichtige Konventionen

- **Einheiten ohne Klammern**: "kgCOD/m³" nicht "[kgCOD/m³]"
- **Mol vs. Masse**: Buswell-Gleichung gibt mol/mol, COD in gCOD/mol
- **Temperatur**: Standardmäßig in °C, außer explizit anders angegeben
- **COD vs. VS**: COD in kgCOD/m³, VS in % TS
- **Array-Indexierung**: In math-Methoden 0-basiert

### Limitierungen

- **COD-Konvertierung**: Nur für bekannte Moleküle möglich
- **Einheiten-System**: Nicht alle Einheiten-Kombinationen unterstützt
- **Temperatur-Abhängigkeit**: Viele Konstanten sind für Standard-Bedingungen
- **Präzision**: Double-Genauigkeit (~15 Dezimalstellen)

### TODOs (aus Quellcode)

- Acid dissociation constants sind temperaturabhängig (Van 't Hoff)
- Spezifische Volumina sind temperaturabhängig
- Die 40%-Grenze für CH4 (biogas.BioGas) braucht Referenz
- OLR und HRT für Gesamtanlage berechnen (optimization.objectives)
- C:N-Verhältnis als Constraint in Optimierung
- THG-Emissionen in Zielfunktionen

---

## Siehe auch

- **biogas.chemistry**: Hauptquelle für chemische Berechnungen
- **biogas.substrates**: Nutzt chemistry für Substrat-Charakterisierung
- **biooptim.objectives**: Nutzt chemistry für Fitness-Berechnungen
- **science.physValue**: Basis für alle physikalischen Werte
- **science.math**: Mathematische Hilfsfunktionen

---

## Referenzen

1. Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.:  
   *Biogas from grass silage – Measurements and modeling with ADM1*,  
   Bioresource Technology 101, pp. 8158-8165, 2010.

2. Gaida, D.:  
   *Die anaerobe Fermentation - Theoretische Grundlagen, Simulation und Regelung*,  
   2009.

3. ADM1 Report (IWA Task Group for Mathematical Modelling of Anaerobic Digestion Processes)

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*# PhysChem Package API Documentation
