# Finances Package API Documentation

## Übersicht

Das `biogas.finances` Namespace enthält Klassen zur Modellierung der wirtschaftlichen Aspekte von Biogasanlagen, insbesondere die Vergütung nach dem Erneuerbare-Energien-Gesetz (EEG).

---

## Klasse: `funding`

Abstrakte Basisklasse für EEG-Vergütungsmodelle.

### Abstrakte Methoden

#### `getVerguetung(biogas.plant myPlant, double Pel, bool var)`

Berechnet die Vergütung nach EEG.

**Parameter:**
- `myPlant` (biogas.plant): Anlagen-Objekt
- `Pel` (double): Elektrische Leistung [kW]
- `var` (bool): EEG-spezifischer Parameter (z.B. Gülle-Bonus für EEG 2009)

**Rückgabe:**
- `double`: Vergütung [€/kWh]

#### `getVerguetung(biogas.plant myPlant, biogas.substrates mySubstrates, double Pel, bool var)`

Erweiterte Version mit Substratinformation (für EEG 2012+).

**Parameter:**
- `mySubstrates` (biogas.substrates): Substrat-Liste

**Rückgabe:**
- `double`: Vergütung [€/kWh]

**Hinweis:** Wirft Exception mit "Not implemented!" in der Basisklasse.

#### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest EEG-Parameter aus XML.

**Rückgabe:**
- `bool`: true bei Erfolg

#### `getParamsAsXMLString()`

Gibt EEG-Parameter als XML-String zurück.

**Rückgabe:**
- `string`: XML-formatierter String

#### `print()`

Gibt EEG-Parameter formatiert aus.

**Rückgabe:**
- `string`: Formatierter String

---

## Klasse: `eeg2009`

Implementierung der EEG 2009 Vergütungsstruktur (partial class, aufgeteilt in mehrere Dateien).

### Konstruktor

#### `eeg2009()`

Erstellt EEG 2009 Objekt mit Standardwerten.

**Standard-Boni:**
- NaWaRo-Bonus: aktiviert
- KWK-Bonus: deaktiviert
- Innovations-Bonus: deaktiviert
- Immissions-Bonus: deaktiviert
- Gülle-Bonus: aktiviert
- Landschaftspflege-Bonus: deaktiviert

### Eigenschaften

#### Private Felder - Leistungsschwellen

```csharp
// Leistungsschwellwerte [kW]
private static double[] schwellwerte = {150, 500, 5000, 20000}
```

**Bedeutung:** Bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW

#### Private Felder - Grundvergütung

```csharp
// Grundvergütung [ct/kWh] für Baujahr 2009
private static double[] grundverguetung = {11.67, 9.18, 8.25, 7.79}
```

**Index:** Entspricht den Leistungsschwellen

#### Private Felder - Boni

```csharp
// NaWaRo-Bonus [ct/kWh]
private static double[] nawaro = {7.00, 7.00, 4.00, 0.00}
private bool nawaro_b

// KWK-Bonus [ct/kWh]
private static double[] kwk = {3.00, 3.00, 3.00, 3.00}
private bool kwk_b

// Innovations-/Technologie-Bonus [ct/kWh]
private static double[] innovation = {2.00, 2.00, 2.00, 0.00}
private bool innovation_b

// Luftreinhaltungs-/Immissions-Bonus [ct/kWh]
private static double[] immission = {1.00, 1.00, 0.00, 0.00}
private bool immission_b

// Gülle-Bonus [ct/kWh]
private static double[] manure = {4.00, 1.00, 0.00, 0.00}
private bool manure_b

// Landschaftspflege-Bonus [ct/kWh]
private static double[] landschaft = {2.00, 2.00, 0.00, 0.00}
private bool landschaft_b
```

### Methoden

#### Gülle-Bonus Prüfung

##### `static check_manurebonus(biogas.substrates mySubstrates, biogas.sensors mySensors)`

Prüft ob aktuelle Substratfütterung den Gülle-Bonus qualifiziert.

**Parameter:**
- `mySubstrates` (biogas.substrates): Substrat-Liste
- `mySensors` (biogas.sensors): Sensor-Objekt mit aktuellen Messungen

