# This script reproduces table 3 in the paper
python3 train_lpo.py -f0 0.2 ../models/lpo_VOC_0.2.dat
python3 train_lpo.py -f0 0.1 ../models/lpo_VOC_0.1.dat
python3 train_lpo.py -f0 0.05 ../models/lpo_VOC_0.05.dat
python3 train_lpo.py -f0 0.03 ../models/lpo_VOC_0.03.dat
python3 train_lpo.py -f0 0.02 ../models/lpo_VOC_0.02.dat
python3 train_lpo.py -f0 0.01 ../models/lpo_VOC_0.01.dat -iou 0.925 # Increase the IoU a bit to make sure the number of proposals match
