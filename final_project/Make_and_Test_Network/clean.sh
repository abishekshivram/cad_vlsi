rm -r build;
rm -r verilog;
rm -r sim_build;
rm Makefile;
find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf