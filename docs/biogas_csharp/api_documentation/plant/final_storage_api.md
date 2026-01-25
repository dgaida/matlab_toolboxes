# Final Storage Tank API Documentation

## Übersicht

Das `biogas.final_storage_tank` Namespace enthält die Klasse zur Modellierung des Endlagers (Gärrestlager) einer Biogasanlage. Das Endlager dient zur Zwischenlagerung des ausgegärten Gärrests vor der Ausbringung als Dünger.

---

## Klasse: `final_storage_tank`

**Status:** Minimale Implementierung (nur Messfunktionen)

Definiert ein Endlager für Gärrest nach der Fermentation.

### Zweck

Das Endlager hat folgende Funktionen:
1. **Zwischenlagerung**: Pufferung des Gärrests bis zur Ausbringung
2. **Messung**: Erfassung von CSB, VS und Volumenstrom des Auslaufs
3. **Qualitätskontrolle**: Überwachung der Gärrest-Eigenschaften

### Methoden

#### `static run(double t, double[] x, biogas.sensors mySensors)`

Betreibt das Endlager (Messung der Auslaufparameter).

**Parameter:**
- `t` (double): Aktuelle Simulationszeit [d]
- `x` (double[]): ADM-Zustandsvektor des Auslaufstroms
- `mySensors` (biogas.sensors): Sensor-Objekt

**Funktionalität:**
- Misst SS-COD (suspended solids CSB) im Auslaufstrom
- Misst VS-COD (volatile solids CSB) im Auslaufstrom
- Misst Volumenstrom Q des Auslaufs

**Gemessene Sensoren:**
1. `"SS_COD_finalstorage_2"` - Suspended Solids CSB [kgCOD/m³]
2. `"VS_COD_finalstorage_2"` - Volatile Solids CSB [kgCOD/m³]
3. `"Q_finalstorage_2"` - Volumenstrom [m³/d]

**Beispiel:**
```csharp
using biogas;

var sensors = new biogas.sensors();
double t = 10.0;  // Tag 10
double[] x = /* ADM-Zustandsvektor des Gärrests */;

// Endlager betreiben
final_storage_tank.run(t, x, sensors);

// Messwerte abrufen
double SS_COD, VS_COD, Q;
sensors.getMeasurementAt("SS_COD", "SS_COD_finalstorage_2", t, out SS_COD);
sensors.getMeasurementAt("VS_COD", "VS_COD_finalstorage_2", t, out VS_COD);
sensors.getMeasurementAt("Q", "Q_finalstorage_2", t, out Q);

Console.WriteLine($"Endlager-Auslauf (Tag {t}):");
Console.WriteLine($"  SS-COD: {SS_COD:F2} kgCOD/m³");
Console.WriteLine($"  VS-COD: {VS_COD:F2} kgCOD/m³");
Console.WriteLine($"  Volumenstrom: {Q:F1} m³/d");
```

---

## TODOs

Basierend auf den Code-Kommentaren:

### Aktuell fehlend

1. **Volatile Solids Messung**
   - TODO: Messung von VS (nicht nur VS-COD)
   - Wichtig für Düngewertberechnung

2. **Substrat-Information**
   - TODO: Substrat-Parameter müssten übergeben werden
   - Für genaue Charakterisierung des Gärrests

3. **Erweiterte Funktionalität**
   - Speichervolumen modellieren
   - Füllstand tracken
   - Geruchsemissionen berechnen
   - Nährstoffgehalt (N, P, K) berechnen
   - Abdeckung/Gasdichtheit modellieren

---

## Geplante Erweiterungen

### Vollständige Endlager-Klasse

```csharp
public class final_storage_tank
{
    // Identifikation
    public string id;
    public string name;
    
    // Geometrie
    private physValue Vtot;        // Gesamtvolumen [m³]
    private physValue Vliq;        // Aktuelles Flüssigkeitsvolumen [m³]
    private physValue Vliq_max;    // Max. Volumen [m³]
    private physValue depth;       // Tiefe [m]
    private physValue diameter;    // Durchmesser [m] (rund) oder
    private physValue length;      // Länge [m] (rechteckig)
    private physValue width;       // Breite [m] (rechteckig)
    
    // Eigenschaften
    private bool covered;          // Abgedeckt (true/false)
    private string cover_type;     // "none", "foil", "concrete", "floating"
    
    // Gärrest-Eigenschaften
    private physValue TS;          // Trockensubstanz [% FM]
    private physValue VS;          // Organische TS [% TS]
    private physValue pH;          // pH-Wert [-]
    private physValue N_tot;       // Gesamt-Stickstoff [kg/m³]
    private physValue N_NH4;       // Ammonium-Stickstoff [kg/m³]
    private physValue P;           // Phosphor [kg/m³]
    private physValue K;           // Kalium [kg/m³]
    
    // Emissionen
    private physValue NH3_emission;  // Ammoniakemission [kg/d]
    private physValue CH4_emission;  // Methanemission (Restgärung) [m³/d]
    private physValue odor;          // Geruchsemission [GE/s]
}
```

