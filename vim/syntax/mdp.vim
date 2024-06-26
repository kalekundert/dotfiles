syn spell notoplevel

syn keyword mdpOption include define

syn keyword mdpOption integrator tinit dt nsteps init_step comm_mode nstcomm
syn keyword mdpOption comm_grps

syn keyword mdpOption bd_fric ld_seed
syn keyword mdpOption emtol emstep nstcgsteep
syn keyword mdpOption emtolniterfcstep
syn keyword mdpOption rtpi

syn keyword mdpOption nstxout nstvout nstfout nstlog nstcalcenergy nstenergy
syn keyword mdpOption nstxtcout xtc_precision xtc_grps energygrps

syn keyword mdpOption nstlist ns_type pbc periodic_molecules rlist rlistlong
syn keyword mdpOption coulombtype rcoulomb_switch rcoulomb epsilon_r epsilon_rf
syn keyword mdpOption vdwtype rvdw_switch rvdw DispCorr
syn keyword mdpOption table-extension energygrp_table

syn keyword mdpOption fourierspacing fourier_nx fourier_ny fourier_nz pme_order
syn keyword mdpOption ewald_rtol ewald_geometry epsilon_surface optimize_fft

syn keyword mdpOption tcoupl nsttcouple tc_grps tau_t ref_t tc-grps

syn keyword mdpOption pcoupl pcoupltype nstpcouple tau_p compressibility ref_p
syn keyword mdpOption refcoord_scaling

syn keyword mdpOption annealing annealing_npoints annealing_time annealing_temp
syn keyword mdpOption gen_vel gen_temp gen_seed

syn keyword mdpOption constraints constraint_algorithm continuation shake_tol
syn keyword mdpOption lincs_order lincs_iter lincs_warnangle morse

syn keyword mdpOption energygrp_excl

syn keyword mdpOption nwall wall_type wall_r_linpot wall_atomtype wall_density
syn keyword mdpOption wall_ewald_zfac

syn keyword mdpOption pull pull_dim pull_r1 pull_r0 pull_constr_tol pull_start
syn keyword mdpOption pull_nstxout pull_nstfout pull_ngroups pull_group0
syn keyword mdpOption pull_weights0 pull_pbcatom0 pull_group1 pull_weights1
syn keyword mdpOption pull_pbcatom1 pull_vec1 pull_init1 pull_rate1 pull_k1
syn keyword mdpOption pull_kB1 pull_geometry

syn keyword mdpOption disre disre_weighting disre_mixed disre_fc disre_tau
syn keyword mdpOption nstdisreout orire orire_fc orire_tau orire_fitgrp
syn keyword mdpOption nstorireout

syn keyword mdpOption free_energy init_lambda delta_lambda sc_alpha sc_power
syn keyword mdpOption sc_sigma couple-moltype couple-lambda0 couple-lambda1
syn keyword mdpOption couple-intramol

syn keyword mdpOption acc_grps accelerate freezegrps freezedim cos_acceleration
syn keyword mdpOption deform

syn keyword mdpOption E_x E_xt E_y E_yt E_z E_zt 

syn keyword mdpOption QMMM QMMM-grps QMMMscheme QMmethod QMbasis QMcharge
syn keyword mdpOption Qmmult CASorbitals CASelectrons SH

syn keyword mdpOption implicit_solvent gb_algorithm nstgbradii rgbradii
syn keyword mdpOption gb_epsilon_solvent gb_saltconc gb_obc_alpha gb_obc_beta
syn keyword mdpOption gb_obc_gamma gb_dielectric_offset sa_algorithm
syn keyword mdpOption sa_surface_tension

syn keyword mdpOption user1_grps user2_grps userint1 userint2 userint3 userint4
syn keyword mdpOption userreal1 userreal2 userreal3 userreal4 

syn match mdpComment ";.*$" contains=@Spell

highlight link mdpOption Keyword
highlight link mdpComment Comment
