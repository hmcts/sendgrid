# Azure SendGrid

This repository provisions SendGrid sub user accounts in our manually created SendGrid accounts, 'sendgridnonprod' and 'sendgridprod', provisioned through the [Azure marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/sendgrid.sendgrid).

## Setting up a new account

Each team can create a non-production and a production account.  Accounts are created as subusers under the respective non-production and production accounts.

Accounts are created with an 'hmcts-' prepended to avoid name clashes.

### Accounts default

The central primary accounts are Silver tier and all sub-accounts created have the same tier.

An account password is automatically generated during account creation and stored in the SendGrid Key Vault.


## Setting up DMARC

[DMARC](https://en.wikipedia.org/wiki/DMARC) is required to authenticate that we own the domain that is being sent from.

### Choose a from address

You need to select a domain for your from address in non-production and production.

The standard pattern is:

* mail-your-product-nonprod.platform.hmcts.net
* mail-your-product.platform.hmcts.net

You may also serve your production domain from `service.gov.uk` if you have one.

e.g.

* mail.your-service.service.gov.uk 

### Setup in SendGrid portal

1. Make sure the new account you are setting up has correct domain name and zone name, check other accounts as examples (e.g. access-management.tf)

2. Once changes has been mereged and the pipeline applies them successfully, please follow below steps.

    a. Log in at https://app.sendgrid.com. Username is "hmcts-<name-specified-in-configuration>". Retrieve password from vault.
    
    b. Browse to Settings --> Sender Authentication on the left side of the menu
    
    c. Then tick 'I've added these records.' and click 'Verify'.

If successful then DMARC is all setup.

## API key

SendGrid requires an API key for sending emails through it.

An API key is automatically created for you when the account is created and stored in the SendGrid Key Vault. The key has restricted access with 'Mail Send' permission allowed.

The API key name format is `hmcts-<account-name>-api-key`


### Getting the key from the application

The API key should be read from Key Vault via terraform.

See example [SSCS pull request](https://github.com/hmcts/sscs-evidence-share/pull/710),
note a mistake was made initially and the password was used instead of the API key, corrected in [PR#713](https://github.com/hmcts/sscs-evidence-share/pull/713).

