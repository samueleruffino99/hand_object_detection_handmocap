#!/bin/bash
srun --time $1 --partition=gpu.debug --gres=gpu:1 --pty bash -i