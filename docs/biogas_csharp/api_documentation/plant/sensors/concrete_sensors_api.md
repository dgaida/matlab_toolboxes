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

---

### Q_sensor

Misst Volumenströme.

**Spezifikation:** `"Q"`

**Dimension:** 1

**Typ:** 0

**Konstruktor:**
```csharp
public Q_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): ID + `"_2"` (Eingang) oder `"_3"` (Ausgang)

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Stream-Vektor (dimension: dim_stream)

**Ausgabe:**
- `physValue[1]`: Volumenstrom [m³/d]

**Berechnung:**
```csharp
Q = ADMstate.calcQOfADMstate(x)
```

**Beispiel:**
```csharp
var sensor = new Q_sensor("F1_3");
double[] stream = /* ADM-Stream */;
physValue[] q = sensor.measure(5.0, 0.5, stream);
Console.WriteLine($"Volumenstrom: {q[0].Value:F1} m³/d");
```

---

### HRT_sensor

Misst die hydraulische Verweilzeit (Hydraulic Retention Time).

**Spezifikation:** `"HRT"`

**Dimension:** 1

**Typ:** 1 (benötigt Parameter)

**Konstruktor:**
```csharp
public HRT_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor
- `par[0]` (double): Flüssigvolumen Vliq [m³]

**Ausgabe:**
- `physValue[1]`: HRT [d]

**Ausnahmen:**
- `exception`: Wenn `par.Length != 1`

**Berechnung:**
```csharp
HRT = ADMstate.calcHRTOfADMstate(x, Vliq)
```

**Beispiel:**
```csharp
var sensor = new HRT_sensor("F1");
double[] state = /* ADM-Zustand */;
double Vliq = 2500.0;  // m³

physValue[] hrt = sensor.measure(5.0, 0.5, state, Vliq);
Console.WriteLine($"HRT: {hrt[0].Value:F1} Tage");

// Typische Werte: 20-60 Tage
if (hrt[0].Value < 20.0)
    Console.WriteLine("WARNUNG: HRT zu kurz!");
```

---

### OLR_sensor

Misst die organische Raumbelastung (Organic Loading Rate).

**Spezifikation:** `"OLR"`

**Dimension:** 1

**Typ:** 7 (benötigt plant, substrates, sensors, Q)

**Konstruktor:**
```csharp
public OLR_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID

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

**Ausgabe:**
- `physValue[1]`: OLR [kgCOD/(m³·d)]

**Ausnahmen:**
- `exception`: Wenn `Q.Length < n_substrate`

**Berechnung:**
```csharp
digester myDigester = myPlant.getDigesterByID(id_suffix);
OLR = myDigester.calcOLR(x, substrates_or_sludge, Q_substrates, Qsum)
```

**Spezialfall:** Wenn kein Substrat zugeführt wird:
- Erstellt Sludge-Objekte aus TS/VS der Fermenter
- Nutzt gemessene TS/VS-Werte oder Defaults

**Beispiel:**
```csharp
var sensor = new OLR_sensor("F1");

// Über sensors-Klasse messen (Typ 7)
double[] x = /* ADM-Zustand */;
double[] Q = {100.0, 50.0, 0.0, 0.0};  // 2 Substrate, 2 Fermenter

mySensors.measure_type7(5.0, x, plant, substrates, mySensors,
                        substrate_network, plant_network, "F1");

double olr = mySensors.getCurrentMeasurementD("OLR_F1");
Console.WriteLine($"OLR: {olr:F2} kgCOD/(m³·d)");

// Typische Werte: 2-6 kg/(m³·d)
```

**Hinweis:**
- **Copyright:** GPL v3+
- **TODO:** Größtenteils identisch mit TS_sensor, könnte zusammengelegt werden

---

### density_sensor

Misst die Dichte des Substrat-Feeds.

**Spezifikation:** `"density"`

**Dimension:** 1

**Typ:** 7

**Konstruktor:**
```csharp
public density_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, plant myPlant,
                                             substrates mySubstrates, sensors mySensors,
                                             double[] Q, params double[] par)
```

**Eingabe:**
- Wie OLR_sensor (Typ 7)

**Ausgabe:**
- `physValue[1]`: Dichte [kg/m³]

**Berechnung:**
```csharp
// Substrat-Dichte (gewichteter Mittelwert)
substrates.get_weighted_sum_of(Q_substrates, "rho", out rho_substrate);
rho_substrate = rho_substrate.convertUnit("kg/d");

// Sludge-Dichte (Annahme: 1000 kg/m³)
rho_sludge = 1000 kg/m³

