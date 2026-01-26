# Biogas C# Toolbox

Eine umfassende C#-Bibliothek zur Modellierung, Simulation und Optimierung von Biogasanlagen.

## 📋 Übersicht

Die **Biogas C# Toolbox** ist eine spezialisierte Softwarebibliothek für die Simulation und Optimierung von Biogasanlagen. Sie basiert auf dem **Anaerobic Digestion Model No. 1 (ADM1)** und bietet umfangreiche Funktionen zur Modellierung aller relevanten Komponenten einer Biogasanlage.

### Hauptmerkmale

- **Vollständige Anlagenmodellierung**: Fermenter, BHKWs, Pumpen, Substrate, Sensoren
- **ADM1-Integration**: Wissenschaftlich validiertes Prozessmodell
- **Physikochemische Berechnungen**: Buswell-Gleichung, COD, BMP, Elementarbilanzen
- **Optimierung**: Fitness-Funktionen, Constraints, Multi-Objective-Optimierung
- **Wirtschaftlichkeit**: EEG-Vergütung (2009/2012), Kosten-Nutzen-Analyse
- **Sensor-Simulation**: Realistische Sensoren mit Rauschen, Drift und Kalibrierung
- **XML-Persistenz**: Speichern und Laden aller Konfigurationen

## 🚀 Quick Start

In dem biogas_c# Ordner liegt der C# Source Code mit dem DLLs erstellt werden können. Diese DLLs werden für das folgende Beispiel benötigt.

### Einfaches Beispiel: Biogasanlage simulieren

```csharp
using biogas;
using science;

// Anlage laden
var plant = new plant("plant_config.xml");
var substrates = new substrates("substrates.xml");
var sensors = sensors.create_sensor_network(plant, substrates, 
                                            plant_network, plant_network_max);

// Substratfütterung definieren
double[] Q = {100.0, 50.0};  // m³/d Mais und Gülle

// Simulation über 30 Tage
for (double t = 0; t < 30; t += 0.5)
{
    // ADM-Simulation (vereinfacht)
    double[] stream = /* ADM-Zustandsvektor */;
    
    // Messungen durchführen
    sensors.measure_type0(t, stream, "F1", 3);
    
    // Prozessparameter abrufen
    double pH = sensors.getCurrentMeasurementD("pH_F1_3");
    double vfa = sensors.getCurrentMeasurementD("VFA_F1_3");
    
    Console.WriteLine($"Tag {t}: pH={pH:F2}, VFA={vfa:F0} mg/l");
}
```

## 📦 Hauptkomponenten

### 1. Anlagenkomponenten (`biogas.plant`)

```csharp
// Biogasanlage erstellen
var plant = new plant();

// Fermenter hinzufügen
var fermenter = new digester("F1", "Hauptfermenter");
fermenter.set_params_of("Vliq", 2500.0, "T", 42.0);
plant.addDigester(fermenter);

// BHKW hinzufügen
var chp = new chp("CHP1", "BHKW 1");
chp.set_params_of("Pel", 500.0, "eta_el", 0.42);
plant.addCHP(chp);

// Speichern
plant.saveAsXML("my_plant.xml");
```

### 2. Substrate (`biogas.substrates`)

```csharp
// Substrat definieren
var maize = new substrate("maize", "Maissilage");
maize.set_params_of(
    "TS", 32.0,    // % FM
    "VS", 95.0,    // % TS
    "RF", 20.0,    // Rohfaser
    "RP", 8.0,     // Rohprotein
    "RL", 3.0      // Rohfett
);

// Berechnungen
double bmp = maize.calcBMP().Value;              // l/g FM
double gasQuality = maize.calcGasQuality().Value; // % CH4
Console.WriteLine($"BMP: {bmp:F2} l/g FM, CH4: {gasQuality:F1}%");
```

### 3. Sensoren (`biogas.sensors`)

```csharp
// Sensor-Netzwerk automatisch erstellen
var sensors = sensors.create_sensor_network(
    plant, substrates, plant_network, plant_network_max
);

// Messungen durchführen
double[] stream = /* ADM-Stream */;
sensors.measure(5.0, "pH_F1_3", stream);

// Werte abrufen
physValue pH = sensors.getCurrentMeasurement("pH_F1_3");
double pH_value = sensors.getCurrentMeasurementD("pH_F1_3");

// Zeitreihe
double[] time = sensors.getTimeStream();
double[] pH_values;
sensors.getMeasurementStream("pH_F1_3", out pH_values);
```

