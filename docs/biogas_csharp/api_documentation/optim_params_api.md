# Optimization Parameters Package API Documentation

## Übersicht

Das `biooptim` Namespace enthält Klassen zur Definition und Verwaltung von Optimierungsparametern für Biogasanlagen, einschließlich Fitness-Funktionen, Gewichtungen und Sollwerten.

## Klassen

### `fitness_params`

Definiert Fitness-Parameter für die Zielfunktion der Optimierung.

#### Konstruktoren

##### `fitness_params(int numDigesters)`

Erstellt ein fitness_params-Objekt mit Standardparametern.

**Parameter:**
- `numDigesters` (int): Anzahl der Fermenter auf der Anlage

##### `fitness_params(string XMLfile)`

Liest fitness_params aus einer XML-Datei.

**Parameter:**
- `XMLfile` (string): Name der XML-Datei

#### Eigenschaften

##### Fermenter-spezifische Parameter (Listen)

```csharp
// pH-Wert Grenzen
private List<double> pH_min       // Minimaler pH-Wert [-]
private List<double> pH_max       // Maximaler pH-Wert [-]
private List<double> pH_optimum   // Optimaler pH-Wert [-]

// Trockensubstanz
private List<double> TS_max       // Maximale TS [% FM]

// FOS/TAC Verhältnis
private List<double> VFA_TAC_min  // Minimales VFA/TAC [gHAcEq/gCaCO3]
private List<double> VFA_TAC_max  // Maximales VFA/TAC [gHAcEq/gCaCO3]

// Flüchtige Fettsäuren
private List<double> VFA_min      // Minimale VFA [gHAcEq]
private List<double> VFA_max      // Maximale VFA [gHAcEq]

// Pufferkapazität
private List<double> TAC_min      // Minimale TAC [gCaCO3]

// Hydraulische Verweilzeit
private List<double> HRT_min      // Minimale HRT [d]
private List<double> HRT_max      // Maximale HRT [d]

// Organische Raumbelastung
private List<double> OLR_max      // Maximale OLR [kgVS/(m³*d)]

// Stickstoff
private List<double> Snh4_max     // Maximales NH4 [g/l]
private List<double> Snh3_max     // Maximales NH3 [g/l]

// Säureverhältnis
private List<double> AcVsPro_min  // Min. Acetat/Propionat [mol/mol]
```

##### Anlagen-Parameter

```csharp
public double TS_feed_max         // Max. TS in Feststoffwolf [% FM]
public double HRT_plant_min       // Min. HRT der Anlage [d]
public double HRT_plant_max       // Max. HRT der Anlage [d]
public double OLR_plant_max       // Max. OLR der Anlage [kgVS/(m³*d)]
public bool manurebonus           // Güllebonus möglich
public string fitness_function    // Name der Fitnessfunktion
public int nObjectives            // Anzahl der Zielfunktionen
```

##### Gewichtungen

```csharp
public weights myWeights          // Gewichtungsobjekt
public setpoints mySetpoints      // Sollwerte
```

#### Methoden

##### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest Parameter aus einem XML-Reader.

**Parameter:**
- `reader` (ref XmlTextReader): Offener XML-Reader

##### `getParamsAsXMLString()`

Gibt Parameter als XML-String zurück.

**Rückgabe:**
- `string`: XML-String

##### `saveAsXML(string XMLfile)`

Speichert fitness_params in eine XML-Datei.

**Parameter:**
- `XMLfile` (string): Name der XML-Datei

##### `print()`

Gibt Parameter als formatierten String aus.

**Rückgabe:**
- `string`: Formatierter String für Konsolenausgabe

##### `get_params_of(out object[] variables, params string[] symbols)`

Holt spezifische Parameter als Objekt-Array.

**Parameter:**
- `variables` (out object[]): Ausgabe-Array
- `symbols` (params string[]): Parameter-Namen

**Ausnahmen:**
- `exception`: Unbekannter Parameter
- `exception`: Keine Eingabeargumente

##### `get_param_of(string symbol, int digester_index)`

Gibt einen Parameter für einen bestimmten Fermenter zurück.

**Parameter:**
- `symbol` (string): Parameter-Name
- `digester_index` (int): Index des Fermenters (0-basiert)

**Rückgabe:**
- `double`: Parameter-Wert

**Ausnahmen:**
- `exception`: Ungültiger Fermenter-Index
- `exception`: Unbekannter Parameter

##### `set_params_of(params object[] symbols)`

Setzt Parameter.

