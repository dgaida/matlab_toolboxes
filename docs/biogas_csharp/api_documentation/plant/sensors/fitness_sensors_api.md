# Fitness Sensors API Documentation

## Übersicht

Das `fitness`-Verzeichnis enthält spezialisierte Sensoren zur Bewertung der Prozessstabilität und Optimierungsperformance von Biogasanlagen. Diese Sensoren (Typ 8) werden hauptsächlich in Optimierungsalgorithmen verwendet, um die Einhaltung von Prozessgrenzen zu überwachen und Fitnesswerte zu berechnen.

**Namespace:** `biogas`

**Sensor-Typ:** 8 (Fitness-Sensoren)

**Gemeinsame Signatur:**
```csharp
protected override physValue[] doMeasurement(
    plant myPlant,
    fitness_params myFitnessParams,
    sensors mySensors,
    params double[] par
)
```

---

## Sensor-Übersicht

| Sensor | Beschreibung | Spec | Fitness-Bereich |
|--------|--------------|------|-----------------|
| `AcVsPro_fit_sensor` | Acetat/Propionat-Verhältnis | `AcVsPro_fit` | 0 (gut) - 1+ (schlecht) |
| `CH4_fit_sensor` | Methankonzentration < 50% | `CH4_fit` | 0 (gut) - 1+ (schlecht) |
| `HRT_fit_sensor` | Hydraulische Verweilzeit | `HRT_fit` | 0 (gut) - 1+ (schlecht) |
| `N_fit_sensor` | Stickstoff (NH4/NH3) | `N_fit` | 0 (gut) - 2+ (schlecht) |
| `OLR_fit_sensor` | Organische Raumbelastung | `OLR_fit` | 0 (gut) - 1+ (schlecht) |
| `SS_COD_fit_sensor` | Löslicher CSB-Abbau | `SS_COD_fit` | 0 (gut) - 1 (schlecht) |
| `TAC_fit_sensor` | Pufferkapazität | `TAC_fit` | 0 (gut) - 1+ (schlecht) |
| `TS_fit_sensor` | Trockensubstanz | `TS_fit` | 0 (gut) - 1+ (schlecht) |
| `VFA_TAC_fit_sensor` | VFA/TAC-Verhältnis | `VFA_TAC_fit` | 0 (gut) - 1+ (schlecht) |
| `VFA_fit_sensor` | Flüchtige Fettsäuren | `VFA_fit` | 0 (gut) - 1+ (schlecht) |
| `VS_COD_fit_sensor` | Abbaugrad org. Substanz | `VS_COD_fit` | 0 (gut) - 1 (schlecht) |
| `gasexcess_fit_sensor` | Biogasüberschuss-Kosten | `gasexcess_fit` | Kosten in 1000 €/d |
| `pH_fit_sensor` | pH-Wert | `pH_fit` | 0 (gut) - 1+ (schlecht) |
| `setpoint_fit_sensor` | Sollwert-Abweichung | `setpoint_fit` | Quadr. Abweichung |
| `manurebonus_sensor` | Gülle-Bonus | `manurebonus` | 0/1 (Nein/Ja) |
| `udot_sensor` | Substratänderung | `udot` | ||u'||² |

---

## Gemeinsame Eigenschaften

Alle Fitness-Sensoren teilen folgende Eigenschaften:

### Konstruktoren

```csharp
public <SensorName>() : base(_spec, "<Beschreibung>", "")
{
    _type = 8;  // oder 9 für manurebonus/udot
}

public <SensorName>(ref XmlTextReader reader, string id) : 
    base(ref reader, id)
{
    _type = 8;  // oder 9
}
```

### Eigenschaften

```csharp
public override string spec { get { return _spec; } }
public static string _spec = "<sensor_id>";
```

### Standard-Methoden

```csharp
// Nicht implementiert (wirft Exception)
protected override physValue[] doMeasurement(double[] x, params double[] par)
{
    throw new exception("Not implemented!");
}

// Hauptmethode
protected override physValue[] doMeasurement(
    plant myPlant,
    fitness_params myFitnessParams,
    sensors mySensors,
    params double[] par
)
{
    // Implementierung
}
```

---

## Fitness-Berechnungsmethode

