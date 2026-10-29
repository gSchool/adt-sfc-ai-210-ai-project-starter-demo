# Source Check: <name>

**Reach for this when you do not trust an input** — not for every source, and not on a
schedule. Five questions, ten minutes.

A source of truth is operational, not just a place. **If it holds data but has no named
owner, no review cadence, and no retirement process, it is a storage location — and storage
locations decay.**

---

**1. Location** — which system, and where inside it? One place everyone goes, or several?

**2. Owner** — who is accountable for its accuracy? A name, not a team. If nobody is, say so
plainly.

**3. Update cadence** — how often is it refreshed or reviewed? When was it last?

**4. Access** — who can read it, change it, approve changes? Can an automated workflow reach
it, or only a person?

**5. Retirement** — when something in it goes out of date, what happens to it?

---

**Verdict:** source of truth / storage location

**Which question you could not answer:**

<!-- Usually the interesting one. Not being able to answer is a finding about the source,
     not a gap in this check. -->

**If something came back unknown:** who would you ask, roughly how long would finding out
take, and what work is not blocked by not knowing?

**What changes as a result:** update the row in `sources/SOURCES.md`, and if this is going
to govern how the project treats the source from now on, write it up in `docs/decisions/`.
