# Biogas C# Toolbox

A comprehensive C# library for modeling, simulation, and optimization of biogas plants.

## 📋 Overview

The **Biogas C# Toolbox** is a specialized software library for the simulation and optimization of biogas plants. It is based on the **Anaerobic Digestion Model No. 1 (ADM1)** and provides extensive functionality for modeling all relevant components of a biogas plant.

### Key Features

- **Full Plant Modeling**: Digesters, CHPs, pumps, substrates, sensors
- **ADM1 Integration**: Scientifically validated process model
- **Physicochemical Calculations**: Buswell equation, COD, BMP, elemental balances
- **Optimization**: Fitness functions, constraints, multi-objective optimization
- **Economics**: Renewable Energy Sources Act (EEG) remuneration (2009/2012), cost-benefit analysis
- **Sensor Simulation**: Realistic sensors with noise, drift, and calibration
- **XML Persistence**: Save and load all configurations

## 🚀 Quick Start

The `biogas_c#` folder contains the C# source code that can be used to create DLLs. These DLLs are required for the following example.

### Simple Example: Simulating a Biogas Plant

```csharp
using biogas;
using science;

// Load plant configuration
var plant = new plant("plant_config.xml");
var substrates = new substrates("substrates.xml");
var sensors = sensors.create_sensor_network(plant, substrates, 
                                            plant_network, plant_network_max);

// Define substrate feeding (e.g., maize and manure)
double[] Q = {100.0, 50.0};  // m³/d

// Simulation over 30 days
for (double t = 0; t < 30; t += 0.5)
{
    // ADM simulation (simplified)
    double[] stream = /* ADM state vector */;
    
    // Perform measurements
    sensors.measure_type0(t, stream, "F1", 3);
    
    // Retrieve process parameters
    double pH = sensors.getCurrentMeasurementD("pH_F1_3");
    double vfa = sensors.getCurrentMeasurementD("VFA_F1_3");
    
    Console.WriteLine($"Day {t}: pH={pH:F2}, VFA={vfa:F0} mg/l");
}
```

## 📦 Main Components

### 1. Plant Components (`biogas.plant`)

```csharp
// Create biogas plant
var plant = new plant();

// Add digester
var fermenter = new digester("F1", "Main Digester");
fermenter.set_params_of("Vliq", 2500.0, "T", 42.0);
plant.addDigester(fermenter);

// Add CHP unit
var chp = new chp("CHP1", "CHP Unit 1");
chp.set_params_of("Pel", 500.0, "eta_el", 0.42);
plant.addCHP(chp);

// Save configuration
plant.saveAsXML("my_plant.xml");
```

### 2. Substrates (`biogas.substrates`)

```csharp
// Define substrate
var maize = new substrate("maize", "Maize Silage");
maize.set_params_of(
    "TS", 32.0,    // % FM (Fresh Matter)
    "VS", 95.0,    // % TS (Total Solids)
    "RF", 20.0,    // Crude Fiber
    "RP", 8.0,     // Crude Protein
    "RL", 3.0      // Crude Fat
);

// Calculations
double bmp = maize.calcBMP().Value;              // l/g FM
double gasQuality = maize.calcGasQuality().Value; // % CH4
Console.WriteLine($"BMP: {bmp:F2} l/g FM, CH4: {gasQuality:F1}%");
```

### 3. Sensors (`biogas.sensors`)

```csharp
// Automatically create sensor network
var sensors = sensors.create_sensor_network(
    plant, substrates, plant_network, plant_network_max
);

// Perform measurements
double[] stream = /* ADM Stream */;
sensors.measure(5.0, "pH_F1_3", stream);

// Retrieve values
physValue pH = sensors.getCurrentMeasurement("pH_F1_3");
double pH_value = sensors.getCurrentMeasurementD("pH_F1_3");

// Time series
double[] time = sensors.getTimeStream();
double[] pH_values;
sensors.getMeasurementStream("pH_F1_3", out pH_values);
```

### 4. Chemical Calculations (`biogas.chemistry`)

