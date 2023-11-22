#!/usr/bin/env python
# Created by Yanqing Su
# Cite: S. Xu, E. Hwang, W. Jian, Y. Su, I.J. Beyerlein, Intermetallics 124 (2020) 106844

usage="""
        Usage: bcc_gsfe_poscar.py tx tz vacuum shift    
               tx (float) - displacement of top block of atoms in the x direction
               tz (float) - displacement of top block of atoms in the z direction
               vacuum (float) - thickness of vacuum added along the y direction
               shift (int) - above which plane along the y direction is the top block
        Example: bcc_gsfe_poscar.py 1. 2. 12. 5
"""

import os
import re
import sys
import math
import numpy as np

def get_direct():
  xa = []; ya = []; za = []; ly = []
  filename = "POSCAR_0"
  #print(filename)
  fin = open(filename,"r")
  # Read and ignore header lines
  header1 = fin.readline()
  header2 = fin.readline()
  header3 = fin.readline()
  header4 = fin.readline()
  header5 = fin.readline()
  header6 = fin.readline()
  header7 = fin.readline()
  header8 = fin.readline()

  header3 = header3.strip(); header3t = header3.split(); bx = float(header3t[0])
  header4 = header4.strip(); header4t = header4.split(); by = float(header4t[1])
  header5 = header5.strip(); header5t = header5.split(); bz = float(header5t[2])
  header6 = header6.strip(); header6t = header6.split();ntype = len(header6t)
  index_sort=sorted(list(range(ntype)), key=lambda k: header6t[k])
  header7 = header7.strip(); atomtypes = header7.split()
  #print(header7, atomtypes)
  tmp1 = np.array(atomtypes); tmp2 = tmp1.astype(float); tmp3 = tmp2.astype(int)
  tmp5 = 0
  for i in range(0, len(tmp3)):
    tmp5 += tmp3[i]
  numoftype = tmp3.tolist(); tmp4 = np.cumsum(tmp3); num_end = tmp4.tolist()
#  print(tmp5)
  sortnum = [numoftype[i] for i in index_sort];sortnum_end = [num_end[i] for i in index_sort]
  newindex = list(range(sortnum_end[0]-sortnum[0],sortnum_end[0]))
  newindex += list(range(sortnum_end[1]-sortnum[1],sortnum_end[1]))
  newindex += list(range(sortnum_end[2]-sortnum[2],sortnum_end[2]))
  # Loop over lines and extract variables of interest
  #print(fin)
  i = 0
  for line in fin:
    line = line.strip()
    columns = line.split()
    #print(line, columns)
    xa.append(float(columns[0]));ya.append(float(columns[1]));za.append(float(columns[2]))
    i += 1
    if i == tmp5:
      break
  fin.close()

  return xa,ya,za,bx,by,bz,atomtypes,sortnum,newindex

def shift(vec,ly,k,xa,ya,za,box):
  #print ("vec[0] = ", vec[0], "  vec[1] = ", vec[1],"  vec[2] = ",vec[2])
  for i in list(range(len(ly))):
    #print ("i = ", i, "  ly[i] = ", ly[i],"  k = ",k)
    if ly[i]>k:
      #print ("i = ", i, "  ly[i] = ", ly[i],"  k = ",k)
      xa[i] += vec[0]
      ya[i] += vec[1]
      za[i] += vec[2]
      #print ("i = ", i, "  za[i] = ", za[i],"  ly = ", ly[i])
  for i in list(range(len(xa))):
    xa[i] = ( (xa[i] + box[0])/box[0] - int((xa[i] + box[0])/box[0]) )* box[0]
    ya[i] = ( (ya[i] + box[1])/box[1] - int((ya[i] + box[1])/box[1]) )* box[1]
    za[i] = ( (za[i] + box[2])/box[2] - int((za[i] + box[2])/box[2]) )* box[2]
  return xa,ya,za