Die meisten Fitness-Sensoren nutzen die zentrale Methode:

### `sensors.calcFitnessDigester_min_max()`

```csharp
public static double calcFitnessDigester_min_max(
    plant myPlant,
    sensors mySensors,
    string var_id,
    string min_max,
    fitness_params myFitnessParams,
    string append_var_id,
    bool use_tukey
)
```

**Parameter:**
- `var_id` (string): Variable ("pH", "VFA", "TS", "OLR", etc.)
- `min_max` (string): "min", "max", oder "min_max"
- `append_var_id` (string): "_2" (Eingang), "_3" (Ausgang), oder ""
- `use_tukey` (bool): Tukey-Biweight-Funktion verwenden

**Rückgabe:**
- `double`: Fitness-Wert (0 = alle Grenzen eingehalten, >0 = Verletzungen)

**Formel (ohne Tukey):**
```
fitness = Σ(verletzt_i) / n_fermenter
verletzt_i = 1 wenn min/max verletzt, 0 sonst
```

**Formel (mit Tukey):**
```
fitness = Σ(tukey(Δ_i)) / n_fermenter
Δ_i = Abstand zur nächsten Grenze
tukey(x) = Tukey-Biweight-Funktion
```

**Beispiel:**
```csharp
// pH soll zwischen pH_min und pH_max liegen
double pH_fitness = sensors.calcFitnessDigester_min_max(
    myPlant,
    mySensors,
    "pH",           // Variable
    "min_max",      // Min und Max prüfen
    myFitnessParams,
    "_3",           // Fermenter-Ausgang
    true            // Tukey-Funktion
);
```

---

## Sensor-Detailbeschreibungen

### 1. AcVsPro_fit_sensor

Überwacht das Acetat/Propionat-Verhältnis als Stabilitätsindikator.

**Spec:** `"AcVsPro_fit"`

**Messung:**
```csharp
double AcVsPro_fitness = sensors.calcFitnessDigester_min_max(
    myPlant,
    mySensors,
    "AcVsPro",
    "min",              // Nur Minimum prüfen
    myFitnessParams,
    "_3",
    true
);

values[0] = new physValue("AcVsPro_fitness", AcVsPro_fitness, "-");
```

**Parameter in fitness_params:**
- `AcVsPro_min`: Minimales Acetat/Propionat-Verhältnis

**Interpretation:**
- 0: Verhältnis > Minimum (stabil)
- >0: Verhältnis < Minimum (Prozess-Instabilität)

**Beispiel:**
```csharp
var sensor = new AcVsPro_fit_sensor();
var fitnessParams = new fitness_params("fitness.xml");

// Messen
physValue[] fitness = sensor.measure(
    10.0,
    0.5,
    myPlant,
    fitnessParams,
    mySensors
);

Console.WriteLine($"AcVsPro Fitness: {fitness[0].Value:F3}");
```

---

### 2. CH4_fit_sensor

Bestraft Methankonzentrationen unter 50% im Biogas.

**Spec:** `"CH4_fit"`

**Messung:**
```csharp
// Biogas-Vektor holen
physValue[] biogas_v = mySensors.getCurrentMeasurementVector("total_biogas_");

double methaneConcentration = biogas_v[2].Value;  // CH4 in %

// Fitness: 0 wenn CH4 >= 50%, >0 wenn CH4 < 50%
double CH4_fitness = Convert.ToDouble(methaneConcentration < 50) *
    (0 * 1 + math.tukeybiweight(methaneConcentration - 50));

values[0] = new physValue("CH4_fitness", CH4_fitness, "-");
```

**Berechnung:**
- Wenn CH4 >= 50%: Fitness = 0 (gut)
- Wenn CH4 < 50%: Fitness = tukey(CH4 - 50)

**Tukey-Funktion:**
```csharp
// math.tukeybiweight(x) berechnet:
// - x < 0: Bestrafung steigt
// - x = 0: Grenzwert
// - x > 0: Keine Bestrafung
```

**Interpretation:**
- 0: CH4 >= 50% (normal)
- 0.01-0.5: Leichte CH4-Reduktion
- 0.5-1: Mittlere CH4-Reduktion
- >1: Starke CH4-Reduktion (kritisch)