**Rückgabe:**
- `bool`: true wenn Gülle-Bonus erfüllt

**Bedingung:**
```
Σ(Gülle [kg/d]) ≥ 0.3 × Σ(alle Substrate [kg/d])
```

**Hinweis:** Anforderung muss JEDERZEIT erfüllt sein.

##### `static check_manurebonus(biogas.substrates mySubstrates, double[] Q)`

Prüft Gülle-Bonus für gegebene Substratfütterung.

**Parameter:**
- `Q` (double[]): Substratströme [m³/d]

**Rückgabe:**
- `bool`: true wenn Gülle-Bonus erfüllt

##### `static check_manurebonus(biogas.substrates mySubstrates, double[] Q, out double[] A, out double b, out double dist_bonus)`

Erweiterte Version mit Constraint-Details.

**Ausgabeparameter:**
- `A` (out double[]): Constraint-Vektor
- `b` (out double): Rechte Seite der Ungleichung
- `dist_bonus` (out double): Abstand zur Bonus-Grenze (≤0 = erfüllt)

**Lineare Ungleichung:**
```
A × Q ≤ b

wobei:
A[i] = -0.7 × ρ_gülle     für Gülle
A[i] = 0.3 × ρ_substrat   für andere Substrate
b = 0
```

**Beispiel:**
```csharp
double[] A, Q = {80.0, 120.0};  // Mais, Gülle
double b, dist;

bool hasBonus = eeg2009.check_manurebonus(
    substrates, Q, out A, out b, out dist
);

if (hasBonus)
{
    Console.WriteLine("Gülle-Bonus erfüllt!");
    Console.WriteLine($"Sicherheitsabstand: {-dist:F1} kg/d");
}
else
{
    Console.WriteLine("Gülle-Bonus NICHT erfüllt!");
    Console.WriteLine($"Fehlbetrag: {dist:F1} kg/d");
}
```

#### Vergütungsberechnung

##### `override getVerguetung(biogas.plant myPlant, double Pel, bool manure_b)`

Berechnet EEG 2009 Vergütung.

**Parameter:**
- `myPlant` (biogas.plant): Anlagen-Objekt
- `Pel` (double): Elektrische Leistung [kW]
- `manure_b` (bool): true wenn Substratmix Gülle-Bonus erfüllt

**Rückgabe:**
- `double`: Vergütung [€/kWh]

**Formel:**
```
// Für jede Leistungsschwelle i:
factor_i = min(Pel_rest, schwellwerte[i]) / Pel

verguetung += factor_i × (
    grundverguetung[i] +
    nawaro[i] × nawaro_b +
    kwk[i] × kwk_b +
    innovation[i] × innovation_b +
    immission[i] × immission_b +
    manure[i] × manure_b × nawaro_b +
    landschaft[i] × landschaft_b × nawaro_b
)

// Degression
verguetung × (1 - 0.01 × (construct_year - 2009))
```

**Beispiel:**
```csharp
var plant = new biogas.plant("plant.xml");
var eeg = new eeg2009();

// Boni konfigurieren
eeg.set_params_of(
    "nawaro", true,
    "kwk", true,
    "manure", true
);

// Vergütung berechnen
double Pel = 500.0;  // kW
bool manureBonus = true;

double verguetung = eeg.getVerguetung(plant, Pel, manureBonus);
Console.WriteLine($"Vergütung: {verguetung:F4} €/kWh");
Console.WriteLine($"Vergütung: {verguetung * 100:F2} ct/kWh");
```

#### Parameter-Verwaltung

##### `override set_params_of(params object[] symbols)`

Setzt Bonus-Parameter.

**Syntax:**
```csharp
eeg.set_params_of(
    "nawaro", true,
    "kwk", false,
    "innovation", false,
    "immission", false,
    "manure", true,
    "landschaft", false
);
```

**Ausnahmen:**
- `exception`: Unbekannter Parameter

##### `override get_params_of(out object[] variables, params string[] symbols)`

Holt Bonus-Parameter.

**Parameter:**
- `variables` (out object[]): Ausgabe-Array
- `symbols` (params string[]): Parameter-Namen

**Ausnahmen:**
- `exception`: Unbekannter Parameter
- `exception`: Keine Eingabe

