# Gas Storage Package API Documentation

## Übersicht

Das `biogas.gas_storage` Namespace enthält Klassen zur Modellierung von Gasspeichern in Biogasanlagen. Diese Dokumentation beschreibt den aktuellen Stand und geplante Funktionalität.

---

## Klasse: `gas_storage`

**Status:** Platzhalter-Klasse (noch nicht implementiert)

Modelliert einen Biogasspeicher zur Pufferung von Biogasproduktion und -verbrauch.

### Konzept

Der Gasspeicher soll als Puffer zwischen Biogasproduktion (aus Fermentern) und Biogasverbrauch (durch BHKWs) dienen.

#### Design-Überlegungen (aus Kommentaren im Code)

**Regelungsstrategie:**
- Gasspeicher sollte immer halb voll geregelt werden
- Ermöglicht gleichmäßige Bereitstellung von positiver und negativer Regelenergie

**Dimensionierung (Beispiel):**
```
Gasspeichervolumen: 1000 m³
Max. Biogasproduktion: 6000 m³/d

Puffer von leer → voll: 1000/6000 = 1/6 Tag = 4 h
Puffer von halb → voll: 2 h
Puffer von halb → leer: 2 h
```

**Interpretation:**
- Bei maximaler Produktion und keinem Verbrauch: 2h bis Speicher voll
- Bei keiner Produktion und maximalem Verbrauch: 2h bis Speicher leer

---

## Geplante Funktionalität

### Eigenschaften (geplant)

```csharp
// Volumina
private physValue _Vgas          // Aktuelles Gasvolumen [m³]
private physValue _Vgas_max      // Max. Speichervolumen [m³]
private physValue _Vgas_min      // Min. Speichervolumen [m³]

// Sollwert für Regelung
private physValue _Vgas_setpoint // Sollvolumen [m³] (Standard: Vgas_max/2)

// Drücke
private physValue _p_gas         // Aktueller Gasdruck [bar]
private physValue _p_max         // Max. Gasdruck [bar]
private physValue _p_min         // Min. Gasdruck [bar]

// Biogaszusammensetzung
private double[] _composition    // CH4, CO2, H2, H2S [m³/m³ oder %]

// Regelung
private physValue _kp            // Proportionale Verstärkung
```

### Methoden (geplant)

#### Konstruktoren

```csharp
public gas_storage()
public gas_storage(string id, string name)
public gas_storage(physValue Vgas_max)
public gas_storage(string XMLfile)
```

#### Dynamik

```csharp
// Aktualisierung
public void update(double dt, double Q_in, double Q_out)
{
    // Volumen aktualisieren
    // Druck berechnen
    // Überlauf/Unterlauf prüfen
}

// Zustandsvektor
public double[] getState()
{
    // [Vgas, p_gas, composition...]
}

public void setState(double[] state)
```

#### Regelung

```csharp
// Regelabweichung berechnen
public double getControlError()
{
    return Vgas.Value - Vgas_setpoint.Value;
}

// Stellgröße für BHKW-Regelung
public double getControlSignal()
{
    double error = getControlError();
    return kp.Value * error;  // P-Regler
}

// Füllstand prüfen
public bool isFull()
{
    return Vgas.Value >= Vgas_max.Value * 0.95;
}

public bool isEmpty()
{
    return Vgas.Value <= Vgas_min.Value * 1.05;
}

public double getFillLevel()
{
    return Vgas.Value / Vgas_max.Value;  // [0...1]
}
```

#### Biogasmanagement

```csharp
// Biogas entnehmen
public double[] withdrawBiogas(double Q_needed)
{
    // Gibt Biogasstrom zurück [m³/d]
    // Reduziert Speicherinhalt
    // Bei leerem Speicher: Q_available < Q_needed
}

// Biogas einspeichern
public void storeBiogas(double[] Q_biogas)
{
    // Erhöht Speicherinhalt
    // Bei vollem Speicher: Überlauf
}

// Überschuss abfackeln
public double getExcessBiogas()
{
    if (isFull())
        return /* Überlaufmenge */;
    return 0.0;
}
```

#### Thermodynamik

```csharp
// Druck aus Volumen berechnen (ideales Gas)
private double calcPressure(double V, double T)
{
    // p = n*R*T/V
    // Ideales Gasgesetz
}

// Temperatureinfluss
public void setTemperature(physValue T)
{
    // Temperaturänderung → Druckänderung
}
```

---

## Anwendungsfälle (geplant)

