# Calculations in alloys and ceramics

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants) and generalized stacking fault energies (GSFE) of several alloys and ceramics. The effects of chemical short-range order (CSRO) and temperature will be considered.

Please read the following journal articles to understand how the aforementioned material properties can be calculated.

\[Pure metals\]:

- Xiaowang Wang, Shuozhi Xu, Wu-Rong Jian, Xiang-Guo Li, Yanqing Su, Irene J. Beyerlein, [Generalized stacking fault energies and Peierls stresses in refractory body-centered cubic metals from machine learning-based interatomic potentials,](http://dx.doi.org/10.1016/j.commatsci.2021.110364) Comput. Mater. Sci. 192 (2021) 110364
- Yanqing Su, Shuozhi Xu, Irene J. Beyerlein, [Density functional theory calculations of generalized stacking fault energy surfaces for eight face-centered cubic transition metals](http://dx.doi.org/10.1063/1.5115282), J. Appl. Phys. 126 (2019) 105112

\[Random alloys\]:

- Abdullah Al Mamun, Shuozhi Xu, Xiang-Guo Li, Yanqing Su, [Comparing interatomic potentials in calculating basic structural parameters and Peierls stress in tungsten-based random binary alloys](http://dx.doi.org/10.1088/1402-4896/acf533), Phys. Scr. (in press)
- Shuozhi Xu, Arjun S. Kulathuvayal, Liming Xiong, Yanqing Su, [Effects of ferromagnetism in ab initio calculations of basic structural parameters of Fe-A (A = Mo, Nb, Ta, V, or W) random binary alloys](http://dx.doi.org/10.1140/epjb/s10051-022-00431-9), Eur. Phys. J. B 95 (2022) 167
- Rebecca A. Romero, Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, C.V. Ramana, [Atomistic calculations of the local slip resistances in four refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.ijplas.2021.103157), Int. J. Plast. 149 (2022) 103157
- Shuozhi Xu, Saeed Zare Chavoshi, Yanqing Su, [On calculations of basic structural parameters in multi-principal element alloys using small atomistic models](http://dx.doi.org/10.1016/j.commatsci.2021.110942), Comput. Mater. Sci. 202 (2022) 110942

\[Alloys with CSRO\]:

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107

Please, each time you run a new type of simulation, create a new directory.

## LAMMPS

LAMMPS on [OSCER](http://www.ou.edu/oscer.html) likely does not come with many packages. To build more packages into LAMMPS, please visit [this page](https://docs.lammps.org/Build_package.html).

To finish this project, at least four packages are needed. The first two comes with the official LAMMPS source code, and so it should be straightforward to install them:

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- EXTRA-COMPUTE package. This is to calculate the elastic constants at finite temperatures using the Born matrix method. To learn more, please visit [this page](https://docs.lammps.org/Howto_elastic.html
) and [this page](https://docs.lammps.org/compute_born_matrix.html).

The other two do not come with the official LAMMPS source code, and so it is not straightforward to install them:

- [VCSGC package](https://vcsgc-lammps.materialsmodeling.org). This is to generate materials with chemical short-range order at a given temperature. [Here](http://dx.doi.org/10.1103/PhysRevB.85.184203) is the paper for VCSGC; it should be cited if one uses this package.
- [M3GNet package](https://www.linkedin.com/posts/ongsp_github-advancesoftcorplammps-compiled-activity-7008842815757586432-BaWR). This is to help use the M3GNet potential. [Here](https://www.nature.com/articles/s43588-022-00349-3) is the paper for M3GNet; it should be cited if one uses this package.

Therefore, the first step in this project is to install all four packages to your own version of LAMMPS.

## Alloys

Six alloys will be considered.

### HfMoNbTaTi

Done. Need to cite [this paper](http://dx.doi.org/10.1063/5.0116898).

### HfNbTaTiZr

Done. Also need to cite [this paper](http://dx.doi.org/10.1063/5.0116898).

### CoCrNi

Note: All files for calculations can be found in the `CoCrNi` directory in this GitHub repository, except the data files which can be [here](https://drive.google.com/drive/folders/13xaI274U-xIsBN8h_TY_eohsXxedEwFE?usp=sharing). The reason is that the data files are too large for GitHub.

All data files are from [this paper](http://dx.doi.org/10.1016/j.actamat.2020.08.044), which should be cited.

#### Lattice parameters at 0 K

###### Random CoCrNi

Run the simulation with files `lmp_0K.in`, `min.NiCoCr_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, you will find a new file `a_E`. The first column is the ratio of the trial lattice parameter to 3.5564, the second column is the trial lattice parameter itself, in units of Anstrong, the thrid column is the cohesive energy, in units of eV. If you plot a curve with the second column as the x axis and the third column as the y axis, the curve should look like the ones in Figure 1(a) of [this paper](http://dx.doi.org/10.1016/j.commatsci.2021.110942).

Then run `sh min.sh` to find out the trial lattice parameter corresponding to the lowest cohesive energy (i.e., the minimum on that curve), and that would be the actual lattice parameter. Specifically, you will see

	1 3.55644549888703 -4.32151351854507

on the screen. Record these three numbers. These are for random CoCrNi.

###### CoCrNi with CSRO

The simulation requires files 
`lmp_0K.in`, `min.NiCoCr_27nmx_27nmy_27nmz_350K.dat`, and `CoCrNi.lammps.eam`. The second file can be found [here](https://drive.google.com/drive/folders/13xaI274U-xIsBN8h_TY_eohsXxedEwFE?usp=sharing). Make one change in `lmp_lat.in`:

- Line 10. Change the word `random` to `350K`, i.e., to match the new data file's name.

Run the simulation. Once it is finished, you will find a new file `a_E`. The first column is the ratio of the trial lattice parameter to 3.561; the other two columns have the same meaning as the random case. Repeat the remaining steps in the random case and record the three numbers for the CoCrNi with CSRO.

#### Elastic constants at 0 K

###### Random CoCrNi

Run the simulation with files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.NiCoCr_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, you will find a file `lmp.out`, at the end of which you will find values of C11all, C12all etc. Specifically, you will see

	Elastic Constant C11all = 309.979695007998 GPa
	Elastic Constant C22all = 310.087578803684 GPa

Rename that file to `lmp_random.out` and upload it to the `CoCrNi/ela_const/0K` directory. 

###### CoCrNi with CSRO

The simulation requires files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.NiCoCr_27nmx_27nmy_27nmz_350K.dat`, and `CoCrNi.lammps.eam`. Make one change in `init.mod`:

- Change the last number (by default 1.) of line 50 to the correct ratio identified in the prior lattice parameter calculation, i.e., the first of the three numbers you recorded for the CSRO case.

Run the simulation. Once it is finished, rename the newly generated file `lmp.out` to `lmp_350K.out` and upload it to the `CoCrNi/ela_const/0K` directory.

#### Lattice parameters at 300 K

###### Random CoCrNi

Run the simulation with files `lmp_300K.in`, `min.NiCoCr_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, go to the file `log.lammps` and find the first block of data that starts with a line `Step Lx Ly Lz`. The first column of the data block starts from 0, increasing in increment of 100, and stops at 10000.

In fact, you will find that the first line of the block is

	0    271.59916    274.41197     277.1948
	
while the last line is

	10000     272.5714    275.39428    278.18707

First, calculate the lattice parameter at the last step 10000, using

(Lx'/Lx + Ly'/Ly + Lz'/Lz)/3

where Lx', Ly', and Lz' are taken at the step 10000, while Lx, Ly, and Lz are taken at step 0. Record the result.

Then repeat the equation above, but using Lx', Ly', and Lz' at steps 9900, 9800 , ..., and 9100, respectively. In total, you get ten lattice parameters. Calculate the mean of the ten numbers, and that is the lattice parameter for random CoCrNi at 350 K.

You will also find a newly generated file `data.relax`, which will be used later for the elastic constants calculations.

###### CoCrNi with CSRO

Repeat the steps above, except that

- Use the data file `min.NiCoCr_27nmx_27nmy_27nmz_350K.dat` instead
- Change the word `random` to `350K` in line 10 of the file `lmp_300K.in`

Record the lattice parameter, which is for CoCrNi with CSRO.

Again, the newly generated file `data.relax` will be used later for the elastic constants calculations.

#### Elastic constants at 300 K

###### Random CoCrNi

Run the simulation with files `in.elastic`, `init.in`, `potential.in`, `output.in`, `final_output.in`, `data.relax`, and `CoCrNi.lammps.eam`. Note that the file `data.relax` is the one you got from the `Lattice parameters at 300 K - Random CoCrNi` calculation.

Once it is finished, rename the file `lmp.out` to `lmp_random.out` and upload it to the `CoCrNi/ela_const/300K` directory. 

###### CoCrNi with CSRO

Repeat the steps above, except that

- Use the `data.relax` file from the `Lattice parameters at 300 K - CoCrNi with CSRO` calculation instead

At the end of the simulation, rename the file `lmp.out` to `lmp_300K.out` and upload it to the `CoCrNi/ela_const/300K` directory.

#### GSFE at 0 K

###### Random CoCrNi

Run the simulation with files `lmp_gsfe.in`, `data.CoCrNi_gsfe_random`, and `CoCrNi.lammps.eam`.

Once it is finished, you will find a file `gsfe_ori`, which should contain 3001 lines, with the first one being

	0 -374943.444563279

Then run `sh gsfe_curve.in` in the terminal to generate a new file `gsfe`. Plot a curve using its first and second columns as the _x_ and _y_ axes, respectively. Bring it to our meeting for discussion.

###### CoCrNi with CSRO

Repeat the steps above, except that

- Use the data file `data.CoCrNi_gsfe_350K` instead
- Change the word `random` to `350K` in line 14 of the file `lmp_gsfe.in`
- Change the number `3.5564` to `3.561` in line 51 of the file `lmp_gsfe.in`

### MoNbTa

#### Lattice parameters

###### Random MoNbTa, at 0 K, 600 K, and 900 K

Done.

###### MoNbTa with CSRO, at 0 K

Need to generate MoNbTa with CSRO.

- First, use [Atomsk](https://atomsk.univ-lille.fr) to generate random MoNbTa.
- Then, use the [VCSGC package](https://vcsgc-lammps.materialsmodeling.org) to generate MoNbTa with CSRO, annealed at 300 K.

#### Elastic constants

###### Random MoNbTa, at 0 K, 600 K, and 900 K

Done.

###### MoNbTa with CSRO, at 0 K

At the end of the `log.out` file, you will find values of C11all, C12all etc. Use Equations 10-12 of [this paper](http://dx.doi.org/10.1016/j.commatsci.2021.110942) to calculate the three effective BCC elastic constants, in units of GPa. Specifically, they should be

	383.218 119.581 53.754

Record these numbers.

#### GSFE at 0 K

###### Random MoNbTa

Done.

###### CoCrNi with CSRO, at 0 K

### Co<sub>2</sub>Ni<sub>2</sub>Ru

#### Lattice parameters at 0 K

#### Elastic constants at 0 K

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