#### Datenmanagement

##### `override getParamsFromXMLReader(ref XmlTextReader reader)`

Liest EEG 2009 Parameter aus XML.

**XML-Format:**
```xml
<EEG2009>
    <nawaro>1</nawaro>
    <kwk>0</kwk>
    <innovation>0</innovation>
    <immission>0</immission>
    <manure>1</manure>
    <landschaft>0</landschaft>
</EEG2009>
```

##### `override getParamsAsXMLString()`

Gibt EEG 2009 Parameter als XML zurück.

##### `override print()`

Gibt EEG 2009 Parameter formatiert aus.

**Beispielausgabe:**
```
   ----------   EEG 2009   ----------   
nawaro= True 			kwk= False 			innovation= False 
immission= False 		manure= True 		landschaft= False 
```

---

## Klasse: `eeg2012`

Implementierung der EEG 2012 Vergütungsstruktur (noch nicht vollständig implementiert).

### Konstruktor

#### `eeg2012()`

Erstellt EEG 2012 Objekt.

### Eigenschaften

```csharp
// Grundvergütung [ct/kWh] (TODO: prüfen ob für EEG 2012 gültig)
private static double[] grundverguetung = {11.67, 9.18, 8.25, 7.79}
```

### Methoden

**Hinweis:** Alle Methoden sind Platzhalter und müssen noch implementiert werden.

#### `override getVerguetung(biogas.plant myPlant, double Pel, bool var)`

**Status:** Nicht implementiert, gibt 0 zurück.

#### `override getParamsFromXMLReader(ref XmlTextReader reader)`

**Status:** Nicht implementiert, gibt true zurück.

#### `override getParamsAsXMLString()`

**Status:** Gibt leeres XML-Tag zurück.

#### `override print()`

**Status:** Gibt nur Überschrift aus.

---

## Klasse: `finances`

Hauptklasse für Finanzberechnungen einer Biogasanlage.

### Konstruktor

#### `finances()`

Erstellt Finanz-Objekt mit Standardwerten.

**Standardwerte:**
- revenueTherm: 0.015 €/kWh
- revenueGas: 0.0 €/m³
- priceElEnergy: 0.18 €/kWh
- EEG: EEG 2009

### Eigenschaften

#### Private Felder

```csharp
// Erlöse
private physValue _revenueTherm    // Wärmeverkauf [€/kWh]
private physValue _revenueGas      // Biogasverkauf [€/m³]

// Kosten
private physValue _priceElEnergy   // Strompreis [€/kWh]

// Vergütung
private funding myEEG              // EEG-Objekt (eeg2009 oder eeg2012)
```

#### Public Properties

```csharp
public physValue revenueTherm      // Wärmeverkaufserlös [€/kWh]
public physValue revenueGas        // Biogasverkaufserlös [€/m³]
public physValue priceElEnergy     // Stromkosten [€/kWh]
```

### Methoden

#### Vergütung

##### `getVerguetung(biogas.plant myPlant, double Pel, bool var)`

Berechnet EEG-Vergütung für die Anlage.

**Parameter:**
- `myPlant` (biogas.plant): Anlagen-Objekt
- `Pel` (double): Elektrische Leistung [kW]
- `var` (bool): Für EEG 2009: Gülle-Bonus

**Rückgabe:**
- `double`: Vergütung [€/kWh]

**Delegiert an:** `myEEG.getVerguetung(myPlant, Pel, var)`

#### Datenmanagement

##### `getParamsFromXMLReader(ref XmlTextReader reader)`

Liest Finanz-Parameter aus XML.

**XML-Format:**
```xml
<finances>
    <EEG2009>
        <nawaro>1</nawaro>
        <!-- weitere EEG-Parameter -->
    </EEG2009>
    <revTherm>0.015</revTherm>
    <revGas>0.0</revGas>
    <priceEl>0.18</priceEl>
</finances>
```

**Hinweis:** Automatische Erkennung von EEG2009 oder EEG2012.

##### `getParamsAsXMLString()`

Gibt Finanz-Parameter als XML zurück.

##### `print()`

Gibt Finanz-Parameter formatiert aus.

