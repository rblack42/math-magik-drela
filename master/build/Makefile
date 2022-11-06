FC = gfortran

FSRCS = qprop.f qmil.f tpdes.f bnsolv.f gvcalc.f \
	   	cdfun.f tqcalc.f motor.f spline.f io.f qcget.f
FOBJS = $(FSRCS:.f=.o)
FINCS = QDEF.INC

QPROPOBJS = qprop.o gvcalc.o cdfun.o tqcalc.o motor.o spline.o io.o qcget.o
QMILOBJS  = qmil.o tpdes.o gvcalc.o cdfun.o tqcalc.o bnsolv.o spline.o io.o qcget.o
.PHONY:	qcopy
qcopy:
	cd ../master/Qprop/src && \
		cp $(FSRCS) ../../../build && \
		cp $(FINCS) ../../../build
		
qprop: $(QPROPOBJS)
	$(FC) -o qprop $(QPROPOBJS)

qmil: $(QMILOBJS)
	$(FC) -o qmil $(QMILOBJS)
%.o:	%.f
	$(FC) -c $^ -o $@