**Parameter:**
- `symbols` (params object[]): Abwechselnd Name und Wert

**Syntax:**
```csharp
set_params_of("TS_feed_max", 5.0, "nObjective", 1);
```

##### `set_list_params_of(string symbol, int digester_index, double value)`

Setzt einen Listen-Parameter für einen bestimmten Fermenter.

**Parameter:**
- `symbol` (string): Parameter-Name
- `digester_index` (int): Fermenter-Index (0-basiert)
- `value` (double): Neuer Wert

---

### `weights`

Gewichtungen für die Zielfunktion.

#### Konstruktor

##### `weights()`

Erstellt normalisiertes Gewichtungsobjekt mit Standardwerten.

#### Eigenschaften

```csharp
public double w_CSB         // CSB-Abbau (0.1)
public double w_CH4         // CH4-Konzentration (0.1)
public double w_money       // Kosten-Nutzen-Verhältnis (0.1)
public double w_energy      // Energieproduktion (0.0)
public double w_pH          // pH-Wert (0.1)
public double w_TS          // Trockensubstanz (0.1)
public double w_VFA         // Flüchtige Fettsäuren (0.1)
public double w_HRT         // Hydraulische Verweilzeit (0.1)
public double w_TAC         // Pufferkapazität (0.05)
public double w_OLR         // Organische Raumbelastung (0.1)
public double w_N           // Stickstoff (0.1)
public double w_gasexc      // Gasüberschuss (0.1)
public double w_FOS_TAC     // FOS/TAC-Verhältnis (0.1)
public double w_faecal      // Fäkalkeimabbau (0)
public double w_AcVsPro     // Acetat/Propionat-Verhältnis (0)
public double w_setpoint    // Sollwertverfolgung (0)
public double w_udot        // Substratänderung (0)
```

#### Methoden

##### `normalize()`

Normalisiert die Gewichte so, dass ihre Summe 1 ergibt.

##### `is_normal(out double sum_weights)`

Prüft, ob die Summe der Gewichte 1 ist.

**Parameter:**
- `sum_weights` (out double): Summe aller Gewichte

**Rückgabe:**
- `bool`: true wenn |1 - sum| < 0.01

##### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest Gewichte aus XML und normalisiert sie.

##### `getParamsAsXMLString()`

Gibt normalisierte Gewichte als XML zurück.

##### `print()`

Gibt Gewichte formatiert aus.

##### `set_params_of(params object[] symbols)`

Setzt Gewichte und normalisiert anschließend automatisch.

---

### `setpoint`

Definiert einen einzelnen Sollwert für die Regelung.

#### Konstruktoren

##### `setpoint()`

Erstellt Sollwert mit Standardwerten.

##### `setpoint(ref XmlTextReader reader)`

Liest Sollwert aus XML-Reader.

#### Eigenschaften

```csharp
public string location      // "chps", "digesters", "substrates" oder spezifische ID
public string sensor_id     // Sensor-Spezifikation (z.B. "energyProduction")
public int index           // Index innerhalb des Sensors (0-basiert)
public string s_operator   // "sum", "mean" oder leer
public double scalefac     // Skalierungsfaktor (Standard: 0.1)
```

#### Methoden

##### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest Sollwert-Parameter aus XML.

##### `getParamsAsXMLString()`

Gibt Sollwert als XML-String zurück.

##### `print()`

Gibt Sollwert formatiert aus.

---

### `setpoints`

Liste von Sollwerten.

#### Basis-Klasse

Erbt von `List<setpoint>`

#### Methoden

##### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest alle Sollwerte aus XML.

##### `getParamsAsXMLString()`

Gibt alle Sollwerte als XML zurück.

##### `print()`

Gibt alle Sollwerte formatiert aus.

##### `get(int index)`

Gibt Sollwert an Position index zurück (0-basiert).

**Parameter:**
- `index` (int): Index des Sollwerts

**Rückgabe:**
- `setpoint`: Sollwert-Objekt

**Ausnahmen:**
- `exception`: Ungültiger Index

##### `getNumSetpoints()`

Gibt die Anzahl der Sollwerte zurück.

##### `set_params_of(int index, params object[] symbols)`

Setzt Parameter eines bestimmten Sollwerts.

**Parameter:**
- `index` (int): Index des Sollwerts
- `symbols` (params object[]): Parameter-Paare

---

## Anwendungsbeispiele

### Fitness-Parameter erstellen und konfigurieren