// Gesamt
density = (rho_substrate + rho_sludge * Q_sludge) / Q_total
```

**Beispiel:**
```csharp
var sensor = new density_sensor("F1");

// Messung über sensors-Klasse
mySensors.measure_type7(5.0, x, plant, substrates, mySensors,
                        substrate_network, plant_network, "F1");

double rho = mySensors.getCurrentMeasurementD("density_F1");
Console.WriteLine($"Dichte: {rho:F1} kg/m³");
```

**Hinweise:**
- **TODO:** mySensors wird hier eigentlich nicht benötigt
- Annahme: Sludge-Dichte = 1000 kg/m³
- Misst nur Eingangs-Dichte (Feed), nicht Dichte im Fermenter

---

### biomassMeth_sensor, biomassAciAce_sensor

Messen Biomasse-Konzentrationen verschiedener Mikroorganismen-Gruppen.

**Spezifikationen:** `"biomassMeth"`, `"biomassAciAce"`

**Dimension:** 1

**Typ:** 0

**Konstruktoren:**
```csharp
public biomassMeth_sensor(string id_suffix)
public biomassAciAce_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID + `"_2"` oder `"_3"`

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor

**Ausgabe:**
- `physValue[1]`: Biomasse [kgCOD/m³]

**Berechnungen:**
```csharp
// biomassMeth: Methanogene
// Xac (Acetat-abbauende) + Xh2 (H2-abbauende)
biomass_meth = ADMstate.calcMethBiomassOfADMstate(x)

// biomassAciAce: Acidogene + Acetogene
// Xsu (Zucker) + Xaa (Aminosäuren) + Xfa (LCFA) + Xc4 (Valerat/Butyrat) + Xpro (Propionat)
biomass_aci_ace = ADMstate.calcAciAceBiomassOfADMstate(x)
```

**Beispiel:**
```csharp
var meth_sensor = new biomassMeth_sensor("F1_3");
var aci_ace_sensor = new biomassAciAce_sensor("F1_3");

double[] state = /* ADM-Zustand */;

physValue[] X_meth = meth_sensor.measure(5.0, 0.5, state);
physValue[] X_aci_ace = aci_ace_sensor.measure(5.0, 0.5, state);

Console.WriteLine($"Methanogene: {X_meth[0].Value:F2} kgCOD/m³");
Console.WriteLine($"Acidogene+Acetogene: {X_aci_ace[0].Value:F2} kgCOD/m³");

// Verhältnis
double ratio = X_aci_ace[0].Value / X_meth[0].Value;
Console.WriteLine($"Verhältnis Aci+Ace/Meth: {ratio:F2}");
```

---

### inhibition_sensor

Misst Inhibierungsterme des ADM1-Modells.

**Spezifikation:** `"inhibition"`

**Dimension:** 8

**Typ:** 91 (Custom - aus internen Variablen)

**Konstruktor:**
```csharp
public inhibition_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] intvars, params double[] par)
```

**Eingabe:**
- `intvars` (double[]): ADM1-interne Variablen (ohne Biogas-Vektor)

**Ausgabe:**
- `physValue[8]`:
  - `[0]`: IpH_a (pH-Inhibierung Acidogene) [100 %]
  - `[1]`: IpH_h2 (pH-Inhibierung Hydrogenotrophe) [100 %]
  - `[2]`: IpH_ac (pH-Inhibierung Acetotrophe) [100 %]
  - `[3]`: IpH (Gesamt-pH-Inhibierung) [100 %]
  - `[4]`: Iin (Stickstoff-Inhibierung) [100 %]
  - `[5]`: I_NH3 (Ammoniak-Inhibierung) [100 %]
  - `[6]`: Iin * I_NH3 (Kombinierte N-Inhibierung) [100 %]
  - `[7]`: I_H2_c4 (Wasserstoff-Inhibierung C4) [100 %]

**Berechnung:**
```csharp
// pH-Inhibierung
IpH_a = intvars[27]
IpH_h2 = intvars[29]
IpH_ac = intvars[31]
IpH = intvars[27] * intvars[29] * intvars[31]

// Stickstoff-Inhibierung
Iin = intvars[23]
I_NH3 = intvars[24]

// Wasserstoff-Inhibierung
I_H2_c4 = intvars[25]
```

