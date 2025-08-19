# A&E Model Development for Public Health Scotland

<div align="center">
  <table>
    <tr>
      <td><img src="https://raw.githubusercontent.com/camillandreozzi/Operational_A-E/main/results/images_dir/best_new_site_voronoi_map.png" alt="Voronoi Map of Best New Site" width="400"/></td>
      <td><img src="https://raw.githubusercontent.com/camillandreozzi/Operational_A-E/main/results/images_dir/best_new_site_model.png" alt="Best New Site Model" width="400"/></td>
    </tr>
    <tr>
      <td align="center">Voronoi Map of Best New Site</td>
      <td align="center">Best New Site from Modelling</td>
    </tr>
  </table>
</div>

## 📋 Summary

- [Project Overview](#-project-overview)
- [Data](#-data)
- [Installation](#-installation)
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
