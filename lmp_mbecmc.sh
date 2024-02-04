#!/usr/bin/bash

rm -rf lammps-mbecmc
module load intel/2022a
git clone -b stable https://github.com/lammps/lammps.git lammps-mbecmc
cd lammps-mbecmc/src
make yes-manybody
make yes-extra-compute
make yes-mc
make mpi
