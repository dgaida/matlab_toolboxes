# Optimization Package API Documentation

## Übersicht

Das `biooptim` Namespace (Optimization) enthält Klassen zur Definition und Berechnung von Zielfunktionen für die Optimierung von Biogasanlagen.

## Klassen

### `objectives`

Definiert Zielfunktionen für die Optimierung von Biogasanlagen.

#### Öffentliche Methoden

##### `getObjectives(...)`

Berechnet alle Zielfunktionen und gibt Fitness-Werte zurück.

**Parameter:**
- `mySensors` (biogas.sensors): Sensor-Objekt der Anlage
- `myPlant` (biogas.plant): Anlagen-Objekt
- `mySubstrates` (biogas.substrates): Substrat-Objekt
- `myFitnessParams` (fitness_params): Fitness-Parameter

**Ausgabe-Parameter:**
- `Stability_punishment` (out double): Stabilitätsstrafe
- `energyBalance` (out double): Energiebilanz [1000 €/d]
- `energyProd_fitness` (out double): Energieproduktions-Fitness
- `energyConsumption` (out double): Elektrischer Energieverbrauch [kWh/d]
- `energyThConsumptionHeat` (out double): Thermischer Energieverbrauch [kWh/d]
- `energyConsumptionPump` (out double): Pumpen-Energieverbrauch [kWh/d]
- `energyConsumptionMixer` (out double): Rührwerk-Energieverbrauch [kWh/d]
- `energyProdMicro` (out double): Thermische Energieproduktion durch Mikrobiologie [kWh/d]
- `moneyEnergy` (out double): Erlös aus Energieverkauf [€/d]
- `fitness_constraints` (out double): Summe aller Constraint-Fitness-Werte
- `fitness` (out double[]): Fitness-Vektor

**Beschreibung:**

Diese Methode ist die Hauptschnittstelle zur Berechnung aller Zielfunktionen. Sie wertet verschiedene Aspekte der Anlagenperformance aus:

1. **CSB-Abbau**: Bewertung des Abbaus organischer Substanzen
2. **Methanqualität**: CH4-Anteil im Biogas
3. **pH-Stabilität**: Einhaltung optimaler pH-Bereiche
4. **FOS/TAC-Verhältnis**: Prozessstabilität
5. **TS-Konzentration**: Trockensubstanzgehalt
6. **VFA-Konzentration**: Flüchtige Fettsäuren
7. **Säureverhältnis**: Acetat zu Propionat
8. **TAC**: Pufferkapazität
9. **OLR**: Organische Raumbelastung
10. **HRT**: Hydraulische Verweilzeit
11. **Stickstoff**: NH4/NH3-Konzentrationen
12. **Gasüberschuss**: Nicht verwertbares Gas
13. **Stabilität**: Prozessstabilität
14. **Energieproduktion**: Elektrische und thermische Energie
15. **Wirtschaftlichkeit**: Kosten-Nutzen-Verhältnis

**Beispiel:**
```csharp
double stability, energyBalance, energyProdFit;
double energyCons, energyThCons, pumpCons, mixerCons, microProd;
double moneyEnergy, fitnessConstr;
double[] fitness;

objectives.getObjectives(
    sensors, plant, substrates, fitnessParams,
    out stability,
    out energyBalance,
    out energyProdFit,
    out energyCons,
    out energyThCons,
    out pumpCons,
    out mixerCons,
    out microProd,
    out moneyEnergy,
    out fitnessConstr,
    out fitness
);

Console.WriteLine($"Energiebilanz: {energyBalance} k€/d");
Console.WriteLine($"Fitness: {fitness[0]}");
```

#### Private Methoden

##### `calcFitnessConstraints(...)`

Berechnet die gewichtete Summe aller Constraint-Fitness-Werte.