**Beispiel:**
```csharp
var sensor = new CH4_fit_sensor();

// CH4-Konzentration aus Biogas-Sensor
physValue[] biogas = mySensors.getCurrentMeasurementVector("total_biogas_");
Console.WriteLine($"CH4: {biogas[2].Value:F1}%");

// Fitness messen
physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

if (fitness[0].Value > 0)
{
    Console.WriteLine($"WARNUNG: CH4 < 50% (Fitness: {fitness[0].Value:F3})");
}
```

---

### 3. HRT_fit_sensor

Überwacht die hydraulische Verweilzeit (Hydraulic Retention Time).

**Spec:** `"HRT_fit"`

**Messung:**
```csharp
double HRT_fitness = sensors.calcFitnessDigester_min_max(
    myPlant,
    mySensors,
    "HRT",
    "min_max",          // Min und Max prüfen
    myFitnessParams,
    "",                 // Kein Suffix (HRT ist nicht In/Out-spezifisch)
    true
);

values[0] = new physValue("HRT_fitness", HRT_fitness, "-");
```

**Parameter in fitness_params:**
- `HRT_min`: Minimale HRT [d]
- `HRT_max`: Maximale HRT [d]

**Typische Grenzen:**
- Min: 15-20 Tage
- Max: 60-80 Tage

**Interpretation:**
- 0: HRT im optimalen Bereich
- >0: HRT zu kurz oder zu lang

**Beispiel:**
```csharp
var sensor = new HRT_fit_sensor();

// Fitness messen
physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// HRT-Wert abrufen
double hrt = mySensors.getCurrentMeasurementD("HRT_F1");

Console.WriteLine($"HRT: {hrt:F1} Tage");
Console.WriteLine($"HRT Fitness: {fitness[0].Value:F3}");

if (fitness[0].Value > 0)
{
    if (hrt < fitnessParams.get_param_of("HRT_min", 0))
        Console.WriteLine("WARNUNG: HRT zu kurz");
    else
        Console.WriteLine("WARNUNG: HRT zu lang");
}
```

---

### 4. N_fit_sensor

Überwacht Stickstoff-Konzentrationen (NH4/NH3).

**Spec:** `"N_fit"`

**Messung:**
```csharp
double N_fitness = 
    biogas.sensors.calcFitnessDigester_min_max(
        myPlant, mySensors, "Snh4",
        "max", myFitnessParams, "_3", true
    ) +
    biogas.sensors.calcFitnessDigester_min_max(
        myPlant, mySensors, "Snh3",
        "max", myFitnessParams, "_3", true
    );

values[0] = new physValue("N_fitness", N_fitness, "-");
```

**Komponenten:**
1. NH4⁺ (Ammonium) - `Snh4`
2. NH3 (Ammoniak, toxisch) - `Snh3`

**Parameter in fitness_params:**
- `Snh4_max`: Maximales NH4⁺ [g/l]
- `Snh3_max`: Maximales NH3 [g/l]

**Interpretation:**
- 0: Beide Werte unter Maximum
- 0-1: NH4⁺ über Maximum
- 1-2: NH4⁺ und NH3 über Maximum (kritisch)

**Beispiel:**
```csharp
var sensor = new N_fit_sensor();

physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// Einzelne N-Werte abrufen
double nh4 = mySensors.getCurrentMeasurementD("NH4_F1_3");
double nh3 = mySensors.getCurrentMeasurementD("NH3_F1_3");

Console.WriteLine($"NH4: {nh4:F2} g/l");
Console.WriteLine($"NH3: {nh3:F3} g/l");
Console.WriteLine($"N Fitness: {fitness[0].Value:F3}");

if (fitness[0].Value > 1.5)
{
    Console.WriteLine("KRITISCH: NH3-Inhibition wahrscheinlich!");
}
```

---

### 5. OLR_fit_sensor

Überwacht die organische Raumbelastung (Organic Loading Rate).

**Spec:** `"OLR_fit"`

**Messung:**
```csharp
double OLR_fitness = sensors.calcFitnessDigester_min_max(
    myPlant,
    mySensors,
    "OLR",
    "max",              // Nur Maximum prüfen
    myFitnessParams,
    "",
    true
);

values[0] = new physValue("OLR_fitness", OLR_fitness, "-");
```