```csharp
using biogas;

// Buswell equation for carbohydrates
physValue ch4, co2;
chemistry.buswell_extended("Xch", out ch4, out co2);
Console.WriteLine($"CH4: {ch4.Value} mol/mol, CO2: {co2.Value} mol/mol");

// Calculate COD
physValue cod = chemistry.get_COD_of("Sac");  // Acetic acid
Console.WriteLine($"COD Acetate: {cod.Value} gCOD/mol");

// Elemental composition
physValue c, h, o, n, s;
chemistry.get_CHONS_of("Xpr", out c, out h, out o, out n, out s);
Console.WriteLine($"Protein: C{c.Value}H{h.Value}O{o.Value}N{n.Value}");
```

### 5. Optimization (`biooptim`)

```csharp
using biooptim;

// Define fitness parameters
var fitnessParams = new fitness_params(2);
fitnessParams.myWeights.set_params_of(
    "w_money", 0.4,
    "w_CH4", 0.2,
    "w_pH", 0.15
);

// Calculate objective functions
double stability, energyBalance, fitness_constr;
double[] fitness;

objectives.getObjectives(
    sensors, plant, substrates, fitnessParams,
    out stability, out energyBalance, /* ... */, out fitness
);

Console.WriteLine($"Fitness: {fitness[0]:F3}");
Console.WriteLine($"Energy Balance: {energyBalance:F2} k€/d");
```

## 🔬 Scientific Basis

### Anaerobic Digestion Model No. 1 (ADM1)

The ADM1 is the leading mathematical model for anaerobic digestion processes:

- **Process Steps**: Disintegration → Hydrolysis → Acidogenesis → Acetogenesis → Methanogenesis
- **19 State Variables**: Dissolved and particulate components
- **Inhibitions**: pH, NH3, H2
- **Gas Phase**: CH4, CO2, H2

### Physicochemical Models

- **Buswell Equation**: Theoretical biogas production from CcHhOoNnSs
- **COD Balancing**: Chemical Oxygen Demand for all components
- **Elemental Balances**: C, H, O, N, S
- **Thermodynamics**: Gibbs energy, equilibria

### Validated Parameters

All default values are based on scientific literature:
- Batstone et al. (2002): ADM1 Report
- Rieger et al. (2003): Sensor modeling
- Koch et al. (2010): Grass silage modeling
- Gaida (2009): Theoretical foundations

## 📊 Typical Use Cases

### 1. Process Monitoring

```csharp
// Monitor critical process parameters
double pH = sensors.getCurrentMeasurementD("pH_F1_3");
double vfa = sensors.getCurrentMeasurementD("VFA_F1_3");
double olr = sensors.getCurrentMeasurementD("OLR_F1");

if (pH < 6.8 || pH > 7.5)
    Console.WriteLine("⚠️ pH outside optimal range!");
    
if (vfa > 3000)
    Console.WriteLine("⚠️ VFA critically high!");
    
if (olr > 4.0)
    Console.WriteLine("⚠️ Overload!");
```

### 2. Substrate Optimization

```csharp
// Test different substrate mixtures
var scenarios = new Dictionary<string, double[]>
{
    {"100% Maize", new double[] {150, 0}},
    {"50/50 Mix", new double[] {75, 100}},
    {"Optimal", new double[] {80, 120}}
};

foreach (var scenario in scenarios)
{
    // Simulation with mixture
    // ... ADM calculation ...
    
    double pH = sensors.getCurrentMeasurementD("pH_F1_3");
    double ch4 = sensors.getCurrentMeasurementD("CH4_F1_3");
    
    Console.WriteLine($"{scenario.Key}: pH={pH:F2}, CH4={ch4:F1}%");
}
```

### 3. Energy Balance

```csharp
// Electrical energy
double[] biogas = {10, 500, 200};  // H2, CH4, CO2 [m³/d]
physValue P_el, P_therm;
plant.burnBiogas("CHP1", biogas, out P_el, out P_therm);

// Heat requirement
double heatPower = plant.calcHeatPower("F1", Q, substrates, 
                                       plant.Tout, sensors);

// Balance
double balance = P_therm.Value - heatPower;
Console.WriteLine($"Heat surplus: {balance:F1} kWh/d");
```

### 4. Economics

