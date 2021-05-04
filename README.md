# Terraform aws iam s3 demo



Sample use case using Terraform to create AWS IAM User, S3 Bucket & Objects and Policy.  

Reference to `Terraform AWS modules` repositories,   
[https://registry.terraform.io/namespaces/terraform-aws-modules](https://registry.terraform.io/namespaces/terraform-aws-modules)  
[https://github.com/terraform-aws-modules](https://github.com/terraform-aws-modules)


Directory structure used in this demo:
```
.
├── iam.tf
├── main.tf
├── modules
│   ├── iam-user
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── s3
│       ├── bucket
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       └── object
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
├── outputs.tf
└── variables.tf
```

In `main.tf` set aws region, terraform state store, modules to create resources.  
Set default variable values in `variables.tf`.  
`iam.tf` contains sample S3 Policy attached to the user.  

Prerequisites:  
Create and configure resources to store the terraform state, for example: 
```
terraform {
  backend "s3" {
    bucket          = "<tfstate_bucket>"
    key             = "<dir>/<file.tfstate>"
    encrypt         = true
    kms_key_id      = "<alias/key>"
    dynamodb_table  = "<state_lock>"
    region          = "eu-west-1"
  }
}
```

Use [keybase](https://keybase.io/) tool to secure user password.

For instance, use [https://keybase.io/](https://keybase.io/) to store public key then in the user module, set `pgp_key = "keybase:<user>"` reference parameter.

`outputs.tf` prints out `keybase_password_decrypt_command` string.  
Use [https://keybase.io/decrypt](https://keybase.io/decrypt) to decrypt the password. 

```
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.73
Comment: https://keybase.io/crypto

<keybase_password_decrypt_command output string>

wc903ksdf98032idso903= (not actual data)
-----END PGP MESSAGE-----
```


