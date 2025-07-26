# A&E Model Development for Public Health Scotland

<div align="center">
  <img src="https://raw.githubusercontent.com/camillandreozzi/Operational_A-E/main/results/images_dir/best_ed.png" alt="A&E Optimization" width="700"/>
</div>

## 📋 Sommario

- [Panoramica del Progetto](#-panoramica-del-progetto)
- [Struttura del Repository](#-struttura-del-repository)
- [Dati](#-dati)
- [Installazione](#-installazione)
- [Riproduzione dei Risultati](#-riproduzione-dei-risultati)
- [Principali Risultati](#-principali-risultati)
- [Contributi](#-contributi)
- [Autori](#-autori)
- [Licenza](#-licenza)

## 🔍 Panoramica del Progetto

Questo repository contiene tutto il codice sviluppato per affrontare la Undergraduate Operational Research Challenge di Public Health Scotland. Il progetto mira a sviluppare un modello dettagliato per il sistema di Pronto Soccorso (A&E) in Scozia, con l'obiettivo di comprendere e ottimizzare il flusso dei pazienti nel sistema ospedaliero.

Public Health Scotland è l'agenzia nazionale scozzese responsabile del miglioramento e della protezione della salute e del benessere dei cittadini. L'obiettivo è sfruttare i dati e le analisi per migliorare l'efficacia e l'esperienza degli utenti del sistema sanitario.

La documentazione completa è disponibile nella cartella `docs`:
- `problem_description.pdf`: Descrizione dettagliata della sfida
- `Business Report.pdf`: Report di business con analisi e raccomandazioni
- `Optimizing Healthcare.pdf`: Paper completo con metodologia e risultati

Per maggiori informazioni sulla sfida, visita [Undergraduate Operational Research Challenge](https://www.maths.ed.ac.uk/school-of-mathematics/events/operational-research-challenge).

## 📁 Struttura del Repository

Il repository è organizzato nelle seguenti cartelle principali:

### `/src`: Codice Sorgente
- **`/exploratory`**: Notebook e script per l'analisi esplorativa dei dati
  - `data_transf.ipynb`: Trasformazione e preprocessing dei dati
  - `exploration.ipynb`: Esplorazione iniziale dei dataset
  - `Exploratory Data Analysis.ipynb`: Analisi dettagliate sui pattern nei dati
  - `Exploratory_Analysis_PatientProfiles.R`: Script R per l'analisi dei profili pazienti

- **`/modeling`**: Modelli analitici e di ottimizzazione
  - **`/location_optimization`**: Modelli per ottimizzare la posizione delle strutture sanitarie
    - `BNS_ED.ipynb`: Ottimizzazione per i Pronto Soccorso (Emergency Departments)
    - `BNS_MIU.ipynb`: Ottimizzazione per le unità per traumi minori (Minor Injury Units)
    - `BNS_real_data.ipynb`: Applicazione dei modelli su dati reali
    - `Finding_Best_New_Site.ipynb`: Algoritmi per trovare le posizioni ottimali
    - `Elderly Work.ipynb`: Analisi specifiche per la popolazione anziana
    - `Best_New_Site_Distributional_Assumptions.R`: Assunzioni distributive per i modelli
    - `metrics.R`: Metriche di valutazione per i modelli di localizzazione
  
  - **`/wait_time`**: Modelli per l'analisi e la previsione dei tempi di attesa
    - `Modelling.ipynb`: Modelli predittivi per i tempi di attesa

- **`/utils`**: Script di utilità
  - `add_geography.R`: Funzioni per l'integrazione dei dati geografici
  - `data_transf.R`: Funzioni di trasformazione dati in R

### `/data`: Dati del Progetto
- Contiene tutti i dataset utilizzati nel progetto (file CSV, Excel)
- `/shapefiles`: File di forme geografiche per la visualizzazione e l'analisi spaziale

### `/docs`: Documentazione
- `problem_description.pdf`: Descrizione della sfida
- `Business Report.pdf`: Report di business
- `Optimizing Healthcare.pdf`: Paper completo

### `/results`: Risultati delle Analisi
- **`/images_dir`**: Visualizzazioni e grafici generati dalle analisi
  - Mappe di distribuzione
  - Grafici di performance
  - Visualizzazioni Voronoi per le aree di servizio
- **`/ED`**: Risultati specifici per i Pronto Soccorso
- **`/MIU`**: Risultati specifici per le Unità per Traumi Minori
- File di output dei modelli (`.Rdata`, `.npz`, `.pkl`)

## 📊 Dati

Il progetto utilizza diversi dataset forniti da Public Health Scotland:
- Dati di attività mensile dei Pronto Soccorso
- Dati demografici dei pazienti
- Dati geografici delle strutture sanitarie esistenti
- Dati di popolazione per area geografica

**Nota**: I dataset non sono inclusi nel repository GitHub a causa delle dimensioni e delle politiche di condivisione. Contattare gli autori per accedere ai dati necessari.

## 🔧 Installazione

### Prerequisiti
- Python 3.8+
- R 4.0+
- Git

### Setup

1. Clona il repository:
   ```bash
   git clone https://github.com/camillandreozzi/Operational_A-E.git
   cd Operational_A-E
   ```

2. Installa le dipendenze Python:
   ```bash
   pip install -r requirements.txt
   ```

3. Installa i pacchetti R necessari:
   ```R
   install.packages(c("readxl", "tidyverse", "magritt", "ranger", "caret", "optimx", "patchwork", "sf", "tmap"))
   ```

## 🚀 Riproduzione dei Risultati

### Analisi Esplorativa
1. Esegui i notebook nella cartella `src/exploratory` per comprendere i dati
2. Segui il notebook `Exploratory Data Analysis.ipynb` per un'analisi completa

### Modelli di Ottimizzazione
1. Per l'ottimizzazione delle posizioni:
   - Inizia con `src/modeling/location_optimization/BNS_real_data.ipynb`
   - Esegui `Finding_Best_New_Site.ipynb` per ottenere le posizioni ottimali

2. Per l'analisi dei tempi di attesa:
   - Utilizza `src/modeling/wait_time/Modelling.ipynb`

### Visualizzazione dei Risultati
I risultati principali sono disponibili nella cartella `results`, con visualizzazioni nella sottocartella `images_dir`.

## 📈 Principali Risultati

Il progetto ha portato a risultati significativi per l'ottimizzazione del sistema sanitario scozzese:

1. **Identificazione di Posizioni Ottimali**: Sono state identificate le posizioni ottimali per nuove strutture sanitarie che minimizzano i tempi di accesso per la popolazione.

2. **Analisi dei Pattern di Utilizzo**: Sono stati identificati pattern significativi nell'utilizzo dei servizi di emergenza, con particolare attenzione alle differenze demografiche e geografiche.

3. **Modelli Predittivi per i Tempi di Attesa**: Sono stati sviluppati modelli per prevedere i tempi di attesa nelle strutture sanitarie, permettendo una migliore pianificazione delle risorse.

4. **Ottimizzazione per Popolazioni Vulnerabili**: Analisi specifiche per le popolazioni anziane e altre categorie vulnerabili, con raccomandazioni per migliorare l'accesso ai servizi.

Per i dettagli completi, consultare il documento `docs/Optimizing Healthcare.pdf`.

## 👥 Contributi

Se desideri contribuire a questo progetto:

1. Fai un fork del repository
2. Crea un branch per le tue modifiche: `git checkout -b feature/nome-feature`
3. Commit le modifiche: `git commit -m 'Aggiunta nuova feature'`
4. Push al branch: `git push origin feature/nome-feature`
5. Apri una Pull Request

## ✍️ Autori

* **Glauco Rampone**: Notebook Python, Analisi Dati, Sviluppo Modelli
* **Camilla Andreozzi**: Codice R, Analisi Dati, Sviluppo Modelli

## 📄 Licenza

Questo progetto è rilasciato sotto licenza MIT - vedere il file LICENSE per i dettagli.