**Beispielausgabe:**
```
   ----------   FINANCES   ----------   
   ----------   EEG 2009   ----------   
nawaro= True 			kwk= False 			innovation= False 
immission= False 		manure= True 		landschaft= False 
revTherm= 0.02 €/kWh			revGas= 0.00 €/m^3
  priceEl= 0.18 €/kWh
```

---

## Anwendungsbeispiele

### EEG 2009 Vergütung berechnen

```csharp
using biogas;

// Anlage erstellen
var plant = new biogas.plant("plant.xml");
plant.set_params_of("construct_year", 2009);

// Finanzen konfigurieren
var finances = new finances();
finances.myEEG.set_params_of(
    "nawaro", true,
    "kwk", true,
    "manure", true
);

// Elektrische Leistung
double Pel = 500.0;  // kW

// Gülle-Bonus prüfen
var substrates = new biogas.substrates("substrates.xml");
double[] Q = {80.0, 120.0};  // Mais, Gülle [m³/d]

bool hasManureBonus = eeg2009.check_manurebonus(substrates, Q);

// Vergütung berechnen
double verguetung = finances.getVerguetung(plant, Pel, hasManureBonus);

Console.WriteLine($"Elektrische Leistung: {Pel} kW");
Console.WriteLine($"Gülle-Bonus: {(hasManureBonus ? "Ja" : "Nein")}");
Console.WriteLine($"Vergütung: {verguetung:F4} €/kWh");
Console.WriteLine($"Vergütung: {verguetung * 100:F2} ct/kWh");

// Jahreserlös schätzen
double volllaststunden = 8000;  // h/a
double jahresertrag = Pel * volllaststunden * verguetung;
Console.WriteLine($"\nGeschätzter Jahreserlös: {jahresertrag:N0} €/a");
```

### Gülle-Bonus optimieren

```csharp
using biogas;

var substrates = new biogas.substrates("substrates.xml");

// Verschiedene Substratmixe testen
var scenarios = new List<(string name, double[] Q)>
{
    ("50% Gülle", new double[] {100, 100}),
    ("40% Gülle", new double[] {120, 80}),
    ("30% Gülle", new double[] {140, 60}),
    ("20% Gülle", new double[] {160, 40})
};

Console.WriteLine("Gülle-Bonus Analyse:\n");

foreach (var scenario in scenarios)
{
    double[] A;
    double b, dist;
    
    bool hasBonus = eeg2009.check_manurebonus(
        substrates, scenario.Q, out A, out b, out dist
    );
    
    double totalQ = scenario.Q[0] + scenario.Q[1];
    double gullePercent = scenario.Q[1] / totalQ * 100;
    
    Console.WriteLine($"{scenario.name} ({gullePercent:F1}% Massenanteil):");
    Console.WriteLine($"  Mais: {scenario.Q[0]} m³/d");
    Console.WriteLine($"  Gülle: {scenario.Q[1]} m³/d");
    Console.WriteLine($"  Status: {(hasBonus ? "✓ Bonus erfüllt" : "✗ Kein Bonus")}");
    
    if (hasBonus)
        Console.WriteLine($"  Sicherheitsabstand: {-dist:F1} kg/d");
    else
        Console.WriteLine($"  Fehlbetrag: {dist:F1} kg/d Gülle");
    
    Console.WriteLine();
}
```

### Vergütung über Leistungsbereiche

```csharp
using biogas;

var plant = new biogas.plant();
plant.set_params_of("construct_year", 2009);

var eeg = new eeg2009();
eeg.set_params_of(
    "nawaro", true,
    "kwk", false,
    "manure", false
);

Console.WriteLine("EEG 2009 Vergütung nach Leistung:\n");
Console.WriteLine("Pel [kW]  | Vergütung [ct/kWh]");
Console.WriteLine("----------|-------------------");

// Verschiedene Leistungen testen
double[] testPowers = {100, 150, 250, 500, 750, 1000, 2000, 5000};

foreach (double pel in testPowers)
{
    double verg = eeg.getVerguetung(plant, pel, false) * 100;
    Console.WriteLine($"{pel,8:F0} | {verg,17:F2}");
}
```

### Degression über Baujahre