**Parameter:**
- `myFitnessParams`: Fitness-Parameter mit Gewichten
- `SS_COD_fitness` (double): Fitness für SS-CSB-Abbau
- `VS_COD_fitness` (double): Fitness für VS-CSB-Abbau
- `pHvalue_fitness` (double): pH-Wert Fitness
- `VFA_TAC_fitness` (double): FOS/TAC Fitness
- `TS_fitness` (double): TS-Konzentrations-Fitness
- `VFA_fitness` (double): VFA-Konzentrations-Fitness
- `AcVsPro_fitness` (double): Acetat/Propionat-Verhältnis Fitness
- `TAC_fitness` (double): TAC-Fitness
- `OLR_fitness` (double): OLR-Fitness
- `HRT_fitness` (double): HRT-Fitness
- `N_fitness` (double): Stickstoff-Fitness
- `CH4_fitness` (double): Methan-Fitness
- `biogasExcess_fitness` (double): Gasüberschuss-Fitness [1000 €/d]
- `Stability_punishment` (double): Stabilitätsstrafe
- `energyProd_fitness` (double): Energieproduktions-Fitness
- `fitness_etaIE` (double): Fäkalkeimabbau (Enterokokken)
- `fitness_etaFC` (double): Fäkalkeimabbau (Coliforme)
- `diff_setpoints` (double): Sollwert-Abweichung

**Rückgabe:**
- `double`: Gewichtete Summe aller Constraint-Fitness-Werte

**Formel:**
```
fitness_constraints = 
    w_CSB * (SS_COD_fitness + VS_COD_fitness) +
    w_pH * pHvalue_fitness +
    w_TS * TS_fitness +
    w_gasexc * biogasExcess_fitness +
    w_CH4 * CH4_fitness +
    w_FOS_TAC * VFA_TAC_fitness +
    w_VFA * VFA_fitness +
    w_AcVsPro * AcVsPro_fitness +
    w_TAC * TAC_fitness +
    w_OLR * OLR_fitness +
    w_HRT * HRT_fitness +
    w_N * N_fitness +
    w_energy * energyProd_fitness +
    Stability_punishment +
    w_faecal * (fitness_etaIE + fitness_etaFC) +
    w_setpoint * diff_setpoints
```

##### `calcFitnessVector(...)`

Berechnet den finalen Fitness-Vektor basierend auf der Anzahl der Zielfunktionen.

**Parameter:**
- `myFitnessParams`: Fitness-Parameter
- `energyBalance` (double): Energiebilanz [1000 €/d]
- `fitness_constraints` (double): Constraint-Fitness
- `udot` (double): Substratänderung

**Rückgabe:**
- `double[]`: Fitness-Vektor

**Modi:**
1. **Ein Ziel (nObjectives = 1)**:
   ```
   fitness[0] = w_money * energyBalance + fitness_constraints + w_udot * udot
   ```

2. **Zwei Ziele (nObjectives = 2)**:
   ```
   fitness[0] = energyBalance
   fitness[1] = fitness_constraints + w_udot * udot
   ```

3. **Drei Ziele (nObjectives = 3)**:
   ```
   fitness[0] = energyBalance
   fitness[1] = fitness_constraints
   fitness[2] = w_udot * udot
   ```

##### `getElEnergyConsumption(...)`

Berechnet den elektrischen Energieverbrauch.

**Parameter:**
- `myPlant` (biogas.plant): Anlagen-Objekt
- `mySensors` (biogas.sensors): Sensor-Objekt
- `energyConsumptionPump` (out double): Pumpen-Verbrauch [kWh/d]
- `energyConsumptionMixer` (out double): Rührwerk-Verbrauch [kWh/d]

**Rückgabe:**
- `double`: Gesamter elektrischer Energieverbrauch [kWh/d]

**Komponenten:**
- Pumpen für Substratförderung
- Pumpen für Substrattransport
- Rührwerke in allen Fermentern

##### `getThermalEnergyConsumption(...)`

Berechnet den thermischen Energieverbrauch.

**Parameter:**
- `myPlant` (biogas.plant): Anlagen-Objekt
- `mySensors` (biogas.sensors): Sensor-Objekt
- `energyConsumptionHeat` (out double): Wärmeverluste [kWh/d]
- `energyProdMixer` (out double): Wärmeproduktion durch Rührwerke [kWh/d]
- `energyProdMicro` (out double): Wärmeproduktion durch Mikrobiologie [kWh/d]

**Rückgabe:**
- `double`: Netto-thermischer Energieverbrauch [kWh/d]

