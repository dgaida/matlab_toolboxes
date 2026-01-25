# Concrete Sensor Classes API Documentation

## Übersicht

Diese Dokumentation beschreibt alle konkreten Sensor-Implementierungen im `biogas` Namespace. Die Sensoren sind nach Funktionsbereich gruppiert:

1. **ADM-Sensoren**: Messen ADM1-Modellvariablen
2. **Prozess-Sensoren**: Messen Prozessparameter (pH, VFA, TS, etc.)
3. **Energie-Sensoren**: Messen Energie-Produktion/-Verbrauch
4. **Fitness-Sensoren**: Messen Optimierungskriterien
5. **Spezial-Sensoren**: Sonstige Messungen

---

## 1. ADM-Sensoren

Diese Sensoren messen Variablen des Anaerobic Digestion Model 1 (ADM1).

### ADMstate_sensor

Misst den 37-dimensionalen ADM-Zustandsvektor.

**Spezifikation:** `"ADMstate"`

**Dimension:** `(int)ADMstate.dim_state` (37)

**Typ:** 98 (Custom)

**Konstruktor:**
```csharp
public ADMstate_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID (z.B. `"F1"`)

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): 37-dim ADM-Zustandsvektor [verschiedene Einheiten]

**Ausgabe:**
- `physValue[37]`: Zustandsvariablen mit Namen und Einheiten aus `ADMstate.symADMstate`

**Beispiel:**
```csharp
var sensor = new ADMstate_sensor("F1");
double[] state = /* 37-dim ADM-Zustand */;
physValue[] measured = sensor.measure(5.0, 0.5, state);

// Zugriff auf einzelne Zustandsvariablen
physValue Ssu = measured[0];   // Monosaccharide
physValue Saa = measured[1];   // Aminosäuren
// ...
```

**Hinweise:**
- **NICHT FERTIG** - hängt vom implementierten ADM1-Modell ab
- Einheiten und Symbole werden aus `ADMstate.getUnitOfADMstatevariable()` bezogen

---

### ADMstream_sensor

Misst den ADM-Stream-Vektor (33-34 Dimensionen).

**Spezifikation:** `"ADMstream"`

**Dimension:** `(int)ADMstate.dim_stream - 1` (33 oder 34)

**Typ:** 0

**Konstruktor:**
```csharp
public ADMstream_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID + `"_2"` (Eingang) oder `"_3"` (Ausgang)

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] u, params double[] par)
```

**Eingabe:**
- `u` (double[]): 33-34 dim Stream-Vektor [verschiedene Einheiten]

**Ausgabe:**
- `physValue[]`: Stream-Variablen mit Einheiten

**Ausnahmen:**
- `exception`: Wenn `u.Length < ADMstate.dim_stream - 1`

**Beispiel:**
```csharp
var sensor = new ADMstream_sensor("F1_2");  // Eingang
double[] stream = /* 33-dim Stream */;
physValue[] measured = sensor.measure(5.0, 0.5, stream);
```

---

### ADMintvars_sensor

Misst die ADM1-internen Variablen (64 + Anzahl Gase).

**Spezifikation:** `"ADMintvars"`

**Dimension:** `64 + (int)BioGas.n_gases` (67 für 3 Gase)

**Typ:** 97 (Custom)

**Konstruktor:**
```csharp
public ADMintvars_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): Vektor der internen Variablen (Reaktionsraten, Inhibierungen, etc.)

**Ausgabe:**
- `physValue[]`: Interne Variablen mit generischen Namen `"var_0"`, `"var_1"`, etc.

**Ausnahmen:**
- `exception`: Wenn `x.Length != dimension`

**Beispiel:**
```csharp
var sensor = new ADMintvars_sensor("F1");
double[] intvars = /* interne ADM-Variablen */;
physValue[] measured = sensor.measure(5.0, 0.5, intvars);
```

**Hinweise:**
- **NICHT FERTIG** - nur für ADM1xp geeignet
- Variablen haben keine spezifischen Namen, nur Indizes

---

### ADMparams_sensor

Misst die ADM1-Parameter.

**Spezifikation:** `"ADMparams"`

**Dimension:** `ADMparams.numParams`

**Typ:** 927 (Custom)