### 4. Chemische Berechnungen (`biogas.chemistry`)

```csharp
using biogas;

// Buswell-Gleichung für Kohlenhydrate
physValue ch4, co2;
chemistry.buswell_extended("Xch", out ch4, out co2);
Console.WriteLine($"CH4: {ch4.Value} mol/mol, CO2: {co2.Value} mol/mol");

// COD berechnen
physValue cod = chemistry.get_COD_of("Sac");  // Essigsäure
Console.WriteLine($"COD Acetat: {cod.Value} gCOD/mol");

// Elementzusammensetzung
physValue c, h, o, n, s;
chemistry.get_CHONS_of("Xpr", out c, out h, out o, out n, out s);
Console.WriteLine($"Protein: C{c.Value}H{h.Value}O{o.Value}N{n.Value}");
```

### 5. Optimierung (`biooptim`)

```csharp
using biooptim;

// Fitness-Parameter definieren
var fitnessParams = new fitness_params(2);
fitnessParams.myWeights.set_params_of(
    "w_money", 0.4,
    "w_CH4", 0.2,
    "w_pH", 0.15
);

// Zielfunktionen berechnen
double stability, energyBalance, fitness_constr;
double[] fitness;

objectives.getObjectives(
    sensors, plant, substrates, fitnessParams,
    out stability, out energyBalance, /* ... */, out fitness
);

Console.WriteLine($"Fitness: {fitness[0]:F3}");
Console.WriteLine($"Energiebilanz: {energyBalance:F2} k€/d");
```

## 🔬 Wissenschaftliche Grundlagen

### Anaerobic Digestion Model No. 1 (ADM1)

Das ADM1 ist das führende mathematische Modell für anaerobe Abbauprozesse:

- **Prozessschritte**: Desintegration → Hydrolyse → Acidogenese → Acetogenese → Methanogenese
- **19 Zustandsvariablen**: Gelöste und partikuläre Komponenten
- **Inhibierungen**: pH, NH3, H2
- **Gasphase**: CH4, CO2, H2

### Physikochemische Modelle

- **Buswell-Gleichung**: Theoretische Biogasproduktion aus CcHhOoNnSs
- **COD-Bilanzierung**: Chemical Oxygen Demand für alle Komponenten
- **Elementarbilanzen**: C, H, O, N, S
- **Thermodynamik**: Gibbs-Energie, Gleichgewichte

### Validierte Parameter

Alle Default-Werte basieren auf wissenschaftlicher Literatur:
- Batstone et al. (2002): ADM1 Report
- Rieger et al. (2003): Sensor-Modellierung
- Koch et al. (2010): Gras-Silage-Modellierung
- Gaida (2009): Theoretische Grundlagen

## 📊 Typische Anwendungsfälle

### 1. Prozessüberwachung

```csharp
// Kritische Prozessparameter überwachen
double pH = sensors.getCurrentMeasurementD("pH_F1_3");
double vfa = sensors.getCurrentMeasurementD("VFA_F1_3");
double olr = sensors.getCurrentMeasurementD("OLR_F1");

if (pH < 6.8 || pH > 7.5)
    Console.WriteLine("⚠️ pH außerhalb Optimum!");
    
if (vfa > 3000)
    Console.WriteLine("⚠️ VFA kritisch hoch!");
    
if (olr > 4.0)
    Console.WriteLine("⚠️ Überlastung!");
```

### 2. Substratoptimierung

```csharp
// Verschiedene Substratmischungen testen
var scenarios = new Dictionary<string, double[]>
{
    {"100% Mais", new double[] {150, 0}},
    {"50/50 Mix", new double[] {75, 100}},
    {"Optimal", new double[] {80, 120}}
};

foreach (var scenario in scenarios)
{
    // Simulation mit Mischung
    // ... ADM-Berechnung ...
    
    double pH = sensors.getCurrentMeasurementD("pH_F1_3");
    double ch4 = sensors.getCurrentMeasurementD("CH4_F1_3");
    
    Console.WriteLine($"{scenario.Key}: pH={pH:F2}, CH4={ch4:F1}%");
}
```

### 3. Energiebilanz

