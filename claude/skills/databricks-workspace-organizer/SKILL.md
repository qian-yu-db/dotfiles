---
name: databricks-workspace-organizer
description: >
  Generate comprehensive README documentation for Databricks workspace directories and provide
  organization recommendations. This skill should be used when users want to document their
  Databricks workspace structure, audit workspace contents, get file organization recommendations,
  or create workspace status reports. Trigger phrases include "document my workspace",
  "organize my databricks workspace", "workspace status", "workspace README", "audit workspace",
  "workspace organization recommendations". Requires Databricks CLI configured with a valid profile.
---

# Databricks Workspace Organizer

Generate comprehensive documentation and organization recommendations for Databricks workspaces.

## Prerequisites

- Databricks CLI installed and configured
- Valid Databricks profile in `~/.databrickscfg`
- Workspace read permissions

## Workflow

### Step 1: Identify Target Workspace

Determine the workspace path and profile to use:

```bash
# Default user workspace path pattern
/Workspace/Users/{email}/

# List available profiles
cat ~/.databrickscfg | grep '\['
```

If user doesn't specify a profile, use `DEFAULT`. If user doesn't specify a path, ask for their email to construct the workspace path.

### Step 2: Explore Workspace Structure

Use the workspace explorer script to gather comprehensive information:

```bash
python3 scripts/workspace_explorer.py --path "{workspace_path}" --profile {profile_name}
```

The script outputs JSON with:
- Directory structure
- Item types (NOTEBOOK, DIRECTORY, REPO, MLFLOW_EXPERIMENT, DASHBOARD, FILE)
- Timestamps (created_at, modified_at) where available
- Item counts by type

If the script is unavailable, manually explore using Databricks CLI:

```bash
# List workspace contents with JSON output for timestamps
databricks workspace list "{path}" --profile {profile} --output json

# Get detailed status of specific items
databricks workspace get-status "{item_path}" --profile {profile}

# Get MLflow experiment details (includes timestamps)
databricks experiments get-by-name "{experiment_path}" --profile {profile}
```

### Step 3: Analyze Each Directory

For each top-level directory, gather:

1. **Contents**: List all items within
2. **Purpose**: Infer from naming and contents
3. **Item Types**: Count of notebooks, repos, experiments, etc.
4. **Timestamps**: Creation and modification dates where available
5. **Subdirectories**: Note nested structure

Group directories by category:
- **GenAI/Agents**: Agent development, LLM workflows
- **ML/Models**: Traditional ML, model serving, experiments
- **Data Engineering**: Pipelines, ETL, streaming
- **Solutions/Demos**: Reference implementations, demos
- **Customer Work**: Customer-specific projects
- **Training**: Educational materials
- **Utilities**: Setup, monitoring, scratch
- **Archive**: Deprecated content

### Step 4: Generate README

Create a comprehensive README following the template in `references/readme_template.md`.

Key sections to include:
1. **Header**: Owner, path, last updated date
2. **Directory Tree**: ASCII tree structure overview
3. **Detailed Breakdown**: Each directory with contents, timestamps, descriptions
4. **Statistics**: Item counts, experiment counts, customer counts
5. **Maintenance Notes**: Cleanup policies, recent changes
6. **Quick Reference**: Task-to-location mapping

### Step 5: Provide Organization Recommendations

Analyze the workspace and provide recommendations based on `references/organization_best_practices.md`.

Common recommendations:
- **Consolidation**: Merge similar directories
- **Naming**: Standardize naming conventions
- **Cleanup**: Identify stale experiments, old notebooks
- **Structure**: Suggest folder hierarchy improvements
- **Archive**: Recommend items to archive

### Step 6: Upload README (Optional)

If user requests, upload the README to the workspace:

```bash
databricks workspace import "{workspace_path}/WORKSPACE_README.md" \
  --file {local_readme_path} \
  --format AUTO \
  --profile {profile}
```

## MLflow Experiment Management

### List Experiments

```bash
databricks experiments list-experiments --profile {profile} --output json
```

### Move Experiments

To move an experiment to a different folder, rename it:

```bash
databricks experiments update-experiment {experiment_id} \
  --new-name "/Users/{email}/{new_folder}/{experiment_name}" \
  --profile {profile}
```

### Delete Old Experiments

To clean up experiments older than N days:

```bash
databricks experiments delete-experiment {experiment_id} --profile {profile}
```

## Output Format

The generated README should be:
- Markdown formatted
- Include tables for structured data
- Use code blocks for paths and commands
- Include timestamps in YYYY-MM-DD format
- Be comprehensive but scannable

## Example Usage

```
User: "Document my Databricks workspace and give me organization recommendations"
User: "Generate a README for /Workspace/Users/john@company.com/ using the PROD profile"
User: "What's the current state of my workspace? How can I organize it better?"
User: "Clean up my MLflow experiments older than 3 months and document what's left"
```
