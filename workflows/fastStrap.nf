include { BootstrapsCellPhy;SupportCellPhy } from '../modules/phylo'

workflow {
    Channel
        .fromPath( params.joint_vcf )
        .set  { joint_vcf }
    Channel
        .fromPath( params.best_tree )
        .set  { best_tree }
    Channel
        .of( 1..params.n_bootstrap_search )
        .set { bootstrap_idx }
    joint_vcf
        .combine(best_tree)
        .combine(bootstrap_idx)
        .set { inputs_for_bootstrap }
    BootstrapsCellPhy( inputs_for_bootstrap )
    BootstrapsCellPhy
        .out
        .collectFile( name: 'allBootstraps.txt', newLine: true )
        .set { all_bootstraps }
    SupportCellPhy( best_tree, all_bootstraps)
}