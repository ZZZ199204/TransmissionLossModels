%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                                                  %%%%%
%%%%      NICTA Energy System Test Case Archive (NESTA) - v0.7.0      %%%%%
%%%%              Optimal Power Flow - Typical Operation              %%%%%
%%%%                         05 - June - 2017                         %%%%%
%%%%                                                                  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   The semidefinite relaxation of the OPF problem successfully solves 
%   this network with a value of 60 MVA for the line-flow limit on the line from
%   bus 2 to bus 3. The semidefinite relaxation fails to give a physically
%   meaningful solution to this network with a value of 50 MVA for the line-flow
%   limit on this line. See the following publication for further details.
%
%   Lesieutre, B.C. & Molzahn, D.K. & Borden, AR. & Demarco, C.L., 
%   "Examining the Limits of the Application of Semidefinite Programming to Power Flow Problems",
%   49th Annual Allerton Conference on Communication, Control, and Computing (Allerton),  
%   September, 2011, pp. 1492-1499
%
%   opt objective value:  5812.64 $/hr
%
%    Bus      Voltage          Generation             Load          Lambda($/MVA-hr)
%     #   Mag(pu) Ang(deg)   P (MW)   Q (MVAr)   P (MW)   Q (MVAr)     P        Q   
%   ----- ------- --------  --------  --------  --------  --------  -------  -------
%       1  1.100    0.000*   148.07     54.70    110.00     40.00    37.575     -
%       2  0.926    7.259    170.01     -8.79    110.00     40.00    30.101     -
%       3  0.900  -17.267      0.00     -4.84     95.00     50.00    45.537     -
%                           --------  --------  --------  --------
%                  Total:    318.07     41.06    315.00    130.00
%
function mpc = nesta_case3_lmbd
mpc.version = '2';
mpc.baseMVA = 100.0;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1	 3	 00.0	 00.0	 0.0	 0.0	 1	    1	   0	 100.0	 1	    1.0000	    1.0000;
	2	 2	 00.0	 00.0	 0.0	 0.0	 1	    1	   0	 100.0	 1	    1.0000	    1.0000;
	3	 2	 100.0	 00.0	 0.0	 0.0	 1	    1	   0	 100.0	 1	    1.0000	    1.0000;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	 0	 0	 1000.0	 -1000.0	 1	 100.0	 1	 20000.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0;
	2	 0	 0	 1000.0	 -1000.0	 1	 100.0	 1	 20000.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0;
	%3	 0	 0	 1000.0	 -1000.0	 1	 100.0	 1	 20000.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0	 0.0;
];

%% generator cost data
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	 0.0	 0.0	 3	   1	   000000	   0.00000;
	2	 0.0	 0.0	 3	   1	   000000	   0.00000;
	%2	 0.0	 0.0	 3	   1     000000	   0.00000;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
	1	 3	 1	 1	 0	 5.0	 0.0	 0.0	 0.0	 0.0	 1	 -1     1;
	3	 2	 1	 1	 0	 10000.0	 0.0	 0.0	 0.0	 0.0	 1	 -1	 1;
	1	 2	 1	 1	 0	 10000.0	 0.0	 0.0	 0.0	 0.0	 1	 -1	 1;
];

% INFO    : === Translation Options ===
% INFO    : Phase Angle Bound:           30.0 (deg.)
% INFO    : AC OPF Solution File:        nesta_case3_lmbd.m.opf.sol
% INFO    : 
% INFO    : === Voltage Setpoint Replacement Notes ===
% INFO    : Bus 1	: V=1.0, theta=0.0 -> V=1.1, theta=-0.0
% INFO    : Bus 2	: V=1.0, theta=0.0 -> V=0.92617, theta=7.25883
% INFO    : Bus 3	: V=1.0, theta=0.0 -> V=0.9, theta=-17.2671
% INFO    : 
% INFO    : === Generator Setpoint Replacement Notes ===
% INFO    : Gen at bus 1	: Pg=0.0, Qg=0.0 -> Pg=148.067, Qg=54.697
% INFO    : Gen at bus 1	: Vg=1.0 -> Vg=1.1
% INFO    : Gen at bus 2	: Pg=0.0, Qg=0.0 -> Pg=170.006, Qg=-8.791
% INFO    : Gen at bus 2	: Vg=1.0 -> Vg=0.92617
% INFO    : Gen at bus 3	: Pg=0.0, Qg=0.0 -> Pg=0.0, Qg=-4.843
% INFO    : Gen at bus 3	: Vg=1.0 -> Vg=0.9
% INFO    : 
% INFO    : === Writing Matpower Case File Notes ===
