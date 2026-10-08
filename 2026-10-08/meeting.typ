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
  regrets: none,

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
  ),
)

