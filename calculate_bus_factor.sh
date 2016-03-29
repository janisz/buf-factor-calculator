cat top_repos.txt | while read repo
do
        export repo=$repo
        export REPO_DATA_DIR=./data/repos/$repo
        python ./bus_factor_calculator.py >> ./bus_factor.csv
done
