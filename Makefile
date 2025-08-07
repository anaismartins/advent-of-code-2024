day2:
	gfortran -O2 -g -fcheck=all -c src/day2.f90 -o obj/day2.o
	gfortran -O2 -g -fcheck=all -c src/utils.f90 -o obj/utils.o
	gfortran -O2 -g -fcheck=all obj/day2.o obj/utils.o -o output/day2
	./output/day2