**Beispiel:**
```csharp
var sensor = new inhibition_sensor("F1");

// Über sensors-Klasse messen (benötigt interne Variablen)
double[] intvars = /* ADM-interne Variablen */;
physValue[] inhib = sensor.measure(5.0, 0.5, intvars);

Console.WriteLine("Inhibierungen:");
Console.WriteLine($"  pH (gesamt): {inhib[3].Value:F3}");
Console.WriteLine($"  Stickstoff: {inhib[4].Value:F3}");
Console.WriteLine($"  Ammoniak: {inhib[5].Value:F3}");
Console.WriteLine($"  Wasserstoff: {inhib[7].Value:F3}");

// Warnung bei starker Inhibierung
if (inhib[3].Value < 0.5)  // < 50% Aktivität
    Console.WriteLine("WARNUNG: Starke pH-Inhibierung!");
if (inhib[6].Value < 0.5)
    Console.WriteLine("WARNUNG: Starke Stickstoff-Inhibierung!");
```

**Hinweise:**
- **NICHT FERTIG** - hängt von ADM-internen Variablen ab
- Werte: 0.0 (vollständig inhibiert) bis 1.0 (keine Inhibierung)
- Indizes beziehen sich auf ADM1-interne Variablen

---

### aceto_hydro_sensor

Misst das Verhältnis von acetoclastischer zu hydrogenotropher Methanogenese.

**Spezifikation:** `"aceto_hydro"`

**Dimension:** 2

**Typ:** 911 (Custom - aus internen Variablen)

**Konstruktor:**
```csharp
public aceto_hydro_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] intvars, params double[] par)
```

**Eingabe:**
- `intvars` (double[]): ADM1-interne Variablen
- `par[0]` (double): Yac (Yield-Koeffizient Acetat)
- `par[1]` (double): Yh2 (Yield-Koeffizient Wasserstoff)

**Ausgabe:**
- `physValue[2]`:
  - `[0]`: Acetoclastische Methanogenese [100 %]
  - `[1]`: Hydrogenotrophe Methanogenese [100 %]

**Berechnung:**
```csharp
// Uptake-Raten aus internen Variablen
p_ac = intvars[48]  // Acetat-Aufnahme
p_h2 = intvars[49]  // Wasserstoff-Aufnahme

// CH4-Produktion
ch4_prod_ac = p_ac * (1 - Yac)
ch4_prod_h2 = p_h2 * (1 - Yh2)

// Anteile in %
aceto_ratio = ch4_prod_ac / (ch4_prod_ac + ch4_prod_h2) * 100
hydro_ratio = ch4_prod_h2 / (ch4_prod_ac + ch4_prod_h2) * 100
```

**Beispiel:**
```csharp
var sensor = new aceto_hydro_sensor("F1");

double[] intvars = /* ADM-interne Variablen */;
double Yac = 0.05;  // 5% Yield
double Yh2 = 0.06;  // 6% Yield

physValue[] ratio = sensor.measure(5.0, 0.5, intvars, Yac, Yh2);

Console.WriteLine("Methanogenese-Wege:");
Console.WriteLine($"  Acetoclastisch: {ratio[0].Value:F1}%");
Console.WriteLine($"  Hydrogenotroph: {ratio[1].Value:F1}%");

// Typisch: 70% acetoclastisch, 30% hydrogenotroph
```

**Hinweise:**
- **NICHT FERTIG** - hängt von ADM-internen Variablen ab
- Summe sollte 100% ergeben
- Wichtig für Prozessverständnis

---

### faecal_sensor

Misst die Fäkalbakterien-Entfernungsrate.

**Spezifikation:** `"faecal"`

**Dimension:** 2

**Typ:** 1 (benötigt Parameter)

**Konstruktor:**
```csharp
public faecal_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor (nicht verwendet)
- `par[0]` (double): HRT [d]
- `par[1]` (double): Temperatur [°C]

**Ausgabe:**
- `physValue[2]`:
  - `[0]`: Intestinale Enterokokken-Entfernung [%]
  - `[1]`: Fäkalcoliforme-Entfernung [%]

**Ausnahmen:**
- `exception`: Wenn `par.Length != 2`
- `exception`: Wenn `HRT == 0`

**Berechnungen:**
```csharp
// Intestinale Enterokokken
eta_IE = 98.29 - 2.2 * (1/HRT)² + 0.031 * T

// Fäkalcoliforme
eta_FC = 98.29 - 1.0 * (1/HRT)² + 0.031 * T
```

**Beispiel:**
```csharp
var sensor = new faecal_sensor("F1");

double HRT = 30.0;  // Tage
double T = 38.0;    // °C

physValue[] removal = sensor.measure(5.0, 0.5, new double[1], HRT, T);

Console.WriteLine("Fäkalbakterien-Entfernung:");
Console.WriteLine($"  Enterokokken: {removal[0].Value:F2}%");
Console.WriteLine($"  Coliforme: {removal[1].Value:F2}%");

