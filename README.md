# Multi-principal element alloys

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants) and generalized stacking fault energies (GSFE) of four equal-molar multi-principal element alloys (MPEAs). The effects of chemical short-range order (CSRO) and temperature will be considered.

Please read the following journal articles to understand how the aforementioned material properties can be calculated.

\[Pure metals\]:

- Xiaowang Wang, Shuozhi Xu, Wu-Rong Jian, Xiang-Guo Li, Yanqing Su, Irene J. Beyerlein, [Generalized stacking fault energies and Peierls stresses in refractory body-centered cubic metals from machine learning-based interatomic potentials,](http://dx.doi.org/10.1016/j.commatsci.2021.110364) Comput. Mater. Sci. 192 (2021) 110364
- Yanqing Su, Shuozhi Xu, Irene J. Beyerlein, [Density functional theory calculations of generalized stacking fault energy surfaces for eight face-centered cubic transition metals](http://dx.doi.org/10.1063/1.5115282), J. Appl. Phys. 126 (2019) 105112

\[Random alloys\]:

- Abdullah Al Mamun, Shuozhi Xu, Xiang-Guo Li, Yanqing Su, [Comparing interatomic potentials in calculating basic structural parameters and Peierls stress in tungsten-based random binary alloys](http://dx.doi.org/10.1088/1402-4896/acf533), Phys. Scr. 98 (2023) 105923
- Shuozhi Xu, Arjun S. Kulathuvayal, Liming Xiong, Yanqing Su, [Effects of ferromagnetism in ab initio calculations of basic structural parameters of Fe-A (A = Mo, Nb, Ta, V, or W) random binary alloys](http://dx.doi.org/10.1140/epjb/s10051-022-00431-9), Eur. Phys. J. B 95 (2022) 167
- Rebecca A. Romero, Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, C.V. Ramana, [Atomistic calculations of the local slip resistances in four refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.ijplas.2021.103157), Int. J. Plast. 149 (2022) 103157
- Shuozhi Xu, Saeed Zare Chavoshi, Yanqing Su, [On calculations of basic structural parameters in multi-principal element alloys using small atomistic models](http://dx.doi.org/10.1016/j.commatsci.2021.110942), Comput. Mater. Sci. 202 (2022) 110942

\[Alloys with CSRO\]:

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107

## LAMMPS

LAMMPS on [OSCER](http://www.ou.edu/oscer.html) likely does not come with many packages. To build more packages into LAMMPS, please visit [this page](https://docs.lammps.org/Build_package.html).

To finish this project, at least three packages are needed.

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- EXTRA-COMPUTE package. This is to calculate the elastic constants at finite temperatures using the Born matrix method. To learn more, please visit [this page](https://docs.lammps.org/Howto_elastic.html
) and [this page](https://docs.lammps.org/compute_born_matrix.html).
- MC package. This is to generate materials with chemical short-range order at a given temperature. [This paper](http://dx.doi.org/10.1103/PhysRevB.85.184203) should be cited if one uses this package.

Note: if you use sbatch files from [LAMMPSatOU](https://github.com/ANSHURAJ11/LAMMPSatOU), you may need to change the walltime (default: 12 hours) and/or number of cores (default: 16). For this project, I recommend

	#SBATCH --time=200:00:00
	#SBATCH --ntasks=32

Please, each time you run a new type of simulation, create a new directory.

Four MPEAs will be considered. No new calculations are needed for the last two alloys. Data are presented here so that you will include them in the paper.

## CoCrNi

Note: All files for calculations can be found in the `CoCrNi` directory in this GitHub repository, except the data files which can be [here](https://drive.google.com/drive/folders/13xaI274U-xIsBN8h_TY_eohsXxedEwFE?usp=sharing). The reason is that the data files are too large for GitHub.

All data files are from [this paper](http://dx.doi.org/10.1016/j.actamat.2020.08.044), which should be cited.

### Lattice parameters at 0 K

#### Random CoCrNi

Run the simulation with files `lmp_0K.in`, `min.CoCrNi_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, you will find a new file `a_E`. The first column is the ratio of the trial lattice parameter to 3.5564, the second column is the trial lattice parameter itself, in units of Anstrong, the thrid column is the cohesive energy, in units of eV. If you plot a curve with the second column as the x axis and the third column as the y axis, the curve should look like the ones in Figure 1(a) of [this paper](http://dx.doi.org/10.1016/j.commatsci.2021.110942).

Then run `sh min.sh` to find out the trial lattice parameter corresponding to the lowest cohesive energy (i.e., the minimum on that curve), and that would be the actual lattice parameter. Specifically, you will see

	1 3.55644549888703 -4.32151351854507

on the screen. Record these three numbers. These are for random CoCrNi.

#### CoCrNi with CSRO

The simulation requires files 
`lmp_0K.in`, `min.CoCrNi_27nmx_27nmy_27nmz_350KMDMC.dat`, and `CoCrNi.lammps.eam`. The second file can be found [here](https://drive.google.com/drive/folders/13xaI274U-xIsBN8h_TY_eohsXxedEwFE?usp=sharing). Make one change in `lmp_lat.in`:

- Line 10. Change the word `random` to `350KMDMC`, i.e., to match the new data file's name.

Run the simulation. Once it is finished, you will find a new file `a_E`. The first column is the ratio of the trial lattice parameter to 3.561; the other two columns have the same meaning as the random case. Repeat the remaining steps in the random case and record the three numbers for the CoCrNi with CSRO.

### Elastic constants at 0 K

#### Random CoCrNi

Run the simulation with files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.CoCrNi_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, you will find a file `lmp.out`, at the end of which you will find values of C11all, C12all etc. Specifically, you will see

	Elastic Constant C11all = 309.979695007998 GPa
	Elastic Constant C22all = 310.087578803684 GPa

Rename that file to `lmp_random.out` and upload it to the `CoCrNi/ela_const/0K` directory. 

#### CoCrNi with CSRO

The simulation requires files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.CoCrNi_27nmx_27nmy_27nmz_350KMDMC.dat`, and `CoCrNi.lammps.eam`. Make one change in `init.mod`:

- Change the last number (by default 1.) of line 50 to the correct ratio identified in the prior lattice parameter calculation, i.e., the first of the three numbers you recorded for the CSRO case.

Run the simulation. Once it is finished, rename the newly generated file `lmp.out` to `lmp_350KMDMC.out` and upload it to the `CoCrNi/ela_const/0K` directory.

### Lattice parameters at 300 K

#### Random CoCrNi

Run the simulation with files `lmp_300K.in`, `min.CoCrNi_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, go to the file `log.lammps` and find the first block of data that starts with a line `Step Lx Ly Lz`. The first column of the data block starts from 0, increasing in increment of 100, and stops at 10000.

In fact, you will find that the first line of the block is

	0    271.59916    274.41197     277.1948
	
while the last line is

	10000     272.5714    275.39428    278.18707

First, calculate the lattice parameter at the last step 10000, using

(Lx'/Lx + Ly'/Ly + Lz'/Lz)/3

where Lx', Ly', and Lz' are taken at the step 10000, while Lx, Ly, and Lz are taken at step 0. Record the result.

Then repeat the equation above, but using Lx', Ly', and Lz' at steps 9900, 9800 , ..., and 9100, respectively. In total, you get ten lattice parameters. Calculate the mean of the ten numbers, and that is the ratio of the lattice parameter for random CoCrNi at 300 K to the trial lattice parameter, 3.5564 Angstrom.

You will also find a newly generated file `data.relax`, which will be used later in elastic constants calculations.

#### CoCrNi with CSRO

Repeat the steps above, except that

- Use the data file `min.CoCrNi_27nmx_27nmy_27nmz_350KMDMC.dat` instead
- Change the word `random` to `350KMDMC` in line 10 of the file `lmp_300K.in`

Record the lattice parameter, which is for CoCrNi with CSRO. The trial lattice parameter is 3.561 Angstrom.

Again, the newly generated file `data.relax` will be used later in elastic constants calculations.

### Elastic constants at 300 K

#### Random CoCrNi

Run the simulation with files `in.elastic`, `init.in`, `potential.in`, `output.in`, `final_output.in`, `data.relax`, and `CoCrNi.lammps.eam`. Note that the file `data.relax` is the one you got from the `Lattice parameters at 300 K - Random CoCrNi` calculation.

Once it is finished, go to the end of the file `lmp.out`, and you will see

	Elastic Constant C11 = 298.291596568703 GPa
	Elastic Constant C22 = 297.341418727254 GPa

which are smaller than those calculated at 0 K, as expected.

Rename the file `lmp.out` to `lmp_random.out` and upload it to the `CoCrNi/ela_const/300K` directory. 

#### CoCrNi with CSRO

Repeat the steps above, except that

- Use the `data.relax` file from the `Lattice parameters at 300 K - CoCrNi with CSRO` calculation instead

Once the simulation is finished, rename the file `lmp.out` to `lmp_300K.out` and upload it to the `CoCrNi/ela_const/300K` directory.

### GSFE at 0 K

#### Random CoCrNi

Run the simulation with files `lmp_gsfe.in`, `data.CoCrNi_gsfe_random`, and `CoCrNi.lammps.eam`.

Once it is finished, you will find a file `gsfe_ori`, which should contain 3001 lines, with the first one being

	0 -374943.444563279

Then run `sh gsfe_curve.in` in the terminal to generate a new file `gsfe`. Plot a curve using its first and second columns as the _x_ and _y_ axes, respectively. Bring it to our meeting for discussion.

#### CoCrNi with CSRO

Repeat the steps above, except that

- Use the data file `data.CoCrNi_gsfe_350KMDMC` instead
- Change the word `random` to `350KMDMC` in line 14 of the file `lmp_gsfe.in`
- Change the number `3.5564` to `3.561` in line 51 of the file `lmp_gsfe.in`

### Pure metal

CoCrNi contains only one pure metal, Ni, having the same lattice (i.e., FCC). It would be interesting to compare the temperature effect between it and the MPEA.

For CoCrNi, [Jian et al.](http://dx.doi.org/10.1016/j.actamat.2020.08.044) built all atomistc structures, and so we directly used them. For Ni, however, we need to build the atomistic structure ourselves. The first step is to install [Atomsk](https://atomsk.univ-lille.fr).

Run the atomsk script, `atomsk_Ni.sh`, which can be found in `CoCrNi/ni/` in this GitHub repository, to build a Ni structure named `data.Ni`.

Then use the data file and the same potential file to calculate its lattice parameters and elastic constants at 0 K and 300 K. Also calculate its GSFE at 0 K.

Note: The trial lattice parameter is 3.5564 Angstrom. When calculating the lattice parameter at 0 K, in line 44 of `lmp_0K.in`, change the three numbers 54, 63, and 45, to 30, 30, and 10, respectively. This is because different cell sizes are used here.

## MoNbTa

Similar to Ni, we need to build the atomistic structures for MoNbTa ourselves.

### Random MoNbTa

Run the atomsk script, `atomsk_MoNbTa.sh`, which can be found in `MoNbTa/random/` in this GitHub repository, to build a random MoNbTa structure named `data.MoNbTa_random`.

All results for random MoNbTa have been calculated. They are summarized in the file `MoNbTa/random/data_random.txt` in this GitHub repository. Most results were based on the [EAM potential](http://dx.doi.org/10.1016/j.commatsci.2021.110942) while those at 0 K were also based on the [MTP](http://dx.doi.org/10.1038/s41524-023-01046-z). We can compare the two potentials for properties at 0 K in the paper.

### MoNbTa with CSRO

Run the atomsk script, `atomsk_Mo.sh`, which can be found in `MoNbTa/csro/` in this GitHub repository, to build a Mo structure named `data.Mo`.

Then build MoNbTa with CSRO, annealed at 300 K, by running hybrid molecular dynamics (MD) and Monte Carlo (MC) simulations using `lmp_mdmc.in`, `data.Mo`, and `CrMoNbTaVW_Xu2022.eam.alloy`.

By default, in `lmp_mdmc.in`, the two numbers at the end of lines 10 and 11 are 0.021 and -0.32, respectively. They are the chemical potential difference between Co and Ni, and that between Cr and Ni, respectively, in CoCrNi. Here, the two numbers need to be modified because MoNbTa is being studied.

How are they determined? Follow the procedure described in Section B.2 of [this paper](https://doi.org/10.1016/j.actamat.2019.12.031). Each LAMMPS simulation will create a series of `mc.*.dump` files and eventually a `data.MoNbTa_CSRO` file. Use OVITO to check the dump files to see if the three elements are almost equal-molar. If they are far from equal-molar and there is no sign that they are approaching equal-molar, cancel the simulation, modify the two numbers in lines 10 and 11 of `lmp_mdmc.in`, and run the simulation again. Iteratively adjust the two numbers until the final structure `data.MoNbTa_CSRO` is almost equal-molar. Note that it does not have to be exactly equal-molar.

Once the iteration is done, calculate the lattice parameters and elastic constants at 0 K, 300 K, 600 K, 900 K, and 1200 K. Also calculate the GSFE at 0 K.

Use the same method for CoCrNi. Remember to modify the input files accordingly and use the appropriate potential.

In particular, the trial lattice parameter is 3.135 Angstrom. When calculating the lattice parameter at 0 K, change line 44 of `lmp_0K.in` to

	variable lat_para equal (lx/(10*sqrt(6.)/2.)+ly/(46*sqrt(3.))+lz/(14*sqrt(2.)))/3.

### Pure metals

MoNbTa contains three pure metals having the same lattice (i.e., BCC). It would be interesting to compare the temperature effect between them and the MPEA.

Results are in `Mo.txt`, `Nb.txt`, and `Ta.txt`, respectively. They were studied at 0 K, 300 K, 600 K, 900 K, and 1200 K, respectively. The only exception is that Nb becomes unstable at 1200 K so there is no data for that case.

## HfMoNbTaTi

Data at 0 K were taken from [this paper](http://dx.doi.org/10.1063/5.0116898). Need to cite it. Data at finite temperatures are newly calculated for the current project. In all cases, simulation cells with size D (see Table II of the paper) were used.

Results are summarized in the directory `HfMoNbTaTi` in this GitHub repository. USFEs, taken on the \{110\} plane, are in units of mJ/m<sup>2</sup>.

#### Random HfMoNbTaTi

The random material was studied at 0 K, 300 K, 600 K, 900 K, and 1200 K, respectively. Results are in `data_random.txt`.

#### HfMoNbTaTi with CSRO

Following [this paper](http://dx.doi.org/10.1063/5.0116898), four levels of CSRO were considered, with the material annealed at 300 K, 600 K, and 900 K, respectively. In what follows, let's call them 300KMDMC, 600KMDMC, 900KMDMC, respectively.

The material 300KMDMC was studied at 0 K and 300 K, respectively. Results are in `data_300KMDMC.txt`.

The material 600KMDMC was studied at 0 K and 600 K, respectively. Results are in `data_600KMDMC.txt`.

The material 900KMDMC was studied at 0 K and 900 K, respectively. Results are in `data_900KMDMC.txt`.

## HfNbTaTiZr

Data at 0 K were taken from [this paper](http://dx.doi.org/10.1063/5.0116898). Need to cite it. Data at finite temperatures are newly calculated for the current project. In all cases, simulation cells with size D (see Table II of the paper) were used.

Results are summarized in the directory `HfNbTaTiZr` in this GitHub repository. USFEs, taken on the \{110\} plane, are in units of mJ/m<sup>2</sup>.

Note that only random HfNbTaTiZr is considered, and the results are in `data_random.txt`.