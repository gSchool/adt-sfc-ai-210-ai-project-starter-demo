# AI Project Starter

A repository you can clone and actually work in — a project that runs many tasks over time
with an AI agent, not a harness for one.

The structure is the point. **Each directory exists because one of the rules in
[`AGENTS.md`](./AGENTS.md) needs somewhere to put something.**

## The idea

Most people start with an agent by opening a chat and pasting. That works until something
goes wrong, and then nobody can say what it read, what it was asked, why the result was
accepted, or whether the material was current.

This repository front-loads the parts that are painful to retrofit: a boundary between what
an agent may treat as instruction and what it may only read, a declared set of sources with
owners and dates, a check between produced and accepted, and a record of reasoning rather
than only results.

## Setting it up — once

1. **Fill in `PROJECT.md`.** What this project is, who the output is for, what good looks
   like, what is out of bounds. This is the context every task inherits, so you write it
   once instead of repeating it.
2. **Put your material in `sources/` and fill in `sources/SOURCES.md`.** One row per file:
   what it is, who owns it, when it was last current. Expect gaps — the gaps are the useful
   part. An undeclared source still works; the agent will just tell you it is unverified.
3. **Point your agent at the repository.** It reads `AGENTS.md` and `PROJECT.md`.

That is setup. It is not meant to take an afternoon.

## Running a task — every time

1. **Copy `templates/task.md` into `tasks/` as `NNNN-short-name.md`.** Ten lines. What the
   task is, what a usable result includes, what it must not do.
2. **Work in `work/`.**
3. **Check the result** — `tools/check-output.sh work/yourfile.md`, then the four questions
   in `AGENTS.md` section 4.
4. **Move it to `output/`** and close the task file with what was decided and why.

Three touches. If a task needs more ceremony than that, it is probably more than one task.

## When something smells

`templates/` holds two heavier instruments. You do not run these per task — you reach for
them when something is wrong and you want to know why.

- **`source-check.md`** — when you do not trust an input. Five questions that separate a
  source of truth from a place where files happen to live.
- **`readiness-check.md`** — when tasks keep producing junk and you suspect the inputs
  rather than the prompt. Four dimensions with evidence. **It can legitimately tell you not
  to proceed yet, and that is a result.**

## What is deliberately empty

`prompts/` and `docs/specs/` have READMEs and nothing else. Both get filled by practices
that come later — reusable versioned prompts, and specifications detailed enough to build
from. The slot exists now so adopting them means filling it rather than reorganizing.

**A layout you have to throw away when you learn the next thing was the wrong layout.**

## Adapting it

Nothing here is tool-specific. `CLAUDE.md` points at `AGENTS.md` so tools looking for either
name read the same rules; add another pointer if yours looks for a third.

`AGENTS.md` section 2 — what counts as an identifier worth replacing — is the part most
worth making specific to your environment.
