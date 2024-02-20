# Multi-principal element alloys

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants), and generalized stacking fault energies (GSFE) of four equal-molar multi-principal element alloys (MPEAs). The effects of chemical short-range order (CSRO) will be considered.

Please read the following journal articles to understand how the aforementioned material properties can be calculated.

\[Elemental materials\]:

- Xiaowang Wang, Shuozhi Xu, Wu-Rong Jian, Xiang-Guo Li, Yanqing Su, Irene J. Beyerlein, [Generalized stacking fault energies and Peierls stresses in refractory body-centered cubic metals from machine learning-based interatomic potentials](http://dx.doi.org/10.1016/j.commatsci.2021.110364), Comput. Mater. Sci. 192 (2021) 110364
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

To build LAMMPS with these three packages, use the file `lmp_mbecmc.sh`. First, cd to any directory on OSCER, e.g., \$HOME, then

	sh lmp_mbecmc.sh

Note that the second command in `lmp_mbecmc.sh` will load a module. If one cannot load it, try `module purge` first.

Once the `sh` run is finished, we will find a file `lmp_mpi` in the `lammps_mbecmc/src` directory on OSCER. And that is the LAMMPS executable with MANYBODY, EXTRA-COMPUTE, and MC packages.

Note: if we use the sbatch files from [LAMMPSatOU](https://github.com/ANSHURAJ11/LAMMPSatOU), we may want to change the walltime (default: 12 hours) and/or number of cores (default: 16). For this project, we use

	#SBATCH --time=200:00:00
	#SBATCH --ntasks=32

Each time we run a new type of simulation, create a new directory.

Four MPEAs will be considered.

## CoCrNi

Note: All files for calculations can be found in the `CoCrNi` directory in this GitHub repository, except the data files which can be found [here](https://drive.google.com/drive/folders/13xaI274U-xIsBN8h_TY_eohsXxedEwFE?usp=sharing). The reason is that the data files are too large for GitHub.

All data files are from [this paper](http://dx.doi.org/10.1016/j.actamat.2020.08.044).

### Lattice parameters at 0 K

#### Random CoCrNi

Run the simulation with files `lmp_0K.in`, `min.CoCrNi_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, we will find a new file `a_E`. Run the following script in the terminal

	awk NF a_E > new_aE

Then we will find another new file `new_aE`. The first column is the ratio of the trial lattice parameter to 3.5564, the second column is the trial lattice parameter itself, in units of Angstrom, and the third column is the cohesive energy, in units of eV. If we plot a curve with the second column as the _x_ axis and the third column as the _y_ axis, the curve should look like the ones in Figure 1(a) of [this paper](http://dx.doi.org/10.1016/j.commatsci.2021.110942).

Then run `sh min.sh` to find out the trial lattice parameter corresponding to the lowest cohesive energy (i.e., the minimum on that curve), and that would be the actual lattice parameter. Specifically, we will see

	1 3.55644549888703 -4.32151351854507

on the screen. Record these three numbers. These are for random CoCrNi.

#### CoCrNi with CSRO

The simulation requires files 
`lmp_0K.in`, `min.CoCrNi_27nmx_27nmy_27nmz_350KMDMC.dat`, and `CoCrNi.lammps.eam`. Make one change in `lmp_0K.in`:

- Line 10. Change the word `random` to `350KMDMC`, i.e., to match the new data file's name.

Run the simulation. Once it is finished, run `awk NF a_E > new_aE` in the terminal to generate a file `new_aE`. The first column is the ratio of the trial lattice parameter to 3.561; the other two columns have the same meaning as the random case. Repeat the remaining steps in the random case and record the three numbers for CoCrNi with CSRO.

### Elastic constants at 0 K

Results, based on the [100]-[010]-[001] system, are in the file `CoCrNi/ela_const/0K/data.txt`. 

#### Random CoCrNi

Run the simulation with files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.CoCrNi_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, we will find an output file, `*.out`, at the end of which we will find values of C11all, C12all etc. Specifically, we will see

	Elastic Constant C11all = 309.979695007998 GPa
	Elastic Constant C22all = 310.087578803684 GPa

Since the elastic constants are in the [1-10]-[11-2]-[111] system, they should be [converted](https://github.com/shuozhixu/elastic_tensor) to those in the [100]-[010]-[001] system.

#### CoCrNi with CSRO

The simulation requires files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.CoCrNi_27nmx_27nmy_27nmz_350KMDMC.dat`, and `CoCrNi.lammps.eam`. Make one change in `init.mod`:

- Change the last number (by default 1.) of line 50 to the correct ratio identified in the prior lattice parameter calculation, i.e., the first of the three numbers we recorded for the CSRO case.

Since the elastic constants are in the [1-10]-[11-2]-[111] system, they should be [converted](https://github.com/shuozhixu/elastic_tensor) to those in the [100]-[010]-[001] system.

### Lattice parameters at 300 K

#### Random CoCrNi

Run the simulation with files `lmp_300K.in`, `min.CoCrNi_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, go to the file `log.lammps` and find the first block of data that starts with a line `Step Lx Ly Lz`. The first column of the data block starts from 0, increasing in increments of 100, and stops at 10000.

In fact, we will find that the first line of the block is

	0    271.59916    274.41197     277.1948
	
while the last line is

	10000     272.5714    275.39428    278.18707

First, calculate the lattice parameter at the last step 10000, using

	(Lx'/Lx + Ly'/Ly + Lz'/Lz)/3

where Lx', Ly', and Lz' are taken at step 10000, while Lx, Ly, and Lz are taken at step 0. Record the result.

Then repeat the calculation above, but using Lx', Ly', and Lz' at steps 9900, 9800, ..., and 9100, respectively. In total, we get ten numbers. Calculate the mean of the ten numbers, and that is the ratio of the lattice parameter for random CoCrNi at 300 K to the trial lattice parameter, 3.5564 Angstrom.

We will also find a newly generated file `data.relax`, which will be used later in elastic constants calculations.

#### CoCrNi with CSRO

Repeat the steps above, except that

- Use the data file `min.CoCrNi_27nmx_27nmy_27nmz_350KMDMC.dat` instead
- Change the word `random` to `350KMDMC` in line 10 of the file `lmp_300K.in`

Record the lattice parameter, which is for CoCrNi with CSRO. The trial lattice parameter is 3.561 Angstrom.

Again, the newly generated file `data.relax` will be used later in elastic constants calculations.

### Elastic constants at 300 K

Results are in the file `CoCrNi/ela_const/300K/data.txt`. 

#### Random CoCrNi

Run the simulation with files `in.elastic`, `init.in`, `potential.in`, `output.in`, `final_output.in`, `data.relax`, and `CoCrNi.lammps.eam`. Note that the file `data.relax` is the one we got from the `Lattice parameters at 300 K - Random CoCrNi` calculation.

Once it is finished, go to the end of the output file, and we will see

	Elastic Constant C11 = 298.291596568703 GPa
	Elastic Constant C22 = 297.341418727254 GPa

which are smaller than those calculated at 0 K, as expected.

Since the elastic constants are in the [1-10]-[11-2]-[111] system, they should be [converted](https://github.com/shuozhixu/elastic_tensor) to those in the [100]-[010]-[001] system.

#### CoCrNi with CSRO

Repeat the steps above, except that

- Use the `data.relax` file from the `Lattice parameters at 300 K - CoCrNi with CSRO` calculation instead

Since the elastic constants are in the [1-10]-[11-2]-[111] system, they should be [converted](https://github.com/shuozhixu/elastic_tensor) to those in the [100]-[010]-[001] system.

### GSFE at 0 K

#### Random CoCrNi

Run the simulation with files `lmp_gsfe.in`, `data.CoCrNi_gsfe_random`, and `CoCrNi.lammps.eam`. The first file can be found in the directory `CoCrNi/gsfe/` in this GitHub repository.

Once it is finished, we will find a file `gsfe_ori`, which should contain 101 lines, with the first one being

	0 -374943.444563279

Then run `sh gsfe_curve.in` in the terminal to generate a new file `gsfe`.

Note: we have calculated only a single GSFE curve here. [A previous paper](http://dx.doi.org/10.1016/j.intermet.2020.106844) found that multiple GSFE curves need to be calculated to obtain a good mean GSFE curve.

To obtain other GSFE curves on other shift planes, please change the last integer (by default 1) in line 34 of `lmp_gsfe.in` to `2`, `3`, ..., `20`, respectively. And run 19 more simulations. Then we will have 20 GSFE curves.

#### CoCrNi with CSRO

Follow the procedures above, except that

- Use the data file `data.CoCrNi_gsfe_350KMDMC` instead
- Change the word `random` to `350KMDMC` in line 13 of the file `lmp_gsfe.in`
- Change the number `3.5564` to `3.561` in line 32 of the file `lmp_gsfe.in`

Similarly, we need to obtain 20 GSFE curves.

### Pure metal

CoCrNi contains only one pure metal, Ni, that has the same lattice as the alloy. It would be interesting to compare the temperature effect between it and the MPEA.

For CoCrNi, [Jian et al.](http://dx.doi.org/10.1016/j.actamat.2020.08.044) built all atomistc structures, and so we directly used them. For Ni, however, we need to build the atomistic structure ourselves. The first step is to install [Atomsk](https://atomsk.univ-lille.fr).

Run the atomsk script, `atomsk_Ni.sh`, which can be found in `CoCrNi/ni/` in this GitHub repository, to build a Ni structure named `data.Ni`, by

	sh atomsk_Ni.sh

Then use the data file and the same potential file to calculate its lattice parameters, elastic constants, and GSFE at 0 K, 300 K, 600 K, 900 K, and 1200 K. Remember to 

#### Lattice parameter

Note: The trial lattice parameter is 3.5564 Angstrom. When calculating the lattice parameter at 0 K, in line 44 of `lmp_0K.in`, change the three numbers 54, 63, and 45, to 30, 30, and 10, respectively. That is because different cell sizes are used here.

#### GSFE

For GSFE at 0 K, make the following two changes in the `lmp_gsfe.in` file

- line 17. Delete `Co` and `Cr`
- line 32. Use the correct lattice parameter for Ni at 0 K

For GSFE at finite temperatures, make the following three changes to the `lmp_gsfe.in` file:

- line 17. Delete `Co` and `Cr`
- line 32. Use the correct lattice parameter for Ni at the specified temperature
- add the following lines immediately before the first `displace_atoms` command (note: there are two of them):

		variable        myTemp equal 300
		neighbor        0.3     bin
		neigh_modify    delay   10
		thermo          1
		velocity        all create ${myTemp} 1917
		thermo_style    custom step lx ly lz
		fix 1 all npt temp ${myTemp} ${myTemp} 0.1 x 0. 0. 1. y 0. 0. 1.
		run 10000
		unfix 1

	In the first line above, the default temperature is 300. Change it to 600, 900, and 1200, respectively, in the corresponding calculation.

## MoNbTa

Similar to Ni, we need to build the atomistic structures for MoNbTa ourselves.

### Random MoNbTa

Run the atomsk script, `atomsk_MoNbTa.sh`, which can be found in `MoNbTa/random/` in this GitHub repository, to build a random MoNbTa structure named `data.MoNbTa_random`.

In the data file, change the masses section to

		1   95.96000000    # Mo
		2   92.90638000    # Nb
		3   180.94788000   # Ta

The lattice parameter, elastic constants, and GSFE of random MoNbTa have been calculated. They are summarized in the file `MoNbTa/random/data_random.txt` in this GitHub repository. Most results were based on the [EAM potential](http://dx.doi.org/10.1016/j.commatsci.2021.110942) while those at 0 K were also based on the [MTP](http://dx.doi.org/10.1038/s41524-023-01046-z).

#### Warren-Cowley (WC) parameter

First, calculate the radial distribution functions (RDF) for random MoNbTa. To do that, run a LAMMPS simulation with three files `data.MoNbTa_random`, `CrMoNbTaVW_Xu2022.eam.alloy`, and `lmp_vcsgc.in`. The second file can be found in [another GitHub repository](https://github.com/shuozhixu/CMS_2022). The last file is from the `MoNbTa/csro/` directory in this GitHub repository and should be modified as follows:

- Lines 3 and 4. Change the two large numbers to zero
- Linne 25. Change the data file name to `data.MoNbTa_random`

Once the simulation is finished, we will find a file `cn.out`, which contains RDF information. Based on the information, one can calculate the WC parameters. The codes used are not shared here.

[//]: # (Then build a new directory named `WCP_random` and move three files there: `cn.out`, `cn.sh`, and `csro.sh`. The last two files can be found in the `MoNbTa/wc/` directory in this GitHub repository.)

[//]: # (Run)

[//]: # (sh cn.sh)
	
[//]: # (Then we will find a new directory `cn` and one or more `rdf.*.dat` files in it. Then move `csro.sh` into the `cn` directory and execute it, i.e.,)

[//]: # (	move csro.sh cn/)
[//]: # (	cd cn/)
[//]: # (	sh csro.sh)
	
[//]: # (Then we will find a file named `csro.a1.dat`, which is what we need. The 2nd to 7th numbers in that file are &alpha;\_MoMo, &alpha;\_MoNb, &alpha;\_MoTa, &alpha;\_NbNb, &alpha;\_NbTa, and &alpha;\_TaTa, respectively. These are WC parameters.)

#### Density functional theory

Density functional theory (DFT) calculations will be conducted using VASP to calculate the lattice parameter, elastic constants, and GSFE of random MoNbTa.

##### Lattice parameter

All files can be found in `MoNbTa/random/dft/a0/` in this GitHub repository. Create a new directory named `a0` on OSCER and move files there. Enter that directory.

First, create `POTCAR` by

	cat POTCAR_Mo POTCAR_Nb POTCAR_Ta > POTCAR

Second, submit the job by

	sbatch vasp.batch

Once the calculation is finished, open the file `CONTCAR` and record `lx`, `ly`, and `lz` which appear in line 3, line 4, and line 5, respectively. The lattice parameter can be calculated by

	(lx/sqrt(6)+ly/(sqrt(2)*6)+lz/sqrt(3))/3

##### Elastic constants

All files can be found in `MoNbTa/random/dft/ela_const/` in this GitHub repository. Create a new directory named `ela_const` on OSCER and move files there. Enter that directory.

First, copy `POTCAR`, which we just created, into that directory.

Second, copy `CONTCAR`, which was just generated by the lattice parameter calculation, into that directory. Then rename the file to `POSCAR`.

Third, submit the job by

	sbatch vasp.batch

Once the calculation is finished, open the file `OUTCAR`. The elastic constants are below the line `TOTAL ELASTIC MODULI (kBar)` in that file. The constants can converted from kBar to GPa following

	1 kBar = 0.1 GPa

Also, since the calculated elastic constants are in the [11-2]-[111]-[1-10] system they should be [converted](https://github.com/shuozhixu/elastic_tensor) to those in the [100]-[010]-[001] system.

##### GSFE

All files can be found in `MoNbTa/random/dft/gsfe/` in this GitHub repository. Create a new directory named `gsfe-5` on OSCER and move files there. Enter that directory.

First, copy `POTCAR`, which we just created, into that directory.

Second, copy `CONTCAR`, which was just generated by the lattice parameter calculation, into that directory. Then rename the file to `POSCAR_0`.

Third, edit line 14 of the file `gsfe_curve.sh`; by default, `c` equals 1, change the value of `c` to

	16021.8/(lx*lz)

where `1/(lx*lz)` is to divide the energy by area, and `16021.8` is to convert the unit from eV/angstrom<sup>2</sup> to mJ/m<sup>2</sup>. 

Fourth, build 41 subdirectories by

	sh build.sh

Fifth, submit 41 jobs by

	sh run.sh

Once all calculations are finished, generate the GSFE curve file `gsfe` by

	sh gsfe_curve.sh

The USFE is the maximum GSFE value.

So far, we have calculated only a single GSFE curve. To obtain other GSFE curves on other shift planes, please change the last number (by default `5`) at the end of line 12 of `build.sh` to `3`, `4`, `6`, and `7`, respectively. Then copy all necessary files into four directories: `gsfe-3`, `gsfe-4`, `gsfe-6`, and `gsfe-7`.

In each directory, run `sh build.sh` and `sh run.sh`; then when all calculations are finished, run `sh gsfe_curve.sh`. That way, we will get four more GSFE curves, and hence four more USFE values. Calculate the mean USFF value based on the five USFE values and report the mean value in the paper.

### MoNbTa with CSRO

#### Build the CSRO structure

##### Semi-grand canonical ensemble

The first step is to determine the chemical potential difference between Mo and Nb, and that between Mo and Ta, respectively. To this end, run a hybrid molecular dynamics (MD) / Monte Carlo (MC) simulation in a semi-grand canonical (SGC) ensemble using `lmp_sgc.in` and `CrMoNbTaVW_Xu2022.eam.alloy`.

Once the simulation is finished, we will find a file `statistics.dat`, which should contain one line:

	-0.021 0.32 0 0.0005  0.9995

The first two numbers are the two chemical potential differences we provided in lines 10 and 11 of `lmp_sgc.in`, while the last three numbers are the concentrations of Mo, Nb, and Ta, respectively. Since they are not close to equal-molar, modify the two numbers in lines 10 and 11 of `lmp_sgc.in`, and run the simulation again. We can make the modification in the same folder and a new line will be appended to `statistics.dat` once the new simulation is finished. Therefore, no need to delete the file `statistics.dat` each time we submit a new job. Iteratively adjust the two numbers until the material is almost equal-molar. Note that it does not have to be exactly equal-molar. The procedure is similar to what is described in Section B.2 of [this paper](https://doi.org/10.1016/j.actamat.2019.12.031).

##### Variance constrained semi-grand canonical ensemble

Once the two chemical potential differences are identified, change the two chemical potential differences in lines 10 and 11 in file `lmp_vcsgc.in` to the correct values. Then run the atomsk script, `atomsk_Mo.sh` to build a Mo structure named `data.Mo`.

Next, make two changes to `data.Mo`:

- Line 4. Change the first number `1` to `3`
- Line 12 contains the atomic mass of Mo. Add two lines after it, i.e.,

		Masses
		
		1   95.96000000    # Mo
		2   92.90638000    # Nb
		3   180.94788000   # Ta
		
		Atoms # atomic

Next, run a hybrid MD/MC simulation in variance constrained semi-grand canonical (VC-SGC) ensemble using `lmp_vcsgc.in`, `data.Mo`, and `CrMoNbTaVW_Xu2022.eam.alloy`.

Once the simulation is finished, we will find a file `data.MoNbTa_CSRO`, which is the CSRO structure annealed at 300 K, and a file `cn.out`.

We can also check whether the potential energy converges to a constant. For that, plot a curve with `pe` as the _y_ axis and `step` as the _x_ axis. We can find `pe` and `step` in the log file; only use the data in the first run. The curve may look like Figure 1(a) of [this paper](https://doi.org/10.1073/pnas.1808660115), which is for CoCrNi.

#### Material properties

Use the data file `data.MoNbTa_CSRO` to calculate its lattice parameters and elastic constants at 0 K, 300 K, 600 K, 900 K, and 1200 K. Also calculate its GSFE at 0 K.

Note that the calculated elastic constants are in the [11-2]-[111]-[1-10] system, and so they should be [converted](https://github.com/shuozhixu/elastic_tensor) to those in the [100]-[010]-[001] system.

In all calculations, use the same method for CoCrNi. Remember to modify the input files accordingly and use the appropriate potential.

##### Lattice parameters

The initial trial lattice parameter is 3.135 Angstrom, but after running LAMMPS simulations, it might change. The new trial lattice parameter can be calculated by

	(lx/(10*sqrt(6.))+ly/(46*sqrt(3.)/2.)+lz/(14*sqrt(2.)))/3.
	
where `lx`, `ly`, and `lz` can be found in the data file `data.MoNbTa_CSRO`, i.e.,

	lx = xhi - xlo
	ly = yhi - ylo
	lz = zhi - zlo

In particular, when calculating the lattice parameter at 0 K, additionally change line 44 of `lmp_0K.in` to

	variable lat_para equal (lx/(10*sqrt(6.))+ly/(46*sqrt(3.)/2.)+lz/(14*sqrt(2.)))/3.
	
##### GSFE

Based on the file `lmp_gsfe.in` for CoCrNi, make the following changes:

- line 13. Use the data file for MoNbTa
- line 17. Use the potential file for MoNbTa
- line 32. Use the lattice parameter for MoNbTa
- line 35. Change the last part to `${tmp2}-1.+${latparam}/sqrt(2.)*(${d}-10)`
- line 57. Change the last part to `(${latparam}*sqrt(3)/2)/${stepn}`

Then iteratively change the value of `d` in line 34 to obtain 20 GSFE curves.

#### WC parameter

Follow the steps in the random MoNbTa case to calculate the WC parameters in the CSRO MoNbTa structure.

Eventually, use all WC parameters to make a plot similar to Figure 2(d) of [this paper](http://dx.doi.org/10.1016/j.actamat.2020.08.044).

### Pure metals

MoNbTa contains three pure metals having the same lattice as the alloy. It would be interesting to compare the temperature effect between them and the MPEA.

Lattice parameters, elastic constants, and USFEs of the three pure metals are in `Mo.txt`, `Nb.txt`, and `Ta.txt`. They were studied at 0 K, 300 K, 600 K, 900 K, and 1200 K, respectively. The only exception is that Nb becomes unstable at 1200 K so there is no data for that case.

## HfMoNbTaTi

Calculations at 0 K were performed when preparing [this paper](http://dx.doi.org/10.1063/5.0116898), although USFE data were not reported there. All data at finite temperatures are newly calculated for the current project. In all cases, simulation cells with size D (see Table II of the paper) were used.

Lattice parameters, elastic constants, and USFEs are summarized in the directory `HfMoNbTaTi` in this GitHub repository. USFEs, taken on the \{110\} plane, are in units of mJ/m<sup>2</sup>.

#### Random HfMoNbTaTi

The random material was studied at 0 K, 300 K, 600 K, 900 K, and 1200 K, respectively. Results are in `data_random.txt`.

#### HfMoNbTaTi with CSRO

Following [this paper](http://dx.doi.org/10.1063/5.0116898), four levels of CSRO were considered, with the material annealed at 300 K, 600 K, and 900 K, respectively. In what follows, let's call them 300KMDMC, 600KMDMC, 900KMDMC, respectively.

All materials were studied at 0 K, 300 K, 600 K, 900 K, and 1200 K, respectively. Results are in `data_300KMDMC.txt`, `data_600KMDMC.txt`, and `data_900KMDMC.txt`.

## HfNbTaTiZr

Calculations at 0 K were performed when preparing [this paper](http://dx.doi.org/10.1063/5.0116898), although USFE data were not reported there. All data at finite temperatures are newly calculated for the current project. In all cases, simulation cells with size D (see Table II of the paper) were used.

Lattice parameters, elastic constants, and USFEs are summarized in the directory `HfNbTaTiZr` in this GitHub repository. USFEs, taken on the \{110\} plane, are in units of mJ/m<sup>2</sup>.

#### Random HfNbTaTiZr

The random material was studied at 0 K, 300 K, 600 K, 900 K, and 1200 K, respectively. Results are in `data_random.txt`.

#### HfNbTaTiZr with CSRO

Following [this paper](http://dx.doi.org/10.1063/5.0116898), four levels of CSRO were considered, with the material annealed at 300 K, 600 K, and 900 K, respectively. In what follows, let's call them 300KMDMC, 600KMDMC, 900KMDMC, respectively.

All materials were studied at 0 K only. Results are in `data_300KMDMC.txt`, `data_600KMDMC.txt`, and `data_900KMDMC.txt`.

## References

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107
- Wu-Rong Jian, Zhuocheng Xie, Shuozhi Xu, Yanqing Su, Xiaohu Yao, Irene J. Beyerlein, [Effects of lattice distortion and chemical short-range order on the mechanisms of deformation in medium entropy alloy CoCrNi](http://dx.doi.org/10.1016/j.actamat.2020.08.044), Acta Mater. 199 (2020) 352--369
- Shuozhi Xu, Emily Hwang, Wu-Rong Jian, Yanqing Su, Irene J. Beyerlein, [Atomistic calculations of the generalized stacking fault energies in two refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.intermet.2020.106844), Intermetallics 124 (2020) 106844
