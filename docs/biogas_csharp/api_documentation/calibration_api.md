# Calibration Package API Documentation

## Übersicht

Das `biocalib` Namespace ist für die Kalibrierung von Sensoren und Referenzmessungen in Biogasanlagen vorgesehen.

## Status

⚠️ **Hinweis**: Dieses Paket befindet sich in der Planungsphase und enthält derzeit nur eine Platzhalter-Klasse.

## Klassen

### `calibration`

Platzhalter-Klasse für zukünftige Kalibrierungsfunktionalität.

#### Beschreibung

Diese Klasse ist als Rahmen für die Implementierung von Kalibrierungsfunktionen vorgesehen.

## Geplante Funktionalität

Laut TODOs im Quellcode ist folgende Funktionalität geplant:

### Sensor-Verwaltung

- Anlegen von Referenzsensoren zu Beginn der Simulation
- Einlesen von Referenzmessungen
- Zuordnung von simulierten Sensoren zu Referenzsensoren

### Konfiguration

- Definition über XML-Dateien
- Identifikation von Sensor-Zuordnungen über IDs
- Mapping zwischen Referenz- und Simulationssensoren

## Geplante Architektur

```csharp
namespace biocalib
{
    /// <summary>
    /// Verwaltung von Sensorkalibrierung und Referenzmessungen
    /// </summary>
    public class calibration
    {
        // Geplante Eigenschaften:
        // - Liste von Referenzsensoren
        // - Zuordnung Referenz <-> Simulation
        // - Kalibrierungsparameter
        
        // Geplante Methoden:
        // - LoadReferenceMeasurements()
        // - CreateReferenceSensors()
        // - MapSimulatedToReferenceSensor()
        // - ApplyCalibration()
    }
}
```

## Anwendungsszenario (geplant)

### Kalibrierung eines pH-Sensors

```csharp
// Beispiel für zukünftige Verwendung
var calibration = new calibration();

// Referenzmessungen laden
calibration.LoadReferenceMeasurements("reference_data.xml");

// Referenzsensoren erstellen
calibration.CreateReferenceSensors();

// Simulierten Sensor zuordnen
calibration.MapSimulatedToReferenceSensor(
    simulatedSensorId: "pH_sensor_fermenter1",
    referenceSensorId: "ref_pH_lab_001"
);

// Kalibrierung anwenden
var calibratedValue = calibration.ApplyCalibration("pH_sensor_fermenter1", rawValue);
```

## Integration mit dem System

Die Kalibrierung soll mit folgenden Komponenten interagieren:

### Sensoren
- Lesen von Sensor-IDs aus der Biogasanlage
- Zuordnung zu Referenzmessungen
- Anwendung von Kalibrierungskurven

### XML-Konfiguration

Geplantes Format für Sensor-Zuordnung:

```xml
<calibration>
    <reference_sensor id="ref_pH_001" type="pH">
        <measurements file="ref_data_pH.csv" />
    </reference_sensor>
    
    <sensor_mapping>
        <map simulated_id="pH_sensor_fermenter1" 
             reference_id="ref_pH_001" />
    </sensor_mapping>
    
    <calibration_parameters sensor_id="pH_sensor_fermenter1">
        <offset>0.2</offset>
        <scale>1.05</scale>
    </calibration_parameters>
</calibration>
```

## Entwicklungsstatus

- [ ] Grundlegende Klassenstruktur
- [ ] Referenzsensor-Verwaltung
- [ ] XML-Konfiguration
- [ ] Kalibrierungsalgorithmen
- [ ] Integration mit Simulationsumgebung
- [ ] Dokumentation
- [ ] Unit Tests

## Hinweise für Entwickler

Beim Implementieren dieser Funktionalität sollten folgende Aspekte berücksichtigt werden:

1. **Datenformat**: Einheitliches Format für Referenzmessungen definieren
2. **Zeitstempel**: Synchronisation zwischen Referenz- und Simulationsdaten
3. **Interpolation**: Umgang mit nicht-synchronen Messzeitpunkten
4. **Validierung**: Prüfung der Kalibrierungsqualität
5. **Fehlerbehandlung**: Robuster Umgang mit fehlenden oder fehlerhaften Referenzdaten

## Siehe auch

- `biogas.sensors`: Sensor-Definitionen in der Simulation
- `biogas.plant`: Integration mit Anlagenmodell
- XML-Konfigurationsdateien für Anlagenparameter
