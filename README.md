# Calculations in alloys and ceramics

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants) and generalized stacking fault energies (GSFE) of several alloys and ceramics. The effects of chemical short-range order (CSRO) and temperature will be considered.

Please read the following journal articles to understand how the aforementioned material properties can be calculated.

\[Calculations in pure metals\]:

- Xiaowang Wang, Shuozhi Xu, Wu-Rong Jian, Xiang-Guo Li, Yanqing Su, Irene J. Beyerlein, [Generalized stacking fault energies and Peierls stresses in refractory body-centered cubic metals from machine learning-based interatomic potentials,](http://dx.doi.org/10.1016/j.commatsci.2021.110364) Comput. Mater. Sci. 192 (2021) 110364
- Yanqing Su, Shuozhi Xu, Irene J. Beyerlein, [Density functional theory calculations of generalized stacking fault energy surfaces for eight face-centered cubic transition metals](http://dx.doi.org/10.1063/1.5115282), J. Appl. Phys. 126 (2019) 105112

\[Calculations in random alloys\]:

- Shuozhi Xu, Arjun S. Kulathuvayal, Liming Xiong, Yanqing Su, [Effects of ferromagnetism in ab initio calculations of basic structural parameters of Fe-A (A = Mo, Nb, Ta, V, or W) random binary alloys](http://dx.doi.org/10.1140/epjb/s10051-022-00431-9), Eur. Phys. J. B 95 (2022) 167
- Rebecca A. Romero, Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, C.V. Ramana, [Atomistic calculations of the local slip resistances in four refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.ijplas.2021.103157), Int. J. Plast. 149 (2022) 103157
- Shuozhi Xu, Saeed Zare Chavoshi, Yanqing Su, [On calculations of basic structural parameters in multi-principal element alloys using small atomistic models](http://dx.doi.org/10.1016/j.commatsci.2021.110942), Comput. Mater. Sci. 202 (2022) 110942

\[Calculations in alloys with CSRO\]:

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107

## LAMMPS

LAMMPS on [OSCER](http://www.ou.edu/oscer.html) likely does not come with many packages. To build more packages into LAMMPS, please visit [this page](https://docs.lammps.org/Build_package.html).

To finish this project, at least four packages are needed. The first two comes with the official LAMMPS source code, and so it should be straightforward to install them:

- MANYBODY package
- EXTRA-COMPUTE package. This is to calculate the elastic constants at finite temperatures using the Born matrix method. To learn more, please visit [this page](https://docs.lammps.org/Howto_elastic.html
) and [this page](https://docs.lammps.org/compute_born_matrix.html).

The other two do not come with the official LAMMPS source code, and so it is not straightforward to install them:

- [VCSGC package](https://vcsgc-lammps.materialsmodeling.org). This is to generate materials with chemical short-range order at a given temperature. [Here](http://dx.doi.org/10.1103/PhysRevB.85.184203) is the paper for VCSGC; it should be cited if one uses this package.
- [M3GNet package](https://www.linkedin.com/posts/ongsp_github-advancesoftcorplammps-compiled-activity-7008842815757586432-BaWR). This is to help use the M3GNet potential. [Here](https://www.nature.com/articles/s43588-022-00349-3) is the paper for M3GNet; it should be cited if one uses this package.

Therefore, the first step in this project is to install all four packages to your own version of LAMMPS.

## Alloys

At least four alloys will be considered.

### CoCrNi

#### Lattice parameters at 0 K

###### Random CoCrNi

Run the simulation with files `lmp_lat.in`, `min.NiCoCr_27nmx_27nmy_27nmz_random`, and `CoCrNi.lammps.eam`. The second file can be found [here](https://drive.google.com/drive/folders/13xaI274U-xIsBN8h_TY_eohsXxedEwFE?usp=sharing) while the other two in this GitHub repository.

Once the simulation is finished, you will find a new file a_E. The first column is the ratio of the trial lattice parameter to 3.5564, the second column is the trial lattice parameter itself, in units of Anstrong, the thrid column is the cohesive energy, in units of eV. If you plot a curve with the second column as the x axis and the third column as the y axis, the curve should look like the ones in Figure 1(a) of [this paper](http://dx.doi.org/10.1016/j.commatsci.2021.110942).

Then run `sh min.sh` to find out the trial lattice parameter corresponding to the lowest cohesive energy (i.e., the minimum on that curve), and that would be the actual lattice parameter. Specifically, you will see

	0.924 3.04920000000009 -5.96926166742226

on the screen. Record these three numbers. These are for random CoCrNi.

###### CoCrNi with CSRO

Make a new directory and copy these files into it: 
`lmp_lat.in`, `min.NiCoCr_27nmx_27nmy_27nmz_350K.dat`, and `CoCrNi.lammps.eam`. The second file can be found [here](https://drive.google.com/drive/folders/13xaI274U-xIsBN8h_TY_eohsXxedEwFE?usp=sharing). Make one change in `lmp_lat.in`:

- Line 12. Change the word `random` to `350K`, i.e., to match the new data file's name.

Run the simulation. Once it is finished, you will find a new file `a_E`. The first column is the ratio of the trial lattice parameter to 3.yyy; the other two columns have the same meaning as the random case. Repeat the remaining steps in the random case and record the three numbers for the CoCrNi with CSRO annealled at 350 K.

#### Elastic constants at 0 K

###### Random CoCrNi

Run the simulation with files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.NiCoCr_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once the simulation is finished, go to the end of the file lmp.out. You will find values of C11all, C12all etc. Use Equations 10-12 of [this paper](http://dx.doi.org/10.1016/j.commatsci.2021.110942) to calculate the three effective BCC elastic constants, in units of GPa. Specifically, they should be

	383.218 119.581 53.754

Record these numbers, which are for the random CoCrNi.

###### CoCrNi with CSRO

Make a new directory and copy these files into it: `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.NiCoCr_27nmx_27nmy_27nmz_350K.dat`, and `CoCrNi.lammps.eam`. Make one change in `init.mod`:

- Change the last number (by default 0.zzz) of line 50 to the correct ratio identified in the prior lattice parameter calculation, i.e., the first of the three numbers you recorded for the CSRO case.

Run the simulation and record the three elastic constants, which are for CoCrNi with CSRO.

#### Lattice parameters at 350 K

###### Random CoCrNi

###### CoCrNi with CSRO

#### Elastic constants at 350 K

#### GSFE

### MoNbTa

#### Lattice parameters

#### Elastic constants

#### GSFE

### Co<sub>2</sub>Ni<sub>2</sub>Ru

#### Lattice parameters

#### Elastic constants

#### GSFE

### Al<sub>0.3</sub>CoCrFeNi

#### Lattice parameters

#### Elastic constants

#### GSFE

## Ceramics

Four ceramics will be considered.

### BaCe<sub>0.5</sub>Zr<sub>0.5</sub>O<sub>3</sub>

It is the simplification of BaCe<sub>0.4</sub>Zr<sub>0.4</sub>Y<sub>0.1</sub>Yb<sub>0.1</sub>O<sub>$3-\delta$</sub>, which is an electrolyte in one type of fuel cell.

#### Lattice parameters

#### Elastic constants

#### GSFE

### BaCo<sub>0.5</sub>Fe<sub>0.5</sub>O<sub>3</sub> 

It is the simplification of BaCo<sub>0.4</sub>Fe<sub>0.4</sub>Zr<sub>0.1</sub>Y<sub>0.1</sub>O<sub>$3-\delta$</sub>, which is a positive electrode (i.e., cathode) in one type of fuel cell.

#### Lattice parameters

#### Elastic constants

### La<sub>0.8</sub>Sr<sub>0.2</sub>Ga<sub>0.8</sub>Mg<sub>0.2</sub>O<sub>2.8</sub>

It is an electrolyte in one type of fuel cell.

#### Lattice parameters

#### Elastic constants

#### GSFE

### La<sub>0.6</sub>Sr<sub>0.4</sub>CoO<sub>3</sub> 

It is the simplification of La<sub>0.6</sub>Sr<sub>0.4</sub>CoO<sub>$3-\delta$</sub>, which is a cathode in one type of fuel cell.

#### Lattice parameters

#### Elastic constants