**Komponenten:**
- Substrataufheizung
- Wärmeverluste durch Strahlung
- Wärmeproduktion durch Bakterien (negativ)
- Wärmeproduktion durch Rührwerk-Dissipation (negativ)

##### `getMaxElEnergyProduction(...)`

Berechnet die maximal mögliche elektrische Energieproduktion.

**Parameter:**
- `myPlant` (biogas.plant): Anlagen-Objekt

**Rückgabe:**
- `double`: Maximale elektrische Energie [kWh/d]

**Berechnung:**
```
Pmax = Σ(Pel_BHKW * 24h)
```

## Energiebilanz

### Berechnung

```csharp
energyBalance = 
    energyConsumption * priceElEnergy +     // Stromkosten
    costs_heating +                          // Heizkosten
    - moneyEnergy +                          // Erlöse
    substrate_costs;                         // Substratkosten
    
// Umrechnung in 1000 €/d
energyBalance = energyBalance / 1000;
```

### Komponenten

1. **Kosten:**
   - Elektrischer Strom für Pumpen und Rührwerke
   - Heizung (thermische Energie)
   - Substratkosten

2. **Erlöse:**
   - Verkauf elektrischer Energie
   - Verkauf thermischer Energie (oder virtuelle Gutschrift bei Eigennutzung)

## Constraint-Bewertung

### Normalisierung

Alle Constraint-Fitness-Werte sind zwischen 0 und 1 normalisiert:
- **0**: Optimaler Zustand
- **1**: Kritischer Zustand (Grenze verletzt)

### Tukey-Funktion

Viele Constraints verwenden Tukey-Funktionen für weiche Übergänge:

```
           ⎧ 0                              wenn x ≤ min
fitness =  ⎨ ((x - min) / (max - min))²    wenn min < x < max
           ⎩ 1                              wenn x ≥ max
```

## Anwendungsbeispiele

### Grundlegende Optimierung

```csharp
// Anlage und Parameter vorbereiten
var plant = new biogas.plant("plant_config.xml");
var sensors = new biogas.sensors();
var substrates = new biogas.substrates("substrates.xml");
var fitnessParams = new fitness_params(2);

// Gewichte setzen
fitnessParams.myWeights.set_params_of(
    "w_money", 0.4,
    "w_CH4", 0.2,
    "w_pH", 0.15,
    "w_OLR", 0.15,
    "w_VFA", 0.1
);

// Zielfunktionen berechnen
double stability, energyBalance, energyProdFit;
double energyCons, energyThCons, pumpCons, mixerCons, microProd;
double moneyEnergy, fitnessConstr;
double[] fitness;

objectives.getObjectives(
    sensors, plant, substrates, fitnessParams,
    out stability, out energyBalance, out energyProdFit,
    out energyCons, out energyThCons, out pumpCons,
    out mixerCons, out microProd, out moneyEnergy,
    out fitnessConstr, out fitness
);

// Ergebnisse auswerten
Console.WriteLine("=== Optimierungsergebnisse ===");
Console.WriteLine($"Fitness: {fitness[0]:F3}");
Console.WriteLine($"Energiebilanz: {energyBalance:F2} k€/d");
Console.WriteLine($"Constraints: {fitnessConstr:F3}");
Console.WriteLine($"Stromverbrauch: {energyCons:F1} kWh/d");
Console.WriteLine($"  - Pumpen: {pumpCons:F1} kWh/d");
Console.WriteLine($"  - Rührwerke: {mixerCons:F1} kWh/d");
Console.WriteLine($"Wärmebedarf: {energyThCons:F1} kWh/d");
Console.WriteLine($"Energieerlös: {moneyEnergy:F2} €/d");
```

### Multi-Objective Optimization

```csharp
// Fitness-Parameter für 2 Ziele
var fitnessParams = new fitness_params(2);
fitnessParams.set_params_of("nObjectives", 2);

// Zielfunktionen berechnen
double[] fitness;
// ... getObjectives aufrufen ...

// Pareto-Front auswerten
Console.WriteLine("=== Multi-Objective Ergebnisse ===");
Console.WriteLine($"Ziel 1 (Wirtschaftlichkeit): {fitness[0]:F2} k€/d");
Console.WriteLine($"Ziel 2 (Prozessstabilität): {fitness[1]:F3}");
```

