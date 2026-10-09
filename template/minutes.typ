// =====================================================================
// minutes.typ — Science Students' Association council meeting minutes
// =====================================================================
// Requires Typst 0.15 or newer (uses the built-in `divider`).
//
// Usage (in meeting.typ):
//
//   #import "../minutes.typ": *
//   #show: minutes.with(
//     people: people,                  // from people.typ
//     date: "June 24, 2026",
//     attendance: csv("attendance.csv"),
//     reports: council-reports,        // from reports.typ
//     ...
//   )
//
// Any field left as `none` (or left out) is printed as a highlighted
// [FILL IN: ...] placeholder, so a half-finished draft still compiles.
// Anything written after `#show: minutes.with(...)` is appended at the
// very end of the document (for extra appendices, say).
//
// The logo is loaded from this file's folder, so keep `ssa_logo.png`
// next to `minutes.typ`.

// ---------------------------------------------------------------------
// 1. TERM-LEVEL DEFAULTS
// ---------------------------------------------------------------------
// Override these through `minutes.with(...)` only when they change.

#let default-chair = "Reyna Torres"

#let council-report-roles = (
  "President and Vice President",
  "Treasurer",
  "UMSU Director",
  "Senators",
  "Director of Student Advocacy",
  "Indigenous Representative",
  "International Representative",
  "Accessibility Representative",
  "2SLGBTQIA+ Representative",
  "Women's Representative",
  "First Years' Representative",
  "Racialized Representative",
  "Black Students' Representative",
  "Communications",
  "Student Services",
  "Special Events",
  "Lounge Programmer",
  "External Partnerships Programmer",
)

#let committee-report-roles = (
  "Executive Committee",
  "Selections Committee",
  "Bylaws Committee",
)

#let attendance-colors = (
  "Present": rgb("#defbe6"), // soft green
  "Absent": rgb("#ffc3a0"), // soft red
  "Absent with regrets": rgb("#fff1c5"), // soft yellow
  "Position vacant": rgb("#d3dee6"), // grayish
)

// ---------------------------------------------------------------------
// 2. NAMES — first mention in an agenda item gets the "intro" style,
//    later mentions in the same item are just the last name.
// ---------------------------------------------------------------------
// People are defined in people.typ and handed to `minutes.with(people: ...)`.
// Intro styles:
//   "title-last" -> "President Crossman"   (unique titles; the default)
//   "title-full" -> "Senator Jane Smith"   (several holders, short title)
//   "full"       -> "Jane Smith"           (long or shared titles)
//
// `who`, `surname` and `fullname` return content, not strings.

#let _people = state("minutes-people", (:))
#let _seen = state("minutes-names-seen", ())

#let _full(p) = p.first + " " + p.last

// Only call inside `context`.
#let _person(key) = {
  let people = _people.get()
  if key not in people {
    panic("Unknown person key \"" + key + "\". Known keys: " + people.keys().join(", ", default: "(none)"))
  }
  people.at(key)
}

// First mention in the current item -> intro style; afterwards -> last name.
#let who(key) = context {
  let p = _person(key)
  let is-first = not _seen.get().contains(key)
  _seen.update(s => s + (key,))
  if not is-first { p.last } else {
    let style = p.at("intro", default: "title-last")
    if style == "title-last" { p.title + " " + p.last } else if style == "title-full" {
      p.title + " " + _full(p)
    } else if style == "full" { _full(p) } else {
      panic("Unknown intro style \"" + style + "\" for \"" + key + "\"")
    }
  }
}

// Always last name only; does not count as a first mention.
#let surname(key) = context _person(key).last

// Always full name; does not count as a first mention.
#let fullname(key) = context _full(_person(key))

// ---------------------------------------------------------------------
// 3. SMALL HELPERS (private)
// ---------------------------------------------------------------------

