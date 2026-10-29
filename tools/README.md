# tools/

Checks that run, rather than rules people remember.

**A rule in `AGENTS.md` is a reminder. A rule in a script is a check.** The difference shows
up on the day somebody is in a hurry.

| Tool | What it does |
|---|---|
| `check-output.sh` | Scans a file for things that should not have survived sanitization |

Run it before anything leaves `work/`:

```
tools/check-output.sh work/yourfile.md
```

It exits 0 when it finds nothing and 1 when it does, so it drops into a pre-commit hook or a
CI step without modification.

## Adding to it

Good candidates are whatever people skip when rushed. Checking that every file in `sources/`
has a row in `SOURCES.md`. Verifying nothing in `output/` is newer than its task file.
Scanning for your organization's own identifier formats, which this script does not know.

Keep them fast and boring. A check that takes a minute gets run. One that takes ten does not.
