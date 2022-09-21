### Create or download templates

1. Download the template [here](https://github.com/Azure/prometheus-collector/blob/main/mixins/kubernetes/rules/recording_and_alerting_rules/templates/ci_recommended_alerts.json) and save it as **ci_recommended_alerts.json**.

2. Download the parameter file [here](https://github.com/Azure/prometheus-collector/blob/soham/armParametersJson/mixins/kubernetes/rules/recording_and_alerting_rules/templates/ci_recommended_alert_parameters.json) and save it as **ci_recommended_alert_parameters.json**.

3. Edit the values in the parameter file.

  - For **clusterName** , use the values on the **AKS Overview** page for the AKS cluster.
  - For **location**, use the values on the **Azure Monitor workspace Overview** page for the Azure Monitor workspace. 
  - For **actionGroupResourceId**, use the value on the **Action Groups Overview under Alerts** page.
  - For **macResourceId**, use the values on the **Azure Monitor workspace Properties** page for the Azure Monitor workspace. 
  
### Deploy template

If you are unfamiliar with the concept of deploying resources by using a template, see:

* [Deploy resources with Resource Manager templates and Azure PowerShell](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-powershell)
* [Deploy resources with Resource Manager templates and the Azure CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-cli)

If you choose to use the Azure CLI, you first need to install and use the CLI locally. You must be running the Azure CLI version 2.0.59 or later. To identify your version, run `az --version`. If you need to install or upgrade the Azure CLI, see [Install the Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).

#### To deploy with Azure PowerShell:

`
New-AzResourceGroupDeployment -Name <OnboardCluster> -ResourceGroupName <ResourceGroupName> -TemplateFile .\ci_recommended_alerts.json -TemplateParameterFile .\ci_recommended_alert_parameters.json
`

The configuration change can take a few minutes to complete. When it's completed, a message is displayed that's similar to the following and includes the result:

<pre>
    "provisioningState": "Succeeded",
    "templateHash": "17855828164304086384",
    "templateLink": null,
    "timestamp": "2022-09-21T20:37:28.846403+00:00",
    "validatedResources": null
  },
  "resourceGroup": "sohamTestKV",
  "tags": null,
  "type": "Microsoft.Resources/deployments"
</pre>

#### To deploy with Azure CLI, run the following commands:

<pre>
az login
az account set --subscription "Subscription Name"
az deployment group create --resource-group "ResourceGroupName" --template-file ci_recommended_alerts.json --parameters ci_recommended_alert_parameters.json
</pre>

The configuration change can take a few minutes to complete. When it's completed, a message is displayed that's similar to the following and includes the result:

<pre>
    "provisioningState": "Succeeded",
    "templateHash": "17855828164304086384",
    "templateLink": null,
    "timestamp": "2022-09-21T20:37:28.846403+00:00",
    "validatedResources": null
  },
  "resourceGroup": "sohamTestKV",
  "tags": null,
  "type": "Microsoft.Resources/deployments"
</pre>

#### To deploy with Azure CLI, using inline parameters, run the following commands:
To know more about inline parameters while deploying cli, follow [this](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-cli).

<pre>
az login
az account set --subscription "Subscription Name"
az deployment group create --resource-group "ResourceGroupName" --template-file ci_recommended_alerts.json --parameters clusterName='Cluster Name' actionGroupResourceId='action group resource id' macResourceId='mac resource id' location='mac location'
</pre>

The configuration change can take a few minutes to complete. When it's completed, a message is displayed that's similar to the following and includes the result:

<pre>
    "provisioningState": "Succeeded",
    "templateHash": "17855828164304086384",
    "templateLink": null,
    "timestamp": "2022-09-21T20:37:28.846403+00:00",
    "validatedResources": null
  },
  "resourceGroup": "sohamTestKV",
  "tags": null,
  "type": "Microsoft.Resources/deployments"
</pre>