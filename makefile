all : ad-hoc

ad-hoc : main.m
	clang main.m -o ad-hoc -framework CoreWLAN -framework Foundation


