#requires -Module PSDevOps
Import-BuildStep -SourcePath (
    Join-Path $PSScriptRoot 'GitHub'
) -BuildSystem GitHubWorkflow

Push-Location ($PSScriptRoot | Split-Path)
New-GitHubWorkflow -Name "Build PowerShellWeb" -On Push, Demand -Job  BuildPowerShellWeb -OutputPath .\.github\workflows\BuildPowerShellWeb.yml

Pop-Location