```csharp
using biogas;

var plant = new biogas.plant();
var eeg = new eeg2009();
eeg.set_params_of("nawaro", true);

double Pel = 500.0;  // kW

Console.WriteLine("EEG 2009 Degression:\n");
Console.WriteLine("Baujahr | Vergütung [ct/kWh]");
Console.WriteLine("--------|-------------------");

for (int year = 2009; year <= 2020; year++)
{
    plant.set_params_of("construct_year", year);
    double verg = eeg.getVerguetung(plant, Pel, false) * 100;
    Console.WriteLine($"{year,7} | {verg,17:F2}");
}
```

### Wirtschaftlichkeitsrechnung

```csharp
using biogas;

var plant = new biogas.plant("plant.xml");
var finances = new finances();
var substrates = new biogas.substrates("substrates.xml");

// Betriebsparameter
double Pel = 500.0;  // kW
double Pel_kWh_d = Pel * 24;  // kWh/d
double Pth_kWh_d = 600 * 24;  // kWh/d thermisch

double[] Q = {80.0, 120.0};  // m³/d Substratfütterung

// Erlöse
double verguetung = finances.getVerguetung(plant, Pel, true);
double erloes_el = Pel_kWh_d * verguetung;
double erloes_th = Pth_kWh_d * finances.revenueTherm.Value;
double erloes_gesamt = erloes_el + erloes_th;

// Kosten
double strom_kosten = 200;  // kWh/d Eigenverbrauch
strom_kosten *= finances.priceElEnergy.Value;

double substrat_kosten = 0;
for (int i = 0; i < Q.Length; i++)
{
    substrat_kosten += Q[i] * substrates.get(i + 1).get_param_of("cost");
}

double kosten_gesamt = strom_kosten + substrat_kosten;

// Bilanz
double gewinn_tag = erloes_gesamt - kosten_gesamt;
double gewinn_jahr = gewinn_tag * 365;

Console.WriteLine("=== Wirtschaftlichkeitsrechnung ===\n");
Console.WriteLine("Erlöse:");
Console.WriteLine($"  Stromverkauf: {erloes_el:F2} €/d");
Console.WriteLine($"  Wärmeverkauf: {erloes_th:F2} €/d");
Console.WriteLine($"  Gesamt: {erloes_gesamt:F2} €/d\n");

Console.WriteLine("Kosten:");
Console.WriteLine($"  Eigenverbrauch Strom: {strom_kosten:F2} €/d");
Console.WriteLine($"  Substratkosten: {substrat_kosten:F2} €/d");
Console.WriteLine($"  Gesamt: {kosten_gesamt:F2} €/d\n");

Console.WriteLine("Bilanz:");
Console.WriteLine($"  Gewinn: {gewinn_tag:F2} €/d");
Console.WriteLine($"  Gewinn: {gewinn_jahr:N0} €/a");
```

### Finanz-Parameter aus XML laden und ändern

```csharp
using biogas;

// Aus XML laden
var finances = new finances();
var reader = new System.Xml.XmlTextReader("finances_config.xml");
finances.getParamsFromXMLReader(ref reader);
reader.Close();

Console.WriteLine("Geladene Konfiguration:");
Console.WriteLine(finances.print());

// Parameter ändern
finances.revenueTherm.Value = 0.02;  // 2 ct/kWh
finances.priceElEnergy.Value = 0.25;  // 25 ct/kWh

// EEG-Boni ändern
finances.myEEG.set_params_of(
    "kwk", true,
    "innovation", true
);

// Speichern
string xml = finances.getParamsAsXMLString();
System.IO.File.WriteAllText("finances_updated.xml", xml);

Console.WriteLine("\nAktualisierte Konfiguration:");
Console.WriteLine(finances.print());
```

---

## Vergütungs-Übersicht EEG 2009

### Grundvergütung (Baujahr 2009)

| Leistung | Grundvergütung [ct/kWh] |
|----------|-------------------------|
| ≤ 150 kW | 11.67 |
| ≤ 500 kW | 9.18 |
| ≤ 5 MW | 8.25 |
| ≤ 20 MW | 7.79 |

### Boni (Baujahr 2009)