**Konstruktor:**
```csharp
public ADMparams_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Parameter-Vektor

**Ausgabe:**
- `physValue[]`: Parameter mit generischen Namen `"par_0"`, `"par_1"`, etc.

**Beispiel:**
```csharp
var sensor = new ADMparams_sensor("F1");
double[] params = /* ADM-Parameter */;
physValue[] measured = sensor.measure(5.0, 0.5, params);
```

---

## 2. Prozess-Sensoren

### pH_stream_sensor

Misst den pH-Wert aus dem ADM-Stream.

**Spezifikation:** `"pH_stream"`

**Dimension:** 1

**Typ:** 0

**Konstruktor:**
```csharp
public pH_stream_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID + `"_2"` oder `"_3"`

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustand (34 oder 37 dim)

**Ausgabe:**
- `physValue[1]`: pH-Wert [-]

**Berechnung:**
```csharp
biogas.ADMstate.calcPHOfADMstate(x, out pH)
```

**Beispiel:**
```csharp
var sensor = new pH_stream_sensor("F1_3");
double[] state = /* ADM-Stream */;
physValue[] pH = sensor.measure(5.0, 0.5, state);
Console.WriteLine($"pH: {pH[0].Value:F2}");
```

---

### pH_sensor

Misst den pH-Wert aus ADM-internen Variablen.

**Spezifikation:** `"pH"`

**Dimension:** 1

**Typ:** 91 (Custom - aus internen Variablen)

**Konstruktor:**
```csharp
public pH_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-interne Variablen (H+ ist x[19])

**Ausgabe:**
- `physValue[1]`: pH = -log10([H+])

**Berechnung:**
```csharp
if (x[19] > 0)
    pH = -Math.Log10(x[19])
else
    pH = 0
```

**Beispiel:**
```csharp
var sensor = new pH_sensor("F1_3");
double[] intvars = /* ADM-interne Variablen ohne Biogas-Vektor */;
physValue[] pH = sensor.measure(5.0, 0.5, intvars);
```

**Hinweise:**
- **NICHT FERTIG** - hängt von ADM-internen Variablen ab
- Index 19 ist H+ Konzentration (1-basierte Zählung in Dokumentation: Position 20)

---

### VFA_sensor

Misst die gesamte VFA-Konzentration (Volatile Fatty Acids).

**Spezifikation:** `"VFA"`

**Dimension:** 1

**Typ:** 0

**Konstruktor:**
```csharp
public VFA_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor

**Ausgabe:**
- `physValue[1]`: VFA-Konzentration [gHAceq/l]

**Berechnung:**
```csharp
VFA = ADMstate.calcVFAOfADMstate(x, "gHAceq/l")
VFA.Symbol = "Svfa"
```

**Beispiel:**
```csharp
var sensor = new VFA_sensor("F1_3");
double[] state = /* ADM-Zustand */;
physValue[] vfa = sensor.measure(5.0, 0.5, state);
Console.WriteLine($"VFA: {vfa[0].Value:F1} gHAceq/l");
```

---

### VFAmatrix_sensor

Misst die vier Hauptkomponenten der VFA.

**Spezifikation:** `"VFAmatrix"`

**Dimension:** 4

**Typ:** 0

**Konstruktor:**
```csharp
public VFAmatrix_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor

**Ausgabe:**
- `physValue[4]`:
  - `[0]`: Sva (Valeriansäure) [g/l]
  - `[1]`: Sbu (Buttersäure) [g/l]
  - `[2]`: Spro (Propionsäure) [g/l]
  - `[3]`: Sac (Essigsäure) [g/l]

**Berechnung:**
```csharp
values[0] = ADMstate.calcFromADMstate(x, "Sva",  "g/l")
values[1] = ADMstate.calcFromADMstate(x, "Sbu",  "g/l")
values[2] = ADMstate.calcFromADMstate(x, "Spro", "g/l")
values[3] = ADMstate.calcFromADMstate(x, "Sac",  "g/l")
```

**Spezielle Methoden:**
```csharp
public override physValue getCurrentMeasurement(string param, bool noisy)
public override physValue[] getMeasurementStream(string param, bool noisy)
public override physValue getMeasurementAt(string param, double t, bool noisy)
```

**Parameter-Namen:**
- `"Sva"`: Valeriansäure
- `"Sbu"`: Buttersäure
- `"Spro"`: Propionsäure
- `"Sac"`: Essigsäure

**Beispiel:**
```csharp
var sensor = new VFAmatrix_sensor("F1_3");
double[] state = /* ADM-Zustand */;
physValue[] vfa = sensor.measure(5.0, 0.5, state);

Console.WriteLine($"Valeriansäure: {vfa[0].Value:F2} g/l");
Console.WriteLine($"Buttersäure: {vfa[1].Value:F2} g/l");
Console.WriteLine($"Propionsäure: {vfa[2].Value:F2} g/l");
Console.WriteLine($"Essigsäure: {vfa[3].Value:F2} g/l");

