# 3Edges developer install

1) Make sure your AWS is configured with your user credentials
    - aws configure

2) Terraform commands:
    - To start the project

        ```terraform init```

    - To validate the main.tf

        ```terraform validate```

    - To generate an action plan

        ```terraform plan -out=plan.bkp```

    - Apply the selected plan

        ```terraform apply plan.bkp```

    - Destroy everything

        ```terraform destroy -auto-approve```

# Documentation