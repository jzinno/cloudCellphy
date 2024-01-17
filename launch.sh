#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --job-name=nextflow
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=jzinno@nygenome.org
#SBATCH --output=cloudCellphy-log_%j.out


module load anaconda3
module load nextflow/22.10.4
module load singularity/3.8.6

eval "$(conda shell.bash hook)"
conda deactivate

if [ ! -d $PWD/nxf-scratch ]; then
    mkdir $PWD/nxf-scratch
fi

export NXF_TEMP=$PWD/nxf-scratch

#export PATH=$PWD/bin:$PATH

nextflow workflows/cloudCellphy.nf -with-report report-nextflow-log.html -with-dag flowchart.html -with-timeline timeline.html -resume