### Geplante Methoden

#### Füllstand-Management

```csharp
public void addSludge(double[] x_sludge, double Q)
{
    // Gärrest hinzufügen
    // Aktualisiert Vliq
    // Aktualisiert Zusammensetzung (gewichtetes Mittel)
}

public double[] removeSludge(double Q)
{
    // Gärrest entnehmen
    // Reduziert Vliq
    // Gibt ADM-Zustandsvektor zurück
}

public double getFillLevel()
{
    return Vliq / Vliq_max;  // 0...1
}

public double getAvailableCapacity()
{
    return Vliq_max - Vliq;  // m³
}

public double getStorageDays(double Q_out_avg)
{
    // Tage bis Lager voll
    return (Vliq_max - Vliq) / Q_out_avg;
}
```

#### Nährstoff-Berechnung

```csharp
public physValue calcTotalNitrogen(double[] x)
{
    // N_tot = organischer N + Ammonium-N
    // Aus ADM-Zustandsvektor
}

public physValue calcNH4_N(double[] x)
{
    // Ammonium-Stickstoff aus ADM
}

public physValue calcFertilizerValue(double[] x)
{
    // Düngewert basierend auf N, P, K
    // In €/m³
}
```

#### Emissions-Berechnung

```csharp
public physValue calcNH3Emission(double T_ambient, double windspeed)
{
    // Ammoniakemission abhängig von:
    // - NH4-Gehalt
    // - Temperatur
    // - Windgeschwindigkeit
    // - Abdeckung
}

public physValue calcCH4Emission()
{
    // Restgärung im Endlager
    // Methanschlupf
}

public physValue calcOdorEmission()
{
    // Geruchsemission
    // Abhängig von VS, Lagertemperatur, Abdeckung
}
```

#### Wärmemanagement

```csharp
public physValue calcHeatLoss(physValue T_ambient)
{
    // Wärmeverlust an Umgebung
    // Wichtig wenn Gärrest warm eingelagert wird
}

public physValue calcTemperatureChange(double dt, double Q_in, 
                                       physValue T_in, physValue T_ambient)
{
    // Temperaturänderung im Lager
}
```

---

## Anwendungsbeispiele (geplant)

### Beispiel 1: Einfaches Endlager

```csharp
using biogas;

// Endlager erstellen
var storage = new final_storage_tank();
storage.set_params_of(
    "id", "storage_1",
    "name", "Gärrestlager",
    "Vtot", 5000.0,      // 5000 m³
    "Vliq", 2000.0,      // Aktuell 2000 m³
    "covered", true,
    "cover_type", "foil"
);

// Füllstand
double fillLevel = storage.getFillLevel();
Console.WriteLine($"Füllstand: {fillLevel:P0}");

// Kapazität
double capacity = storage.getAvailableCapacity();
Console.WriteLine($"Freie Kapazität: {capacity:F0} m³");
```

### Beispiel 2: Gärrest einlagern

```csharp
using biogas;

var storage = new final_storage_tank("storage.xml");
var sensors = new biogas.sensors();

// Gärrest aus Fermenter
double t = 10.0;
double[] x_sludge = /* ADM-Zustandsvektor */;
double Q_in = 150.0;  // m³/d

// Einlagern
storage.addSludge(x_sludge, Q_in);

// Messung
final_storage_tank.run(t, x_sludge, sensors);

// Nährstoffgehalt
physValue N_tot = storage.calcTotalNitrogen(x_sludge);
physValue fertilizer_value = storage.calcFertilizerValue(x_sludge);

Console.WriteLine($"Gesamt-N: {N_tot.Value:F2} kg/m³");
Console.WriteLine($"Düngewert: {fertilizer_value.Value:F2} €/m³");
```

### Beispiel 3: Emissionen berechnen

