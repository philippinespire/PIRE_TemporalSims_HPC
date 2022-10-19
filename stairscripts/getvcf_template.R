source("/home/br450/vcf2sfs/vcf2sfs.r")

mygt<-vcf2gt("/scratch/br450/SLiM_ped_g1/simdir/stairway/i_iteration_allchr_wgs_n_numsamp_c_filter_t0.recode.vcf", "/scratch/br450/SLiM_ped_g1/simdir/stairway/indpopmap_numsamp")

mysfs1<-gt2sfs.raw(mygt, "time0")

mysfs1_fold<- fold.sfs(mysfs1)

write.1D.fsc(mysfs1_fold,"/scratch/br450/SLiM_ped_g1/simdir/stairway/i_iteration_wgs_n_numsamp_filter.sfs")
