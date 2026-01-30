# Databricks Workspace README Template

Use this template structure when generating workspace documentation.

---

## Template Structure

```markdown
# Databricks Workspace Organization

**Owner:** <user_email>
**Workspace Path:** `<workspace_path>`
**Last Updated:** <YYYY-MM-DD>

---

## Directory Structure Overview

[ASCII tree showing top-level structure]

```
/Workspace/Users/<email>/
├── <directory_1>/          # Brief description
├── <directory_2>/          # Brief description
├── ...
└── .<system_directory>/    # (System) description
```

---

## Detailed Directory Breakdown

### 1. <Directory Name>/
**Purpose:** <One sentence describing the directory's purpose>

| Item | Type | Description |
|------|------|-------------|
| `item_name` | Type | Description |
| ... | ... | ... |

[Repeat for each major directory]

---

## Statistics

| Metric | Count |
|--------|-------|
| Total Directories | X |
| Total Notebooks | X |
| Total Repos | X |
| MLflow Experiments | X |
| Dashboards | X |

---

## MLflow Experiments

| Experiment | Created | Last Updated | Category |
|------------|---------|--------------|----------|
| `experiment_name` | YYYY-MM-DD | YYYY-MM-DD | Category |
| ... | ... | ... | ... |

---

## Maintenance Notes

### Cleanup Policy
- **MLflow Experiments:** [Describe cleanup policy, e.g., "Experiments older than 3 months are periodically deleted"]
- **Last Cleanup:** <YYYY-MM-DD> (<description of what was cleaned>)

### Recent Organization Changes
1. <Change description and date>
2. ...

---

## Quick Reference

| Task | Location |
|------|----------|
| <Common task> | `<directory>/` |
| ... | ... |
```

---

## Section Guidelines

### Directory Structure Overview
- Use ASCII tree format for visual clarity
- Include brief inline comments for each directory
- Mark system directories with "(System)"
- Keep descriptions to 3-5 words

### Detailed Directory Breakdown
- Number directories for easy reference
- Include "Purpose" statement for each
- Use tables for contents when there are multiple items
- Include timestamps where available
- Note language for notebooks (PYTHON, SQL, SCALA)
- Distinguish between DIRECTORY, REPO, NOTEBOOK, MLFLOW_EXPERIMENT, DASHBOARD, FILE

### Timestamp Formatting
- Always use YYYY-MM-DD format
- Include both created_at and modified_at when available
- Note if timestamps are unavailable for certain item types

### Statistics Section
- Count items by type
- Include counts for nested items
- Note unique counts (e.g., "22 unique customers")

### Quick Reference
- Map common tasks to locations
- Use imperative form ("Deploy a model" not "Model deployment")
- Include 5-10 most common tasks

---

## Example Sections

### Example Directory Breakdown

```markdown
### 3. model_serving/
**Purpose:** Model deployment, serving, and inference optimization

| Notebook | Created | Modified | Description |
|----------|---------|----------|-------------|
| `1. Determine Optimal Concurrency` | 2024-08-26 | 2025-12-30 | Concurrency optimization |
| `chat-batch-inference-udf` | 2024-08-26 | 2025-12-30 | Chat batch inference |
| `deploy-mlflow-pyfunc-model-serving` | 2024-09-04 | 2025-12-30 | PyFunc model deployment |

**Subdirectories:**
- `ai_gateway/` - AI Gateway configurations
- `peft_train_merge_deploy/` - PEFT training and deployment
```

### Example Quick Reference

```markdown
## Quick Reference

| Task | Location |
|------|----------|
| Fine-tune an LLM | `LLM_finetuning_and_SGC/` |
| Deploy a model | `model_serving/` |
| Build an agent | `Agentic_system/` |
| Batch LLM inference | `LLM_batch_workflow/` |
| Classic ML examples | `Classic_ML/` |
| Customer work | `customer_requests/<customer>/` |
| Demo content | `db_demos/` |
| Training materials | `internal_training/` |
| Quick experiments | `Sandbox/_scratch` |
```
