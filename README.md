# A&E Model Development for Public Health Scotland

This repository contains all the code used to address the Undergraduate Operational Research Challenge for Public Health Scotland. The project aims to develop a more detailed Accident & Emergency (A&E) model to understand the flow of patients being admitted to the hospital system. 

A full description of the challenge  (`problem_description.pdf`), the business report file (`Business Report.pdf`) and the full paper (`Optimizing Healthcare.pdf`) can be found in thein this repository in the `docs` folder. For more information about the challenge, please visit the [Undergraduate Operational Research Challenge](https://www.maths.ed.ac.uk/school-of-mathematics/events/operational-research-challenge).

Public Health Scotland is Scotland’s national agency responsible for improving and protecting the health and well-being of its citizens. Their goal is to leverage intelligence and data to enhance the healthcare system's effectiveness and user experience.

<table>
<tr>
<td><img src="data/images/best_new_site_voronoi_map.png" alt="Voronoi Map of Best New Site" style="width: 460px;"/></td>
<td><img src="data/images/best_new_site_model.png" alt="Best New Site from Modelling" style="width: 400px;"/></td>
</tr>
<tr>
<td align="center">Voronoi Map of Best New Site</td>
<td align="center">Best New Site from Modelling</td>
</tr>
</table>

## Getting Started

Clone the repository to your local machine using:
   ```bash
   git clone https://github.com/camillandreozzi/Operational_A-E.git
   ```

To install required libraries in **Python**:
   ```bash
   pip install -r requirements.txt
   ```

To install required libraries in **R**:
   ```R
   install.packages(c("readxl", "tidyverse", "magritt", "ranger", "caret", "optimx", "patchwork"))
   ```



Run the R scripts and Python notebooks to replicate the model development and analysis.


## Contributing

If you wish to contribute to this project, please fork the repository and submit a pull request with your proposed changes.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Authors

* **Glauco Rampone**: Python Notebooks, Data Analysis, Model Development
* **Camilla Andreozzi**: R Code, Data Analysis, Model Development
