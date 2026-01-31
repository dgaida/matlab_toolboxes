# MATLAB Toolboxes for Biogas Plant Modeling, Simulation, and Control

This repository contains a comprehensive collection of MATLAB and C# tools for the simulation, optimization, and control of biogas plants. It is based on the **Anaerobic Digestion Model No. 1 (ADM1)** and provides extensive functionality for modeling all relevant components of a biogas plant.

## 🌟 Overview

The toolboxes are designed to support research and development in the field of anaerobic digestion. They include process models, control algorithms, optimization methods, and graphical user interfaces.

### Key Features
- **ADM1 Integration**: Scientifically validated process model.
- **Full Plant Modeling**: Digesters, CHPs, pumps, substrates, sensors.
- **Control & Optimization**: Advanced control strategies and optimization tools.
- **Machine Learning**: Tools for data-driven modeling and analysis.
- **C# Toolbox**: A standalone C# library for biogas plant modeling.

## 📂 Repository Structure

The repository is organized into several specialized toolboxes:

### Biogas Specific Toolboxes
- `biogas_blocks/`: Simulink blocks simulating biogas plant components.
- `biogas_c#/`: A comprehensive C# library for modeling and simulation.
- `biogas_calibration/`: Tools for calibrating biogas plant models.
- `biogas_control/`: Advanced control algorithms for biogas processes.
- `biogas_gui/`: Graphical user interfaces for monitoring and simulation.
- `biogas_ml/`: Machine learning tools tailored for biogas data.
- `biogas_optimization/`: Optimization scripts for plant operation.
- `biogas_scripts/`: General utility scripts for biogas modeling.

### Core Utility Toolboxes
- `data_tool/`: Data processing and statistical analysis.
- `numerics_tool/`: Numerical methods and classes.
- `optimization_tool/`: General-purpose optimization algorithms.
- `ml_tool/`: Machine learning framework.
- `cv_tool/`: Computer vision utilities.
- `io_tool/`: File I/O operations.
- `doc_tool/`: Automated documentation generation.
- `setup_tool/`: Installation and path management.
- `toolbox_creator/`: Tools for creating and packaging MATLAB toolboxes.

## 🚀 Getting Started (MATLAB)

### Installation
1. Ensure you have MATLAB R2010a or later installed.
2. Clone this repository to your local machine.
3. Set the repository root as your current MATLAB directory.
4. Run the installation script:
   ```matlab
   install_biogaslibrary_full()
   ```
   *Note: Detailed installation steps can be found in `ReadMe1st.txt`.*

### Running a Simulation
1. Navigate to `.../biogaslibrary/examples/model/Gummersbach`.
2. Open `plant_gummersbach.mdl` in Simulink.
3. Start the simulation.
4. Use the `gui_sensors` tool to visualize process values after simulation.

## 💻 Biogas C# Toolbox

The `biogas_c#` directory contains a standalone C# library for biogas plant modeling. It is suitable for integration into .NET applications.

For more details, see the [Biogas C# Toolbox README](biogas_c#/README.md).

## 📖 Documentation

- **MATLAB Help**: Use the `doc` command in MATLAB to access the integrated help files.
- **C# API**: API documentation for the C# library is located in `docs/biogas_csharp/api_documentation/`.

## 🔬 Scientific Basis

The models are primarily based on:
- **Batstone et al. (2002)**: "The IWA Anaerobic Digestion Model No 1 (ADM1)"
- Research conducted at **Cologne University of Applied Sciences (TH Köln)**.

## 📜 License

This project is licensed under the **GNU General Public License v3.0**. See the `LICENSE` file for details.

## 👥 Authors & Contact

- **Daniel Gaida**: daniel.gaida@th-koeln.de
- **GECO-C Team**: [http://geco.web.fh-koeln.de/](http://geco.web.fh-koeln.de/)

---
*Last Updated: February 2025*
