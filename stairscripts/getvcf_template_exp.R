source("/home/br450/vcf2sfs/vcf2sfs.r")

mygt<-vcf2gt("/projects/f_mlp195/brendanr/simdir/stairway_exp/i_iteration_allchr_wgs_n_numsamp_c_filter_t0.recode.vcf", "/projects/f_mlp195/brendanr/simdir/stairway_exp/indpopmap_numsamp")

mysfs1<-gt2sfs.raw(mygt, "time0")

mysfs1_fold<- fold.sfs(mysfs1)

write.1D.fsc(mysfs1_fold,"/projects/f_mlp195/brendanr/simdir/stairway_exp/i_iteration_wgs_n_numsamp_filter.sfs")
