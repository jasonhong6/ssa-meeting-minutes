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
  crossman: (first: "Noah", last: "Crossman", title: "President", intro: "title-last"),
  pereira: (first: "Caleb", last: "Pereira", title: "Vice President", intro: "title-last"),
  torres: (first: "Reyna", last: "Torres", title: "Chairperson", intro: "title-last"),
  hong: (first: "Jason", last: "Hong", title: "Secretary", intro: "title-last"),
  negi: (first: "Yashsavi", last: "Negi", title: "Senator", intro: "title-full"),
  uppal: (first: "Hargun", last: "Uppal", title: "Senator", intro: "title-full"),
  joshi: (first: "Kushal", last: "Joshi", title: "Senator", intro: "title-full"),
  kruk: (first: "Danylo", last: "Kruk", title: "UMSU Director", intro: "full"),
  brar: (first: "Roopak", last: "Brar", title: "Director of Student Advocacy", intro: "full"),
  singh: (first: "Gurminder", last: "Singh", title: "International Representative", intro: "full"),
  abazid: (first: "Zaina", last: "Abazid", title: "Women’s Representative", intro: "full"),
  fatunmbi: (first: "Seun", last: "Fatunmbi", title: "Black Students’ Representative", intro: "full"),
  gislason: (first: "Alice Miranda", last: "Gislason", title: "2SLGBTQIA+ Representative", intro: "full"),
  vong: (first: "Victoria", last: "Vong", title: "Accessibility Representative", intro: "full"),
  quill: (first: "April", last: "Quill", title: "Indigenous Representative", intro: "full"),
  sharma: (first: "Anshika", last: "Sharma", title: "Treasurer", intro: "title-last"),
  delaney: (first: "Sean", last: "Delaney", title: "Lounge Programmer", intro: "full"),
  sarte: (first: "Nick", last: "Sarte", title: "Executive Assistant", intro: "title-last"),
  haque: (first: "Hamza", last: "Haque", title: "External Partnerships Programmer", intro: "full"),
  ryu: (first: "Yeeun", last: "Ryu", title: "Director of Communications", intro: "full"),
  conia: (first: "Vincenzina", last: "Conia", title: "Communications Programmer (Marketing)", intro: "full"),
  dhaliwal: (first: "Imrose", last: "Dhaliwal", title: "Communications Programmer (Marketing)", intro: "full"),
  ganetsky: (first: "Alix", last: "Ganetsky", title: "Communications Programmer (Media)", intro: "full"),
  kaur: (first: "Hashmeen", last: "Kaur", title: "Communications Programmer (Productions)", intro: "full"),
  derksen: (first: "Quinn", last: "Derksen", title: "Director of Special Events", intro: "full"),
  gupta: (first: "Jayden", last: "Gupta", title: "Special Events Programmer (Social)", intro: "full"),
  large: (first: "Zenah", last: "Large", title: "Special Events Programmer (Social)", intro: "full"),
  talukder: (first: "Fatin Shadab", last: "Talukder", title: "Special Events Programmer (Research)", intro: "full"),
  lehman: (first: "Benjamin", last: "Lehman", title: "Special Events Programmer (Research)", intro: "full"),
  ogweno: (first: "Ian", last: "Ogweno", title: "Director of Student Services", intro: "full"),
  wong: (first: "Erica", last: "Wong", title: "Student Services Programmer (Academics)", intro: "full"),
  lozano: (first: "Mary", last: "Lozano", title: "Student Services Programmer (Academics)", intro: "full"),
  kumar: (first: "Harsh", last: "Kumar", title: "Services Programmer (Operations)", intro: "full"),
  gray: (first: "Matthew", last: "Gray", title: "Services Programmer (Operations)", intro: "full"),
  durojaiye: (first: "Kay", last: "Durojaiye", title: "Student Services Programmer (Outreach)", intro: "full"),
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
















// --- BASIC LAYOUT AND FORMAT ---
#set page(margin: 1.00in) // Default: 1.75in
#set par(leading: 0.55em, spacing: 0.55em, first-line-indent: 1.8em, justify: true)
// #set text(font: "New Computer Modern")
// #show raw: set text(font: "New Computer Modern Mono")
#show heading: set block(above: 1.4em, below: 1em)

// --- PREFERENCES ---
#show link: underline // Underline Links
#show image: it => {
  // Automatic centering of images
  align(center, it)
}
// #show raw: set text(font: "Fira Code")

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
// #set heading(numbering: "1.")
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
    Date: 2026-09-23 \
    Location: Human Ecology 207 \
    Chaired By: Nick Sarte, Executive Assistant \
    Meeting type: Regular
  ],
  image("../template/ssa_logo.png", width: 2.75cm),
)

