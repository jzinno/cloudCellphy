# cloudCellphy

Nextflow pipeline for massive-scale single-cell phylogenetics

The pipeline is currently configured to run on a SLURM cluster, but can be easily adapted to other schedulers.

OCI appears to use K8s, and this should be easy to adapt to K8s as well, see [their documentation](https://www.nextflow.io/docs/latest/executor.html#kubernetes). Specifics of running the pipeline on OCI are obviously going to be different, but see `launch.sh` for an example of how to run the pipeline on a SLURM cluster. The basic nextflow command is:

```bash
nextflow workflows/cloudCellphy.nf -with-report report-nextflow-log.html -with-dag flowchart.html -with-timeline timeline.html
```