### Beispiel 1: Speicher initialisieren

```csharp
// Gasspeicher erstellen
var storage = new gas_storage();
storage.set_params_of(
    "Vgas_max", 1000.0,     // 1000 m³
    "Vgas_min", 50.0,       // 50 m³ Totraum
    "Vgas", 500.0,          // Initial halb voll
    "p_max", 1.05,          // 1.05 bar
    "p_min", 1.01,          // 1.01 bar
    "kp", 10.0              // Regelparameter
);
```

### Beispiel 2: Speicher in Simulation einbinden

```csharp
// Zeitschritt
double dt = 1.0/24.0;  // 1 Stunde in Tagen

// Biogasproduktion aus Fermentern
double Q_produced = 6000.0;  // m³/d

// Biogasverbrauch durch BHKWs
double Q_consumed = 5500.0;  // m³/d

// Speicher aktualisieren
storage.update(dt, Q_produced, Q_consumed);

// Füllstand prüfen
double fillLevel = storage.getFillLevel();
Console.WriteLine($"Füllstand: {fillLevel:P0}");

if (storage.isFull())
{
    double excess = storage.getExcessBiogas();
    Console.WriteLine($"Abfackeln: {excess:F1} m³/d");
}
```

### Beispiel 3: BHKW-Regelung mit Gasspeicher

```csharp
// Regelung: BHKW passt sich an Speicherfüllstand an
double controlSignal = storage.getControlSignal();

// Positives Signal → Speicher zu voll → BHKW hochfahren
// Negatives Signal → Speicher zu leer → BHKW herunterfahren

// BHKW-Leistung anpassen
double Pel_nominal = 500.0;  // kW
double Pel_adjusted = Pel_nominal * (1.0 + 0.1 * controlSignal);

// Begrenzen
Pel_adjusted = Math.Max(0.5 * Pel_nominal, 
                        Math.Min(1.1 * Pel_nominal, Pel_adjusted));

Console.WriteLine($"BHKW Leistung: {Pel_adjusted:F1} kW");
```

### Beispiel 4: Gasqualität tracken

```csharp
// Verschiedene Fermenter produzieren unterschiedliche Gasqualitäten
double[] biogas_f1 = {5, 300, 150};   // H2, CH4, CO2 [m³/d]
double[] biogas_f2 = {3, 250, 125};

// In Speicher einspeisen
storage.storeBiogas(biogas_f1);
storage.storeBiogas(biogas_f2);

// Durchschnittliche Zusammensetzung
double[] composition = storage.getComposition();
double ch4_percent = composition[1] / composition.Sum() * 100;

Console.WriteLine($"CH4-Gehalt im Speicher: {ch4_percent:F1}%");
```

---

## Integration mit Fermenter-Gasphase

### Konzept

Der Gasspeicher kann als Erweiterung der Fermenter-Gasphase verstanden werden:

```
Fermenter 1 (Gasphase: 400 m³)
     │
Fermenter 2 (Gasphase: 500 m³)  →  Gasspeicher (1000 m³)  →  BHKWs
     │
Fermenter 3 (Gasphase: 300 m³)
```

**Gesamtgasvolumen:** 400 + 500 + 300 + 1000 = 2200 m³

### Implementierungsansatz

```csharp
// Methode in plant-Klasse
public double getTotalGasVolume()
{
    double total = 0;
    
    // Fermenter-Gasphasen
    foreach (var digester in myDigesters)
    {
        total += digester.Vgas.Value;
    }
    
    // Externer Gasspeicher
    if (myGasStorage != null)
    {
        total += myGasStorage.Vgas.Value;
    }
    
    return total;
}

// Pufferzeit berechnen
public double getGasBufferTime(double Q_biogas_avg)
{
    double totalGas = getTotalGasVolume();
    return totalGas / Q_biogas_avg;  // [d]
}
```

---

## Regelungsstrategien

### 1. Einfache Schwellwert-Regelung

```csharp
public class SimpleGasStorageControl
{
    private gas_storage storage;
    private double threshold_high = 0.8;  // 80% voll
    private double threshold_low = 0.2;   // 20% voll
    
    public double getBHKWLoadFactor()
    {
        double fillLevel = storage.getFillLevel();
        
        if (fillLevel > threshold_high)
            return 1.1;  // 110% Leistung
        else if (fillLevel < threshold_low)
            return 0.5;  // 50% Leistung
        else
            return 1.0;  // Nennleistung
    }
}
```

