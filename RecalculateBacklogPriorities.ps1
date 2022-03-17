# ----------- Prerequisites -----------
# Querying Azure DevOps requires the Azure CLI with the azure-devops extension to be installed!
# see https://docs.microsoft.com/en-us/cli/azure/ to get the CLI 
# and https://github.com/Azure/azure-devops-cli-extension on how to activate the azure-devops extension
#
# You also need to be logged in, so run `az login` once before executing this script.


# ----------- Setup section -----------

# If $true, work items will not be changed in AZD but you can see a preview of what _would_ be done
$dryRun = $true

# Your organization URL (without any project, so the first part of https://dev.azure.com/your-org/your-project/_workitems/assignedtome/)
$org = https://dev.azure.com/your-organization
# Iteration path of the sprint (open any work item in the sprint to find out)
$iteration = 'project\sprint\2022-03'
# All work items in the given iteration will get a priority that is lower or equal to this value
$maxPrio = 999999

# If $true, then a log of the transactions will be writtn in addition to the console output ({timestamp}-backlog_prio_update.log)
$writeLog = $true

# -------------------------------------


function RecalculateBacklogPriorities {
  # Get all work items from the given sprint that are new and have a backlog priority assigned
  $wiql = "SELECT [Microsoft.VSTS.Common.BacklogPriority] FROM workitems WHERE " + 
  "[System.IterationPath] = '$iteration' AND " +
  "[System.State] = 'New' AND " + 
  "[System.WorkItemType] IN ('Bug', 'Product Backlog Item') AND " + 
  "[Microsoft.VSTS.Common.BacklogPriority] > 0 " + 
  "ORDER BY [Microsoft.VSTS.Common.BacklogPriority]"

  
  # The result will be parsed from JSON into PowerShell objects
  $workitems = (az boards query --organization $org --wiql $wiql | ConvertFrom-Json | Select-Object -Property id -ExpandProperty fields) 

  $count = $workitems.Count
  $stepSize = $maxPrio / $count

  if ($dryRun) {
    "`nSIMULATING backlog priority update of $count work items in $iteration... (set dryRun to false if you want to update the work items in AZD)`n"
    # Write CSV header
    "Count;ID;OldPrio;NewPrio"
  }
  else {
    "`nUPDATING backlog priority of $count work items in $iteration...`n"
  }
  
  $i = 1
  foreach ($workitem in $workitems) {
    $id = $workitem.id
    $oldPrio = $workitem.'Microsoft.VSTS.Common.BacklogPriority'
    $newPrio = [math]::Floor($stepSize * $i)

    if ($dryRun) {
      # Write CSV line
      "$i;$id;$oldPrio;$newPrio"
    }
    else {
      # Actually update work item
      az boards work-item update --organization $org --id $id --fields Microsoft.VSTS.Common.BacklogPriority=$newPrio
    }

    $i++
  }
}

if ($writeLog) {
  $logfilePath = "$((Get-Date).ToString('yyyyMMddTHHmmss'))-backlog_prio_update.log"
  RecalculateBacklogPriorities | Tee-Object -FilePath $logfilePath
}
else {
  RecalculateBacklogPriorities
}
