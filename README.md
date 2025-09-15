# cloudCellphy

[![Docker Build](https://github.com/jzinno/cloudCellphy/actions/workflows/docker-build.yml/badge.svg)](https://github.com/jzinno/cloudCellphy/actions/workflows/docker-build.yml)

### Nextflow pipeline for massive-scale single-cell phylogenetics

The pipeline is currently configured to run on a SLURM cluster, but can be easily adapted to other schedulers.

The basic nextflow command is:

```bash
nextflow workflows/cloudCellphy.nf
```

## Configuration Parameters

The `nextflow.config` file contains various parameters that control the behavior of the pipeline. Below is an explanation of the key parameters:

### Executor

- **queueSize**: Maximum number of jobs in the queue.
- **submitRateLimit**: Rate limit for job submissions.

### Params

- **joint_vcf**: Path to the joint VCF file.
- **out**: Output directory.
- **sample_id**: Sample identifier.
- **start_tree_type**: Type of starting tree for CellPhy.
- **evo_model**: Evolutionary model for CellPhy.
- **prob_msa**: Enables probabilistic multiple sequence alignment.
- **lh_epsilon**: Likelihood epsilon value.
- **n_tree_search**: Number of tree searches.
- **n_bootstrap_search**: Number of bootstrap searches.
- **bs_trees_per_job**: Number of bootstrap trees per job.
- **bs_metric**: Metrics for bootstrap analysis.
- **tree_threads**: Number of threads for tree computation.
- **tree_memory**: Memory allocated for tree computation.

### Run Time

$N$ is the number of maximum likelihood tree searches.

$t_i$ is the time to compute the $i$-th maximum likelihood tree.

$P$ is the number of workers.

#### Sequential execution time

$$
T_{\text{serial}} = \sum_{i=1}^{N} t_i
$$

#### Bounded parallel execution time with P workers

$$
T_{P} \approx \frac{1}{P} \sum_{i=1}^{N} t_i \;+\; \text{tail effects}
$$

#### Fully parallel execution time (unlimited concurrency)

$$
T_{\text{parallel}} = \max_{1 \leq i \leq N} \, t_i
$$
