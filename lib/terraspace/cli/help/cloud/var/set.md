## Examples

Org and Project level variables:

    terraspace cloud var set NAME1 value1 --type org --kind environment
    terraspace cloud var set NAME2 value3 --type project --kind terraform

Env and stack level variables:

    terraspace cloud var set NAME3 value3 --type stack --stack demo --kind environment
    terraspace cloud var set NAME4 value4 --type env --stack dev --kind terraform