### 2. P-Regler

```csharp
public class ProportionalGasStorageControl
{
    private gas_storage storage;
    private double kp = 10.0;
    
    public double getBHKWLoadFactor()
    {
        // Regelabweichung
        double error = storage.getControlError() / storage.Vgas_max.Value;
        
        // Stellgröße
        double u = kp * error;
        
        // Lastfaktor: 1.0 ± u
        double loadFactor = 1.0 + u;
        
        // Begrenzen auf [0.5, 1.1]
        return Math.Max(0.5, Math.Min(1.1, loadFactor));
    }
}
```

### 3. PI-Regler (fortgeschritten)

```csharp
public class PIGasStorageControl
{
    private gas_storage storage;
    private double kp = 10.0;
    private double ki = 1.0;
    private double integral = 0.0;
    
    public double getBHKWLoadFactor(double dt)
    {
        // Regelabweichung
        double error = storage.getControlError() / storage.Vgas_max.Value;
        
        // Integral aktualisieren
        integral += error * dt;
        
        // Anti-Windup
        integral = Math.Max(-1.0, Math.Min(1.0, integral));
        
        // Stellgröße
        double u = kp * error + ki * integral;
        
        // Lastfaktor
        double loadFactor = 1.0 + u;
        
        return Math.Max(0.5, Math.Min(1.1, loadFactor));
    }
}
```

---

## Gasspeicher-Typen

### Folienspeicher (Doppelmembranspeicher)

```csharp
public class FoilGasStorage : gas_storage
{
    // Druckbereich sehr gering (1.005 - 1.02 bar)
    // Großes Volumen möglich
    
    public FoilGasStorage(double volume)
    {
        set_params_of(
            "Vgas_max", volume,
            "p_min", 1.005,  // 5 mbar Überdruck
            "p_max", 1.02    // 20 mbar Überdruck
        );
    }
}
```

### Hochdruckspeicher

```csharp
public class HighPressureGasStorage : gas_storage
{
    // Hoher Druckbereich (bis 200 bar)
    // Kompaktes Volumen
    
    public HighPressureGasStorage(double volume)
    {
        set_params_of(
            "Vgas_max", volume,
            "p_min", 10.0,   // 10 bar
            "p_max", 200.0   // 200 bar
        );
    }
}
```

### Fermenter-Gasraum als Speicher

```csharp
// Wird bereits durch digester.Vgas modelliert
// Kein separates gas_storage-Objekt nötig
```

---

## Messung und Überwachung

### Sensoren (geplant)

```csharp
// In sensors-Klasse hinzufügen:
public class gas_storage_sensor : sensor
{
    public override void measure(double t, ...)
    {
        // Messwerte:
        // - Füllstand [%]
        // - Gasvolumen [m³]
        // - Druck [bar]
        // - CH4-Gehalt [%]
        // - Zufluss [m³/d]
        // - Abfluss [m³/d]
        // - Überlauf [m³/d]
    }
}
```

### Überwachung

```csharp
public class GasStorageMonitor
{
    private gas_storage storage;
    private List<double> fillLevelHistory;
    
    public void update(double t)
    {
        double fillLevel = storage.getFillLevel();
        fillLevelHistory.Add(fillLevel);
        
        // Warnungen
        if (fillLevel > 0.95)
            Console.WriteLine($"[{t:F2}d] Warnung: Speicher fast voll!");
        
        if (fillLevel < 0.05)
            Console.WriteLine($"[{t:F2}d] Warnung: Speicher fast leer!");
    }
    
    public double getAverageFillLevel()
    {
        return fillLevelHistory.Average();
    }
}
```

---

## Wirtschaftliche Aspekte

### Abfackelung vermeiden

```csharp
// Kosten durch Abfackelung
public double calcFlareLosCosts(double Q_flared, double gasPrice)
{
    // Entgangener Gewinn durch nicht verwertetes Biogas
    return Q_flared * gasPrice;
}
```

### Regelenergie bereitstellen

```csharp
// Erlöse durch Regelenergiebereitstellung
public double calcRevenueFromBalancingPower(
    double P_positive,  // Positive Regelleistung [kW]
    double P_negative,  // Negative Regelleistung [kW]
    double price_pos,   // Preis positive Regelleistung [€/kW]
    double price_neg)   // Preis negative Regelleistung [€/kW]
{
    // Nur möglich wenn Speicher halb voll
    if (Math.Abs(getFillLevel() - 0.5) < 0.1)
    {
        return P_positive * price_pos + P_negative * price_neg;
    }
    return 0.0;
}
```

