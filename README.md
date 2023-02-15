# trailhed.sfdc
This repository is intended for trailhead learning and skill improvement.


## DX Development Flow

1. Create the scratch org:

sfdx org create scratch --definition-file config/project-scratch-def.json --wait 30 --alias [aliasname] --target-dev-hub [DevHub]

- Example:
sfdx org create scratch --definition-file config/project-scratch-def.json --wait 30 --alias SFDC-LWC --target-dev-hub TrailHead

2. Upload code to your newly created scratch org:

sfdx force:source:push -u [aliasname]

3. Give Marketplace Admin permission to default user

sfdx force:user:permset:assign -n Marketplace_Admin -u [aliasname]

4. Open scratch org to make your adjustments and make your code

sfdx force:org:open -u [aliasname]

5. Update your code with the changes made to the Org:

sfdx force:source:pull -u [aliasname]