def assign_layers(xa,ya,za):
  lenya=len(ya)
  #print(lenya)
  ly = [0] * lenya
  index_sort=sorted(list(range(lenya)), key=lambda k: ya[k])
  #print(index_sort)
  num = 0
  for i in index_sort:
    ly[i]=int(num/6)
    num += 1
    #print(ly[i])
  return xa,ya,za,ly

def periodicBC(xa,ya,za,box):
  for i in list(range(len(xa))):
    xa[i] = ( (xa[i] + box[0])/box[0] - int((xa[i] + box[0])/box[0]) )* box[0]
    ya[i] = ( (ya[i] + box[1])/box[1] - int((ya[i] + box[1])/box[1]) )* box[1]
    za[i] = ( (za[i] + box[2])/box[2] - int((za[i] + box[2])/box[2]) )* box[2]
  return xa,ya,za

def saveas_cartesion_poscar(xa,ya,za,ly,newindex,sortnum,vacuum,box):
  #faultatom = []
  filename = "POSCAR"
  #faultfile = "faultfile"
  #print(filename)
  fout = open(filename,"w")
  #f1 = open(faultfile,"w")
  fout.write("MoNbTa\n")
  fout.write("1.0\n")
  fout.write(" %22.8f  %22.8f  %22.8f\n"%(box[0],0,0))
  fout.write(" %22.8f  %22.8f  %22.8f\n"%(0,box[1]+vacuum,0))
  fout.write(" %22.8f  %22.8f  %22.8f\n"%(0,0,box[2]))
  fout.write("Mo Nb Ta\n")
  fout.write("%d %d %d\n"%(sortnum[0],sortnum[1],sortnum[2]))
  fout.write("Selective Dynamics\n")
  fout.write("Cart\n")
  lenx = len(xa)
  printi = 0
  for i in newindex:
    printi += 1
    if ly[i] < 2 or ly[i]>9:
      fout.write("%22.8f %22.8f %22.8f F F F\n"%(xa[i]*box[0],ya[i]*box[1],za[i]*box[2]))
    else:
      fout.write("%22.8f %22.8f %22.8f F T F\n"%(xa[i]*box[0],ya[i]*box[1],za[i]*box[2]))
    #if ly[i] == 5 or ly[i]==6:
      #faultatom.append(printi)
      #f1.write("%d\n"%(printi))
  fout.close()
  #f1.close()
  return len(xa)

def addvacuum(ya,vacuum):
  for i in list(range(len(xa))):
    ya[i] += vacuum/2.0
  return ya

# Main Program
if len(sys.argv) > 4:
  tx=float(sys.argv[1])
  tz=float(sys.argv[2])
  vacuum=float(sys.argv[3])
  shiftp=int(sys.argv[4])

  if not os.path.isfile("POSCAR_0"):
    print("Error: This script need POSCAR_0 as seed POSCAR file!!!")
    sys.exit()

  xa,ya,za,bx,by,bz,atomtypes,sortnum,newindex = get_direct()
  xa,ya,za = periodicBC(xa,ya,za,[1.,1.,1.])
  vec1 = [tx, 0, tz]
#  xa,ya,za,ly = assign_layers(xa,ya,za)
# rearrange layers by adjusting ya[i]
#  xa,ya,za,ly = faultplaneshift2mid(xa,ya,za,ly,plane)
# reassinging layers
  xa,ya,za,ly = assign_layers(xa,ya,za)
  xa,ya,za = shift(vec1,ly,shiftp,xa[:],ya[:],za[:],[1.,1.,1.])
  xa,ya,za = periodicBC(xa,ya,za,[1.,1.,1.])
#  xa,ya,za,ly = assign_layers(xa,ya,za)
# add vacuum in the y direction
  directvaccum=vacuum/by
  ya = addvacuum(ya,directvaccum)

  saveas_cartesion_poscar(xa,ya,za,ly,newindex,sortnum,vacuum,[bx,by,bz])

else:
  print("Error: wrong number of arguments!!!")
  print(usage)