```csharp
// EEG remuneration
double remuneration = plant.getVerguetung(500.0, true);  // kW, manure bonus
Console.WriteLine($"Remuneration: {remuneration * 100:F2} ct/kWh");

// Annual revenue
double fullLoadHours = 8000;  // h/a
double annualRevenue = 500 * fullLoadHours * remuneration;
Console.WriteLine($"Annual Revenue: {annualRevenue:N0} €/a");
```

## 🛠️ Advanced Features

### Realistic Sensors

```csharp
// Sensor with noise and drift
var pH_sensor = new pH_sensor("F1_3");
pH_sensor.myConfigs[0].set_params_of(
    "apply_real_sensor", true,
    "noise_level", 0.05,        // 5% noise
    "drift", 0.01,              // 0.01 pH/d drift
    "dT_calib", 7.0             // Weekly calibration
);

// Ideal vs. real measurement
physValue pH_ideal = pH_sensor.getCurrentMeasurement(false);
physValue pH_real = pH_sensor.getCurrentMeasurement(true);
```

### Multi-Digester Operation

```csharp
// Different digesters with different substrate mixtures
var distribution = new Dictionary<string, double[]>
{
    {"F1", new double[] {100, 0}},      // Only maize
    {"F2", new double[] {0, 150}},      // Only manure
    {"F3", new double[] {50, 50}}       // Mix
};

foreach (var kvp in distribution)
{
    string id = kvp.Key;
    double[] Q = kvp.Value;
    
    // Calculate HRT (Hydraulic Retention Time)
    double vliq = plant.getDigesterParam(id, "Vliq");
    var hrt = digester.calcHRT(Q, new physValue(vliq, "m³"));
    
    Console.WriteLine($"{id}: HRT = {hrt.Value:F1} d");
}
```

### Fitness-based Optimization

```csharp
// Multi-Objective Optimization
var fitnessParams = new fitness_params(2);
fitnessParams.set_params_of("nObjectives", 2);

double[] fitness;
objectives.getObjectives(/* ... */, out fitness);

Console.WriteLine($"Objective 1 (Economics): {fitness[0]:F2}");
Console.WriteLine($"Objective 2 (Process Stability): {fitness[1]:F3}");
```

## 📖 Documentation

Full API documentation is available in `docs/biogas_csharp/api_documentation/`:

- **Plant Components**:
  - [plant_api.md](../docs/biogas_csharp/api_documentation/plant/plant_api.md) - Overall plant
  - [digesters_api.md](../docs/biogas_csharp/api_documentation/plant/digesters_api.md) - Digesters, heating, agitators
  - [chps_api.md](../docs/biogas_csharp/api_documentation/plant/chps_api.md) - CHP units
  - [transportation_api.md](../docs/biogas_csharp/api_documentation/plant/transportation_api.md) - Pumps and substrate transport
  - [final_storage_api.md](../docs/biogas_csharp/api_documentation/plant/final_storage_api.md) - Final storage
  - [gas_storage_api.md](../docs/biogas_csharp/api_documentation/plant/gas_storage_api.md) - Gas storage (planned)

- **Substrates & Chemistry**:
  - [substrates_api.md](../docs/biogas_csharp/api_documentation/substrates_api.md) - Substrate definitions
  - [physchem_api.md](../docs/biogas_csharp/api_documentation/physchem_api.md) - Physicochemical calculations
  - [biogas_api.md](../docs/biogas_csharp/api_documentation/biogas_api.md) - Biogas composition

- **Sensors**:
  - [sensors_api.md](../docs/biogas_csharp/api_documentation/plant/sensors/sensors_api.md) - Sensor management
  - [sensor_base_api.md](../docs/biogas_csharp/api_documentation/plant/sensors/sensor_base_api.md) - Base sensor class
  - [sensor_array_api.md](../docs/biogas_csharp/api_documentation/plant/sensors/sensor_array_api.md) - Sensor arrays
  - [sensor_config_api.md](../docs/biogas_csharp/api_documentation/plant/sensors/sensor_config_api.md) - Sensor configuration

- **Optimization**:
  - [optim_params_api.md](../docs/biogas_csharp/api_documentation/optim_params_api.md) - Fitness parameters
  - [optimization_api.md](../docs/biogas_csharp/api_documentation/optimization_api.md) - Objective functions