**Parameter in fitness_params:**
- `OLR_max`: Maximale OLR [kg VS/(m³·d)]

**Typische Grenzen:**
- Max: 3-6 kg VS/(m³·d)

**Interpretation:**
- 0: OLR unter Maximum (sicher)
- >0: OLR über Maximum (Überlastung)

**Beispiel:**
```csharp
var sensor = new OLR_fit_sensor();

physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// OLR-Werte für alle Fermenter
for (int i = 1; i <= myPlant.getNumDigesters(); i++)
{
    string id = myPlant.getDigesterID(i);
    double olr = mySensors.getCurrentMeasurementD($"OLR_{id}");
    
    Console.WriteLine($"{id}: OLR = {olr:F2} kg VS/(m³·d)");
}

Console.WriteLine($"\nOLR Fitness: {fitness[0].Value:F3}");

if (fitness[0].Value > 0.5)
{
    Console.WriteLine("WARNUNG: Mindestens ein Fermenter überlastet");
}
```

---

### 6. SS_COD_fit_sensor

Bewertet den Abbaugrad des löslichen CSB (Chemical Oxygen Demand).

**Spec:** `"SS_COD_fit"`

**Messung:**
```csharp
double SS_COD_degradationRate;
double SS_COD_fitness = getSS_COD_fitness(mySensors, out SS_COD_degradationRate);

values[0] = new physValue("SS_COD_fitness", SS_COD_fitness, "-");
```

**Private Hilfsmethode:**
```csharp
private static double getSS_COD_fitness(
    sensors mySensors,
    out double SS_COD_degradationRate
)
{
    // Löslicher CSB im Endlager
    physValue Q_final = mySensors.getCurrentMeasurement("Q_finalstorage_2");
    physValue SS_COD_final = mySensors.getCurrentMeasurement("SS_COD_finalstorage_2");
    double SS_COD_amount_final = SS_COD_final.Value * Q_final.Value;
    
    // Löslicher CSB im Substrat-Feed
    physValue Q_total = mySensors.getCurrentMeasurement("Q_total_mix_2");
    physValue SS_COD_substrate = mySensors.getCurrentMeasurement("SS_COD_total_mix_2");
    double SS_COD_amount_total = SS_COD_substrate.Value * Q_total.Value;
    
    // Abbaugrad [%]
    SS_COD_degradationRate = 
        (1 - Math.Max(SS_COD_amount_final, 0) / 
             Math.Max(SS_COD_amount_total, double.Epsilon)) * 100;
    
    // Normalisiert zwischen 0 und 1
    double SS_COD_fitness = Math.Abs(
        (1 - math.normalize(SS_COD_degradationRate, 0, 100))
    );
    
    return SS_COD_fitness;
}
```

**Berechnung:**
- Abbaugrad = (1 - SS_COD_out / SS_COD_in) × 100%
- Fitness = |1 - normalize(Abbaugrad, 0, 100)|

**Interpretation:**
- 0: 100% Abbau (perfekt)
- 0.5: 50% Abbau
- 1: 0% Abbau (kein Abbau)

**Beispiel:**
```csharp
var sensor = new SS_COD_fit_sensor();

physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// CSB-Werte
double ss_cod_in = mySensors.getCurrentMeasurementD("SS_COD_total_mix_2");
double ss_cod_out = mySensors.getCurrentMeasurementD("SS_COD_finalstorage_2");

double degradation = (1 - ss_cod_out / ss_cod_in) * 100;

Console.WriteLine($"SS-CSB Eingang: {ss_cod_in:F1} g/l");
Console.WriteLine($"SS-CSB Ausgang: {ss_cod_out:F1} g/l");
Console.WriteLine($"Abbaugrad: {degradation:F1}%");
Console.WriteLine($"SS-CSB Fitness: {fitness[0].Value:F3}");
```

---

### 7. TAC_fit_sensor

Überwacht die Pufferkapazität (Total Alkaline Capacity).

**Spec:** `"TAC_fit"`

