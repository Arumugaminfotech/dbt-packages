#!/bin/bash
date
echo "This job creates a database using a seed and then runs the dbt job"


if [ $# -eq 0 ]; then
    echo "No models were specified. Executing all models"
    dbt run --profiles-dir .
else
    echo "Executing only specified models"
    dbt run --profiles-dir . -m $@
fi