### Sensitivitätsanalyse für Gewichte

```csharp
var fitnessParams = new fitness_params(2);
var results = new List<(double weight, double fitness)>();

// Verschiedene Gewichtungen testen
for (double w = 0.0; w <= 1.0; w += 0.1)
{
    fitnessParams.myWeights.set_params_of(
        "w_money", w,
        "w_CH4", 1.0 - w
    );
    
    double[] fitness;
    // ... getObjectives aufrufen ...
    
    results.Add((w, fitness[0]));
}

// Trade-off visualisieren
Console.WriteLine("=== Sensitivitätsanalyse ===");
Console.WriteLine("Gewicht (Geld) | Fitness");
foreach (var (weight, fit) in results)
{
    Console.WriteLine($"{weight:F1}            | {fit:F3}");
}
```

### Energiebilanz-Analyse

```csharp
double energyBalance, energyCons, energyThCons;
double pumpCons, mixerCons, microProd, moneyEnergy;
// ... andere out-Parameter ...

objectives.getObjectives(
    sensors, plant, substrates, fitnessParams,
    // ... Parameter ...
);

// Detaillierte Energiebilanz
Console.WriteLine("=== Energiebilanz ===");
Console.WriteLine($"Elektrisch:");
Console.WriteLine($"  Verbrauch gesamt: {energyCons:F1} kWh/d");
Console.WriteLine($"    - Pumpen: {pumpCons:F1} kWh/d");
Console.WriteLine($"    - Rührwerke: {mixerCons:F1} kWh/d");

Console.WriteLine($"Thermisch:");
Console.WriteLine($"  Verbrauch netto: {energyThCons:F1} kWh/d");
Console.WriteLine($"  Produktion (Mikro): {microProd:F1} kWh/d");

Console.WriteLine($"Wirtschaftlich:");
Console.WriteLine($"  Energieerlös: {moneyEnergy:F2} €/d");
Console.WriteLine($"  Bilanz: {energyBalance:F2} k€/d");
```

## Constraint-Übersicht

| Constraint | Bewertung | Einheit | Optimum |
|------------|-----------|---------|---------|
| SS_COD | Abbaurate | 0-1 | 0 (max. Abbau) |
| VS_COD | Abbaurate | 0-1 | 0 (max. Abbau) |
| pH | Tukey | 0-1 | 0 (pH_optimum) |
| TS | Tukey | 0-1 | 0 (< TS_max) |
| VFA/TAC | Tukey | 0-1 | 0 (min < x < max) |
| VFA | Tukey | 0-1 | 0 (min < x < max) |
| TAC | Tukey | 0-1 | 0 (> TAC_min) |
| OLR | Tukey | 0-1 | 0 (< OLR_max) |
| HRT | Tukey | 0-1 | 0 (min < x < max) |
| NH4/NH3 | Tukey | 0-1 | 0 (< max) |
| CH4 | Tukey | 0-1 | 0 (> 50%) |
| Gasüberschuss | Linear | k€/d | 0 |
| AcVsPro | Tukey | 0-1 | 0 (> min) |

## Hinweise

- **Einheiten**: Energiebilanz in 1000 €/d, Energien in kWh/d
- **Normalisierung**: Fitness-Werte zwischen 0 (optimal) und ∞ (schlecht)
- **Gewichte**: Automatische Normalisierung in weights-Klasse
- **Multi-Objective**: Unterstützung für 1-3 Zielfunktionen
- **Gasüberschuss**: Verlust durch nicht verwertbares Biogas wird monetär bewertet
- **Stabilitätsstrafe**: Binäre Strafe bei instabilem Prozess (aktuell nicht implementiert)

## TODOs

Laut Quellcode:
- OLR und HRT der Gesamtanlage berechnen
- Stabilitätsbewertung implementieren
- Dokumentation verbessern
- Verhältnis Propionsäure zu Essigsäure in Fitnessfunktion einbauen
- C:N-Verhältnis als Randbedingung
- THG-Emissionen hinzufügen
