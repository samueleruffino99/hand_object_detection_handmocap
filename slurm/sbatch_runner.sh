#!/bin/bash

#SBATCH  --output=log_slurm/%j.out
#SBATCH  --error=log_slurm/%j.err
#SBATCH  --gres=gpu:1
#SBATCH  --mem=30G
#SBATCH  --job-name=handobjdet

# Exit on errors
set -o errexit

# # Set a directory for temporary files unique to the job with automatic removal at job termination
# TMPDIR=/itet-stor/sruffino/net_scratch/dev/mixformer/log_slurm/cache
# TMPDIR=$(mktemp -d)
# if [[ ! -d ${TMPDIR} ]]; then
#     echo 'Failed to create temp directory' >&2
#     exit 1
# fi
# trap "exit 1" HUP INT TERM
# trap 'rm -rf "${TMPDIR}"' EXIT
# export TMPDIR

# # Change the current directory to the location where you want to store temporary files, exit if changing didn't succeed.
# Adapt this to your personal preference
# cd "${TMPDIR}" || exit 1

# Send some noteworthy information to the output log
echo "Running on node:    $(hostname)"
echo "In directory:       $(pwd)"
echo "Starting on:        $(date)"
echo "SLURM_JOB_ID:       ${SLURM_JOB_ID}"
nvcc --version

# Export path for pip packages python
# export PYTHONPATH=/usr/itetnas04/data-scratch-01/sruffino/data/conda_envs/mixformer/lib/python3.6/site-packages:$PYTHONPATH

# export PYTHONPATH=/scratch_net/biwidl304/${USER}/local/lib/python3.6/site-packages:$PYTHONPATH
# export PYTHONUSERBASE=/scratch_net/biwidl304/$USER/local PATH=$PYTHONUSERBASE/bin:$PATH
# export PYTHONPATH=$PYTHONPATH:/scratch_net/biwidl304/${USER}/local/lib/python3.6/site-packages
# export PYTHONPATH=/itet-stor/sruffino/net_scratch/conda_envs/mixformer/lib/python3.6/site-packages:$PYTHONPATH

# Run the script
source /itet-stor/sruffino/net_scratch/conda/etc/profile.d/conda.sh
conda activate handobjdet

python get_cuda_capability.py
# Build packages
cd lib
python setup.py build develop
cd ..

# Run script
echo "Running python script"
CUDA_VISIBLE_DEVICES=0 python demo.py --cuda --checkepoch=8 --checkpoint=132028

# Send more noteworthy information to the output log
echo "Finished at:     $(date)"

# End the script with exit code 0
exit 0