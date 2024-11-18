This repository contains a collection of Matlab files, libraries of functions and drivers that provide the tools to create scripts to command an Automated Valve Controller. This code was compatible to and working with Windows 10 and Matlab 2019b.

## Description
This repository includes several scripts used in the study. Below is a brief overview of each:
- **AVC_code:** as reference, we include the code for controlling the microfluidic chip MS 7 [see Figure 1]. See the repository on [Microfluidics](https://github.com/sanger-matteo/Microdevices_Designs) to find the schematics and masks for this chip.
- **AVC_control_prog:** Microsoft Windows 8 compatible drivers to control the valves.
- **AVC_lib:** set of (mostly) Matlab libraries and function that code for the most commond commands that would be used in an AVC. 
- **helper scripts**: some other example of control programs for the AVC for other microfluidic chips.

| Figures | Description |
| --- | --- |
| ![Figure 1](/Figures/Example_Device.png) | Layout of the MS7 control program in action in Matlab |
| ![Figure 2](/Figures/AVC_MS7.png) | Layout of the three layers device MS7 |

Some practical details on using the software and installation can be found in appendix to the [thesis](https://edoc.unibas.ch/65308/1/Thesis_v11_edoc.pdf) manuscript. 

| ![Figure 3](/Figures/Valves_and_Isolation.png) | 
| --- |
| Set up at the microscopy with AVC system in the background |