```csharp
// Elektrische Energie
double[] biogas = {10, 500, 200};  // H2, CH4, CO2 [m³/d]
physValue P_el, P_therm;
plant.burnBiogas("CHP1", biogas, out P_el, out P_therm);

// Wärmebedarf
double heatPower = plant.calcHeatPower("F1", Q, substrates, 
                                       plant.Tout, sensors);

// Bilanz
double balance = P_therm.Value - heatPower;
Console.WriteLine($"Wärmeüberschuss: {balance:F1} kWh/d");
```

### 4. Wirtschaftlichkeit

```csharp
// EEG-Vergütung
double verguetung = plant.getVerguetung(500.0, true);  // kW, Güllebonus
Console.WriteLine($"Vergütung: {verguetung * 100:F2} ct/kWh");

// Jahreserlös
double volllaststunden = 8000;  // h/a
double jahresertrag = 500 * volllaststunden * verguetung;
Console.WriteLine($"Jahreserlös: {jahresertrag:N0} €/a");
```

## 🛠️ Erweiterte Funktionen

### Realistische Sensoren

```csharp
// Sensor mit Rauschen und Drift
var pH_sensor = new pH_sensor("F1_3");
pH_sensor.myConfigs[0].set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.05,        // 5% Rauschen
    "drift", 0.01,              // 0.01 pH/d Drift
    "dT_calib", 7.0             // Wöchentliche Kalibrierung
);

// Ideale vs. reale Messung
physValue pH_ideal = pH_sensor.getCurrentMeasurement(false);
physValue pH_real = pH_sensor.getCurrentMeasurement(true);
```

### Multi-Fermenter-Betrieb

```csharp
// Verschiedene Fermenter mit unterschiedlichen Substratmischungen
var distribution = new Dictionary<string, double[]>
{
    {"F1", new double[] {100, 0}},      // Nur Mais
    {"F2", new double[] {0, 150}},      // Nur Gülle
    {"F3", new double[] {50, 50}}       // Mix
};

foreach (var kvp in distribution)
{
    string id = kvp.Key;
    double[] Q = kvp.Value;
    
    // HRT berechnen
    double vliq = plant.getDigesterParam(id, "Vliq");
    var hrt = digester.calcHRT(Q, new physValue(vliq, "m³"));
    
    Console.WriteLine($"{id}: HRT = {hrt.Value:F1} d");
}
```

### Fitness-basierte Optimierung

```csharp
// Multi-Objective Optimization
var fitnessParams = new fitness_params(2);
fitnessParams.set_params_of("nObjectives", 2);

double[] fitness;
objectives.getObjectives(/* ... */, out fitness);

Console.WriteLine($"Ziel 1 (Wirtschaftlichkeit): {fitness[0]:F2}");
Console.WriteLine($"Ziel 2 (Prozessstabilität): {fitness[1]:F3}");
```

## 📖 Dokumentation

Vollständige API-Dokumentation verfügbar in `docs/biogas_csharp/api_documentation/`:

- **Anlagenkomponenten**:
  - `plant_api.md` - Gesamtanlage
  - `digesters_api.md` - Fermenter, Heizung, Rührwerke
  - `chps_api.md` - BHKWs
  - `transportation_api.md` - Pumpen und Substrat-Transport
  - `final_storage_api.md` - Endlager
  - `gas_storage_api.md` - Gasspeicher (geplant)

- **Substrate & Chemie**:
  - `substrates_api.md` - Substrat-Definitionen
  - `physchem_api.md` - Physikochemische Berechnungen
  - `biogas_api.md` - Biogas-Zusammensetzung

- **Sensoren**:
  - `sensors_api.md` - Sensor-Verwaltung
  - `sensor_base_api.md` - Basis-Sensor-Klasse
  - `sensor_array_api.md` - Sensor-Arrays
  - `sensor_config_api.md` - Sensor-Konfiguration

- **Optimierung**:
  - `optim_params_api.md` - Fitness-Parameter
  - `optimization_api.md` - Zielfunktionen

- **Wirtschaftlichkeit**:
  - `finances_api.md` - EEG-Vergütung

- **Kalibrierung**:
  - `calibration_api.md` - Sensor-Kalibrierung (geplant)

## ⚙️ Systemanforderungen

- **.NET Framework** 4.5 oder höher / **.NET Core** 3.1+
- **C# 7.0** oder höher
- Optional: **MATLAB** für ADM-Integration (über COM)

### Dependencies

Die Toolbox verwendet primär .NET-Standardbibliotheken:
- `System.Xml` - XML-Verarbeitung
- `System.Collections.Generic` - Datenstrukturen
- Keine externen NuGet-Pakete erforderlich

