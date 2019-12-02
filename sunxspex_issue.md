Fit NuSTAR solar data

Overall Issue:

Fit NuSTAR spectra - spectra are dominated by bright 2-4MK source and want to test whether the additional low count-rate emission at higher energies is real (i.e. consistent with hotter and/or non-thermal).

---

Example:
[https://github.com/KriSun95/nustarFittingExample](https://github.com/KriSun95/nustarFittingExample)

Start point is a NuSTAR spectrum file (.pha), and response (.rmf redistribution matrix file + .arf ancillary response file) that were generated from a NuSTAR observations using nuproducts [https://heasarc.gsfc.nasa.gov/docs/nustar/analysis/](https://heasarc.gsfc.nasa.gov/docs/nustar/analysis/). NuSTAR is two telescopes (FPMA and FPMB) and has effectively no instrumental background (dominant background source is solar).

Currently:

* Load in spectrum using astropy.fits (.pha: spectrum, energy binning, livetime) and calculate uncertainty in spectrum
* Load in response using astropy.fits (.arf: energy bin edges and ARF effective area [cm$^2$] as function of energy; .rmf: energy bin edges, subset information, matrix and convert to RMF array) and create SRM =RMF#ARF [counts cm$^2$ photon$^{-1}$]
* Model function: returns count flux model to pass to forward fitting routine (counts s$^{-1}$ keV$^{-1}$ = counts cm$^2$ photon$^{-1}$ # photon s$^{-1}$ keV$^{-1}$ cm$^{-2}$]
* Fit simple power-law photon model by maximising (using scipy.optimize) Poisson log-likelihood function [https://cxc.cfa.harvard.edu/sherpa/statistics/#cash](https://cxc.cfa.harvard.edu/sherpa/statistics/#cash).
* Fit simple power-law photon model using MCMC approach and do corner plots.

Next steps:

* Fit physically realistic models:
	* Single Thermal (i.e. f\_vth.pro, continuum and CHIANTI lines)
	* Multiple thermal (i.e. 2 component, possibly one fixed to represent pre-event background) 
	* DEM (i.e. power-law of f\_.pro)
	* Thermal and non-thermal (i.e. f\_vth.pro + f\_thick2.pro or f\_thin2.pro, thick or thin target)
* Fit using robust statistical approach, testing nature of excess emission at higher energies/low counts:
	* Maximise other likelihood functions ?
	* Bayesian and MCMC approaches ([https://git.ligo.org/lscsoft/bilby](https://git.ligo.org/lscsoft/bilby)) ?
* Fit FPMA & FPMB simulatenously

Other links:

* NuSTAR solar analysis code (IDL/Python/XSPEC) [https://github.com/ianan/nustar_sac](https://github.com/ianan/nustar_sac)
