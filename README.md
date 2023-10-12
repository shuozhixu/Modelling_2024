# Multi-principal element alloys

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants), generalized stacking fault energies (GSFE), and melting point of four equal-molar multi-principal element alloys (MPEAs). The effects of chemical short-range order (CSRO) will be considered.

Please read the following journal articles to understand how the aforementioned material properties can be calculated.

\[Elemental materials\]:

- Xiaowang Wang, Shuozhi Xu, Wu-Rong Jian, Xiang-Guo Li, Yanqing Su, Irene J. Beyerlein, [Generalized stacking fault energies and Peierls stresses in refractory body-centered cubic metals from machine learning-based interatomic potentials,](http://dx.doi.org/10.1016/j.commatsci.2021.110364) Comput. Mater. Sci. 192 (2021) 110364
- Yanqing Su, Shuozhi Xu, Irene J. Beyerlein, [Density functional theory calculations of generalized stacking fault energy surfaces for eight face-centered cubic transition metals](http://dx.doi.org/10.1063/1.5115282), J. Appl. Phys. 126 (2019) 105112
- Saeed Zare Chavoshi, Shuozhi Xu, Saurav Goel, [Addressing the discrepancy of finding equilibrium melting point of silicon using MD simulations](http://dx.doi.org/10.1098/rspa.2017.0084), Proc. R. Soc. A 473 (2017) 20170084

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

Four MPEAs will be considered.

## CoCrNi

Note: All files for calculations can be found in the `CoCrNi` directory in this GitHub repository, except the data files which can be [here](https://drive.google.com/drive/folders/13xaI274U-xIsBN8h_TY_eohsXxedEwFE?usp=sharing). The reason is that the data files are too large for GitHub.

All data files are from [this paper](http://dx.doi.org/10.1016/j.actamat.2020.08.044).

### Lattice parameters at 0 K

#### Random CoCrNi

Run the simulation with files `lmp_0K.in`, `min.CoCrNi_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, you will find a new file `a_E`. The first column is the ratio of the trial lattice parameter to 3.5564, the second column is the trial lattice parameter itself, in units of Anstrong, the thrid column is the cohesive energy, in units of eV. If you plot a curve with the second column as the x axis and the third column as the y axis, the curve should look like the ones in Figure 1(a) of [this paper](http://dx.doi.org/10.1016/j.commatsci.2021.110942).

Then run `sh min.sh` to find out the trial lattice parameter corresponding to the lowest cohesive energy (i.e., the minimum on that curve), and that would be the actual lattice parameter. Specifically, you will see

	1 3.55644549888703 -4.32151351854507

on the screen. Record these three numbers. These are for random CoCrNi.

#### CoCrNi with CSRO

The simulation requires files 
`lmp_0K.in`, `min.CoCrNi_27nmx_27nmy_27nmz_350KMDMC.dat`, and `CoCrNi.lammps.eam`. Make one change in `lmp_lat.in`:

- Line 10. Change the word `random` to `350KMDMC`, i.e., to match the new data file's name.

Run the simulation. Once it is finished, you will find a new file `a_E`. The first column is the ratio of the trial lattice parameter to 3.561; the other two columns have the same meaning as the random case. Repeat the remaining steps in the random case and record the three numbers for the CoCrNi with CSRO.

### Elastic constants at 0 K

#### Random CoCrNi

Run the simulation with files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.CoCrNi_27nmx_27nmy_27nmz_random.dat`, and `CoCrNi.lammps.eam`.

Once it is finished, you will find an output file, `*.out`, at the end of which you will find values of C11all, C12all etc. Specifically, you will see

	Elastic Constant C11all = 309.979695007998 GPa
	Elastic Constant C22all = 310.087578803684 GPa

Rename that file to `lmp_random.out` and upload it to the `CoCrNi/ela_const/0K` directory. 

#### CoCrNi with CSRO

The simulation requires files `in.elastic`, `displace.mod`, `init.mod`, `potential.mod`, `min.CoCrNi_27nmx_27nmy_27nmz_350KMDMC.dat`, and `CoCrNi.lammps.eam`. Make one change in `init.mod`:

- Change the last number (by default 1.) of line 50 to the correct ratio identified in the prior lattice parameter calculation, i.e., the first of the three numbers you recorded for the CSRO case.

Run the simulation. Once it is finished, rename the newly generated output file to `lmp_350KMDMC.out` and upload it to the `CoCrNi/ela_const/0K` directory.

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

Once it is finished, go to the end of the output file, and you will see

	Elastic Constant C11 = 298.291596568703 GPa
	Elastic Constant C22 = 297.341418727254 GPa

which are smaller than those calculated at 0 K, as expected.

Rename the file to `lmp_random.out` and upload it to the `CoCrNi/ela_const/300K` directory. 

#### CoCrNi with CSRO

Repeat the steps above, except that

- Use the `data.relax` file from the `Lattice parameters at 300 K - CoCrNi with CSRO` calculation instead

Once the simulation is finished, rename the output file to `lmp_300K.out` and upload it to the `CoCrNi/ela_const/300K` directory.

### GSFE at 0 K

#### Random CoCrNi

Run the simulation with files `lmp_gsfe.in`, `data.CoCrNi_gsfe_random`, and `CoCrNi.lammps.eam`. The first file can be found in the directory `CoCrNi/gsfe/` in this GitHub repository.

Once it is finished, you will find a file `gsfe_ori`, which should contain 3001 lines, with the first one being

	0 -374943.444563279

Then run `sh gsfe_curve.in` in the terminal to generate a new file `gsfe`. Plot a curve using its first and second columns as the _x_ and _y_ axes, respectively. Bring it to our meeting for discussion.

#### CoCrNi with CSRO

Follow the procedures above, except that

- Use the data file `data.CoCrNi_gsfe_350KMDMC` instead
- Change the word `random` to `350KMDMC` in line 14 of the file `lmp_gsfe.in`
- Change the number `3.5564` to `3.561` in line 51 of the file `lmp_gsfe.in`

### Melting point

#### Random CoCrNi

Run the simulation with files `lmp_mp.in`, `data.CoCrNi_gsfe_random`, and `CoCrNi.lammps.eam`. The first file can be found in the directory `CoCrNi/melting_point/` in this GitHub repository.

Once it is finished, you will find a file `avePE.out`. Plot its 2nd and 4th column as the _x_ and _y_ axes, respectively. It should look like one of the curves in Figure 2(b) of [this paper](http://dx.doi.org/10.1098/rspa.2017.0084).

In line 6 of `lmp_mp.in`, the trial melting point is set as 1200 K.

- If 1200 K is lower than the actual melting point, the curve you plot will decrease. Then increase the last number in line 6 and rerun the simulation.
- If 1200 K is higher than the actual melting point, the curve you plot will increase. Then decrease the last number in line 6 and rerun the simulation.

Repeat the steps above until you find the actual melting point, which should lead to a curve that neither increases nor decreases.

Note: Save the data for each curve because eventually you will need to plot multiple curves like those in Figure 2(b) of [this paper](http://dx.doi.org/10.1098/rspa.2017.0084).

#### CoCrNi with CSRO

Follow the procedures above, except that

- Use the data file `data.CoCrNi_gsfe_350KMDMC` instead
- Change the word `random` to `350KMDMC` in line 17 of the file `lmp_mp.in`

### Pure metal

CoCrNi contains only one pure metal, Ni, that has the same lattice as the alloy. It would be interesting to compare the temperature effect between it and the MPEA.

For CoCrNi, [Jian et al.](http://dx.doi.org/10.1016/j.actamat.2020.08.044) built all atomistc structures, and so we directly used them. For Ni, however, we need to build the atomistic structure ourselves. The first step is to install [Atomsk](https://atomsk.univ-lille.fr).

Run the atomsk script, `atomsk_Ni.sh`, which can be found in `CoCrNi/ni/` in this GitHub repository, to build a Ni structure named `data.Ni`, by

	sh atomsk_Ni.sh

Then use the data file and the same potential file to calculate its lattice parameters and elastic constants at 0 K and 300 K. Also calculate its GSFE at 0 K and its melting point.

Note: The trial lattice parameter is 3.5564 Angstrom. When calculating the lattice parameter at 0 K, in line 44 of `lmp_0K.in`, change the three numbers 54, 63, and 45, to 30, 30, and 10, respectively. This is because different cell sizes are used here.

## MoNbTa

Similar to Ni, we need to build the atomistic structures for MoNbTa ourselves.

### Random MoNbTa

Run the atomsk script, `atomsk_MoNbTa.sh`, which can be found in `MoNbTa/random/` in this GitHub repository, to build a random MoNbTa structure named `data.MoNbTa_random`.

In the data file, change the masses section to

		1   95.96000000    # Mo
		2   92.90638000    # Nb
		3   180.94788000   # Ta

Lattice parameter, elastic constants, and GSFE of random MoNbTa have been calculated. They are summarized in the file `MoNbTa/random/data_random.txt` in this GitHub repository. Most results were based on the [EAM potential](http://dx.doi.org/10.1016/j.commatsci.2021.110942) while those at 0 K were also based on the [MTP](http://dx.doi.org/10.1038/s41524-023-01046-z). We can compare the two potentials for properties at 0 K in the paper.

#### Warren-Cowley (WC) parameter

First, calculate the radial distribution functions (RDF) for random MoNbTa. To do that, run a LAMMPS simulation with three files `data.MoNbTa_random`, `CrMoNbTaVW_Xu2022.eam.alloy`, and `lmp_mdmc.in`. The last file is from the `MoNbTa/csro/` directory in this GitHub repository and should be modified as follows:

- Lines 3 and 4. Change the two large numbers to zero
- Linne 25. Change the data file name to `data.MoNbTa_random`

Once the simulation is finished, you will find a file `cn.out`, which contains RDF information.

Then build a new directory named `WCP_random` and move three files there: `cn.out`, `cn.sh`, and `csro.sh`. The last two files can be found in the `MoNbTa/wc/` directory in this GitHub repository.

Run

	sh cn.sh
	
Then you will find a new directory `cn` and one or more `rdf.*.dat` files in it. Then move `csro.sh` into the `cn` directory and execute it, i.e.,

	move csro.sh cn/
	cd cn/
	sh csro.sh
	
Then you will find a file named `csro.a1.dat`, which is what we need. The 2nd to 7th numbers in that file are &alpha;\_MoMo, &alpha;\_MoNb, &alpha;\_MoTa, &alpha;\_NbNb, &alpha;\_NbTa, and &alpha;\_TaTa, respectively. These are WC parameters.

[//]: # (#### Melting point)

[//]: # (Use the method described in Section 3.1 of [this paper](https://doi.org/10.1117/12.2635100) to determine whether MoNbTa melts at 1500 K. For this purpose, make two changes to the `lmp_mdmc.in`:)

[//]: # (- Line 3. Change the large number at the end to `0`)
[//]: # (- Line 4. Change the large number at the end to `200000`) 

[//]: # (Run the simulation with the modified `lmp_mdmc.in`, `data.MoNbTa_random`, and `CrMoNbTaVW_Xu2022.eam.alloy`. Once it is finished, load the output data file `data.MoNbTa_CSRO_LT` into OVITO, and then [calculate RDF in OVITO](https://www.ovito.org/manual/reference/pipelines/modifiers/coordination_analysis.html). If the material does not melt at 1500 K, increase the temperature in line 2 of `lmp_mdmc.in` to `2000` or `2500` or `3000`, and rerun the simulation.)

### MoNbTa with CSRO

#### Build the CSRO structure

##### Semi-grand canonical ensemble

The first step is to determine the chemical potential difference between Mo and Nb, and that between Mo and Ta, respectively. To this end, run Monte Carlo (MC) simulations in semi-grand canonical (SGC) ensemble using `lmp_sgc.in` and `CrMoNbTaVW_Xu2022.eam.alloy`.

Once the simulation is finished, you will find a file `statistics.dat`, which should contain one line:

	0.021 -0.32 0.0045 0.34  0.6555

The first two numbers are the two energy differences you provided in lines 10 and 11 of `lmp_sgc.in`, while the last three numbers are the concentrations of Mo, Nb, and Ta, respectively. Since they are not close to equal-molar, modify the two numbers in lines 10 and 11 of `lmp_sgc.in`, and run the simulation again. You can make the modification in the same folder and a new line will be appended to `statistics.dat` once the new simulation is finished. Iteratively adjust the two numbers until the material is almost equal-molar. Note that it does not have to be exactly equal-molar. The procedure is similar to what is described in Section B.2 of [this paper](https://doi.org/10.1016/j.actamat.2019.12.031).

##### Variance constrained semi-grand canonical ensemble

Once the two chemical potential differences are identified, change the two chemical energy differences in lines 10 and 11 in file `lmp_vcsgc.in` to the correct values. Then run the atomsk script, `atomsk_Mo.sh` to build a Mo structure named `data.Mo`.

Next, make two changes to `data.Mo`:

- Line 4. Change the first number `1` to `3`
- Line 12 contains the atomic mass of Mo. Add two lines after it, i.e.,

		Masses
		
		1   95.96000000    # Mo
		2   92.90638000    # Nb
		3   180.94788000   # Ta
		
		Atoms # atomic

Next, run a hybrid MD/MC simulation in variance constrained semi-grand canonical (VC-SGC) ensemble using `lmp_vcsgc.in`, `data.Mo`, and `CrMoNbTaVW_Xu2022.eam.alloy`.

Once the simulation is finished, you will find a file `data.MoNbTa_CSRO`, which is the CSRO structure annealed at 300 K, and a file `cn.out`.

You can also check whether the potential energy converges to a constant. For that, plot a curve with `pe` as the _y_ axis and `step` as the _x_ axis. You can find `pe` and `step` in the log file; only use the data in the first run. The curve may look like Figure 1(a) of [this paper](https://doi.org/10.1073/pnas.1808660115), which is for CoCrNi.

#### Material properties

Use the data file `data.MoNbTa_CSRO` to calculate its lattice parameters and elastic constants at 0 K, 300 K, 600 K, 900 K, and 1200 K. Also calculate its GSFE at 0 K and its melting point.

Use the same method for CoCrNi. Remember to modify the input files accordingly and use the appropriate potential.

In particular, the initial trial lattice parameter is 3.135 Angstrom, but after running LAMMPS simulations, it might change. The new trial lattice parameter can be calculated by

	(lx/(10*sqrt(6.)/2.)+ly/(46*sqrt(3.))+lz/(14*sqrt(2.)))/3.

Also, when calculating the lattice parameter at 0 K, change line 44 of `lmp_0K.in` to

	variable lat_para equal (lx/(10*sqrt(6.)/2.)+ly/(46*sqrt(3.))+lz/(14*sqrt(2.)))/3.

#### WC parameter

Follow the steps in the random MoNbTa case to calculate the WC parameters in the CSRO MoNbTa structure.

Eventually, use all WC parameters to make a plot similar to Figure 2(d) of [this paper](http://dx.doi.org/10.1016/j.actamat.2020.08.044).

### Pure metals

MoNbTa contains three pure metals having the same lattice as the alloy. It would be interesting to compare the temperature effect between them and the MPEA.

Lattice parameters, elastic constants, and USFEs of the three pure metals are in `Mo.txt`, `Nb.txt`, and `Ta.txt`. They were studied at 0 K, 300 K, 600 K, 900 K, and 1200 K, respectively. The only exception is that Nb becomes unstable at 1200 K so there is no data for that case.

## HfMoNbTaTi

Data at 0 K were taken from [this paper](http://dx.doi.org/10.1063/5.0116898). Data at finite temperatures are newly calculated for the current project. In all cases, simulation cells with size D (see Table II of the paper) were used.

Lattice parameters, elastic constants, and USFEs are summarized in the directory `HfMoNbTaTi` in this GitHub repository. USFEs, taken on the \{110\} plane, are in units of mJ/m<sup>2</sup>.

#### Random HfMoNbTaTi

The random material was studied at 0 K, 300 K, 600 K, 900 K, and 1200 K, respectively. Results are in `data_random.txt`.

#### HfMoNbTaTi with CSRO

Following [this paper](http://dx.doi.org/10.1063/5.0116898), four levels of CSRO were considered, with the material annealed at 300 K, 600 K, and 900 K, respectively. In what follows, let's call them 300KMDMC, 600KMDMC, 900KMDMC, respectively.

The material 300KMDMC was studied at 0 K and 300 K, respectively. Results are in `data_300KMDMC.txt`.

The material 600KMDMC was studied at 0 K and 600 K, respectively. Results are in `data_600KMDMC.txt`.

The material 900KMDMC was studied at 0 K and 900 K, respectively. Results are in `data_900KMDMC.txt`.

## HfNbTaTiZr

Data at 0 K were taken from [this paper](http://dx.doi.org/10.1063/5.0116898). Need to cite it. Data at finite temperatures are newly calculated for the current project. In all cases, simulation cells with size D (see Table II of the paper) were used.

Lattice parameters, elastic constants, and USFEs are summarized in the directory `HfNbTaTiZr` in this GitHub repository. USFEs, taken on the \{110\} plane, are in units of mJ/m<sup>2</sup>.

Note that only random HfNbTaTiZr is considered, and the results are in `data_random.txt`.

## References

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107
- Wu-Rong Jian, Zhuocheng Xie, Shuozhi Xu, Yanqing Su, Xiaohu Yao, Irene J. Beyerlein, [Effects of lattice distortion and chemical short-range order on the mechanisms of deformation in medium entropy alloy CoCrNi](http://dx.doi.org/10.1016/j.actamat.2020.08.044), Acta Mater. 199 (2020) 352--369
- Saeed Zare Chavoshi, Shuozhi Xu, Saurav Goel, [Addressing the discrepancy of finding equilibrium melting point of silicon using MD simulations](http://dx.doi.org/10.1098/rspa.2017.0084), Proc. R. Soc. A 473 (2017) 20170084
