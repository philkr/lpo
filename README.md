Learning to propose objects
===========================

This implements the learning and inference/proposal algorithm described in "Learning to Propose Objects, Krähenbühl and Koltun, CVPR 2015".

#### Dependencies:
 * c++11 compiler (gcc >= 4.7)
 * cmake
 * boost-python
 * python (2.7 or 3.1+ should both work)
 * numpy
 * libmatio (optional)
 * libpng, libjpeg
 * Eigen 3 (3.2.0 or newer)
 * OpenMP (optional but recommended)

#### Compilation:
 Go to the top level directory
```bash
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j9
```

The code should compile and run fine on both Linux and Mac OS, let me know if you have any difficulty or find a bug. For Windows you're on your own.

#### Experiments

The code to reproduce most results in the paper is included here. All experiments should be run from the `src` directory.

To generate the main comparison in table 3 run:
```bash
bash eval_all.sh
```

To analyze a model like table 2 run:
```bash
python analyze_model.py path/to/model
```

To do the bounding box evaluation call:
```bash
python eval_box.py path/to/output_file path/to/model1 path/to/model2 path/to/model3 path/to/model4
```
This will create a binary file measuring number of proposals vs best overlap per object. You can then use the `results/box.py` script to generate the bounding box evaluation and produce the plots. For your convenience we included the precomputed results of many prior methods on VOC 2012 in `results/box/*.dat`.

#### Citation

If you're using this code in a scientific publication please cite:
```
@inproceedings{kk-lpo-15,
  author    = {Philipp Kr{\"{a}}henb{\"{u}}hl and
               Vladlen Koltun},
  title     = {Learning to Propose Objects},
  booktitle = {CVPR},
  year      = {2015},
}
```

#### License
All my code is published under a BSD license, so feel free to reuse and/or share it. There are some dependencies which are under different licenses and/or patented. All those dependencies are located in the `external` directory.