// Alternative: Parameter-Zugriff
physValue sac = sensor.getCurrentMeasurement("Sac");
```

**Hinweise:**
- **NICHT FERTIG** - TODO klärt warum dieser Sensor zusätzlich zu den Einzel-Sensoren existiert

---

### Sva_sensor, Sbu_sensor, Spro_sensor, Sac_sensor

Messen einzelne VFA-Komponenten.

**Spezifikationen:** `"Sva"`, `"Sbu"`, `"Spro"`, `"Sac"`

**Dimension:** 1

**Typ:** 0

**Konstruktoren:**
```csharp
public Sva_sensor(string id_suffix)
public Sbu_sensor(string id_suffix)
public Spro_sensor(string id_suffix)
public Sac_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor

**Ausgabe:**
- `physValue[1]`: Säure-Konzentration [g/l]

**Beispiele:**
```csharp
// Essigsäure
var sac_sensor = new Sac_sensor("F1_3");
physValue[] sac = sac_sensor.measure(5.0, 0.5, state);
Console.WriteLine($"Essigsäure: {sac[0].Value:F2} g/l");

// Propionsäure
var spro_sensor = new Spro_sensor("F1_3");
physValue[] spro = spro_sensor.measure(5.0, 0.5, state);
```

---

### TAC_sensor

Misst die Gesamtalkalität (Total Alkalinity Concentration).

**Spezifikation:** `"TAC"`

**Dimension:** 1

**Typ:** 0

**Konstruktor:**
```csharp
public TAC_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor

**Ausgabe:**
- `physValue[1]`: TAC [gCaCO3eq/l]

**Berechnung:**
```csharp
TAC = ADMstate.calcTACOfADMstate(x, "gCaCO3eq/l")
```

**Grenzwerte (informativ):**
- TAC < 50 mmol/l: Gefährlich
- 50 < TAC < 100 mmol/l: Geringe Warnung
- 100 < TAC < 250 mmol/l: OK

**Beispiel:**
```csharp
var sensor = new TAC_sensor("F1_3");
physValue[] tac = sensor.measure(5.0, 0.5, state);
Console.WriteLine($"TAC: {tac[0].Value:F1} gCaCO3eq/l");
```

---

### VFA_TAC_sensor

Misst das Verhältnis VFA/TAC.

**Spezifikation:** `"VFA_TAC"`

**Dimension:** 1

**Typ:** 0

**Konstruktor:**
```csharp
public VFA_TAC_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor

**Ausgabe:**
- `physValue[1]`: VFA/TAC-Verhältnis [gHAceq/gCaCO3eq]

**Berechnung:**
```csharp
VFA_TAC = ADMstate.calcFOSTACOfADMstate(x)
```

**Beispiel:**
```csharp
var sensor = new VFA_TAC_sensor("F1");
physValue[] ratio = sensor.measure(5.0, 0.5, state);
Console.WriteLine($"VFA/TAC: {ratio[0].Value:F3}");
```

**Hinweise:**
- Wichtiger Stabilitätsindikator
- Typisch: < 0.3 = stabil, > 0.4 = kritisch

---

### AcVsPro_sensor

Misst das Verhältnis Essigsäure zu Propionsäure.

**Spezifikation:** `"AcVsPro"`

**Dimension:** 1

**Typ:** 0

**Konstruktor:**
```csharp
public AcVsPro_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor

**Ausgabe:**
- `physValue[1]`: Sac/Spro-Verhältnis [mol/mol]

**Berechnung:**
```csharp
Ac_vs_Pro = ADMstate.calcAcetic_vs_PropionicOfADMstate(x)
```

**Beispiel:**
```csharp
var sensor = new AcVsPro_sensor("F1");
physValue[] ratio = sensor.measure(5.0, 0.5, state);
Console.WriteLine($"Ac/Pro: {ratio[0].Value:F2}");
```

---

### NH3_sensor, NH4_sensor

Messen Ammoniak bzw. Ammonium.

**Spezifikationen:** `"Snh3"`, `"Snh4"`

**Dimension:** 2

**Typ:** 5 (Custom - benötigt plant)

**Konstruktoren:**
```csharp
public NH3_sensor(string id_suffix)
public NH4_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
{
    throw new exception("Not implemented!");
}

protected override physValue[] doMeasurement(plant myPlant, double[] x,
                                             string param, params double[] par)