**Messung:**
```csharp
double TAC_fitness = sensors.calcFitnessDigester_min_max(
    myPlant,
    mySensors,
    "TAC",
    "min",              // Nur Minimum prüfen
    myFitnessParams,
    "_3",
    true
);

values[0] = new physValue("TAC_fitness", TAC_fitness, "-");
```

**Parameter in fitness_params:**
- `TAC_min`: Minimale TAC [mmol/l]

**Grenzwerte (aus VDI-Tagung):**
- TAC < 50 mmol/l: Gefährlich
- 50 < TAC < 100 mmol/l: Geringe Warnung
- 100 < TAC < 250 mmol/l: OK

**Interpretation:**
- 0: TAC > Minimum (ausreichend gepuffert)
- >0: TAC < Minimum (Pufferkapazität zu gering)

**Beispiel:**
```csharp
var sensor = new TAC_fit_sensor();

physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// TAC für alle Fermenter
for (int i = 1; i <= myPlant.getNumDigesters(); i++)
{
    string id = myPlant.getDigesterID(i);
    double tac = mySensors.getCurrentMeasurementD($"TAC_{id}_3");
    
    string status = tac > 100 ? "OK" : 
                    tac > 50 ? "Warnung" : 
                    "KRITISCH";
    
    Console.WriteLine($"{id}: TAC = {tac:F1} mmol/l ({status})");
}

Console.WriteLine($"\nTAC Fitness: {fitness[0].Value:F3}");
```

---

### 8. TS_fit_sensor

Überwacht den Trockensubstanzgehalt (Total Solids).

**Spec:** `"TS_fit"`

**Messung:**
```csharp
double TS_fitness = sensors.calcFitnessDigester_min_max(
    myPlant,
    mySensors,
    "TS",
    "max",              // Nur Maximum prüfen
    myFitnessParams,
    "_3",
    true
);

values[0] = new physValue("TS_fitness", TS_fitness, "-");
```

**Parameter in fitness_params:**
- `TS_max`: Maximaler TS [% FM]

**Typische Grenzen:**
- Max: 10-15% FM

**Interpretation:**
- 0: TS unter Maximum (pumpfähig)
- >0: TS über Maximum (zu dick)

**Beispiel:**
```csharp
var sensor = new TS_fit_sensor();

physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// TS-Werte
for (int i = 1; i <= myPlant.getNumDigesters(); i++)
{
    string id = myPlant.getDigesterID(i);
    double ts = mySensors.getCurrentMeasurementD($"TS_{id}_3");
    
    Console.WriteLine($"{id}: TS = {ts:F2}% FM");
}

Console.WriteLine($"\nTS Fitness: {fitness[0].Value:F3}");

if (fitness[0].Value > 0.5)
{
    Console.WriteLine("WARNUNG: TS zu hoch - Pumpprobleme möglich");
}
```

---

### 9. VFA_TAC_fit_sensor

Überwacht das VFA/TAC-Verhältnis als Stabilitätsindikator.

**Spec:** `"VFA_TAC_fit"`

**Messung:**
```csharp
double VFA_TAC_fitness = sensors.calcFitnessDigester_min_max(
    myPlant,
    mySensors,
    "VFA_TAC",
    "min_max",          // Min und Max prüfen
    myFitnessParams,
    "_3",
    true
);

values[0] = new physValue("VFA_TAC_fitness", VFA_TAC_fitness, "-");
```

**Parameter in fitness_params:**
- `VFA_TAC_min`: Minimales VFA/TAC-Verhältnis
- `VFA_TAC_max`: Maximales VFA/TAC-Verhältnis

**Typische Grenzen:**
- Min: 0.1
- Max: 0.4 (Warnung bei > 0.3)

**Interpretation:**
- 0: Verhältnis im optimalen Bereich
- >0: Verhältnis außerhalb (Instabilität)

**Beispiel:**
```csharp
var sensor = new VFA_TAC_fit_sensor();

physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// VFA/TAC für alle Fermenter
for (int i = 1; i <= myPlant.getNumDigesters(); i++)
{
    string id = myPlant.getDigesterID(i);
    double vfa_tac = mySensors.getCurrentMeasurementD($"VFA_TAC_{id}_3");
    
    string status = vfa_tac < 0.3 ? "Stabil" : 
                    vfa_tac < 0.4 ? "Warnung" : 
                    "INSTABIL";
    
    Console.WriteLine($"{id}: VFA/TAC = {vfa_tac:F3} ({status})");
}

Console.WriteLine($"\nVFA/TAC Fitness: {fitness[0].Value:F3}");
```

