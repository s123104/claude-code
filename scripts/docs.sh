#!/usr/bin/env bash
set -euo pipefail

# docs.sh — 維護與測試本地中文鏡像文檔（單一 .sh 整合版）
# 用法：
#   bash scripts/docs.sh maintain   # 僅更新鏡像 README 索引
#   bash scripts/docs.sh update-main # 同步主手冊的「本地鏡像索引（繁中）」區塊
#   bash scripts/docs.sh test       # 僅執行驗證測試
#   bash scripts/docs.sh all        # maintain → update-main → test（預設）

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOCS_DIR="$ROOT_DIR/docs/anthropic-claude-code-zh-tw"
README_PATH="$DOCS_DIR/README.md"
MAIN_DOC_PATH="$ROOT_DIR/claude-code-zh-tw.md"

run_maintain() {
  echo "[maintain] Updating README index..."
  DOCS_DIR="$DOCS_DIR" python3 - <<'PY'
import os
from pathlib import Path
from typing import List

DOCS_DIR = Path(os.environ["DOCS_DIR"]).resolve()
README_PATH = DOCS_DIR / "README.md"

ORDER = [
    "overview.md",
    "quickstart.md",
    "common-workflows.md",
    "sdk.md",
    "sub-agents.md",
    "hooks-guide.md",
    "github-actions.md",
    "mcp.md",
    "troubleshooting.md",
    "third-party-integrations.md",
    "amazon-bedrock.md",
    "google-vertex-ai.md",
    "corporate-proxy.md",
    "llm-gateway.md",
    "devcontainer.md",
    "setup.md",
    "iam.md",
    "security.md",
    "monitoring-usage.md",
    "costs.md",
    "analytics.md",
    "settings.md",
    "ide-integrations.md",
    "terminal-config.md",
    "memory.md",
    "cli-reference.md",
    "interactive-mode.md",
    "slash-commands.md",
    "hooks.md",
    "data-usage.md",
    "legal-and-compliance.md",
]

def build_bullets(files: List[str]) -> List[str]:
    seen = set()
    ordered = [f for f in ORDER if f in files and not (f in seen or seen.add(f))]
    remaining = sorted([f for f in files if f not in seen])
    final = ordered + remaining
    bullets = []
    for fname in final:
        slug = fname[:-3] if fname.endswith(".md") else fname
        bullets.append(f"- {slug} → [{fname}](./{fname})")
    return bullets

if not README_PATH.exists():
    raise SystemExit(f"README not found: {README_PATH}")

all_md = sorted([p.name for p in DOCS_DIR.glob("*.md") if p.name != "README.md"])
new_bullets = build_bullets(all_md)

text = README_PATH.read_text(encoding="utf-8")
lines = text.splitlines()

try:
    idx = lines.index("## 條目")
except ValueError:
    raise SystemExit("Heading '## 條目' not found in README.md")

end = len(lines)
for i in range(idx + 1, len(lines)):
    if lines[i].startswith("> "):
        end = i
        break

new_lines = lines[: idx + 1] + ["", *new_bullets, "", *lines[end:]]
README_PATH.write_text("\n".join(new_lines) + "\n", encoding="utf-8")
print("README index updated.")
PY
}

run_update_main() {
  echo "[update-main] Sync '本地鏡像索引（繁中）' block in main manual..."
  DOCS_DIR="$DOCS_DIR" README_PATH="$README_PATH" MAIN_DOC_PATH="$MAIN_DOC_PATH" python3 - <<'PY'
import os, re
from pathlib import Path

DOCS_DIR = Path(os.environ["DOCS_DIR"]).resolve()
README_PATH = Path(os.environ["README_PATH"]).resolve()
MAIN = Path(os.environ["MAIN_DOC_PATH"]).resolve()

if not MAIN.exists():
    raise SystemExit(f"Main doc not found: {MAIN}")
if not README_PATH.exists():
    raise SystemExit(f"Mirror README not found: {README_PATH}")

# Parse front-matter for source_index and fetched_at
text = README_PATH.read_text(encoding="utf-8")
source_index = "https://docs.anthropic.com/zh-TW/docs/claude-code/overview"
fetched_at = ""
if text.startswith("---\n"):
    try:
        fm_end = text.index("\n---", 4)
        header = text[4:fm_end]
        m_src = re.search(r"^source_index:\s*\"?(.+?)\"?$", header, flags=re.MULTILINE)
        m_time = re.search(r"^fetched_at:\s*\"?(.+?)\"?$", header, flags=re.MULTILINE)
        if m_src:
            source_index = m_src.group(1).strip()
        if m_time:
            fetched_at = m_time.group(1).strip()
    except ValueError:
        pass

block_lines = [
    "- [docs/anthropic-claude-code-zh-tw/README.md](docs/anthropic-claude-code-zh-tw/README.md) — Anthropic 官方文檔（繁中）本地鏡像索引",
    f"  > 來源: {source_index} · 抓取時間: {fetched_at}" if fetched_at else f"  > 來源: {source_index}",
]

main_text = MAIN.read_text(encoding="utf-8")
lines = main_text.splitlines()

# Find section start
try:
    idx = lines.index("### 本地鏡像索引（繁中）")
except ValueError:
    raise SystemExit("Heading '### 本地鏡像索引（繁中）' not found in main manual")

# Find next '### ' heading to bound the section
end = len(lines)
for i in range(idx + 1, len(lines)):
    if lines[i].startswith("### "):
        end = i
        break

# Rebuild section: keep the heading and replace following content until next heading
new_section = [lines[idx], "", *block_lines, ""]
new_lines = lines[:idx] + new_section + lines[end:]
MAIN.write_text("\n".join(new_lines) + "\n", encoding="utf-8")
print("Main manual mirror-index block updated.")
PY
}

