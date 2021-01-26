## Examples

Org and Project level variables:

    terraspace cloud var rm NAME1 --type org --kind environment
    terraspace cloud var rm NAME2 --type project --kind environment

Env and stack level variables:

    terraspace cloud var rm NAME3 --type stack --stack demo --kind environment
    terraspace cloud var rm NAME4 --type env --env dev --kind terraform
