-- 1. Create a secret for Salesforce credentials
CREATE OR REPLACE SECRET sf_api_creds
  TYPE = GENERIC_STRING
  SECRET_STRING = '{"username":"megtype@yahoo.com", "password":"test", "token":"5aedfghg"}';

-- 2. Define the network rule for Salesforce API
CREATE OR REPLACE NETWORK RULE salesforce_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('megtype-dev-ed.my.salesforce.com');

-- 3. Create the integration
CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION sf_integration
  ALLOWED_NETWORK_RULES = (salesforce_network_rule)
  ALLOWED_AUTHENTICATION_SECRETS = (sf_api_creds)
  ENABLED = TRUE;

CREATE OR REPLACE API INTEGRATION lizagit
   API_PROVIDER = git_https_api
   API_ALLOWED_PREFIXES = ('https://github.com/')
   API_USER_AUTHENTICATION = (
      TYPE = snowflake_github_app
   )
   ENABLED = TRUE;
   
SHOW GIT REPOSITORIES;