#divider()

= Attendance
// Councillor Attendance Table
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
== Guests
- Heaven Kaur; President of UMSU
- Grace Elendu; Vice President of University Affairs of UMSU

#divider()
= Minutes
== Call to Order
Chairperson Nick Sarte called the meeting to order at 6:04 p.m.
== Approval of Agenda
A motion to approve the agenda was moved by Vice President Caleb Pereira and seconded by Director of Student Advocacy Roopak Brar. The agenda was approved as written.
== Treaty Land Acknowledgement
Chairperson Sarte read the treaty land acknowledgement of the SSA.
== Approval of Previous Meeting Minutes
A motion to approve the previous meeting's minutes was moved by Vice President Pereira and seconded by Brar. The meeting minutes were approved as written.

== Reports of Councillors
// Only fill in roles that actually gave a report this meeting
#let report-content = (
  "President and Vice President": [
    - President Noah Crossman and Vice President Pereira gave a summation of the Report of the President and Vice President.
    - *Questions:*
      - President Crossman asked whether having deans of the Faculty of Science present at the SSA Town Hall, as they have in previous Town Halls, is beneficial or a hinderance. If a hinderance, President Crossman or Vice President Pereira may give updates on behalf of the deans.
        - #who("joshi") and #who("brar") spoke in favour of having the deans present, as they are not easy to access for students-at-large.
      - #who("gislason") asked how students may nominate themselves as candidates at the upcoming General Assembly.
        - #who("pereira") stated that
      - #who("hong") asked whether voting for the Community Representatives at the Community Assembly will be restricted to those who self-identify with the groups the Community Representatives will represent.
        - #who("pereira") stated that all students will count toward quorom for the General Assembly. However, voters will be asked only to vote in the elections in which they self-identify for the respective Community Representative group.
      // SKIP: FROM byelection to DUROJAYE

      - #who("uppal") asked about the current situation regarding expansion of the SSA Lounge courtyard.
        - #who("crossman") stated that the courtyard is currently unfinished due to a lack of funds in a previous year. If the previous landscaping architects are still on leave, then the SSA could consider hiring an external architect. The SSA now has the funds to complete an expansion, but it is noted that few people use the courtyard.
        - #who("delaney") stated that students have been using the undeveloped section of the courtyard to play badminton and frisbee, expressing uncertainty about developing the area.
      - #who("kaur") asked about how the proposal to use the referendum fund to create a Neuroscience program (an idea from the 2025-26 academic year) would work.
        - #who("crossman") stated that 2025-26 SSA President Jasmine Groisman had spoken to the Department of Biological Scieneces. The program would exist as its own degree path under Biological Sciences, and the primary use of funding would be to pay the salaries of instructors.
      - #who("kaur") asked if the referendum fund could be used to fund a Pre-Optomery program at the university, stating that the program would not require new instructors, but only a new stream.
        - #who("crossman") stated that this can be discussed with the Associate Dean of Programs.
      - #who("durojaiye") asked if the referendum fund could be used to fund additional sections in courses that currently struggle with long waitlists.
        - #who("crossman") stated that he is unsure how talks would go, but said that it is a conversation he can have with the Associate Dean of Programs.
  ],
  "Treasurer": [
    - #who("sharma") gave a summation of the Report of the Treasurer.
  ],
  "External Partnerships": [

  ],
  "Special Events": [
    - #who("derksen") provided a summation of the Report of the Special Events Team.
    - *Team Bonding Pizza Motion:* A motion to reimburse #who("pereira") for \$138.24 in pizzas purchased for SSA team bonding was moved by Noah Crossman and seconded by April Quill. The motion was carried with one opposition vote from UMSU Director Danylo Kruk.
    - *Team Bonding Pizza Motion:* A motion to reimburse Vice President Pereira for \$448.25 in pizzas purchased for LabTREK was moved by Danylo Kruk and seconded by Noah Crossman. The motion was carried with one opposition vote from UMSU Director Danylo Kruk.
    - *Breakfast and Gratuities Reimbursement Motion:* A motion to reimburse #who("derksen") for \$237.39 for spending on breakfast, gratuities, drinks, and snacks was moved by Caleb Pereira and seconded by Noah Crossman. The motion was carried without opposition.
    - *Comments:*
      - #who("crossman") thanked #who("derksen") for her work on LabTREK.
    - *Questions:*
      - #who("crossman") asked if the Special Events team had any plans aside from the planned event for Orange Shirt Day.
        - #who("derksen") stated that a member of the Physical Education Recreational Kinesiology Student Council (PERKS) wanted to collaborate to hold a running event. Updates on this potential event will be given at a subsequent meeting.
  ],
  "Indigenous Representative": [
    - #who("quill") provided a summation of the Report of the Indigenous Representative.
  ],
  "Accessibility Representative": [
    - #who("vong") gave a summation of the Report of the Accessibility Representative.
    - *Comments:*
      - #who("crossman") thanked #who("vong") for her work on the SSA Discord.
      - #who("crossman") encouraged Councillors to post the SSA's Instagram announcements on the SSA Discord. Councillors who are interested in assisting in the SSA Discord are encouraged to contact #who("crossman").
  ],
  "Student Services": [
    - #who("ogweno"), #who("wong"), and #who("lozano") provided a summation of the Report of the Student Services Team.
    - *Orientation Ice Cream Reimbursement Motion:* A motion to reimburse \$143.66 in ice cream purchased for orientation events was moved by Danylo Kruk and seconded by Hargun Uppal. The motion was carried without opposition.
  ],
  "Communications": [
    - In #who("ryu")'s absence, #who("ganetsky") provided a summation of the Report of the Communications Team.
  ],
  "Lounge Programmer": [
    - #who("delaney") provided a summation of the Report of the Lounge Programmer.
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
    - #who("pereira") provided a summation of the Report of the Executive Committee, in lieu of #who("sarte") who was serving as the Chairperson of the meeting.
    - *Comments:*
      - #who("sarte") reminded Councillors that the deadline to join the Board of Science Groups (BOSG) is approaching soon (September 30, 11:59 p.m.). Councillors were encouraged to spread this reminder.
    - *Questions:*
      - #who("joshi") asked if the deadline to apply to the BOSG would be extended if a group was awaiting full recognition by UMSU, or if a group was awaiting UMSU approval for constituional amendments  required to join the BOSG. It was noted that the process to amend a club constitution is often slow to complete.
        - #who("sarte") stated that if a group has been pre-approved by UMSU and the group's executives have completed the required Sexual Violence Prevention Workshop for approval, they can contact him and explain the group's situation, and contact him subsequently upon obtaining full recognition.
        - With regard to the constitutional amendments, #who("sarte") stated that he will contact all groups expected to join the BOSG, working with groups on a case-by-case basis.
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
== Miscellaneous
// TODO: Not finished. Need to figure out how to actually transcribe allat.
- Following the Report of the President and Vice President, UMSU President Heaven Kaur and UMSU Vice President of University Affairs Grace Elendu visited the SSA Council meeting.
- *Speaking Motion:* A motion to allow Kaur and Elendu to speak was moved by President Crossman and seconded by Senator Joshi.
- President Kaur reminded Councillors of UMSU's planned protest at the Manitoba Legislative Building,
- Vice President of University Affairs Elendu reminded Councillors of UMSU's Ask Admin event.
- *Questions and comments:*
  - Senator Joshi asked whether there is anything the SSA could help with in regards to the events.
    - President Kaur responded, stating that it w ould be helpful to advertise the event to students.
  - UMSU Director Danylo Kruk mentioned that some Councillors had questions regarding the resignation the Vice President of External Affairs and Vice President of Finance and Operations.
    - Vice President Elendu responded, stating that the UMSU Executive Committee prefers that a by-election not be held. Elendu
  - Treasurer Anshika Sharma
  - Vice President of University Affairs Grace Elendu
  - Brar
  - Vice President Pereira
  -
== New Business
- Treasurer Sharma requested that when filling out the SSA Councillor reimbursement form, Councillors match the budget category on the form with the same ballot allocation as the newly approved SSA budget.
- Treasurer Sharma stated that the SSA received the 30% advance payment from UMSU. // TODO: elaborate
- *Council Meeting Pizza Motion:* A motion to reimburse the cost of \$167.83 in pizza purchased for the present Council meeting was moved by Senator Joshi and seconded by Black Students' Representative Seun Fatunmbi. The motion was carried without opposition.
- President Crossman thanked Executive Assistant Nick Sharma for chairing the meeting.
- Vice President Pereira thanked Councillors for their work.
== Important Dates
== Adjournment
A motion to adjourn the meeting was moved by Kruk and seconded by President Crossman. The motion was adopted without objection and the meeting was adjourned at 8:08 p.m.

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