| Bonus | ≤150kW | ≤500kW | ≤5MW | ≤20MW | Bedingung |
|-------|--------|--------|------|-------|-----------|
| NaWaRo | 7.00 | 7.00 | 4.00 | 0.00 | Nachwachsende Rohstoffe |
| KWK | 3.00 | 3.00 | 3.00 | 3.00 | Kraft-Wärme-Kopplung |
| Innovation | 2.00 | 2.00 | 2.00 | 0.00 | Technologie-Bonus |
| Immission | 1.00 | 1.00 | 0.00 | 0.00 | Luftreinhaltung |
| Gülle* | 4.00 | 1.00 | 0.00 | 0.00 | ≥30% Gülle + NaWaRo |
| Landschaft* | 2.00 | 2.00 | 0.00 | 0.00 | Landschaftspflege + NaWaRo |

*gekoppelt an NaWaRo-Bonus

### Degression

**Formel:** `verguetung × (1 - 0.01 × (Baujahr - 2009))`

**Beispiel:** Anlage Baujahr 2012
- Degression: 3% (0.01 × 3 Jahre)
- Reduzierte Vergütung: 97% der 2009er Sätze

---

## TODOs

Laut Quellcode:

### eeg2009.cs
- Prüfen ob alle Boni tatsächlich proportional zur Leistung ausgezahlt werden oder ob z.B. Immissions-Bonus unabhängig von der Leistung ist
- Für Altanlagen (vor 2009) gilt: Grundvergütung bis 150 kW einheitlich 11,67 ct/kWh

### eeg2012.cs
- **Vollständige Implementierung erforderlich**
- Grundvergütung für EEG 2012 prüfen und anpassen
- Neue Bonus-Struktur implementieren
- Bemessungsleistung korrekt berechnen

### finances.cs
- Methode zum Wechsel des EEG-Objekts (eeg2009 ↔ eeg2012)

---

## Best Practices

### 1. EEG-Auswahl

```csharp
// GUT: EEG basierend auf Baujahr wählen
var plant = new biogas.plant();
int baujahr = plant.construct_year;

var finances = new finances();
if (baujahr >= 2012)
{
    finances.myEEG = new eeg2012();
}
else
{
    finances.myEEG = new eeg2009();
}
```

### 2. Gülle-Bonus prüfen

```csharp
// GUT: Regelmäßig während Simulation prüfen
double t = /* Simulationszeit */;
var sensors = new biogas.sensors();

bool manureBonus = eeg2009.check_manurebonus(substrates, sensors);

// BESSER: Mit Constraint-Details für Optimierung
double[] A;
double b, dist;
bool manureBonus = eeg2009.check_manurebonus(
    substrates, Q, out A, out b, out dist
);

if (!manureBonus && Math.Abs(dist) < 100)  // Fast erfüllt
{
    Console.WriteLine("Warnung: Gülle-Bonus fast verloren!");
    Console.WriteLine($"Fehlbetrag: {dist:F1} kg/d");
}
```

### 3. Degression berücksichtigen

```csharp
// GUT: Immer construct_year setzen
var plant = new biogas.plant();
plant.set_params_of("construct_year", 2010);

// VERMEIDEN: construct_year vergessen
// → Degression wird nicht korrekt berechnet
```

### 4. Wirtschaftlichkeit überwachen

```csharp
// GUT: Alle Erlös- und Kostenkomponenten berücksichtigen
double erloes_strom = /* ... */;
double erloes_waerme = /* ... */;
double kosten_substrat = /* ... */;
double kosten_strom = /* ... */;
double kosten_heizung = /* ... */;

double bilanz = erloes_strom + erloes_waerme 
              - kosten_substrat - kosten_strom - kosten_heizung;

// Bilanz regelmäßig tracken
if (bilanz < 0)
{
    Console.WriteLine("Warnung: Negativer Deckungsbeitrag!");
}
```

---

## Siehe auch

- **biogas.plant**: Anlagen-Klasse mit construct_year
- **biogas.substrates**: Substrat-Kosten und -Klassifizierung
- **biogas.sensors**: Messdatenerfassung für Gülle-Bonus
- **biooptim.objectives**: Nutzung von getVerguetung() in Optimierung

---

*Dokumentation erstellt für biogas_c# Toolbox*  
*Stand: Januar 2026*
