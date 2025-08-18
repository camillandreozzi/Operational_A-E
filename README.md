# A&E Model Development for Public Health Scotland

<div align="center">
  <table>
    <tr>
      <td><img src="https://raw.githubusercontent.com/camillandreozzi/Operational_A-E/main/results/images_dir/recovered/best_new_site_voronoi_map.png" alt="Voronoi Map of Best New Site" width="400"/></td>
      <td><img src="https://raw.githubusercontent.com/camillandreozzi/Operational_A-E/main/results/images_dir/recovered/best_new_site_model.png" alt="Best New Site Model" width="400"/></td>
    </tr>
    <tr>
      <td align="center">Voronoi Map of Best New Site</td>
      <td align="center">Best New Site from Modelling</td>
    </tr>
  </table>
</div>

## 📋 Summary

- [Project Overview](#-project-overview)
- [Repository Structure](#-repository-structure)
- [Data](#-data)
- [Installation](#-installation)
- [Reproducing Results](#-reproducing-results)
- [Key Findings](#-key-findings)
- [Contributing](#-contributing)
- [Authors](#-authors)
- [License](#-license)

## 🔍 Project Overview

This repository contains all the code developed to address the Undergraduate Operational Research Challenge for Public Health Scotland. The project aims to develop a detailed model for the Accident & Emergency (A&E) system in Scotland, with the goal of understanding and optimizing patient flow in the hospital system.

Public Health Scotland is Scotland's national agency responsible for improving and protecting the health and well-being of its citizens. The goal is to leverage data and analytics to improve the effectiveness and user experience of the healthcare system.

Complete documentation is available in the `docs` folder:
- `problem_description.pdf`: Detailed description of the challenge
- `Business Report.pdf`: Business report with analysis and recommendations
- `Optimizing Healthcare.pdf`: Complete paper with methodology and results

For more information about the challenge, visit [Undergraduate Operational Research Challenge](https://www.maths.ed.ac.uk/school-of-mathematics/events/operational-research-challenge).

## 📁 Repository Structure

The repository is organized into the following main folders:

### `/data`: Data Files *(Local Only - Not in Repository)*
- **`/raw`**: Original data files and intermediate zones data
- **`/processed`**: Cleaned and processed data files (CSV, JSON, Excel formats)
- **`/shapefiles`**: Geographic shapefiles for Scotland data zones
- Main datasets: population estimates, hospital data, A&E activity data
- **Note**: Data files are excluded from the Git repository due to size and privacy considerations

### `/src`: Source Code
- **`/exploratory`**: Notebooks and scripts for exploratory data analysis
  - `data_transf.ipynb`: Data transformation and preprocessing
  - `exploration.ipynb`: Initial exploration of datasets
  - `Exploratory Data Analysis.ipynb`: Detailed analysis of patterns in the data
  - `Exploratory_Analysis_PatientProfiles.R`: R script for patient profile analysis
  - `filter_non_glasgow_data.ipynb`: Data filtering for Glasgow analysis
  - `technique_4.ipynb`: Advanced analysis techniques
  - `waiting_time_analysis.ipynb`: Analysis of waiting times
- **`/modeling`**: Model development and optimization scripts
  - `/location_optimization`: Hospital location optimization models
  - `/wait_time`: Waiting time prediction models
- **`/analysis`**: Additional analysis scripts
- **`/utils`**: Utility functions and helper scripts
- Main analysis files:
  - `intermediate_zones_exploration.ipynb`: Comprehensive zones analysis
  - `glasgow_edinburgh_analysis.R`: Glasgow and Edinburgh comparative analysis
  - `ModelCode.R`: Main modeling code

### `/results`: Results and Outputs
- **`/analysis`**: Analysis reports (PDF format)
- **`/maps`**: Interactive HTML maps and visualizations
- **`/static_maps`**: Static PNG maps and charts
- **`/models`**: Saved model files (R data, numpy, pickle formats)
- **`/images_dir`**: Additional charts and visualizations

### `/docs`: Documentation
- Complete project documentation and reports

- **`/modeling`**: Analytical and optimization models
  - **`/location_optimization`**: Models to optimize the location of healthcare facilities
    - `BNS_ED.ipynb`: Optimization for Emergency Departments
    - `BNS_MIU.ipynb`: Optimization for Minor Injury Units
    - `BNS_real_data.ipynb`: Application of models on real data
    - `Finding_Best_New_Site.ipynb`: Algorithms to find optimal locations
    - `Elderly Work.ipynb`: Specific analyses for the elderly population
    - `Best_New_Site_Distributional_Assumptions.R`: Optimization for optimal locations
    - `metrics.R`: Evaluation metrics for location models
  
  - **`/wait_time`**: Models for waiting time analysis and prediction
    - `Modelling.ipynb`: Predictive models for waiting times

- **`/utils`**: Utility scripts
  - `add_geography.R`: Functions for integrating geographic data
  - `data_transf.R`: Data transformation functions in R

## 📊 Data Management

**Important**: The `/data` directory is excluded from this Git repository for the following reasons:
- **File size**: Large CSV and Excel datasets exceed GitHub's recommended limits
- **Privacy**: Some datasets may contain sensitive healthcare information
- **Local processing**: Data files are processed locally and results are saved in `/results`

To use this repository:
1. Ensure you have the required datasets in the `/data` directory locally
2. Run the analysis scripts which will generate outputs in `/results`
3. The code is designed to work with the expected data structure

### `/docs`: Documentation
- `problem_description.pdf`: Challenge description
- `Business Report.pdf`: Business report
- `Optimizing Healthcare.pdf`: Complete paper

### `/results`: Analysis Results
- **`/images_dir`**: Visualizations and graphs generated from analyses
  - Distribution maps
  - Performance graphs
  - Voronoi visualizations for service areas
- **`/ED`**: Results specific to Emergency Departments
- **`/MIU`**: Results specific to Minor Injury Units
- Model output files (`.Rdata`, `.npz`, `.pkl`)

## 📊 Data

The project uses various datasets provided by Public Health Scotland:
- Monthly A&E activity data
- Patient demographic data
- Geographic data of existing healthcare facilities
- Population data by geographic area

**Note**: Datasets are not included in the GitHub repository due to size and sharing policies. Contact the authors for access to the necessary data.

## 🔧 Installation

### Prerequisites
- Python 3.8+
- R 4.0+
- Git

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/camillandreozzi/Operational_A-E.git
   cd Operational_A-E
   ```

2. Install Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Install required R packages:
   ```R
   install.packages(c("readxl", "tidyverse", "magritt", "ranger", "caret", "optimx", "patchwork", "sf", "tmap"))
   ```

## 🚀 Reproducing Results

### Exploratory Analysis
1. Run the notebooks in the `src/exploratory` folder to understand the data
2. Follow the `Exploratory Data Analysis.ipynb` notebook for a complete analysis

### Optimization Models
1. For location optimization:
   - Start with `src/modeling/location_optimization/BNS_real_data.ipynb`
   - Run `Finding_Best_New_Site.ipynb` to obtain optimal locations

2. For waiting time analysis:
   - Use `src/modeling/wait_time/Modelling.ipynb`

### Visualizing Results
The main results are available in the `results` folder, with visualizations in the `images_dir` subfolder.

Key visualizations include:
- **Optimal Locations**: Best new site modeling results in `results/images_dir/recovered/best_new_site_model.png`
- **Service Areas**: Voronoi maps showing coverage in `results/images_dir/recovered/best_new_site_voronoi_map.png`
- **Patient Flow Changes**: Impact analysis in `results/images_dir/recovered/change_in_attendances.png`
- **Combined Solutions**: Multi-facility optimization in `results/images_dir/recovered/combined_solution.png`

## 📈 Key Findings

The project has led to significant results for the optimization of the Scottish healthcare system:

1. **Identification of Optimal Locations**: Optimal locations for new healthcare facilities have been identified that minimize access times for the population.

2. **Usage Pattern Analysis**: Significant patterns in emergency service utilization have been identified, with particular attention to demographic and geographic differences.

3. **Predictive Models for Waiting Times**: Models have been developed to predict waiting times in healthcare facilities, allowing for better resource planning.

4. **Optimization for Vulnerable Populations**: Specific analyses for elderly populations and other vulnerable categories, with recommendations to improve access to services.

For complete details, consult the document `docs/Optimizing Healthcare.pdf`.

## 👥 Contributing

If you wish to contribute to this project:

1. Fork the repository
2. Create a branch for your changes: `git checkout -b feature/feature-name`
3. Commit your changes: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature/feature-name`
5. Open a Pull Request

## ✍️ Authors

* **Glauco Rampone**: Python Notebooks, Data Analysis, Model Development
* **Camilla Andreozzi**: R Code, Data Analysis, Model Development

## 📄 License

This project is released under the MIT License - see the LICENSE file for details.
