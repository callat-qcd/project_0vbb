<figure style="float:right">
    <img
    src="./data/callat_logo.png"
    width="100"
    alt="CalLat logo"
    align="right"
    /img>
</figure>

# project_0νbb
neutrinoless double beta decay

[![DOI](https://zenodo.org/badge/130005007.svg)](https://zenodo.org/badge/latestdoi/130005007)


Chiral-continuum extrapolation for "Neutrinoless Double Beta Decay from QCD" with MDWF on HISQ gauge configurations [cite paper]. Details on the mixed action setup may be found in "Möbius domain-wall fermions on gradient-flowed dynamical HISQ ensembles" [[arXiv](https://arxiv.org/abs/1701.07559),[PRD](https://doi.org/10.1103/PhysRevD.96.054513)]. Details of the MILC HISQ ensembles may be found in "Lattice QCD ensembles with four flavors of highly improved staggered quarks" [[arXiv](https://arxiv.org/abs/1212.4768), [PRD](https://doi.org/10.1103/PhysRevD.87.054505)] and "Gradient flow and scale setting on MILC HISQ ensembles" [[arXiv](https://arxiv.org/abs/1503.02769), [PRD](https://doi.org/10.1103/PhysRevD.93.094510)].

This repository includes:
* `project_0vbb.ipynb`: the Jupyter notebook used to perform the chiral-continuum extrapolation.
* `data` folder which includes
   * `n0bb_v3.csv`: matrix elements for the basis of 4-quark operators, the pion decay constant F<sub>π</sub>, and the expansion parameter ε<sub>π</sub>=m<sub>π</sub>/4πF<sub>π</sub>.
   * `gV.csv`: the vector charge of the nucleon.
   * `phi_ju.csv`: the mass of the DW + HISQ valence pion.
   * `hisq_params.csv`: values of a/w0, the taste-identity pion mass splitting, r<sub>1</sub>/a, and α<sub>s</sub> from MILC.

# Setup for Python environment
## Download Anaconda and install
Download [Anaconda](https://www.continuum.io/downloads) and follow installation instructions.

## Create Python environment with Anaconda
```bash
conda create --name pyqcd3 python=3 anaconda
source activate pyqcd3
```

Key libraries from [gplepage GitHub](https://github.com/gplepage).
* `gvar` version 8.3.6 [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1202447.svg)](https://doi.org/10.5281/zenodo.1202447)

* `lsqfit` version 9.3 [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1210188.svg)](https://doi.org/10.5281/zenodo.1210188)

Exit conda environment with
```bash
source deactivate
```

## Open Jupyter notebook
```bash
jupyter notebook 0vbb_workbook.ipynb
```

## 0vbb_workbook.ipynb Tested with the following Python Setup
```
python version: 3.6.1 |Anaconda 4.4.0 (x86_64)| (default, May 11 2017, 13:04:09) 
[GCC 4.2.1 Compatible Apple LLVM 6.0 (clang-600.0.57)]
pandas version: 0.20.1
numpy  version: 1.14.2
scipy  version: 1.0.1
lsqfit version: 9.3
gvar   version: 8.3.6
mpl    version: 2.0.2
```

and

```
python version: 2.7.14 (default, Jan 6 2018, 12:15:00)
[GCC 4.2.1 Compatible Apple LLVM 9.0.0 (clang-900.0.39.2)]
pandas version: 0.20.3
numpy  version: 1.14.2
scipy  version: 1.0.1
mpl    version: 2.0.2
lsqfit version: 9.3
gvar   version: 8.3.6
mpl    version: 2.0.2
```

<figure style="float:right">
    <img
    src="./data/incite_logo.png"
    width="200"
    alt="incite"
    align="right"
    /img>
    <img
    src="./data/olcf_logo.png"
    width="320"
    alt="incite"
    align="right"
    /img>
</figure>