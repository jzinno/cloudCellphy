process MLSearchCellPhy {
    if ("${workflow.stubRun}" == "false") {
        memory ${params.tree_memory}
        cpus ${params.tree_threads}
        queue 'pe2'
    }
    tag "tree-search"

    publishDir "${params.out}/cellphy/mltrees", mode: 'symlink'

    input:
    path(phylo_vcf)
    each tree_search_idx

    output:
    tuple path("${phylo_vcf.simpleName}.CellPhy.${tree_search_idx}.raxml.bestTree"), path("loglikelihood.${tree_search_idx}.txt")


    script:
    """
    raxml-ng-cellphy-linux \
        --search \
        --seed \$RANDOM \
        --msa ${phylo_vcf} \
        --model GTGTR4+G+FO \
        --msa-format VCF \
        --threads ${task.cpus} \
        --prefix ${phylo_vcf.simpleName}.CellPhy.${tree_search_idx} \
        --tree ${params.start_tree_type}{1} \

    loglikelihood=\$(grep "Final LogLikelihood" ${phylo_vcf.simpleName}.CellPhy.${tree_search_idx}.raxml.log | awk '{print \$3}')
    echo \$loglikelihood > loglikelihood.${tree_search_idx}.txt

    """
    stub:
    """
    touch ${phylo_vcf.simpleName}.CellPhy.${tree_search_idx}.raxml.bestTree
    awk -v seed=\$RANDOM 'BEGIN{srand(seed);print -rand()}' > loglikelihood.${tree_search_idx}.txt
    """

}

process BootstrapsCellPhy {
    if ("${workflow.stubRun}" == "false") {
        memory ${params.tree_memory}
        cpus ${params.tree_threads}
        queue 'pe2'
    }
    tag "tree-validation"

    publishDir "${params.out}/cellphy/bootstraps", mode: 'symlink'

    input:
    tuple path(phylo_vcf), path(best_tree), val(bootstrap_search_idx)

    output:
    path("${phylo_vcf.simpleName}.CellPhy.${bootstrap_search_idx}.raxml.bootstraps")


    script:
    """
    raxml-ng-cellphy-linux \
        --bootstrap \
        --seed \$RANDOM \
        --msa ${phylo_vcf} \
        --model GTGTR4+G+FO \
        --msa-format VCF \
        --threads ${task.cpus} \
        --prefix ${phylo_vcf.simpleName}.CellPhy.${bootstrap_search_idx} \
        --bs-trees ${params.bs_trees_per_job} \
        --bs-metric tbe,fbp \


    """
    stub:
    """
    touch ${phylo_vcf.simpleName}.CellPhy.${bootstrap_search_idx}.raxml.bootstraps
    """

}

process SupportCellPhy {
    if ("${workflow.stubRun}" == "false") {
        memory '8 GB'
        cpus 4
        queue 'pe2'
    }
    tag "tree-support"

    publishDir "${params.out}/cellphy/support", mode: 'symlink'

    input:
    path(best_tree)
    path(all_bootstraps)

    output:
    path("${best_tree.simpleName}.CellPhy.raxml.support")


    script:
    """

    raxml-ng-cellphy-linux \
        --support \
        --threads ${task.cpus} \
        --tree ${best_tree} \
        --prefix ${best_tree.simpleName}.CellPhy \
        --bs-trees ${all_bootstraps} \


    """
    stub:
    """
    touch ${best_tree.simpleName}.CellPhy.raxml.support
    """

}