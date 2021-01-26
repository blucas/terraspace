## Examples

Org or project level:

    $ terraspace cloud var list --type project
    Showing project-level variables for acme/main:
    +-------------------+-------+-------------+-----------+
    |       Name        | Value |    Kind     | Sensitive |
    +-------------------+-------+-------------+-----------+
    | AWS_ACCESS_KEY_ID | ***   | environment | true      |
    +-------------------+-------+-------------+-----------+
    $

Env level:

    $ terraspace cloud var list --type env
    Showing env-level variables for acme/main:
    +-------+-------+-----------+-----------+
    | Name  | Value |   Kind    | Sensitive |
    +-------+-------+-----------+-----------+
    | NAME2 | value | terraform | false     |
    +-------+-------+-----------+-----------+
    $

Stack level:

    $ terraspace cloud var list --type stack --stack=demo
    Showing stack-level variables for acme/main:
    +-----------------------+---------------------+-------------+-----------+
    |         Name          |        Value        |    Kind     | Sensitive |
    +-----------------------+---------------------+-------------+-----------+
    | instance_type         | t3.micro            | terraform   | false     |
    | keypair               | default             | terraform   | false     |
    | AWS_SECRET_ACCESS_KEY | ***                 | environment | true      |
    | AWS_REGION            | us-west-2           | environment | false     |
    +-----------------------+---------------------+-------------+-----------+
    $
