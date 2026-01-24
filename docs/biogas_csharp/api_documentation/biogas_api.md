# Biogas Package API Documentation

## Übersicht

Das `biogas` Namespace enthält Klassen zur Modellierung und Simulation von Biogasanlagen. Es umfasst die Definition von Biogas-Zusammensetzungen und deren Verarbeitung.

## Klassen

### `BioGas`

Definiert Biogas als Mix von CH4, CO2, H2 und H2S.

#### Eigenschaften

```csharp
public static double n_gases        // Anzahl der Gase (3)
public static int pos_h2 = 1        // Position von Wasserstoff
public static int pos_ch4 = 2       // Position von Methan
public static int pos_co2 = 3       // Position von Kohlendioxid
public static int pos_h2s = 4       // Position von Schwefelwasserstoff
public static string[] symGases     // Symbole für Gase: {"H2", "CH4", "CO2", "H2S"}
public static string[] labelGases   // Labels für Gase
```

#### Methoden

##### `burn(double[] u)`

Verbrennt einen Biogasstrom und berechnet die Energieproduktion.

**Parameter:**
- `u` (double[]): Gasstrom-Vektor mit mindestens `n_gases` Elementen, gemessen in m³/d

**Rückgabe:**
- `physValue`: Energie in kWh/d

**Ausnahmen:**
- `exception`: wenn u.Length < _n_gases

**Beispiel:**
```csharp
double[] gasStream = {10.0, 500.0, 200.0};  // H2, CH4, CO2 in m³/d
physValue energy = BioGas.burn(gasStream);
```

**Hinweise:**
- Bei Methangehalt < 40% des Gesamtbiogas ist keine Energieproduktion möglich
- Berechnung: P(t) = Q_ch4(t) * H_ch4 + Q_h2(t) * H_h2

##### `merge_streams(double[] u, int n_digester)`

Führt Biogasströme von verschiedenen Fermentern zusammen.

**Parameter:**
- `u` (double[]): Vektor mit `n_digester * n_gases` Elementen in m³/d
- `n_digester` (int): Anzahl der Fermenter

**Rückgabe:**
- `double[]`: Gesamtbiogasstrom mit `n_gases` Elementen in m³/d

**Ausnahmen:**
- `exception`: wenn n_digester < 1
- `exception`: wenn u.Length / n_digester < n_gases

**Beispiel:**
```csharp
// Zwei Fermenter mit je 3 Gasen
double[] streams = {5.0, 250.0, 100.0, 5.0, 250.0, 100.0};
double[] totalBiogas = BioGas.merge_streams(streams, 2);
```

##### `calcRelContent(double[] u, out double total_biogas_total)`

Berechnet den relativen Anteil der verschiedenen Komponenten im Biogasstrom.

**Parameter:**
- `u` (double[]): Biogasstrom in m³/d, Dimension: ≥ n_gases
- `total_biogas_total` (out double): Summe von u in m³/d

**Rückgabe:**
- `double[]`: H2 in ppm, CH4 und CO2 in %

**Ausnahmen:**
- `exception`: wenn u.Length < n_gases

**Beispiel:**
```csharp
double[] gasStream = {10.0, 500.0, 200.0};
double total;
double[] relativeContent = BioGas.calcRelContent(gasStream, out total);
// relativeContent[0] = H2 in ppm
// relativeContent[1] = CH4 in %
// relativeContent[2] = CO2 in %
```

##### `convert(double[] u_rel)`

Konvertiert einen doppelten Biogasstrom-Vektor (in ppm, %, %) zu entsprechenden physValues.

**Parameter:**
- `u_rel` (double[]): Vektor mit n_gases Elementen (H2 in ppm, CH4 in %, CO2 in %)

**Rückgabe:**
- `physValue[]`: u als physValue-Vektor mit Einheiten

**Ausnahmen:**
- `exception`: wenn u_rel.Length < n_gases

##### `calcPercentualBiogasComposition(double[] Qgas, out physValue[] QgasP)`

Berechnet die prozentuale Biogaszusammensetzung aus dem Biogasstrom.

**Parameter:**
- `Qgas` (double[]): Biogasstrom in m³/d
- `QgasP` (out physValue[]): Biogaszusammensetzung in %

**Ausnahmen:**
- `exception`: wenn Qgas.Length < n_gases
- `exception`: wenn Qgas leer ist

##### `calcPercentualBiogasComposition(physValue[] Qgas, out physValue[] QgasP)`

Überladene Version mit physValue-Parametern.

**Parameter:**
- `Qgas` (physValue[]): Biogasstrom in m³/d
- `QgasP` (out physValue[]): Biogaszusammensetzung in %

**Ausnahmen:**
- `exception`: wenn Qgas.Length < n_gases
- `exception`: wenn Qgas leer ist
- `exception`: wenn Qgas nicht in m³/d gemessen ist

## Anwendungsbeispiele

### Energieberechnung aus Biogasproduktion

```csharp
// Biogasproduktion von einem Fermenter
double[] biogas = new double[3];
biogas[BioGas.pos_h2 - 1] = 5.0;      // 5 m³/d H2
biogas[BioGas.pos_ch4 - 1] = 400.0;   // 400 m³/d CH4
biogas[BioGas.pos_co2 - 1] = 200.0;   // 200 m³/d CO2

// Energieproduktion berechnen
physValue energy = BioGas.burn(biogas);
Console.WriteLine($"Energieproduktion: {energy.Value} {energy.Unit}");
```

### Zusammenführen mehrerer Fermenter

```csharp
// Drei Fermenter mit unterschiedlichen Produktionen
double[] allStreams = new double[9];
// Fermenter 1
allStreams[0] = 3.0;  // H2
allStreams[1] = 300.0; // CH4
allStreams[2] = 150.0; // CO2
// Fermenter 2
allStreams[3] = 4.0;
allStreams[4] = 350.0;
allStreams[5] = 175.0;
// Fermenter 3
allStreams[6] = 2.0;
allStreams[7] = 250.0;
allStreams[8] = 125.0;

double[] totalBiogas = BioGas.merge_streams(allStreams, 3);
double total;
double[] composition = BioGas.calcRelContent(totalBiogas, out total);

Console.WriteLine($"Gesamt-Biogasproduktion: {total} m³/d");
Console.WriteLine($"H2: {composition[0]} ppm");
Console.WriteLine($"CH4: {composition[1]} %");
Console.WriteLine($"CO2: {composition[2]} %");
```

## Hinweise

- **Einheiten**: Alle Volumenströme werden in m³/d angegeben
- **Indexierung**: Gas-Positionen sind 1-basiert (pos_h2 = 1, pos_ch4 = 2, pos_co2 = 3)
- **Array-Zugriff**: Bei Verwendung der Positionen muss -1 gerechnet werden (z.B. `u[pos_ch4 - 1]`)
- **Methangehalt**: Bei < 40% Methangehalt am Gesamtbiogas wird keine Energieproduktion angenommen
- **Erweiterbarkeit**: Der Biogasvektor kann mehr als 3 Gase enthalten (z.B. H2S als 4. Gas)

## TODOs

Laut Quellcode:
- Viele Parameter sollten private sein (derzeit public)
- Die 40%-Grenze für Energieproduktion bei niedrigem Methananteil benötigt eine Referenz
- Verbesserung der Kapselung durch reduzierte public-Felder