```

**Eingabe:**
- `myPlant` (plant): Anlagen-Objekt
- `x` (double[]): ADM-Zustandsvektor
- `param` (string): Nicht verwendet
- `par` (params double[]): Nicht verwendet

**Ausgabe:**
- `physValue[2]`:
  - `[0]`: Snh3/Snh4 [g/l] (nur löslicher Anteil)
  - `[1]`: Total NH3/NH4 (inkl. in Xc gebunden) [g/l]

**Berechnung:**
```csharp
// NH3_sensor:
values[0] = ADMstate.calcFromADMstate(x, "Snh3", "g/l")
double NH3_total = ADMstate.calcNH3(x, digester_id, myPlant)  // kmol N/m³
values[1] = new physValue("N", NH3_total, "mol/l", "total ammonia nitrogen")
values[1] = values[1].convertUnit("g/l")
values[1].Symbol = "NH3"

// NH4_sensor:
values[0] = ADMstate.calcFromADMstate(x, "Snh4", "g/l")
double NH4_total = ADMstate.calcNH4(x, digester_id, myPlant)  // kmol N/m³
values[1] = new physValue("N", NH4_total, "mol/l", "total ammonium nitrogen")
values[1] = values[1].convertUnit("g/l")
values[1].Symbol = "NH4"
```

**Beispiel:**
```csharp
// Gemessen über sensors-Klasse (Typ 5)
var nh4_sensor = new NH4_sensor("F1_3");
// ... in sensors-Liste hinzufügen ...
mySensors.measure(5.0, "Snh4_F1_3", plant, state, "");

physValue snh4 = mySensors.getCurrentMeasurement("Snh4_F1_3", 0);
physValue nh4_total = mySensors.getCurrentMeasurement("Snh4_F1_3", 1);
```

**Hinweise:**
- Umrechnungsfaktor: NH4 nutzt 18 g/mol, NH3 nutzt 17 g/mol
- Für Vergleich mit TKN, Ntot, Norg: Alle nutzen 14 g/mol (nur N)

---

### Norg_sensor, Ntot_sensor, TKN_sensor

Messen Stickstoff-Fraktionen.

**Spezifikationen:** `"Norg"`, `"Ntot"`, `"TKN"`

**Dimension:** 1

**Typ:** 5 (Custom - benötigt plant)

**Konstruktoren:**
```csharp
public Norg_sensor(string id_suffix)
public Ntot_sensor(string id_suffix)
public TKN_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(plant myPlant, double[] x,
                                             string param, params double[] par)
```

**Eingabe:**
- `myPlant` (plant): Anlagen-Objekt
- `x` (double[]): ADM-Zustandsvektor
- `param` (string): Nicht verwendet

**Ausgabe:**
- `physValue[1]`: Stickstoff-Konzentration [g/l]

**Berechnungen:**
```csharp
// Norg: Organischer Stickstoff
double Norg = ADMstate.calcNorg(x, digester_id, myPlant)  // kmol N/m³

// Ntot: Gesamt-Stickstoff
double Ntot = ADMstate.calcNtot(x, digester_id, myPlant)  // kmol N/m³

// TKN: Total Kjeldahl Nitrogen (Norg + NH4)
double TKN = ADMstate.calcTKN(x, digester_id, myPlant)  // kmol N/m³

// Alle: Umrechnung zu g/l
values[0] = new physValue("N", value, "mol/l", label)
values[0] = values[0].convertUnit("g/l")
values[0].Symbol = "Norg" / "Ntot" / "TKN"
```

**Beispiel:**
```csharp
var ntot_sensor = new Ntot_sensor("F1_3");
// Über sensors-Klasse messen
mySensors.measure(5.0, "Ntot_F1_3", plant, state, "");

double ntot = mySensors.getCurrentMeasurementD("Ntot_F1_3");
Console.WriteLine($"Gesamt-N: {ntot:F2} g/l");
```

---

### TS_sensor

Misst den Trockensubstanz-Gehalt (Total Solids).

**Spezifikation:** `"TS"`

**Dimension:** 1

**Typ:** 7 (benötigt plant, substrates, sensors, Q)

**Konstruktor:**
```csharp
public TS_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, plant myPlant,
                                             substrates mySubstrates, sensors mySensors,
                                             double[] Q, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor
- `myPlant` (plant): Anlagen-Objekt
- `mySubstrates` (substrates): Substrat-Liste
- `mySensors` (sensors): Sensor-Sammlung
- `Q` (double[]): Volumenströme
  - `Q[0..n_substrate-1]`: Substrat-Ströme [m³/d]
  - `Q[n_substrate..]`: Fermenter-Rezirkulation [m³/d]
- `par` (params double[]): Nicht verwendet

