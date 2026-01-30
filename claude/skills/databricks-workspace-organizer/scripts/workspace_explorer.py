#!/usr/bin/env python3
"""
Databricks Workspace Explorer

Explores a Databricks workspace directory and outputs comprehensive information
about its structure, contents, and metadata.

Usage:
    python3 workspace_explorer.py --path "/Workspace/Users/user@company.com/" --profile DEFAULT
"""

import argparse
import json
import subprocess
import sys
from datetime import datetime
from collections import defaultdict


def run_databricks_cli(args: list, profile: str) -> dict | list | None:
    """Run a Databricks CLI command and return parsed JSON output."""
    cmd = ["databricks"] + args + ["--profile", profile, "--output", "json"]
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        if result.stdout.strip():
            return json.loads(result.stdout)
        return None
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {' '.join(cmd)}", file=sys.stderr)
        print(f"stderr: {e.stderr}", file=sys.stderr)
        return None
    except json.JSONDecodeError:
        return None


def format_timestamp(ts_ms: int | None) -> str | None:
    """Convert millisecond timestamp to YYYY-MM-DD format."""
    if ts_ms is None:
        return None
    return datetime.fromtimestamp(ts_ms / 1000).strftime("%Y-%m-%d")


def explore_directory(path: str, profile: str, depth: int = 0) -> dict:
    """Recursively explore a workspace directory."""
    result = {
        "path": path,
        "name": path.rstrip("/").split("/")[-1],
        "items": [],
        "summary": defaultdict(int),
    }

    items = run_databricks_cli(["workspace", "list", path], profile)
    if not items:
        return result

    for item in items:
        item_info = {
            "name": item["path"].split("/")[-1],
            "path": item["path"],
            "type": item.get("object_type", "UNKNOWN"),
            "language": item.get("language"),
            "created_at": format_timestamp(item.get("created_at")),
            "modified_at": format_timestamp(item.get("modified_at")),
            "size": item.get("size"),
        }

        result["summary"][item_info["type"]] += 1

        # For directories, optionally recurse (limit depth to avoid too much output)
        if item_info["type"] == "DIRECTORY" and depth < 1:
            # Skip system directories
            if not item_info["name"].startswith("."):
                sub_result = explore_directory(item["path"], profile, depth + 1)
                item_info["contents"] = sub_result["items"]
                item_info["summary"] = dict(sub_result["summary"])

        result["items"].append(item_info)

    return result


def get_mlflow_experiments(path: str, profile: str) -> list:
    """Get MLflow experiments under a specific path with timestamps."""
    experiments = []

    # List all experiments
    all_experiments = run_databricks_cli(["experiments", "list-experiments"], profile)
    if not all_experiments:
        return experiments

    # Filter to those under the specified path
    # Convert workspace path to experiment path format
    exp_path_prefix = path.replace("/Workspace", "")

    for exp in all_experiments:
        if exp.get("name", "").startswith(exp_path_prefix):
            experiments.append({
                "name": exp["name"].split("/")[-1],
                "full_path": exp["name"],
                "experiment_id": exp.get("experiment_id"),
                "created_at": format_timestamp(exp.get("creation_time")),
                "last_updated": format_timestamp(exp.get("last_update_time")),
                "lifecycle_stage": exp.get("lifecycle_stage"),
            })

    return experiments


def analyze_workspace(path: str, profile: str) -> dict:
    """Perform comprehensive workspace analysis."""
    print(f"Exploring workspace: {path}", file=sys.stderr)
    print(f"Using profile: {profile}", file=sys.stderr)

    # Explore directory structure
    structure = explore_directory(path, profile)

    # Get MLflow experiments with timestamps
    experiments = get_mlflow_experiments(path, profile)

    # Calculate totals
    total_summary = defaultdict(int)
    for item in structure["items"]:
        total_summary[item["type"]] += 1
        if "summary" in item:
            for item_type, count in item["summary"].items():
                total_summary[item_type] += count

    return {
        "workspace_path": path,
        "profile": profile,
        "analyzed_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "structure": structure,
        "mlflow_experiments": experiments,
        "total_summary": dict(total_summary),
    }


def main():
    parser = argparse.ArgumentParser(
        description="Explore Databricks workspace and output structure information"
    )
    parser.add_argument(
        "--path",
        required=True,
        help="Workspace path to explore (e.g., /Workspace/Users/user@company.com/)",
    )
    parser.add_argument(
        "--profile",
        default="DEFAULT",
        help="Databricks CLI profile to use (default: DEFAULT)",
    )
    parser.add_argument(
        "--output",
        choices=["json", "summary"],
        default="json",
        help="Output format (default: json)",
    )

    args = parser.parse_args()

    result = analyze_workspace(args.path, args.profile)

    if args.output == "json":
        print(json.dumps(result, indent=2))
    else:
        # Summary output
        print(f"\nWorkspace: {result['workspace_path']}")
        print(f"Analyzed: {result['analyzed_at']}")
        print(f"\nTotal Items by Type:")
        for item_type, count in sorted(result["total_summary"].items()):
            print(f"  {item_type}: {count}")
        print(f"\nMLflow Experiments: {len(result['mlflow_experiments'])}")
        print(f"\nTop-level directories: {len(result['structure']['items'])}")


if __name__ == "__main__":
    main()
