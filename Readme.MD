Executing terraform0.12 within a env for dev purposes

# build image
docker build -t terraform12 .

# execute within isolated environment
docker  run --rm  -it -v $(pwd)/:/app terraform12 terraform apply

# bash.rc
export TERRAFORM="docker  run --env-file .env --rm  -it -v $(pwd)/:/app terraform12 terraform"

$TERRAFORM init