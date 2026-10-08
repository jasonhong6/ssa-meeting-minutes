// template.typ — Science Students' Association Meeting Minutes Template

// ==========================================
// 1. STYLING CONSTANTS
// ==========================================
#let text-muted = luma(100)
#let border-color = luma(180)
#let bg-subtle = luma(248)

// ==========================================
// 2. DEFAULT ROLE LISTS
// ==========================================
#let default-councillor-roles = (
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

#let default-committee-roles = (
  "Executive Committee",
  "Selections Committee",
  "Bylaws Committee",
)

// ==========================================
// 3. PEOPLE & NAME TRACKING
// ==========================================
#let people-registry = state("people-registry", (:))
#let seen-names = state("seen-names", ())

// First mention renders "First Last"; subsequent mentions render "Last"
#let who(key) = context {
  let reg = people-registry.get()
  let seen = seen-names.get()
  
  if key not in reg {
    text(fill: red.darken(20%), weight: "bold")[#key (?)]
  } else {
    let p = reg.at(key)
    if key in seen [
      #p.last
    ] else [
      #p.first #p.last
      #seen-names.update(s => (..s, key))
    ]
  }
}

#let surname(key) = context {
  let reg = people-registry.get()
  if key in reg {
    reg.at(key).last
  } else {
    text(fill: red.darken(20%), weight: "bold")[#key (?)]
  }
}