---

## Zukünftige Erweiterungen

### 1. Biomethan-Aufbereitung

```csharp
public class BiomethaneUpgrading
{
    // CO2-Abtrennung
    public double[] upgradeBiogas(double[] rawBiogas)
    {
        // Input: [H2, CH4, CO2, H2S]
        // Output: [CH4_pure, CO2_separated, losses]
        
        // CH4-Gehalt von ~60% auf >96% erhöhen
    }
}
```

### 2. Gasnetz-Einspeisung

```csharp
public class GridFeedIn
{
    // Einspeisung ins Erdgasnetz
    public bool canFeedIn(double[] biogas)
    {
        // Prüfe Gasqualität
        // CH4 > 96%
        // Brennwert im zulässigen Bereich
        // Druck ausreichend
    }
}
```

### 3. Multi-Speicher-System

```csharp
public class GasStorageNetwork
{
    private List<gas_storage> storages;
    
    public void optimizeDistribution(double Q_produced, double Q_needed)
    {
        // Optimale Verteilung auf mehrere Speicher
        // Berücksichtige: Füllstände, Drücke, Standorte
    }
}
```

---

## TODOs

Basierend auf den Code-Kommentaren:

1. **Vollständige Implementierung der gas_storage-Klasse**
   - Eigenschaften definieren
   - Konstruktoren implementieren
   - Dynamik-Methoden (update, setState, getState)
   - Regelungs-Methoden

2. **Integration mit plant-Klasse**
   - `plant.myGasStorage` hinzufügen
   - XML-Serialisierung
   - Berücksichtigung in chps.run()

3. **Gasspeicher-Modell in BHKW-Betrieb integrieren**
   - Anstatt direkter Zuteilung: Biogas → Speicher → BHKW
   - Ermöglicht Stillstandszeiten der BHKWs
   - Ermöglicht flexiblen Betrieb (Regelenergie)

4. **Sensoren für Gasspeicher**
   - Füllstand
   - Druck
   - Durchfluss
   - Gasqualität

5. **Regelungsstrategien implementieren**
   - Einfache Schwellwert-Regelung
   - P-Regler
   - PI-Regler
   - MPC (fortgeschritten)

---

## Literatur und Referenzen

### Dimensionierung

- VDI 3475: Biogas für Motoren
- FNR: Leitfaden Biogas - Von der Gewinnung zur Nutzung
- KTBL: Faustzahlen Biogas

### Regelung

- Luyben, W.L.: Process Modeling, Simulation and Control for Chemical Engineers
- Lunze, J.: Regelungstechnik (Band 1 und 2)

### Wirtschaftlichkeit

- EEG 2009/2012/2014: Vergütungsstruktur
- dena-Studie: Systemdienstleistungen durch Biogasanlagen

---

## Best Practices (wenn implementiert)

### 1. Speichergröße wählen

```csharp
// Faustregel: Speicher = 4-8 Stunden Biogasproduktion
double daily_production = 6000;  // m³/d
double buffer_hours = 6;
double storage_size = daily_production * buffer_hours / 24;

var storage = new gas_storage();
storage.set_params_of("Vgas_max", storage_size);
```

### 2. Sollwert auf 50% setzen

```csharp
// Ermöglicht symmetrische Regelung
storage.set_params_of(
    "Vgas_setpoint", storage.Vgas_max.Value * 0.5
);
```

### 3. Regelparameter tunen

```csharp
// Start mit konservativen Werten
storage.set_params_of("kp", 5.0);

// Schrittweise erhöhen bis gewünschte Dynamik
// Zu hoher kp → Oszillation
// Zu niedriger kp → Langsame Reaktion
```

### 4. Überlauf überwachen

```csharp
// Regelmäßig prüfen
if (storage.isFull())
{
    double excess = storage.getExcessBiogas();
    if (excess > 0)
    {
        logger.Warning($"Abfackeln: {excess:F1} m³/d");
        // Ggf. Substratfütterung reduzieren
    }
}
```

---

## Siehe auch

- **biogas.digesters**: Fermenter mit Gasphase (Vgas)
- **biogas.chps**: BHKW-Betrieb und Biogasverbrauch
- **biogas.plant**: Anlagen-Integration
- **biogas.sensors**: Messdatenerfassung

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*  
*Status: Geplante Funktionalität (Klasse noch nicht implementiert)*
