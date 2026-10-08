
// --- BASIC LAYOUT AND FORMAT ---
#set page(margin: 1.00in, paper: "us-letter")
#set par(leading: 0.55em, spacing: 0.55em, first-line-indent: 1.8em, justify: true)
#show heading: set block(above: 1.4em, below: 1em)

// --- PREFERENCES ---
#show link: underline // Underline Links
#show image: it => {
  // Automatic centering of images
  align(center, it)
}
#show raw: set text(font: "Lilex")

// --- ATTENDANCE TABLE RULES ---
#show table.cell.where(x: 0): strong
#let conditional-cell(body) = {
  // Determine color based on text content
  let cell-color = if body == "Present" {
    rgb("#defbe6") // Soft green
  } else if body == "Absent" {
    rgb("ffc3a0") // Soft red
  } else if body == "Absent with regrets" {
    rgb("fff1c5") // Soft yellow
  } else if body == "Position vacant" {
    rgb("#D3DEE6") // Grayish
  } else {
    none // Default
  }
  // Return a styled table cell
  table.cell(fill: cell-color, body)
}

// --- FOOTER ---
#set page(
  footer: context [
    _Symbol #sym.dagger indicates that no report was given._
    #h(1fr)
    #counter(page).display("1")
  ],
)

// --- SSA SPECIFIC STUFF ---
#set enum(numbering: "(a)(1)(i)(I)")

#let motion(
  title: "",
  body: [], // Renamed from text to avoid shadowing global text()
  category: none,
  moved-by: none,
  seconded-by: none,
  status: none,
) = {
  // Removed leading hashes inside the code block
  block(
    width: 100%,
    stroke: 1pt + luma(150),
    // radius: 4pt,
    inset: 12pt,
    breakable: false,
    // fill: luma(245),
  )[
    // Header Row: Title & Optional Category
    *Motion: #title*
    #if category != none {
      block()[
        #text(style: "italic")[Category: #category]
      ]
    }

    #v(4pt)
    #line(length: 100%, stroke: 0.5pt + luma(200))
    #v(4pt)

    // The main text of the motion (no eval needed)
    #body

    // #v(8pt)
    #v(8pt)
    #line(length: 100%, stroke: 0.5pt + luma(200))
    #v(4pt)


    // Metadata: Moved, Seconded, and Status
    #grid(
      columns: (1fr, 1fr, auto),
      [ *Moved by:* #moved-by ], [ *Seconded by:* #seconded-by ], [ *Status:* #status],
    )
    // if status != none {
    //   let status-color = if lower(status) == "pass" { rgb("2e7d32") } else { rgb("c62828") }
    //   box(
    //     fill: status-color.lighten(90%),
    //     stroke: 0.5pt + status-color,
    //     inset: (x: 8pt, y: 4pt),
    //     radius: 3pt,
    //   )[
    //     #text(weight: "bold", fill: status-color)[#upper(status)]
    //   ]
    // }
    // )
  ]
}

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

// --- BEGIN DOCUMENT ---



#grid(
  columns: (1fr, auto),
  // Text takes remaining space, image scales to its size
  gutter: 1.5em,
  // Horizontal space between the text and the image
  align: bottom,
  [
    *Science Students' Association Council Meeting* \
    Date: [FILL IN] \
    Location: [FILL IN] \
    Chaired By: Reyna Torres, Chairperson \
    Meeting type: [FILL IN]
  ],
  image("ssa_logo.png", width: 2.75cm),
)

#divider()

= Attendance
#let councillors = csv("attendance.csv")
#table(
  columns: (52%, 26%, 22%),
  stroke: 1pt + luma(100),
  table.header([*Position*], [*Name*], [*Attendance*]),

  // Flatten the array and convert every element using our function
  ..councillors.flatten().map(conditional-cell),
)

== Regrets and Proxies
- (Example) (No proxy required): Jason Hong; Secretary.

#divider()
= Minutes
== Call to Order
Chairperson Reyna Torres called the meeting to order at [FILL IN] p.m.
== Approval of Agenda
A motion to approve the agenda was moved by [FILL IN] and seconded by [FILL IN]. The agenda was approved as [FILL IN--AS WRITTEN OR AS AMENDED].
== Treaty Land Acknowledgement
Chairperson Reyna Torres read the treaty land acknowledgement of the SSA.
== Approval of Previous Meeting Minutes
A motion to approve the previous meeting's minutes was moved by [FILL IN] and seconded by [FILL IN]. The meeting minutes were approved as [FILL IN--AS WRITTEN OR AMENDED].

== Reports of Councillors
// Only fill in roles that actually gave a report this meeting
#let report-content = (
  "President and Vice President": [
    Example report.
  ],
)

