## Examples

    $ terraspace cloud var list --type stack --stack=demo
    Showing stack-level variables for acme/main:
    +-----------------------+---------------------+-------------+-----------+
    |         Name          |        Value        |    Kind     | Sensitive |
    +-----------------------+---------------------+-------------+-----------+
    | instance_type         | t3.micro            | terraform   | false     |
    | keypair               | default             | terraform   | false     |
    | AWS_ACCESS_KEY_ID     | fakeSecretAccessKey | environment | false     |
    | AWS_SECRET_ACCESS_KEY | ***                 | environment | true      |
    | AWS_REGION            | us-west-2           | environment | false     |
    | stack_var             | default             | terraform   | false     |
    +-----------------------+---------------------+-------------+-----------+
    $
