#!/bin/bash
EXPERIMENT_HOME_DIR="$PWD"
INPUT_FILE="$EXPERIMENT_HOME_DIR/config/ep-configuration.csv"

echo "Setting up docker keys..."
echo $(./setup/fix-docker-ssh-permissions.sh $DOCKER_CLUSTER_DIR/ssh/id_rsa)

echo "Running experiments from input CSV file..."
sleep 2
OLDIFS=$IFS
IFS=","
while read -u 11 name order number rp environment parallelism block exectime
do
    if [ $name = "name" ]; then
        continue
    fi
    cd "$EXPERIMENT_HOME_DIR"

    if [ $environment = "docker" ]; then
        echo $(./docker-single-run.sh $name $environment $parallelism)
    else # native
        echo $(./native-single-run.sh $name $environment $parallelism)
    fi
    sleep 2
done 11< $INPUT_FILE
IFS=$OLDIFS

echo "Done."
