# Project Structure Documentation

## Overview
This document describes the organized structure of the Operational_A-E repository for Public Health Scotland's A&E optimization project.

## Directory Structure

```
Operational_A-E/
├── data/                           # All data files
│   ├── raw/                        # Original, unprocessed data
│   │   └── intermediate_zones_data/     # Scotland geographic zones data
│   ├── processed/                  # Cleaned and transformed data
│   │   ├── edinburgh_*.csv/.json/.xlsx  # Edinburgh data in various formats
│   │   ├── glasgow_*.csv/.json/.xlsx    # Glasgow data in various formats
│   │   └── *_metadata.json         # Data metadata files
│   ├── shapefiles/                 # Geographic boundary files
│   └── *.csv                       # Main datasets (population, hospitals, A&E activity)
│
├── src/                            # Source code
│   ├── exploratory/                # Data exploration notebooks
│   │   ├── data_transf.ipynb       # Data transformation
│   │   ├── exploration.ipynb       # Initial data exploration
│   │   ├── Exploratory_Data_Analysis.ipynb  # Detailed EDA
│   │   ├── filter_non_glasgow_data.ipynb    # Glasgow data filtering
│   │   ├── technique_4.ipynb       # Advanced analysis techniques
│   │   └── waiting_time_analysis.ipynb     # Waiting time analysis
│   ├── modeling/                   # Model development
│   │   ├── location_optimization/  # Hospital location models
│   │   │   ├── BNS_*.ipynb         # Best New Site models
│   │   │   ├── Finding_Best_New_Site.ipynb
│   │   │   └── metrics.R           # Performance metrics
│   │   └── wait_time/              # Waiting time prediction
│   │       └── Modelling.ipynb
│   ├── analysis/                   # Additional analysis scripts
│   ├── utils/                      # Utility functions
│   │   ├── add_geography.R         # Geographic utilities
│   │   └── data_transf.R           # Data transformation utilities
│   ├── intermediate_zones_exploration.ipynb  # Main zones analysis
│   ├── lavoro_glasgow_edi.R        # Glasgow-Edinburgh comparison
│   └── ModelCode.R                 # Main modeling code
│
├── results/                        # All outputs and results
│   ├── analysis/                   # Analysis reports
│   │   └── comprehensive_datazones_analysis.pdf
│   ├── maps/                       # Interactive HTML maps
│   │   ├── glasgow_*.html          # Glasgow interactive maps
│   │   ├── edinburgh_*.html        # Edinburgh interactive maps
│   │   └── *_density_map.html      # Density visualizations
│   ├── static_maps/                # Static PNG charts and maps
│   │   ├── glasgow_*.png           # Glasgow static visualizations
│   │   └── *_analysis.png          # Analysis charts
│   ├── models/                     # Saved model files
│   │   ├── *.Rdata                 # R model objects
│   │   ├── *.npz                   # NumPy arrays
│   │   └── *.pkl                   # Pickle files
│   └── images_dir/                 # Additional visualizations
│       └── recovered/              # Recovered analysis images
│
├── docs/                           # Documentation
│   ├── Business Report.pdf         # Business analysis report
│   ├── Optimizing Healthcare.pdf   # Complete methodology paper
│   └── problem_description.pdf     # Challenge description
│
├── requirements.txt                # Python dependencies
├── README.md                       # Main project documentation
├── STRUCTURE.md                    # This file
└── LICENSE                         # Project license
```

## File Organization Principles

### Data Organization
- **Raw data**: Kept in original format in `data/raw/`
- **Processed data**: Cleaned versions in `data/processed/`
- **Geographic data**: Shapefiles in dedicated folder
- **Multiple formats**: CSV, JSON, Excel for different use cases

### Code Organization
- **Exploratory**: Initial data exploration and EDA
- **Modeling**: Advanced models and optimization
- **Analysis**: Specific analysis scripts
- **Utils**: Reusable functions and utilities

### Results Organization
- **Analysis**: Final reports and documents
- **Maps**: Interactive visualizations
- **Static maps**: Charts and static visualizations
- **Models**: Saved model objects for reproduction

## Key Files

### Main Analysis Files
- `src/intermediate_zones_exploration.ipynb`: Comprehensive analysis of Scottish intermediate zones
- `src/glasgow_edinburgh_analysis.R`: Comparative analysis between Glasgow and Edinburgh
- `src/ModelCode.R`: Main modeling and optimization code

### Key Datasets
- `data/FINAL_DATA.csv`: Main processed dataset
- `data/hospitals.csv`: Hospital information
- `data/monthly_ae_activity_202505.csv`: A&E activity data
- `data/dz2011-pop-est_21112024.csv`: Population estimates

### Main Results
- `results/analysis/comprehensive_datazones_analysis.pdf`: Complete analysis report
- `results/models/best_new_site_model.Rdata`: Optimal location model
- `results/maps/glasgow_all_zones_interactive_map.html`: Interactive Glasgow map

## Environment Setup

The Python environment is located in `../env_phs/` relative to the repository root. To activate:

```bash
# Windows
..\env_phs\Scripts\activate

# Linux/Mac
source ../env_phs/bin/activate
```

All required packages are listed in `requirements.txt`.
