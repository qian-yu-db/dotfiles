# Databricks Workspace Organization Best Practices

Use these guidelines to analyze workspaces and provide improvement recommendations.

---

## Recommended Directory Structure

### Ideal Top-Level Organization

```
/Workspace/Users/<email>/
├── Projects/               # Active project work
│   ├── <project_name>/
│   └── ...
├── Solutions/              # Reusable solution accelerators & repos
├── Experiments/            # MLflow experiments (consolidated)
├── Training/               # Learning materials & certifications
├── Demos/                  # Demo content (dbdemos, etc.)
├── Apps/                   # Databricks Apps
├── Dashboards/             # AI/BI dashboards
├── Utilities/              # Helper notebooks, setup scripts
├── Sandbox/                # Scratch work, quick tests
├── Archive/                # Deprecated/old content
└── README.md               # Workspace documentation
```

### Category Definitions

| Category | Purpose | Retention |
|----------|---------|-----------|
| Projects | Active customer/internal work | Active |
| Solutions | Reference implementations | Permanent |
| Experiments | MLflow tracking | 3-6 months |
| Training | Educational content | As needed |
| Demos | Demo installations | Update periodically |
| Apps | Databricks Apps | Active |
| Dashboards | BI/Analytics dashboards | Active |
| Utilities | Setup, monitoring tools | Permanent |
| Sandbox | Temporary scratch work | Clean weekly |
| Archive | Old/deprecated content | Review quarterly |

---

## Common Anti-Patterns to Identify

### 1. Scattered MLflow Experiments
**Problem:** MLflow experiments at the top level or scattered across directories
**Solution:** Consolidate all experiments into a single `Experiments/` or `mlflow_experiments/` folder
**Command:**
```bash
databricks experiments update-experiment <id> --new-name "/Users/<email>/Experiments/<name>"
```

### 2. Untitled Notebooks
**Problem:** Multiple "Untitled Notebook YYYY-MM-DD" files
**Indicators:** Notebooks with date-based auto-generated names
**Solution:**
- Delete if truly scratch work
- Rename if contains valuable work
- Move to `Sandbox/` if actively used for testing

### 3. Duplicate Demo Installations
**Problem:** Multiple versions of the same demo (e.g., `llm-rag-chatbot_v0`, `_v1`, `_v2`, `_v3`)
**Solution:** Keep only the latest version, archive or delete older versions

### 4. Flat Structure (Too Many Top-Level Items)
**Problem:** More than 15-20 items at the top level
**Solution:** Group related items into categorical folders

### 5. Deep Nesting (Too Many Levels)
**Problem:** More than 3-4 levels of directory nesting
**Solution:** Flatten structure, use naming conventions instead of deep nesting

### 6. Mixed Content Types
**Problem:** Notebooks, repos, experiments, and dashboards mixed together
**Solution:** Separate by type or purpose

### 7. Stale Content
**Problem:** Items not modified in 6+ months
**Indicators:**
- `modified_at` > 6 months old
- Old course materials
- Completed POC work
**Solution:** Archive or delete

### 8. Orphaned System Directories
**Problem:** Empty or unused `.bundle`, `.ide`, cache directories
**Solution:** Generally leave system directories alone, but note if unusually large

---

## Naming Conventions

### Directory Names
- Use `snake_case` or `PascalCase` consistently
- Be descriptive but concise
- Avoid special characters and spaces
- Good: `model_serving`, `LLM_finetuning`, `customer_requests`
- Bad: `New Folder`, `stuff`, `misc`, `test123`

### Notebook Names
- Describe the notebook's purpose
- Include version or date if multiple versions exist
- Good: `train_sentiment_classifier`, `deploy_embedding_model`
- Bad: `Untitled Notebook 2024-01-15`, `test`, `final_v2_FINAL`

### Experiment Names
- Use descriptive names with project context
- Include model type or task
- Good: `customer_churn_xgboost_v2`, `rag_evaluation_gpt4`
- Bad: `test_experiment`, `exp1`, `mlflow_test`

---

## Cleanup Recommendations

### By Age

| Item Type | Recommended Retention | Action |
|-----------|----------------------|--------|
| MLflow Experiments | 3 months | Delete older unless actively used |
| Scratch Notebooks | 1 week | Delete or rename |
| Demo Installations | 6 months | Update to latest version |
| Training Materials | After certification | Archive |
| Customer POC Work | 6 months post-project | Archive |

### By Type

| Type | Review Frequency | Cleanup Action |
|------|-----------------|----------------|
| MLFLOW_EXPERIMENT | Monthly | Delete stale, consolidate location |
| NOTEBOOK (Untitled) | Weekly | Delete or rename |
| REPO | Quarterly | Remove unused clones |
| DASHBOARD | Quarterly | Archive unused |
| DIRECTORY (empty) | Monthly | Delete |

---

## Recommendation Template

When providing recommendations, use this format:

```markdown
## Workspace Organization Recommendations

### High Priority
1. **[Issue]**: [Description]
   - **Impact**: [Why this matters]
   - **Action**: [Specific steps to fix]
   - **Commands**: [CLI commands if applicable]

### Medium Priority
...

### Low Priority (Nice to Have)
...

### Maintenance Schedule
- **Weekly**: [Tasks]
- **Monthly**: [Tasks]
- **Quarterly**: [Tasks]
```

---

## Example Recommendations

### Example 1: Scattered Experiments
```markdown
### High Priority
1. **Scattered MLflow Experiments**: Found 12 MLflow experiments at the top level
   - **Impact**: Difficult to find and manage experiments, cluttered workspace
   - **Action**: Move all experiments to `mlflow_experiments/` folder
   - **Commands**:
     ```bash
     databricks experiments update-experiment 123456 \
       --new-name "/Users/user@company.com/mlflow_experiments/experiment_name"
     ```
```

### Example 2: Stale Content
```markdown
### Medium Priority
2. **Stale Experiments**: 25 experiments older than 3 months
   - **Impact**: Consuming storage, cluttering experiment list
   - **Action**: Review and delete experiments no longer needed
   - **Oldest experiments**:
     - `ift-mistral-7b-instruct-v0-2-6wjr62` (2024-06-22)
     - `ift-mistral-7b-instruct-v0-2-9opue1` (2024-06-23)
```

### Example 3: Naming Issues
```markdown
### Low Priority
3. **Inconsistent Naming**: Mix of snake_case and other conventions
   - **Current**: `Agentic_system`, `Classic_ML`, `db_demos`, `AI_BI`
   - **Recommendation**: Standardize on snake_case or PascalCase
   - **Suggested renames**:
     - `Agentic_system` → `agentic_systems` or `AgenticSystems`
     - `AI_BI` → `ai_bi` or `AIBI`
```

---

## Metrics to Track

When analyzing a workspace, calculate these metrics:

| Metric | Good | Warning | Action Needed |
|--------|------|---------|---------------|
| Top-level items | < 15 | 15-25 | > 25 |
| Untitled notebooks | 0 | 1-3 | > 3 |
| Experiments > 3 months | < 5 | 5-15 | > 15 |
| Empty directories | 0 | 1-2 | > 2 |
| Max nesting depth | ≤ 3 | 4 | > 4 |
| Items without clear purpose | 0 | 1-5 | > 5 |