// A missing value becomes a highlighted placeholder.
#let _or(value, label) = if value == none {
  highlight(fill: yellow.lighten(40%))[\[FILL IN: #label\]]
} else { value }

// Sentence-ending period, unless the value already ends in one ("7:02 p.m.").
#let _end(value) = if type(value) == str and value.ends-with(".") { [] } else { [.] }

// Pull named fields out of a dictionary, rejecting unknown keys so that a
// typo like `movedby` is an error rather than a silently blank field.
#let _unpack(d, name, keys) = {
  let unknown = d.keys().filter(k => k not in keys)
  if unknown.len() > 0 {
    panic("`" + name + "`: unknown field(s) " + unknown.join(", ") + ". Allowed: " + keys.join(", "))
  }
  keys.map(k => d.at(k, default: none))
}

// ---------------------------------------------------------------------
// 4. COMPONENTS
// ---------------------------------------------------------------------

#let motion(
  title: "",
  id: none,
  body: [],
  category: none,
  moved-by: none,
  seconded-by: none,
  status: none,
) = block(
  width: 100%,
  stroke: 1pt + luma(150),
  inset: 12pt,
  breakable: false,
)[
  #show divider: set line(stroke: 0.5pt + luma(200))
  #show divider: set block(above: 6pt, below: 6pt)

  #strong[Motion: #title#if id != none [ (ID: #id)]]
  #if category != none {
    block(text(style: "italic")[Category: #category])
  }

  #divider()
  #body
  #divider()

  #grid(
    columns: (1fr, 1fr, auto),
    [*Moved by:* #_or(moved-by, "mover")],
    [*Seconded by:* #_or(seconded-by, "seconder")],
    [*Status:* #_or(status, "status")],
  )
]

#let _header(chair, date, location, meeting-type) = grid(
  columns: (1fr, auto),
  gutter: 1.5em,
  align: bottom,
  [
    *Science Students' Association Council Meeting* \
    Date: #_or(date, "date") \
    Location: #_or(location, "location") \
    Chaired by: #chair, Chairperson \
    Meeting type: #_or(meeting-type, "meeting type")
  ],
  image("ssa_logo.png", width: 2.75cm),
)

// `rows` is the parsed csv: one (position, name, status) row per councillor.
#let _attendance-table(rows) = {
  let cells = ()
  for (i, row) in rows.enumerate() {
    if row.len() != 3 {
      panic(
        "Attendance row "
          + str(i + 1)
          + " has "
          + str(row.len())
          + " columns, expected 3 (position, name, status): "
          + repr(row),
      )
    }
    let (position, name, status) = row
    let status = status.trim()
    if status not in attendance-colors {
      panic(
        "Attendance row "
          + str(i + 1)
          + " ("
          + position
          + "): unknown status \""
          + status
          + "\". Allowed: "
          + attendance-colors.keys().join(", "),
      )
    }
    cells += (
      strong(position),
      name,
      table.cell(fill: attendance-colors.at(status), status),
    )
  }
  table(
    columns: (52%, 26%, 22%),
    stroke: 1pt + luma(100),
    table.header([*Position*], [*Name*], [*Attendance*]),
    ..cells,
  )
}

// One `===` heading per role, in the order of `roles`. Roles without an
// entry in `reports` get a dagger. Keys that match no role are an error.
#let _report-sections(roles, reports, what) = {
  let unknown = reports.keys().filter(k => k not in roles)
  if unknown.len() > 0 {
    panic(
      "Unknown "
        + what
        + " report key(s): "
        + unknown.map(k => "\"" + k + "\"").join(", ")
        + ". Valid roles: "
        + roles.join("; "),
    )
  }
  for role in roles {
    let report = reports.at(role, default: none)
    if report == none {
      heading(level: 3)[#role #super[#sym.dagger]]
    } else {
      heading(level: 3, role)
      report
    }
  }
}

// "A motion to approve ... was moved by ... and seconded by ...".
#let _approval(d, name, what, outcome) = {
  let (mover, seconder, result) = _unpack(d, name, ("moved-by", "seconded-by", "result"))
  if result not in (none, "as written", "as amended") {
    panic("`" + name + "`: result must be \"as written\" or \"as amended\", not " + repr(result))
  }
  [A motion to approve #what was moved by #_or(mover, "mover") and seconded by #_or(seconder, "seconder"). #outcome approved #_or(result, "as written / as amended").]
}

// ---------------------------------------------------------------------
// 5. THE TEMPLATE
// ---------------------------------------------------------------------

#let minutes(
  body,
  people: (:),
  chair: default-chair,
  date: none,
  location: none,
  meeting-type: none,
  attendance: none, // csv rows: (position, name, status)
  regrets: none, // array of content; () means "none to report"
  called-to-order: none, // e.g. "7:02 p.m."
  agenda: (:), // (moved-by:, seconded-by:, result:)
  previous-minutes: (:), // (moved-by:, seconded-by:, result:)
  reports: (:), // role -> content
  committee-reports: (:), // committee -> content
  other-business: none,
  final-considerations: none,
  adjournment: (:), // (time:, moved-by:, seconded-by:)
  motions: (), // array of motion(...)
  council-roles: council-report-roles,
  committee-roles: committee-report-roles,
  names-reset-level: 3, // headings at this level or higher reset first mentions
) = {
  // --- Document setup ---
  let title = "SSA Council Meeting Minutes"
  if type(date) == str { title += ", " + date }
  set document(title: title)
  set page(margin: 1in, paper: "us-letter")
  set par(leading: 0.55em, spacing: 0.55em, justify: true)
  show heading: set block(above: 1.4em, below: 1em)
  show heading: it => {
    if it.level <= names-reset-level { _seen.update(()) }
    it
  }
  show link: underline
  show image: it => align(center, it)
  show raw: set text(font: "Lilex")
  set enum(numbering: "(a)(1)(i)(I)")

  _people.update(people)

  // --- Header and attendance ---
  _header(chair, date, location, meeting-type)
  divider()

  [= Attendance]
  if attendance == none {
    _or(none, "attendance (csv rows)")
  } else {
    _attendance-table(attendance)
  }

  [== Absences and Proxies]
  if regrets == none {
    _or(none, "regrets and proxies")
  } else if regrets.len() == 0 {
    [None.]
  } else {
    list(..regrets)
  }

  divider()

  // --- Minutes ---
  [= Minutes]

  [== Call to Order]
  [Chairperson #chair called the meeting to order at #_or(called-to-order, "time")#_end(called-to-order)]

  [== Approval of Agenda]
  _approval(agenda, "agenda", [the agenda], [The agenda was])

  [== Treaty Land Acknowledgement]
  [Chairperson #chair read the treaty land acknowledgement of the SSA.]

  [== Approval of Previous Meeting Minutes]
  _approval(
    previous-minutes,
    "previous-minutes",
    [the previous meeting's minutes],
    [The meeting minutes were],
  )

  [== Reports of Councillors]
  [The symbol _†_ indicates that no report was given.]
  _report-sections(council-roles, reports, "council")

  [== Reports of Committees]
  [The symbol _†_ indicates that no report was given.]
  _report-sections(committee-roles, committee-reports, "committee")

  [== Other Business]
  _or(other-business, "other business")

  [== Final Considerations]
  _or(final-considerations, "final considerations")

  [== Adjournment]
  {
    let (time, mover, seconder) = _unpack(adjournment, "adjournment", ("time", "moved-by", "seconded-by"))
    [A motion to adjourn the meeting was moved by #_or(mover, "mover") and seconded by #_or(seconder, "seconder"). The motion was adopted without objection and the meeting was adjourned at #_or(time, "time")#_end(time)]
  }

  // --- Motions appendix (only if there are any) ---
  pagebreak()
  [= Motions]
  [All motions moved at this meeting are shown below. Motions with IDs are recorded verbatim. Motions without IDs were summarized by the Secretary.]
  if motions.len() > 0 {
    motions.join(v(1em))
  }

  body
}
