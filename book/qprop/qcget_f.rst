qcget.f
=======

This routine will read a user supplied **qdef.inc** file containing three free-stream variables:

* **rhhho** - density
* ** xmuinf** - viscosity
* ** vso** - speed of sound

If this file is not found, the program reverts to values found in **QDEF.INC**:

..  literalinclude::    ../../master/Qprop/src/QDEf.INC

These values match the *Standard Atmosphere* model for sea level.


..	literalinclude::	../../master/Qprop/src/qcget.f
	:language: fortran