**Ausgabe:**
- `physValue[1]`: TS [% FM]

**Berechnung:**
```csharp
if (id.EndsWith("3"))     // Ausgang (_3)
{
    // TS im Fermenter basierend auf COD
    TS = biogas.digester.calcTS(x, substrates_or_sludge, Q_substrates)
}
else if (id.EndsWith("2"))     // Eingang (_2)
{
    // Gewichteter Mittelwert der Substrat-TS
    substrates.get_weighted_mean_of(Q_substrates, "TS", out TS)
    TS.Symbol = "TS"
}

TS.Label = "total solids"
```

**Spezialfall:** Wenn kein Substrat zugeführt wird (`sum(Q_substrates) == 0`):
- Erstelle Sludge-Objekte mit TS aus anderen Fermentern
- Nutze `TS_{digester}_3` Messungen oder Default (11% FM)

**Beispiel:**
```csharp
var sensor = new TS_sensor("F1_2");  // Eingang
double[] Q = {100.0, 50.0, 0.0, 0.0};  // 2 Substrate, 2 Fermenter

// Über sensors-Klasse messen
mySensors.measure_type7(5.0, state, plant, substrates, mySensors,
                        substrate_network, plant_network, "F1");

double ts = mySensors.getCurrentMeasurementD("TS_F1_2");
Console.WriteLine($"TS Eingang: {ts:F2} % FM");
```

**Hinweise:**
- **Copyright:** GPL v3+
- **TODO:** TS-Messung für Fermenter-Eingang erweitern
- Evtl. substrate_sensor nutzen statt direkter Messung

---

### VS_sensor

Misst den organischen Trockensubstanz-Gehalt (Volatile Solids).

**Spezifikation:** `"VS"`

**Dimension:** 1

**Typ:** 85 (Custom - Typ 3)

**Konstruktor:**
```csharp
public VS_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, substrates mySubstrates,
                                             double[] Q, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor
- `mySubstrates` (substrates): Substrat-Liste
- `Q` (double[]): Substrat-Volumenströme [m³/d]
- `par` (params double[]): Nicht verwendet

**Ausgabe:**
- `physValue[1]`: VS [% TS]

**Berechnung:**
```csharp
VS = biogas.digester.calcVS(x, mySubstrates, Q)
```

**Annahmen:**
- TS-Gehalt im Fermenter wird aus COD berechnet
- Verteilung von RF, RP, RL wie in Gesamt-Substratzufuhr
- Asche-Gehalt wie in Gesamt-Substratzufuhr

**Beispiel:**
```csharp
var sensor = new VS_sensor("total_mix_2");
double[] Q = {100.0, 50.0};  // Mais, Gülle

mySensors.measure(5.0, "VS_total_mix_2", stream, substrates, Q);

double vs = mySensors.getCurrentMeasurementD("VS_total_mix_2");
Console.WriteLine($"VS: {vs:F1} % TS");
```

**Hinweise:**
- **TODO:** Bei 2 Fermentern müsste Asche pro Fermenter halbiert werden
- Typ müsste eigentlich 3 sein (nicht 85)

---

### SS_COD_sensor, VS_COD_sensor

Messen löslichen bzw. partikulären COD.

**Spezifikationen:** `"SS_COD"`, `"VS_COD"`

**Dimension:** 1

**Typ:** 0

**Konstruktoren:**
```csharp
public SS_COD_sensor(string id_suffix)
public VS_COD_sensor(string id_suffix)
```

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor

**Ausgabe:**
- `physValue[1]`: COD [kgCOD/m³]

**Berechnungen:**
```csharp
// SS_COD: Löslicher COD (Soluble Solids)
SS_COD = ADMstate.calcSSOfADMstate(x, "kgCOD/m³")

// VS_COD: Partikulärer COD (ohne SS_COD)
VS_COD = ADMstate.calcVSOfADMstate(x, "kgCOD/m³")
```

**Beispiel:**
```csharp
var ss_sensor = new SS_COD_sensor("F1_3");
var vs_sensor = new VS_COD_sensor("F1_3");

physValue[] ss = ss_sensor.measure(5.0, 0.5, state);
physValue[] vs = vs_sensor.measure(5.0, 0.5, state);

Console.WriteLine($"Löslicher COD: {ss[0].Value:F1} kgCOD/m³");
Console.WriteLine($"Partikulärer COD: {vs[0].Value:F1} kgCOD/m³");
Console.WriteLine($"Gesamt-COD: {(ss[0].Value + vs[0].Value):F1} kgCOD/m³");
```