#for role in council-report-roles {
  let content = report-content.at(role, default: none)
  if content == none {
    [=== #role #super[#sym.dagger]]
  } else {
    [=== #role]
    content
  }
}
== Reports of Committees
#let committee-report-content = (
  "Executive Committee": [
    Example report.
  ],
)

#for role in committee-report-roles {
  let content = committee-report-content.at(role, default: none)
  if content == none {
    [=== #role #super[#sym.dagger]]
  } else {
    [=== #role]
    content
  }
}
== Other Business
== Important Dates
== Adjournment
A motion to adjourn the meeting was moved by [FILL IN] and seconded by [FILL IN]. The motion was adopted without objection and the meeting was adjourned at [FILL IN] p.m.

// --- MOTIONS ---
#pagebreak()
= Motions
// Consider giving a more readable identifier, like PRES.A.2026.06.24
#motion(
  title: "Example Motion 1 (ID: P062426A)",
  category: "President & Vice President's Report",
  body: [*WHEREAS* The Executive Committee, hereafter referred to as the Executive, shall be composed of:
    - Executive Assistant; as chair
    - President
    - Vice President
    - Treasurer
    - Two other elected Councillors elected from and by Council \ \
    *BE IT RESOLVED* that the Executive Committee be struck, composed of Noah, Caleb, Nick, Anshika, Danylo and Hargun
  ],
  moved-by: "Jane Doe",
  seconded-by: "John Smith",
  status: "Passed",
)

// #let approve(what, result-noun, moved-by: none, seconded-by: none, how: none) = [
//   A motion to approve #what was moved by #or-todo(moved-by, "mover")
//   and seconded by #or-todo(seconded-by, "seconder").
//   #result-noun were approved as #or-todo(how, "as written / as amended").
// ]

// #let adjourn(moved-by: none, seconded-by: none, time: none) = [
//   A motion to adjourn the meeting was moved by #or-todo(moved-by, "mover")
//   and seconded by #or-todo(seconded-by, "seconder"). The motion was adopted
//   without objection and the meeting was adjourned at #or-todo(time, "time") p.m.
// ]
test
// #adjourn(time: "7:42")

// names.typ — automatic name formatting for meeting minutes
//
// First mention of a person within an agenda item uses their "intro" style;
// every later mention in that same item is just their last name.
// The tracking resets at each heading up to `reset-level`.

// ---------------------------------------------------------------
// 1. PEOPLE — edit this for each term / meeting
// ---------------------------------------------------------------
// intro styles:
//   "title-last" -> "President Crossman"          (unique titles)
//   "title-full" -> "Senator Jane Smith"          (multiple holders, short title)
//   "full"       -> "Jane Smith"                  (long or shared titles)
#let people = (
  crossman: (
    first: "Noah",
    last: "Crossman",
    title: "President",
    intro: "title-last",
  ),
  smith: (
    first: "Jane",
    last: "Smith",
    title: "Senator",
    intro: "title-full",
  ),
  lee: (
    first: "Alex",
    last: "Lee",
    title: "Student Services Programmer (Academics)",
    intro: "full",
  ),
)

// ---------------------------------------------------------------
// 2. SETTINGS
// ---------------------------------------------------------------
// Headings at this level or higher (1 = top level) reset "first mention".
// With 2, both `=` and `==` headings reset; `===` and below do not.
#let reset-level = 2

// ---------------------------------------------------------------
// 3. MACHINERY
// ---------------------------------------------------------------
#let seen = state("names-seen", ())

// Wrap your document with this: #show: setup-names
#let setup-names(body) = {
  show heading: it => {
    if it.level <= reset-level { seen.update(()) }
    it
  }
  body
}

#let _get(key) = {
  assert(key in people, message: "Unknown person key: " + key)
  people.at(key)
}

#let _full(p) = p.first + " " + p.last

// Main function: #who("crossman")
// First mention in the current item -> intro style; afterwards -> last name.
#let who(key) = context {
  let p = _get(key)
  let is-first = not seen.get().contains(key)
  seen.update(s => s + (key,))
  if not is-first { p.last } else {
    let style = p.at("intro", default: "title-last")
    if style == "title-last" { p.title + " " + p.last } else if style == "title-full" {
      p.title + " " + _full(p)
    } else { _full(p) }
  }
}

// Always last name only, and does not count as a first mention.
// Intended for motions: "Moved by #surname("crossman"), seconded by ..."
#let surname(key) = _get(key).last

// Always full name, and does not count as a first mention.
#let fullname(key) = _full(_get(key))

#who("crossman")
#who("joshi")