// Hygienisierungsanforderung: >99%
if (removal[0].Value < 99.0)
    Console.WriteLine("WARNUNG: Hygienisierung unzureichend!");
```

**Hinweise:**
- **TODO:** Zu testen
- Wichtig für Hygienisierung (z.B. bei Güllevergärung)
- Abhängig von HRT und Temperatur

---

## 3. Energie-Sensoren

### energyProduction_sensor

Misst die elektrische und thermische Energieproduktion eines BHKWs.

**Spezifikation:** `"energyProduction"`

**Dimension:** 2

**Typ:** 95 (Custom - Typ 5)

**Konstruktor:**
```csharp
public energyProduction_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): BHKW-ID

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
{
    throw new exception("Not implemented!");
}

protected override physValue[] doMeasurement(plant myPlant, double[] u,
                                             string param, params double[] par)
```

**Eingabe:**
- `myPlant` (plant): Anlagen-Objekt
- `u` (double[]): Biogasstrom [m³/d] (H2, CH4, CO2)
- `param` (string): Nicht verwendet
- `par` (params double[]): Nicht verwendet

**Ausgabe:**
- `physValue[2]`:
  - `[0]`: Elektrische Energie [kWh/d]
  - `[1]`: Thermische Energie [kWh/d]

**Berechnung:**
```csharp
myPlant.burnBiogas(id_suffix, u, out P_el, out P_th)
```

**Beispiel:**
```csharp
var sensor = new energyProduction_sensor("CHP1");

// Biogasstrom zum BHKW
double[] biogas = {10.0, 500.0, 250.0};  // H2, CH4, CO2 [m³/d]

// Über sensors-Klasse messen (Typ 5)
mySensors.measure(5.0, "energyProduction_CHP1", plant, biogas, "");

double P_el, P_th;
mySensors.getCurrentMeasurementD("energyProduction_CHP1", 0, out P_el);
mySensors.getCurrentMeasurementD("energyProduction_CHP1", 1, out P_th);

Console.WriteLine($"Energieproduktion:");
Console.WriteLine($"  Elektrisch: {P_el:F1} kWh/d");
Console.WriteLine($"  Thermisch: {P_th:F1} kWh/d");
Console.WriteLine($"  Verhältnis: {P_th/P_el:F2}");
```

**Hinweis:** Wird von `chps.run()` aufgerufen.

---

### energyProdSum_sensor

Misst die gesamte elektrische und thermische Energieproduktion der Anlage.

**Spezifikation:** `"energyProdSum"`

**Dimension:** 2

**Typ:** 543 (Custom)

**Konstruktor:**
```csharp
public energyProdSum_sensor()
```

**Hinweis:** Kein `id_suffix` - gilt für gesamte Anlage.

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
```

**Eingabe:**
- `x[0]` (double): Gesamt-Stromproduktion [kWh/d]
- `x[1]` (double): Gesamt-Wärmeproduktion [kWh/d]

**Ausgabe:**
- `physValue[2]`:
  - `[0]`: Pel_sum (Elektrisch gesamt) [kWh/d]
  - `[1]`: Pth_sum (Thermisch gesamt) [kWh/d]

**Beispiel:**
```csharp
var sensor = new energyProdSum_sensor();

// Summe aller BHKWs berechnen
double P_el_total = 0;
double P_th_total = 0;

for (int i = 1; i <= plant.getNumCHPs(); i++)
{
    string chp_id = plant.getCHPID(i);
    double P_el, P_th;
    mySensors.getCurrentMeasurementD($"energyProduction_{chp_id}", 0, out P_el);
    mySensors.getCurrentMeasurementD($"energyProduction_{chp_id}", 1, out P_th);
    
    P_el_total += P_el;
    P_th_total += P_th;
}

// Messen
double[] energy = {P_el_total, P_th_total};
physValue[] sum = sensor.measure(5.0, 0.5, energy);

Console.WriteLine($"Gesamt-Energieproduktion:");
Console.WriteLine($"  Strom: {sum[0].Value:F1} kWh/d");
Console.WriteLine($"  Wärme: {sum[1].Value:F1} kWh/d");
```

---

### energyProdMicro_sensor

Misst die durch Mikroorganismen produzierte Wärmeenergie.

**Spezifikation:** `"energyProdMicro"`

**Dimension:** 1

**Typ:** 77 (Custom)

**Konstruktor:**
```csharp
public energyProdMicro_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] p, params double[] par)
```

