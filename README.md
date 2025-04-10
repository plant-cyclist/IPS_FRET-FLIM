# IPS FRET-FLIM

This repository provides R scripts for analyzing FRET-FLIM data that were acquired using PicoQuant's SymPhoTime analysis software.  
The scripts are designed to semi-automate the evaluation process for performing Interaction Pixel Analyses (IPS).  
Note that the structures of the scripts align with the output format of SymPhoTime.  
While it is possible to adapt the scripts for  other software as well, doing so requires careful modifications.

---

## Requirements

The scripts were tested under the following conditions but may also work in other environments:

- Microsoft Windows 11 (64-bit)  
- R version 4.4.1  
- RStudio version 2024.12.1+563

---

## How to Run

1. Download the provided R scripts.  
2. Open the scripts in RStudio either by double-clicking or dragging and dropping them into the RStudio window.

To ensure trouble-free execution, you’ll need to adjust file paths and relevant parameters.  
Please refer to the comments within the scripts, the *Methods* section of our paper, or the included `IPS_manual.pdf` for detailed instructions.  

For testing purposes, we provide sample input files along with the corresponding output results that you can download.

---

## License

Copyright (c) SFB1101 and ZMBP, University of Tübingen  
All scripts are licensed under the [GNU GPL](https://www.gnu.org/licenses/).

---

## How to Cite

If you use the IPS FRET-FLIM scripts in your research, please cite our [paper](https://doi.org/10.1101/2024.06.17.598829):

> Prabha Manishankar, Lea Reuter, Leander Rohr, Atiara Fernandez, Yeliz Idil Yigit, Tanja Schmidt, Irina Droste-Borel, Jutta Keicher, Andrea Bock, Claudia Oecking.  
> *AI-assisted decoding of molecular signatures essential for NON-PHOTOTROPIC HYPOCOTYL3 condensation and function in phototropism.*  
> [https://doi.org/10.1101/2024.06.17.598829](https://doi.org/10.1101/2024.06.17.598829)
