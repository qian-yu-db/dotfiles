---
name: databricks-deploy
description: Deploy Databricks apps and bundles with pre-flight checks. Verifies auth profiles, service principals, and prerequisites before deployment. Automates the deploy-check-diagnose-fix loop to reduce debugging cycles.
license: Apache-2.0
---

# Databricks Deploy Skill

Use this skill when deploying Databricks apps or asset bundles. This skill enforces a pre-flight checklist to avoid the common auth/config failures.

## Pre-Flight Checklist

Before any deployment, run these checks in order:

1. **Verify auth profile**:
   ```bash
   databricks auth profiles
   ```
   Confirm the active profile points to the correct workspace.

2. **Check current identity**:
   ```bash
   databricks current-user me
   ```
   Verify you're authenticated as the expected user/service principal.

3. **Validate config files**:
   - For apps: check `app.yaml` exists and has correct settings
   - For bundles: check `databricks.yml` is valid with `databricks bundle validate`

4. **Check target resources exist**:
   - Catalog/schema for Unity Catalog resources
   - Model serving endpoints if referenced
   - Vector Search endpoints if referenced

## Deployment

After pre-flight passes:

```bash
# For apps
databricks apps deploy <app-name>

# For bundles
databricks bundle deploy -t <target>
```

## Post-Deploy Verification

1. Check status:
   ```bash
   databricks apps get <app-name>
   ```

2. If not RUNNING after 60s, fetch logs:
   ```bash
   databricks apps logs <app-name>
   ```

3. Common failure patterns:
   - **503 errors**: Usually auth/service principal issues. Check app permissions.
   - **ModuleNotFoundError**: Missing dependency in requirements.txt
   - **Credential errors**: Service principal needs correct OAuth scopes

## Troubleshooting Loop

If deployment fails:
1. Read the error logs
2. Identify root cause (do NOT guess — match against known patterns above)
3. Apply minimal fix
4. Redeploy
5. If same error after 2 attempts, stop and present findings to user