```csharp
// Standard-Parameter für 2 Fermenter
var fitParams = new fitness_params(2);

// Anlagenparameter setzen
fitParams.set_params_of(
    "TS_feed_max", 26.0,
    "OLR_plant_max", 4.0,
    "manurebonus", true
);

// Fermenter-spezifische Parameter setzen
fitParams.set_list_params_of("pH_min", 0, 6.5);
fitParams.set_list_params_of("pH_max", 0, 8.0);
fitParams.set_list_params_of("OLR_max", 0, 4.5);

// Parameter speichern
fitParams.saveAsXML("fitness_params.xml");
```

### Gewichte anpassen

```csharp
var weights = new weights();

// Gewichte setzen (werden automatisch normalisiert)
weights.set_params_of(
    "w_money", 0.3,    // Mehr Fokus auf Wirtschaftlichkeit
    "w_CH4", 0.2,      // Methanqualität wichtig
    "w_pH", 0.1,
    "w_OLR", 0.1,
    "w_TS", 0.1,
    "w_VFA", 0.1,
    "w_N", 0.1
);

// Prüfen ob normalisiert
double sum;
if (weights.is_normal(out sum))
{
    Console.WriteLine("Gewichte sind normalisiert");
}

// Ausgeben
Console.WriteLine(weights.print());
```

### Sollwert-Regelung konfigurieren

```csharp
var setpoints = new setpoints();

// Sollwert für Energieproduktion erstellen
var energySetpoint = new setpoint();
energySetpoint.set_params_of(
    "location", "chps",
    "sensor_id", "energyProduction",
    "index", 0,
    "s_operator", "sum",
    "scalefac", 0.1
);

setpoints.Add(energySetpoint);

// Sollwert für Fermenter-pH
var pHSetpoint = new setpoint();
pHSetpoint.set_params_of(
    "location", "fermenter1",
    "sensor_id", "pH",
    "index", 0,
    "s_operator", "",
    "scalefac", 0.05
);

setpoints.Add(pHSetpoint);

Console.WriteLine(setpoints.print());
```

### Vollständige Optimierungskonfiguration

```csharp
// Fitness-Parameter mit Gewichten und Sollwerten
var fitParams = new fitness_params(2);

// Gewichte anpassen
fitParams.myWeights.set_params_of(
    "w_money", 0.4,
    "w_energy", 0.2,
    "w_CH4", 0.2,
    "w_pH", 0.1,
    "w_VFA", 0.1
);

// Sollwert hinzufügen
var setpoint = new setpoint();
setpoint.set_params_of(
    "location", "chps",
    "sensor_id", "energyProduction",
    "s_operator", "sum"
);
fitParams.mySetpoints.Add(setpoint);

// Speichern und laden
fitParams.saveAsXML("config.xml");
var loadedParams = new fitness_params("config.xml");

// Parameter ausgeben
Console.WriteLine(loadedParams.print());
```

## XML-Format

### fitness_params

```xml
<fitness_params>
    <digester index="0">
        <pH_min>6.0</pH_min>
        <pH_max>9.0</pH_max>
        <TS_max>12.0</TS_max>
        <OLR_max>4.0</OLR_max>
    </digester>
    
    <weights>
        <w_money>0.100</w_money>
        <w_CH4>0.100</w_CH4>
        <w_pH>0.100</w_pH>
    </weights>
    
    <setpoints>
        <setpoint>
            <location>chps</location>
            <sensor_id>energyProduction</sensor_id>
            <index>0</index>
            <s_operator>sum</s_operator>
            <scalefac>0.1</scalefac>
        </setpoint>
    </setpoints>
    
    <HRT_plant_min>20</HRT_plant_min>
    <HRT_plant_max>150</HRT_plant_max>
    <manurebonus>true</manurebonus>
</fitness_params>
```

## Hinweise

- **Normalisierung**: Gewichte werden automatisch normalisiert (Summe = 1)
- **Indexierung**: Fermenter-Indizes sind 0-basiert
- **Default-Werte**: Alle Parameter haben sinnvolle Standardwerte
- **XML-Persistenz**: Alle Klassen unterstützen XML-Serialisierung
- **Validierung**: Grenzen werden zur Laufzeit geprüft

## Best Practices

1. **Gewichtung**: Start mit ausgewogenen Gewichten, dann iterativ anpassen
2. **Sollwerte**: Nur kritische Parameter als Sollwerte verwenden
3. **Validierung**: Nach dem Laden aus XML Parameter prüfen
4. **Dokumentation**: Änderungen an Parametern kommentieren
5. **Versionierung**: XML-Konfigurationsdateien versionieren
