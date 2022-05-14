C***********************************************************************
C    Module:  cdfun.f
C 
C    Copyright (C) 2005 Mark Drela 
C 
C    This program is free software; you can redistribute it and/or modify
C    it under the terms of the GNU General Public License as published by
C    the Free Software Foundation; either version 2 of the License, or
C    (at your option) any later version.
C
C    This program is distributed in the hope that it will be useful,
C    but WITHOUT ANY WARRANTY; without even the implied warranty of
C    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
C    GNU General Public License for more details.
C
C    You should have received a copy of the GNU General Public License
C    along with this program; if not, write to the Free Software
C    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
C***********************************************************************


      SUBROUTINE CDFUN(CL,   RE,   MA, CLCD0,CD0,CD2,REREF,REEXP, MCRIT,
     &           CD,CD_CL,CD_RE,CD_MA )
      REAL MA, MCRIT
C
      DATA CDMF / 10.0 /
      DATA IEXP / 3 /
C
C---- CD-scaling factor
      FAC = (RE/REREF)**REEXP
      FAC_RE = REEXP*FAC/RE
C
C---- CD(CL;Re) function
      CLB = CL - CLCD0
      CD    = (CD0 + CD2*CLB**2 )*FAC
      CD_CL = (      CD2*CLB*2.0)*FAC
      CD_RE = (CD0 + CD2*CLB**2 )*FAC_RE
      CD_MA = 0.
C
      IF(MA .GT. MCRIT) THEN
       CD    = CD    + CDMF*(MA-MCRIT)** IEXP
       CD_MA = CD_MA + CDMF*(MA-MCRIT)**(IEXP-1) * FLOAT(IEXP)
      ENDIF
C
      RETURN
      END ! CDFUN



      SUBROUTINE DCDFUN(    BE,    WA,    WT, CLCD0,CL0,DCLDA,
     &              DCD,DCD_BE,DCD_WA,DCD_WT )
C
      A    = BE - ATAN2(WA,WT)
      A_BE = 1.0
      A_WA = -WT/(WA**2 + WT**2)
      A_WT =  WA/(WA**2 + WT**2)
C
      ACD0 = (CLCD0-CL0)/DCLDA
      DCD   = 2.0*SIN(A-ACD0)**2
      DCD_A = 4.0*SIN(A-ACD0)*COS(A-ACD0)
C
      DCD_BE = DCD_A*A_BE
      DCD_WA = DCD_A*A_WA
      DCD_WT = DCD_A*A_WT
C
      RETURN
      END ! DCDFUN