#let fullname(key) = context {
  let reg = people-registry.get()
  if key in reg {
    let p = reg.at(key)
    [#p.first #p.last]
  } else {
    text(fill: red.darken(20%), weight: "bold")[#key (?)]
  }
}

// ==========================================
// 4. UTILITY & COMPONENT HELPERS
// ==========================================

#let divider() = line(length: 100%, stroke: 0.5pt + border-color)

#let todo(text-val: "FILL IN") = box(
  fill: rgb("#ffebee"),
  radius: 3pt,
  inset: (x: 4pt, y: 2pt),
  stroke: 0.5pt + rgb("#ef9a9a"),
  baseline: 0%,
  text(fill: rgb("#c62828"), size: 0.85em, weight: "bold")[#text-val]
)

#let motion(
  title: none,
  number: none,
  mover: none,
  seconder: none,
  body: none,
  status: "Passed", // Passed, Failed, Tabled, Unanimous
  votes: none,      // (for: X, against: Y, abstain: Z)
  notes: none,
) = {
  let status-color = if status in ("Passed", "Carried", "Unanimous") {
    rgb("#2e7d32")
  } else if status == "Failed" {
    rgb("#c62828")
  } else {
    rgb("#e65100")
  }

  v(6pt)
  block(
    width: 100%,
    stroke: 0.5pt + border-color,
    radius: 4pt,
    fill: bg-subtle,
    inset: 10pt,
    breakable: false,
    [
      #grid(
        columns: (1fr, auto),
        gutter: 8pt,
        align: (left + horizon, right + horizon),
        [
          #if number != none [*Motion \##number:* ]
          #if title != none [*#title*]
        ],
        box(
          fill: status-color.lighten(85%),
          stroke: 0.5pt + status-color,
          radius: 3pt,
          inset: (x: 6pt, y: 2pt),
          text(status-color, weight: "bold", size: 8pt)[#status.upper()]
        )
      )

      #if body != none [
        #v(4pt)
        #block(
          stroke: (left: 2pt + brand-blue),
          inset: (left: 8pt, y: 2pt),
          text(style: "italic")[#body]
        )
      ]

      #v(4pt)
      #grid(
        columns: (auto, 1fr),
        row-gutter: 4pt,
        column-gutter: 8pt,
        [*Moved by:*], [#mover],
        [*Seconded by:*], [#seconder],
        ..if votes != none {(
          [*Vote:*],
          [#votes.at("for", default: "-") in favor, #votes.at("against", default: "-") against, #votes.at("abstain", default: "-") abstentions]
        )} else { () },
        ..if notes != none {(
          [*Notes:*], [#notes]
        )} else { () },
      )
    ]
  )
  v(4pt)
}

// Helper to render CSV attendance if provided
#let render-attendance(file-or-data) = {
  let rows = if type(file-or-data) == str {
    csv(file-or-data)
  } else {
    file-or-data
  }
  
  if rows != none and rows.len() > 0 {
    table(
      columns: rows.first().len(),
      fill: (_, row) => if row == 0 { brand-blue } else if calc.even(row) { bg-subtle } else { white },
      stroke: 0.5pt + border-color,
      inset: (x: 6pt, y: 5pt),
      align: left + horizon,
      ..rows.enumerate().map(((r-idx, row)) => {
        row.map(cell => {
          if r-idx == 0 {
            text(fill: white, weight: "bold", size: 8.5pt)[#cell]
          } else {
            text(size: 8.5pt)[#cell]
          }
        })
      }).flatten()
    )
  }
}

// ==========================================
// 5. MAIN TEMPLATE FUNCTION
// ==========================================
#let minutes(
  // Meeting Header Info
  date: none,
  time: none,
  location: none,
  chair: none,
  secretary: none,
  meeting-type: "SSA Council Meeting",
  logo: none,

  // Council Roster
  people: (:),

  // Boilerplate & Motions
  call-to-order: none,
  treaty-acknowledgement: true,
  agenda-approval: (mover: none, seconder: none, amended: false),
  minutes-approval: (mover: none, seconder: none, amended: false),
  adjournment: (time: none, mover: none, seconder: none),

  // Attendance
  attendance: none, // Path to CSV or array of CSV rows
  regrets: (),
  proxies: (),

  // Reports
  councillor-roles: default-councillor-roles,
  committee-roles: default-committee-roles,
  councillor-reports: (:),
  committee-reports: (:),

  // Remaining Content
  body
) = {
  // Page & Document Settings
  set document(title: [#meeting-type — #date])
  set page(
    paper: "us-letter",
    margin: (top: 2cm, bottom: 2cm, left: 2.2cm, right: 2.2cm),
    header: context {
      let p = counter(page).get().first()
      if p > 1 [
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          text(8pt, fill: text-muted)[#meeting-type — #date],
          text(8pt, fill: text-muted)[Page #counter(page).display("1 of 1", both: true)]
        )
        #line(length: 100%, stroke: 0.5pt + border-color)
      ]
    }
  )

  set text(font: ("Linux Libertine", "Times New Roman"), size: 10pt)
  set par(justify: true, leading: 0.65em)

  // Configure heading formatting and reset name tracking per top-level section
  show heading: it => {
    if it.level == 1 {
      seen-names.update(()) // Reset seen names for each major section
      v(14pt, weak: true)
      text(fill: brand-blue, weight: "bold", size: 12pt)[#it.body]
      v(4pt, weak: true)
      line(length: 100%, stroke: 1pt + brand-blue)
      v(6pt, weak: true)
    } else if it.level == 2 {
      v(10pt, weak: true)
      text(fill: brand-blue.lighten(15%), weight: "bold", size: 10.5pt)[#it.body]
      v(4pt, weak: true)
    } else {
      it
    }
  }

  // Populate people registry
  people-registry.update(people)

  // Header Banner
  grid(
    columns: (1fr, auto),
    gutter: 12pt,
    align: (left + horizon, right + horizon),
    [
      #text(brand-blue, size: 16pt, weight: "bold")[Science Students' Association] \
      #v(2pt)
      #text(brand-gold.darken(10%), size: 12pt, weight: "bold")[#meeting-type] \
      #v(2pt)
      #text(text-muted, size: 9pt)[University of Manitoba]
    ],
    if logo != none {
      if type(logo) == str {
        image(logo, width: 2.75cm)
      } else {
        logo
      }
    } else {
      none
    }
  )

  v(4pt)
  divider()
  v(4pt)

  // Meeting Details Grid
  block(
    fill: bg-subtle,
    stroke: 0.5pt + border-color,
    radius: 4pt,
    inset: 8pt,
    width: 100%,
    grid(
      columns: (auto, 1fr, auto, 1fr),
      row-gutter: 6pt,
      column-gutter: 12pt,
      align: (left + horizon),
      [*Date:*], [#if date != none [#date] else [#todo()]],
      [*Time:*], [#if time != none [#time] else [#todo()]],
      [*Location:*], [#if location != none [#location] else [#todo()]],
      [*Chair:*], [#if chair != none [#chair] else [#todo()]],
      ..if secretary != none {(
        [*Secretary:*], [#secretary]
      )} else { () },
    )
  )

  v(6pt)

  // ==========================================
  // CALL TO ORDER & OPENING BOILERPLATE
  // ==========================================
  = Call to Order

  The meeting was called to order at #{
    if call-to-order != none [
      *#call-to-order*
    ] else [
      #todo(text-val: "TIME")
    ]
  } by Chairperson #{
    if chair != none [ #chair. ] else [ #todo(text-val: "CHAIR"). ]
  }

  if treaty-acknowledgement [
    #v(4pt)
    #block(
      fill: luma(252),
      stroke: (left: 2.5pt + brand-gold),
      inset: (left: 8pt, y: 4pt),
      text(size: 8.5pt, fill: text-muted)[
        The Science Students' Association acknowledges that we are on Treaty 1 territory and that the land on which we gather is the traditional territory of the Anishinaabeg, Cree, Oji-Cree, Dakota, and Dene Peoples, and the homeland of the Red River Métis Nation.
      ]
    )
  ]

  // ==========================================
  // APPROVAL OF AGENDA & PREVIOUS MINUTES
  // ==========================================
  = Approval of the Agenda

  #if agenda-approval.mover != none or agenda-approval.seconder != none [
    #motion(
      title: "Approval of the Agenda",
      mover: if agenda-approval.mover != none { agenda-approval.mover } else { todo() },
      seconder: if agenda-approval.seconder != none { agenda-approval.seconder } else { todo() },
      body: [
        BIRT the agenda for this meeting be approved
        #if agenda-approval.at("amended", default: false) [ as amended]. else [. ]
      ],
      status: "Carried",
    )
  ] else [
    #motion(
      title: "Approval of the Agenda",
      mover: todo(text-val: "MOVER"),
      seconder: todo(text-val: "SECONDER"),
      body: [BIRT the agenda for this meeting be approved as presented.],
      status: "Carried",
    )
  ]

  = Approval of the Minutes

  #if minutes-approval.mover != none or minutes-approval.seconder != none [
    #motion(
      title: "Approval of Previous Minutes",
      mover: if minutes-approval.mover != none { minutes-approval.mover } else { todo() },
      seconder: if minutes-approval.seconder != none { minutes-approval.seconder } else { todo() },
      body: [
        BIRT the minutes from the previous Council meeting be approved
        #if minutes-approval.at("amended", default: false) [ as amended]. else [. ]
      ],
      status: "Carried",
    )
  ] else [
    #motion(
      title: "Approval of Previous Minutes",
      mover: todo(text-val: "MOVER"),
      seconder: todo(text-val: "SECONDER"),
      body: [BIRT the minutes from the previous Council meeting be approved as presented.],
      status: "Carried",
    )
  ]

  // ==========================================
  // ATTENDANCE (IF PROVIDED)
  // ==========================================
  if attendance != none or regrets.len() > 0 or proxies.len() > 0 [
    = Attendance

    if attendance != none [
      #render-attendance(attendance)
      #v(6pt)
    ]

    if regrets.len() > 0 [
      *Regrets:* #regrets.join(", ") \
    ]
    if proxies.len() > 0 [
      *Proxies:* #proxies.map(p => [#p.first for #p.second]).join("; ")
    ]
  ]

  // ==========================================
  // COUNCILLOR REPORTS
  // ==========================================
  = Councillor Reports

  #text(size: 8.5pt, fill: text-muted)[#super[†] Indicates no written report was submitted for this meeting.]

  #for role in councillor-roles {
    let report = councillor-reports.at(role, default: none)
    if report != none [
      == #role
      #report
    ] else [
      == #role #super[†]
    ]
  }

  // ==========================================
  // COMMITTEE REPORTS
  // ==========================================
  = Committee Reports

  #text(size: 8.5pt, fill: text-muted)[#super[†] Indicates the committee did not submit a report or meet during this period.]

  #for role in committee-roles {
    let report = committee-reports.at(role, default: none)
    if report != none [
      == #role
      #report
    ] else [
      == #role #super[†]
    ]
  }

  // ==========================================
  // USER-SUPPLIED BODY (Other Business, Motions, Dates)
  // ==========================================
  body

  // ==========================================
  // ADJOURNMENT
  // ==========================================
  = Adjournment

  The meeting was adjourned at #{
    if adjournment.time != none [
      *#adjournment.time*
    ] else [
      #todo(text-val: "TIME")
    ]
  }#{
    if adjournment.mover != none and adjournment.seconder != none [
      #motion(
        title: "Adjournment",
        mover: adjournment.mover,
        seconder: adjournment.seconder,
        body: [BIRT this meeting of Council be adjourned.],
        status: "Carried",
      )
    ] else [
      .
    ]
  }
}