run_test() {
  echo "[test] Running documentation validations..."
  DOCS_DIR="$DOCS_DIR" README_PATH="$README_PATH" python3 - <<'PY'
import os, re, sys
from pathlib import Path
from typing import Dict, List, Tuple

DOCS_DIR = Path(os.environ["DOCS_DIR"]).resolve()
README_PATH = Path(os.environ["README_PATH"]).resolve()

def parse_readme_links(readme_text: str) -> List[Path]:
    links: List[Path] = []
    for m in re.finditer(r"\]\((\./[^)]+)\)", readme_text):
        rel = m.group(1)
        links.append((DOCS_DIR / Path(rel)).resolve())
    return links

def has_required_front_matter(md_text: str) -> Tuple[bool, List[str]]:
    lines = md_text.splitlines()
    if not lines or lines[0].strip() != "---":
        return False, ["missing front-matter opening '---'"]
    try:
        end_idx = lines[1:].index("---") + 1
    except ValueError:
        return False, ["missing front-matter closing '---'"]
    header = "\n".join(lines[1:end_idx])
    problems: List[str] = []
    for key in ("source", "fetched_at"):
        if not re.search(rf"^{key}\s*:\s*\"?.+\"?$", header, flags=re.MULTILINE):
            problems.append(f"front-matter missing '{key}'")
    return (len(problems) == 0, problems)

def find_forbidden_bullets(md_text: str):
    issues = []
    for idx, line in enumerate(md_text.splitlines(), start=1):
        if re.match(r"^\*\s+", line):
            issues.append((idx, line))
    return issues

failures: Dict[str, List[str]] = {}

if not DOCS_DIR.exists():
    print(f"ERROR: Docs dir not found: {DOCS_DIR}")
    sys.exit(2)
if not README_PATH.exists():
    print(f"ERROR: README not found: {README_PATH}")
    sys.exit(2)

readme_text = README_PATH.read_text(encoding="utf-8")
linked_files = parse_readme_links(readme_text)

# broken links
for p in linked_files:
    if not p.exists():
        failures.setdefault(str(README_PATH), []).append(f"broken README link → {p}")

# orphan files
all_md = sorted(p for p in DOCS_DIR.glob("*.md") if p.name != "README.md")
linked_set = {p.resolve() for p in linked_files}
for md in all_md:
    if md.resolve() not in linked_set:
        failures.setdefault(str(README_PATH), []).append(f"orphan markdown not in index → {md.name}")

# per-file checks
for md in all_md:
    text = md.read_text(encoding="utf-8")
    ok, fm = has_required_front_matter(text)
    if not ok:
        for prob in fm:
            failures.setdefault(md.name, []).append(prob)
    forbidden = find_forbidden_bullets(text)
    if forbidden:
        preview = ", ".join([f"L{ln}" for ln, _ in forbidden[:5]])
        extras = " (truncated)" if len(forbidden) > 5 else ""
        failures.setdefault(md.name, []).append(
            f"forbidden '* ' bullet style at {preview}{extras}"
        )

if failures:
    print("Documentation test failures:")
    for file, probs in failures.items():
        print(f"\n- {file}")
        for p in probs:
            print(f"  • {p}")
    sys.exit(1)

print("All documentation tests passed. ✅")
PY
}

cmd="${1:-all}"
case "$cmd" in
  maintain)
    run_maintain
    ;;
  update-main)
    run_update_main
    ;;
  test)
    run_test
    ;;
  all)
    run_maintain
    run_update_main
    run_test
    ;;
  *)
    echo "Usage: $0 {maintain|update-main|test|all}" >&2
    exit 2
    ;;
esac


