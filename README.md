# Salesforce DX Project: Next Steps
Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.


## Commands SFDX ##

# Create new scratch org
sf org create scratch -f config/project-scratch-def.json -a ACR36_SFDC -y 30 -v DevHub-Trailhead -w 30 -d -c

# Status org's
sfdx org list

# Authorize a devhub
sfdx force:auth:web:login --setdefaultdevhubusername

# Set default username
sfdx config:set defaultusername=<username>

# Push in scratch org
sfdx force:source:push -f

# Pull in scratch org
sfdx force:source:pull -f

## Commands Git ##

# Clone repositories
git clone <path repository>

# Create new brantch
git checkout -b ＜new-branch＞

# Mudando de brantch
git checkout ＜branchname＞

# Buscar os commits remotos mais recentes
git fetch

# Atualizar um repositorio
git pull

# Verificar o status da brantch
git status

# Add alguns arquivos
git add <file>

# Comitar arquivos adicionados
git commit -m "message"


## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