```csharp
using biogas;
using science;

var storage = new final_storage_tank("storage.xml");

// Umgebungsbedingungen
var T_ambient = new physValue(15, "°C");
double windspeed = 3.0;  // m/s

// Emissionen
physValue NH3_em = storage.calcNH3Emission(T_ambient, windspeed);
physValue CH4_em = storage.calcCH4Emission();
physValue odor = storage.calcOdorEmission();

Console.WriteLine("Emissionen:");
Console.WriteLine($"  NH3: {NH3_em.Value:F2} kg/d");
Console.WriteLine($"  CH4: {CH4_em.Value:F2} m³/d");
Console.WriteLine($"  Geruch: {odor.Value:F0} GE/s");

// Mit/ohne Abdeckung vergleichen
storage.set_params_of("covered", false);
physValue NH3_em_uncovered = storage.calcNH3Emission(T_ambient, windspeed);

Console.WriteLine($"\nNH3-Emission ohne Abdeckung: {NH3_em_uncovered.Value:F2} kg/d");
Console.WriteLine($"Reduktion durch Abdeckung: {(1 - NH3_em.Value/NH3_em_uncovered.Value):P0}");
```

### Beispiel 4: Lager-Management

```csharp
using biogas;

var storage = new final_storage_tank("storage.xml");

// Tägliche Zu-/Abflüsse
double Q_in_avg = 150.0;   // m³/d aus Fermenter
double Q_out_avg = 100.0;  // m³/d Ausbringung

// Prognose
double days_until_full = storage.getStorageDays(Q_in_avg - Q_out_avg);

Console.WriteLine($"Tage bis Lager voll: {days_until_full:F1}");

if (days_until_full < 30)
{
    Console.WriteLine("Warnung: Ausbringung in den nächsten 30 Tagen erforderlich!");
}

// Optimale Ausbringmenge
double target_fill = 0.5;  // 50% Sollwert
double V_current = storage.Vliq.Value;
double V_target = storage.Vliq_max.Value * target_fill;

double Q_out_optimal = (V_current - V_target) / 30 + Q_in_avg;
Console.WriteLine($"Empfohlene Ausbringrate: {Q_out_optimal:F1} m³/d");
```

### Beispiel 5: Wirtschaftlichkeit

```csharp
using biogas;

var storage = new final_storage_tank("storage.xml");
double[] x = /* ADM-Zustandsvektor */;

// Nährstoffgehalt
physValue N_tot = storage.calcTotalNitrogen(x);
physValue P = storage.calcPhosphorus(x);
physValue K = storage.calcPotassium(x);

// Düngewert berechnen
double price_N = 1.50;   // €/kg N
double price_P = 2.00;   // €/kg P
double price_K = 0.80;   // €/kg K

double value_per_m3 = N_tot.Value * price_N + 
                      P.Value * price_P + 
                      K.Value * price_K;

double total_value = storage.Vliq.Value * value_per_m3;

Console.WriteLine("Düngewert des Lagerinhalts:");
Console.WriteLine($"  N: {N_tot.Value:F2} kg/m³ × {price_N} €/kg = {N_tot.Value * price_N:F2} €/m³");
Console.WriteLine($"  P: {P.Value:F2} kg/m³ × {price_P} €/kg = {P.Value * price_P:F2} €/m³");
Console.WriteLine($"  K: {K.Value:F2} kg/m³ × {price_K} €/kg = {K.Value * price_K:F2} €/m³");
Console.WriteLine($"\nGesamt: {value_per_m3:F2} €/m³");
Console.WriteLine($"Lagerinhalt ({storage.Vliq.Value} m³): {total_value:N0} €");
```

---

## Typische Dimensionierung

### Lagerkapazität

**Faustregel:**
- Mindestens 6 Monate Lagerkapazität (gesetzlich oft vorgeschrieben)
- Besser 9-12 Monate (flexiblere Ausbringung)

**Berechnung:**
```
V_lager = Q_gärrest × Lagerzeit

Beispiel:
Q_gärrest = 150 m³/d
Lagerzeit = 180 d (6 Monate)
V_lager = 150 × 180 = 27.000 m³
```

### Geometrie

#### Runde Lager (häufig)
```
V = π × r² × h
```

**Typische Dimensionen:**
- Durchmesser: 20-50 m
- Tiefe: 4-8 m
- Wandhöhe über Gelände: 0.5-1 m (Erdwall)

#### Rechteckige Lager
```
V = Länge × Breite × Tiefe
```

**Typische Dimensionen:**
- Länge: 30-100 m
- Breite: 20-40 m
- Tiefe: 4-8 m

---

## Abdeckungstypen

### 1. Keine Abdeckung (veraltet)
- **Vorteile:** Niedrige Kosten
- **Nachteile:** Hohe Emissionen (NH3, Geruch), Regenwasserproblematik
- **Heute nicht mehr Stand der Technik**