## 🔧 Installation

### Von Source

```bash
git clone https://github.com/dgaida/matlab_toolboxes.git
cd matlab_toolboxes/biogas_c#
```

Projekt in Visual Studio und kompilieren.

### Als Library

1. Kompilierte DLL referenzieren:
   ```csharp
   // In Projekt-Referenzen
   using biogas;
   using science;
   using biooptim;
   ```

2. Oder Source-Files direkt einbinden

## 🧪 Testing

```csharp
// Unit Test Beispiel (NUnit)
[Test]
public void TestBuswellEquation()
{
    physValue ch4, co2;
    chemistry.buswell_extended("Xch", out ch4, out co2);
    
    Assert.AreEqual(3.0, ch4.Value, 0.01);
    Assert.AreEqual(3.0, co2.Value, 0.01);
}
```

## 📝 XML-Konfiguration

### Beispiel: Fermenter

```xml
<digester id="F1">
    <name>Hauptfermenter</name>
    <physValue symbol="Vliq">
        <value>2500</value>
        <unit>m³</unit>
    </physValue>
    <physValue symbol="T">
        <value>42</value>
        <unit>°C</unit>
    </physValue>
    <heating>
        <eta>0.85</eta>
        <status>1</status>
        <type>1</type>
    </heating>
</digester>
```

### Beispiel: Substrat

```xml
<substrate id="maize">
    <name>Maissilage</name>
    <substrate_class>Mais (GPS) (EK I)</substrate_class>
    <Weender>
        <physValue symbol="TS">
            <value>32</value>
            <unit>% FM</unit>
        </physValue>
        <physValue symbol="VS">
            <value>95</value>
            <unit>% TS</unit>
        </physValue>
    </Weender>
</substrate>
```

## 🤝 Contributing

Beiträge sind willkommen! Bitte beachten Sie:

1. **Code-Style**: Konsistent mit bestehendem Code
2. **Dokumentation**: XML-Kommentare für alle public-Methoden
3. **Tests**: Unit-Tests für neue Features
4. **Validierung**: Wissenschaftliche Referenzen für neue Modelle

## 📜 Lizenz

GPL-3.0 license

## 📚 Literatur

### Kernreferenzen

1. **Batstone et al. (2002)**: "The IWA Anaerobic Digestion Model No 1 (ADM1)" - Water Science & Technology
2. **Koch et al. (2010)**: "Biogas from grass silage – Measurements and modeling with ADM1" - Bioresource Technology
3. **Rieger et al. (2003)**: "Modelling of a secondary clarifier combined with a non-ideal activated sludge model" - WST
4. **Gaida (2009)**: "Die anaerobe Fermentation - Theoretische Grundlagen, Simulation und Regelung"

### Weiterführend

- VDI 4630: Vergärung organischer Stoffe
- VDI 3475: Biogas für Motoren
- FNR: Leitfaden Biogas
- KTBL: Faustzahlen Biogas

## 👥 Autoren & Kontakt

daniel.gaida@th-koeln.de

## 🙏 Danksagungen

Diese Toolbox basiert auf jahrelanger Forschung im Bereich der anaeroben Vergärung. Besonderer Dank gilt:

- IWA Task Group für ADM1

---

## 💡 Tipps & Tricks

### Performance

```csharp
// Effizient: Wiederverwendung von Objekten
var sensors = sensors.create_sensor_network(/* ... */);
for (double t = 0; t < 100; t += 0.5)
{
    sensors.measure_type0(t, stream, "F1", 3);
}

// Ineffizient: Neuerstellen bei jedem Durchlauf
for (double t = 0; t < 100; t += 0.5)
{
    var sensors = new sensors();  // ❌
    sensors.measure(t, "pH_F1_3", stream);
}
```

### Fehlerbehandlung

```csharp
try
{
    double pH = sensors.getCurrentMeasurementD("pH_F1_3");
}
catch (exception ex)
{
    Console.WriteLine($"Fehler: {ex.Message}");
    // ErrorLog.txt wurde automatisch erstellt
}
```

### Debugging

```csharp
// Detaillierte Ausgabe
Console.WriteLine(plant.print());
Console.WriteLine(sensors.print());
Console.WriteLine(substrates.print());
```

---

**Version**: 0.2  
**Letztes Update**: Januar 2026  
**Status**: Produktiv (ADM1-Kern), Entwicklung (erweiterte Features)