---

### 10. VFA_fit_sensor

Überwacht die VFA-Konzentration (Volatile Fatty Acids).

**Spec:** `"VFA_fit"`

**Messung:**
```csharp
double VFA_fitness = sensors.calcFitnessDigester_min_max(
    myPlant,
    mySensors,
    "VFA",
    "min_max",          // Min und Max prüfen
    myFitnessParams,
    "_3",
    true
);

values[0] = new physValue("VFA_fitness", VFA_fitness, "-");
```

**Parameter in fitness_params:**
- `VFA_min`: Minimale VFA [mg/l]
- `VFA_max`: Maximale VFA [mg/l]

**Typische Grenzen:**
- Min: 500 mg/l
- Max: 3000-5000 mg/l

**Interpretation:**
- 0: VFA im optimalen Bereich
- >0: VFA zu niedrig oder zu hoch

**Beispiel:**
```csharp
var sensor = new VFA_fit_sensor();

physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// VFA-Werte
for (int i = 1; i <= myPlant.getNumDigesters(); i++)
{
    string id = myPlant.getDigesterID(i);
    double vfa = mySensors.getCurrentMeasurementD($"VFA_{id}_3");
    
    string status = vfa < 3000 ? "Normal" : 
                    vfa < 5000 ? "Erhöht" : 
                    "KRITISCH";
    
    Console.WriteLine($"{id}: VFA = {vfa:F0} mg/l ({status})");
}

Console.WriteLine($"\nVFA Fitness: {fitness[0].Value:F3}");
```

---

### 11. VS_COD_fit_sensor

Bewertet den Abbaugrad der organischen Trockensubstanz (Volatile Solids).

**Spec:** `"VS_COD_fit"`

**Messung:**
```csharp
double VS_COD_degradationRate;
double VS_COD_fitness = getVS_COD_fitness(mySensors, out VS_COD_degradationRate);

values[0] = new physValue("VS_COD_fitness", VS_COD_fitness, "-");
```

**Private Hilfsmethode:**
```csharp
private static double getVS_COD_fitness(
    sensors mySensors,
    out double VS_COD_degradationRate
)
{
    // VS-CSB im Endlager
    physValue Q_final = mySensors.getCurrentMeasurement("Q_finalstorage_2");
    physValue VS_COD_final = mySensors.getCurrentMeasurement("VS_COD_finalstorage_2");
    double VS_COD_amount_final = VS_COD_final.Value * Q_final.Value;
    
    // VS-CSB im Substrat-Feed
    physValue Q_total = mySensors.getCurrentMeasurement("Q_total_mix_2");
    physValue VS_COD_substrate = mySensors.getCurrentMeasurement("VS_COD_total_mix_2");
    double VS_COD_amount_total = VS_COD_substrate.Value * Q_total.Value;
    
    // Abbaugrad [%]
    VS_COD_degradationRate = 
        (1 - Math.Max(VS_COD_amount_final, 0) / 
             Math.Max(VS_COD_amount_total, double.Epsilon)) * 100;
    
    // Normalisiert zwischen 0 und 1
    double VS_COD_fitness = Math.Abs(
        (1 - math.normalize(VS_COD_degradationRate, 0, 100))
    );
    
    return VS_COD_fitness;
}
```

**Interpretation:**
- 0: 100% Abbau (perfekt)
- 0.5: 50% Abbau
- 1: 0% Abbau

**Typischer Bereich:**
- Guter Abbau: 60-80%
- Fitness: 0.2-0.4

**Beispiel:**
```csharp
var sensor = new VS_COD_fit_sensor();

physValue[] fitness = sensor.measure(10.0, 0.5, myPlant, fitnessParams, mySensors);

// VS-CSB-Werte
double vs_cod_in = mySensors.getCurrentMeasurementD("VS_COD_total_mix_2");
double vs_cod_out = mySensors.getCurrentMeasurementD("VS_COD_finalstorage_2");

double degradation = (1 - vs_cod_out / vs_cod_in) * 100;