- **Economics**:
  - [finances_api.md](../docs/biogas_csharp/api_documentation/plant/finances_api.md) - EEG remuneration

- **Calibration**:
  - [calibration_api.md](../docs/biogas_csharp/api_documentation/calibration_api.md) - Sensor calibration (planned)

## ⚙️ System Requirements

- **.NET Framework** 4.5 or higher / **.NET Core** 3.1+
- **C# 7.0** or higher
- Optional: **MATLAB** for ADM integration (via COM)

### Dependencies

The toolbox primarily uses .NET standard libraries:
- `System.Xml` - XML processing
- `System.Collections.Generic` - Data structures
- No external NuGet packages required

## 🔧 Installation

### From Source

```bash
git clone https://github.com/dgaida/matlab_toolboxes.git
cd matlab_toolboxes/biogas_c#
```

Open the project in Visual Studio and compile.

### As a Library

1. Reference the compiled DLL:
   ```csharp
   // In project references
   using biogas;
   using science;
   using biooptim;
   ```

2. Or include source files directly

## 🧪 Testing

```csharp
// Unit Test Example (NUnit)
[Test]
public void TestBuswellEquation()
{
    physValue ch4, co2;
    chemistry.buswell_extended("Xch", out ch4, out co2);
    
    Assert.AreEqual(3.0, ch4.Value, 0.01);
    Assert.AreEqual(3.0, co2.Value, 0.01);
}
```

## 📝 XML Configuration

### Example: Digester

```xml
<digester id="F1">
    <name>Main Digester</name>
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

### Example: Substrate

```xml
<substrate id="maize">
    <name>Maize Silage</name>
    <substrate_class>Maize (GPS) (EK I)</substrate_class>
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

Contributions are welcome! Please note:

1. **Code Style**: Consistent with existing code
2. **Documentation**: XML comments for all public methods
3. **Tests**: Unit tests for new features
4. **Validation**: Scientific references for new models

## 📜 License

GPL-3.0 license

## 📚 Literature

### Core References

1. **Batstone et al. (2002)**: "The IWA Anaerobic Digestion Model No 1 (ADM1)" - Water Science & Technology
2. **Koch et al. (2010)**: "Biogas from grass silage – Measurements and modeling with ADM1" - Bioresource Technology
3. **Rieger et al. (2003)**: "Modelling of a secondary clarifier combined with a non-ideal activated sludge model" - WST
4. **Gaida (2009)**: "Anaerobic Fermentation - Theoretical Foundations, Simulation and Control" (Die anaerobe Fermentation - Theoretische Grundlagen, Simulation und Regelung)

### Further Reading

- VDI 4630: Fermentation of organic materials
- VDI 3475: Biogas for engines
- FNR: Biogas Guide
- KTBL: Biogas Figures

## 👥 Authors & Contact

daniel.gaida@th-koeln.de

## 🙏 Acknowledgments

This toolbox is based on years of research in the field of anaerobic digestion. Special thanks to:

- IWA Task Group for ADM1

---

## 💡 Tips & Tricks

### Performance

```csharp
// Efficient: Reusing objects
var sensors = sensors.create_sensor_network(/* ... */);
for (double t = 0; t < 100; t += 0.5)
{
    sensors.measure_type0(t, stream, "F1", 3);
}

// Inefficient: Re-creating in every iteration
for (double t = 0; t < 100; t += 0.5)
{
    var sensors = new sensors();  // ❌
    sensors.measure(t, "pH_F1_3", stream);
}
```

### Error Handling

```csharp
try
{
    double pH = sensors.getCurrentMeasurementD("pH_F1_3");
}
catch (exception ex)
{
    Console.WriteLine($"Error: {ex.Message}");
    // ErrorLog.txt is automatically created
}
```

### Debugging

```csharp
// Detailed output
Console.WriteLine(plant.print());
Console.WriteLine(sensors.print());
Console.WriteLine(substrates.print());
```

---

**Version**: 0.2  
**Last Update**: January 2026
**Status**: Productive (ADM1 core), Development (extended features)
