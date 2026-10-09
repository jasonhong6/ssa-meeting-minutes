// =====================================================================
// meeting.typ — the details of this meeting
// =====================================================================
// Copy this file (with reports.typ and attendance.csv) into a new
// folder for each meeting, then fill in what's below. Anything left as
// `none` prints as a yellow [FILL IN: ...] in the PDF, so you can compile
// at any point to see what's still missing.
//
// Compile from this folder with the project root one level up:
//   typst compile --root .. meeting.typ

#import "../template/minutes.typ": *
#import "../template/people.typ": people
#import "reports.typ": committee-reports, council-reports, final-considerations, other-business

#set document(
  author: "Jason Hong",
  description: "Official minutes of the SSA Council regular meeting held on September 23, 2026.",
)

#show: minutes.with(
  people: people,
  // chair: "Reyna Torres", // default is set in minutes.typ; uncomment to override

  // --- Header ---
  date: datetime(year: 2026, month: 10, day: 7).display(), // e.g. "June 24, 2026"
  location: "Science Students' Association Lounge (Armes 209)",
  meeting-type: "Regular", // e.g. "Regular"

  // --- Attendance (statuses: Present, Absent, Absent with regrets, Position vacant) ---
  attendance: csv("attendance.csv"),
  // One entry per line, e.g. ([Jason Hong; Secretary (no proxy required)],).
  // Note the trailing comma when there is only one entry. Use () for "None."
  regrets: (
    [
      #fullname("joshi")\; Senator
      - Proxy: #fullname("hong")\; Secretary
    ],
    [
      #fullname("uppal")\; Senator
      - Proxy: #fullname("sarte")\; Executive Assistant
    ],
    [
      #fullname("brar")\; Director of Student Advocacy
      - Proxy: #fullname("talukder")\; Special Events Programmer (Research)
    ],
    [#fullname("sharma")\; Treasurer],
    [#fullname("haque")\; External Partnerships Programmer],
    [#fullname("conia")\; Communications Programmer (Marketing)],
    [#fullname("ryu")\; Director of Communications],
    [#fullname("dhaliwal")\; Communications Programmer (Marketing)],
    [#fullname("ganetsky")\; Communications Programmer (Media)],
    [#fullname("large")\; Special Events Programmer (Social)],
    [#fullname("ogweno")\; Director of Student Services],
    [#fullname("kumar")\; Student Services Programmer (Operations)],
    [#fullname("gray")\; Student Services Programmer (Operations)],
  ),

  // --- Minutes ---
  called-to-order: "6:04 p.m.", // include a.m./p.m., e.g. "7:02 p.m."
  // `result` must be "as written" or "as amended". Names can be plain text
  // or surname("key") / fullname("key") from people.typ.
  agenda: (moved-by: who("gislason"), seconded-by: who("vong"), result: "as written"),
  previous-minutes: (moved-by: who("negi"), seconded-by: who("crossman"), result: "as written"),
  reports: council-reports,
  committee-reports: committee-reports,
  other-business: other-business, // write [None.] if there is nothing
  // important-dates: none, // write [None.] if there is nothing
  final-considerations: final-considerations,
  adjournment: (time: "7:02 p.m.", moved-by: who("fatunmbi"), seconded-by: who("pereira")), // time e.g. "8:41 p.m."

  // --- Motions (appendix; omitted entirely if there are none) ---
  motions: (
    // motion(
    //   title: "Strike the Executive Committee",
    //   id: "P062426A",
    //   category: "President & Vice President's Report",
    //   body: [
    //     *WHEREAS* the Executive Committee shall be composed of:
    //     - Executive Assistant; as chair
    //     - President
    //     - Treasurer
    //     #v(0.8em)
    //     *BE IT RESOLVED* that the Executive Committee be struck.
    //   ],
    //   moved-by: surname("crossman"),
    //   seconded-by: "John Smith",
    //   status: "Passed",
    // ),
    motion(
      title: "UM Food Bank support fee",
      id: "P100726A",
      category: "Report of the President and Vice President",
      body: [
        *WHEREAS* SSA is developing its new Grocery Support Program.

        *WHEREAS* SSA will be partnering with the UM Food Bank to provide groceries for students.

        *WHEREAS* the UM Food Bank has requested \$250 to account for the potential influx of students. \ \

        *BE IT RESOLVED* that the SSA commits \$250 to the UM Food Bank to support the SSA Grocery Support Program.
      ],
      moved-by: fullname("crossman"),
      seconded-by: fullname("quill"),
      status: "Passed",
    ),

    motion(
      title: "Purchasing grocery store gift cards",
      id: "P100726B",
      category: "Report of the President and Vice President",
      body: [
        *WHEREAS* SSA is developing its new Grocery Support Program. \
        *WHEREAS* SSA will purchase 5 \$75 gift cards from a local grocery store to distribute to recipients. \ \

        *BE IT RESOLVED* that the SSA commits \$375 to the purchase of 5 grocery store gift cards to support the SSA Grocery Support Program.
      ],
      moved-by: fullname("crossman"),
      seconded-by: fullname("abazid"),
      status: "Passed",
    ),

    motion(
      title: "Pumpkin Painting Funding Motion",
      category: "Report of the Indigenous Representative",
      body: [
        Approve \$150.00 in funding for the Pumpkin Painting Hangout event.
      ],
      moved-by: fullname("quill"),
      seconded-by: fullname("gislason"),
      status: "Passed",
    ),

    motion(
      title: "Lounge Pool Table Motion",
      category: "Report of the Lounge Programmer",
      body: [
        Approve \$157.32 in funding to purchase pool table pockets to repair the SSA Lounge's pool table.
      ],
      moved-by: fullname("kruk"),
      seconded-by: fullname("sarte"),
      status: "Passed",
    ),

    motion(
      title: "SSA Office Snack Purchase Motion",
      category: "Report of the Lounge Programmer",
      body: [
        Approve \$240.00 in funding for snacks for the SSA office.
      ],
      moved-by: fullname("gislason"),
      seconded-by: fullname("pereira"),
      status: "Passed",
    ),

    motion(
      title: "Council Meeting Pizza Motion",
      category: "Other Business",
      body: [
        Approve \$142.28 reimbursement to Caleb Pereira for the cost of pizzas purchased for the present Council meeting.
      ],
      moved-by: fullname("pereira"),
      seconded-by: fullname("gislason"),
      status: "Passed",
    ),
  ),
)

