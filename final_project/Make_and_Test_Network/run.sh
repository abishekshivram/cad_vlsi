cd src_nocs
./remove_bsv.sh
cd ..
python3 create_noc_of_nocs.py 
./organise.sh
./runbsvcode