### 2. Folienabdeckung (häufig)
- **Vorteile:** Kosteneffektiv, reduziert Emissionen deutlich
- **Nachteile:** Wartung nötig, begrenzte Lebensdauer
- **Emissionsreduktion:** ~70-90% NH3, ~80-95% Geruch

### 3. Betondecke (gasdicht)
- **Vorteile:** Sehr niedrige Emissionen, lange Lebensdauer, Gasfassung möglich
- **Nachteile:** Hohe Investitionskosten
- **Emissionsreduktion:** ~95-99% NH3, ~95-99% Geruch

### 4. Schwimmdecke (Schwimmschicht)
- **Vorteile:** Natürliche Schwimmschicht aus Feststoffen
- **Nachteile:** Nicht immer stabil, mittlere Emissionsreduktion
- **Emissionsreduktion:** ~40-60% NH3, ~50-70% Geruch

---

## Rechtliche Anforderungen

### Deutschland (beispielhaft)

**Lagerkapazität:**
- Mindestens 6 Monate (oft 9 Monate in nitratbelasteten Gebieten)

**Emissionsschutz:**
- Abdeckung vorgeschrieben (Ausnahmen für Altanlagen)
- TA Luft und Geruchsimmissionsrichtlinie beachten

**Gewässerschutz:**
- Abdichtung erforderlich (Folie oder Beton)
- Abstand zu Gewässern einhalten
- Überlaufsicherung

**Statik:**
- Standsicherheit nachweisen
- Böschungswinkel beachten

---

## Best Practices (für geplante Implementierung)

### 1. Dimensionierung

```csharp
// GUT: Ausreichende Kapazität vorsehen
double Q_gaerrest_daily = 150;  // m³/d
double safety_margin = 1.2;     // 20% Sicherheit
int months = 9;                 // 9 Monate

double V_required = Q_gaerrest_daily * 30 * months * safety_margin;
storage.set_params_of("Vtot", V_required);
```

### 2. Emissionsminimierung

```csharp
// GUT: Abdeckung verwenden
storage.set_params_of(
    "covered", true,
    "cover_type", "foil"  // oder "concrete"
);

// Emissionen tracken
physValue NH3_em = storage.calcNH3Emission(T_ambient, windspeed);
if (NH3_em.Value > 10)  // kg/d
{
    Console.WriteLine("Warnung: Hohe NH3-Emissionen!");
}
```

### 3. Füllstand-Management

```csharp
// GUT: Regelmäßig überwachen
double fillLevel = storage.getFillLevel();

if (fillLevel > 0.9)
{
    Console.WriteLine("Kritisch: Lager fast voll!");
    // Ausbringung planen
}
else if (fillLevel > 0.7)
{
    Console.WriteLine("Warnung: Lager zu 70% gefüllt");
    // Ausbringung vorbereiten
}
```

### 4. Nährstoff-Dokumentation

```csharp
// GUT: Nährstoffgehalt für Düngeverordnung dokumentieren
physValue N_tot = storage.calcTotalNitrogen(x);
physValue P = storage.calcPhosphorus(x);

// Für Düngeplanung protokollieren
Console.WriteLine($"Nährstoffgehalt (Mittelwert):");
Console.WriteLine($"  N-gesamt: {N_tot.Value:F2} kg/m³");
Console.WriteLine($"  P: {P.Value:F2} kg/m³");
Console.WriteLine($"  K: {K.Value:F2} kg/m³");
```

---

## Integration in Gesamtmodell

### Verbindung mit Fermentern

```
Fermenter 1
     │
     ↓ Pumpe P1
Fermenter 2
     │
     ↓ Pumpe P2
Endlager (final_storage_tank)
     │
     ↓ Ausbringung
Feld
```

### In plant-Klasse (geplant)

```csharp
public class plant
{
    // Bestehende Komponenten
    public digesters myDigesters;
    public chps myCHPs;
    public transportation myTransportation;
    
    // Neu: Endlager
    public final_storage_tank myFinalStorage;
    
    // Methode
    public void transferToFinalStorage(double t, string digester_id, double Q)
    {
        // Gärrest aus Fermenter entnehmen
        var digester = myDigesters.get(digester_id);
        double[] x = digester.AD_Model.getState();
        
        // In Endlager übertragen
        myFinalStorage.addSludge(x, Q);
    }
}
```

---

## Siehe auch

- **biogas.digesters**: Fermenter als Quelle des Gärrests
- **biogas.transportation**: Pumpen zum Endlager
- **biogas.sludge**: Gärrest-Charakterisierung
- **biogas.sensors**: Messung der Endlager-Parameter

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*  
*Status: Minimale Implementierung, umfangreiche Erweiterungen geplant*