**Eingabe:**
- `p` (double[]): ADM-Reaktionsraten (ρ-Vektor)
- `par[0]` (double): Vliq (Flüssigvolumen) [m³]

**Ausgabe:**
- `physValue[1]`: Thermische Energie [kWh/d]

**Ausnahmen:**
- `exception`: Wenn `par.Length != 1`

**Berechnung:**
```csharp
P_prod_micro = ADMstate.calcProdEnergyOfMicroOrganisms(p, Vliq)
```

**Beispiel:**
```csharp
var sensor = new energyProdMicro_sensor("F1");

double[] reaction_rates = /* ADM-Reaktionsraten */;
double Vliq = 2500.0;  // m³

physValue[] P_micro = sensor.measure(5.0, 0.5, reaction_rates, Vliq);

Console.WriteLine($"Mikrobielle Wärmeproduktion: {P_micro[0].Value:F1} kWh/d");

// Typisch: 1-5% der BHKW-Wärmeleistung
```

**Hinweise:**
- **NICHT FERTIG** - hängt eindeutig von ADM1 ab
- Wichtig für Wärmebilanz des Fermenters

---

### heatConsumption_sensor

Misst den Wärmeverbrauch eines Fermenters.

**Spezifikation:** `"heatConsumption"`

**Dimension:** 4

**Typ:** 7

**Konstruktor:**
```csharp
public heatConsumption_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): Fermenter-ID

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, plant myPlant,
                                             substrates mySubstrates,
                                             sensors mySensors,
                                             double[] Q, params double[] par)
```

**Eingabe:**
- `x` (double[]): ADM-Zustandsvektor
- `Q` (double[]): Substrat-Volumenströme [m³/d] (nur Substrate, keine Rezirkulation)

**Ausgabe:**
- `physValue[4]`:
  - `[0]`: Substrat-Heizung [kWh/d]
  - `[1]`: Wärmeverlust (Strahlung) [kWh/d]
  - `[2]`: Mikrobielle Wärmeproduktion [kWh/d]
  - `[3]`: Rührwerk-Dissipation [kWh/d]

**Berechnung:**
```csharp
digester myDigester = myPlant.getDigesterByID(id_suffix);

myDigester.calcThermalEnergyBalance(Q, mySubstrates, myPlant.Tout, mySensors,
                                    out P_heat_substrates,
                                    out P_radiation_loss,
                                    out P_microorganisms,
                                    out P_stirrer_dissipation)
```

**Beispiel:**
```csharp
var sensor = new heatConsumption_sensor("F1");

// Über sensors-Klasse messen
double[] Q = {100.0, 50.0};  // Nur Substrate
mySensors.measure_type7(5.0, x, plant, substrates, mySensors,
                        substrate_network, plant_network, "F1");

double[] heat = new double[4];
for (int i = 0; i < 4; i++)
    mySensors.getCurrentMeasurementD("heatConsumption_F1", i, out heat[i]);

Console.WriteLine("Wärmebilanz:");
Console.WriteLine($"  Substrat-Heizung: {heat[0]:F1} kWh/d");
Console.WriteLine($"  Wärmeverlust: {heat[1]:F1} kWh/d");
Console.WriteLine($"  Mikrobielle Produktion: {heat[2]:F1} kWh/d");
Console.WriteLine($"  Rührwerk-Dissipation: {heat[3]:F1} kWh/d");

double net = heat[0] - heat[1] + heat[2] + heat[3];
Console.WriteLine($"  Netto-Wärmebedarf: {net:F1} kWh/d");
```

**Hinweise:**
- **TODO:** Wärme durch Bakterien muss noch abgezogen werden - **Erledigt** (ist in `[2]`)
- Typ 7, aber Q enthält nur Substrate (keine Rezirkulation)

---

### pumpEnergy_sensor

Misst den Energieverbrauch von Pumpen.

**Spezifikation:** `"pumpEnergy"`

**Dimension:** 1

**Typ:** 90 (Custom - Typ 4)

**Konstruktor:**
```csharp
public pumpEnergy_sensor(string id_suffix)
```

**Parameter:**
- `id_suffix` (string): `unit_start + "_" + unit_destiny` (z.B. `"F1_F2"`)

**doMeasurement:**
```csharp
protected override physValue[] doMeasurement(double[] x, params double[] par)
{
    throw new exception("Not implemented!");
}

protected override physValue[] doMeasurement(plant myPlant, double u,
                                             params double[] par)
```

**Eingabe:**
- `myPlant` (plant): Anlagen-Objekt
- `u` (double): Volumenstrom [m³/d]
- `par[
