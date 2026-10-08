// =====================================================================
// reports.typ — the reports given at this meeting
// =====================================================================
// This is the only file where you write report text. Add an entry only
// for roles that actually reported: any role left out automatically gets
// a dagger (†) next to its heading, meaning no report was given.
//
// Each key must match a role name exactly. A misspelled key stops the
// build with a message listing the valid roles. The valid names are the
// two role lists at the top of minutes.typ; the full set is also stubbed
// out below (commented out), so you can uncomment a line and fill it in.
//
// Writing tips (Typst treats a few characters specially in text):
//   - Write dollar signs as \$ (a bare $ starts math mode):  \$250
//   - Write @ as \@ (a bare @ is read as a reference):       name\@example.ca
//   - Write # as \# unless you mean to call a function:      \#12
//   - Names: use #who("key") for people listed in people.typ. The first
//     mention within a report uses the intro style ("President Crossman");
//     later mentions in the same report are just the last name.
//   - Mark up as usual: *bold*, _italic_, "- " for bullet points,
//     "+ " for numbered items.

#import "../minutes.typ": fullname, surname, who

#let council-reports = (
  "President and Vice President": [
    #who("crossman") reported that the Executive Committee met twice this
    month. Later in the report, #who("crossman") noted that the budget
    request of \$250 was approved.

    - Event planning is on schedule.
    - Two committee seats remain open.
  ],

  // "Treasurer": [],
  // "UMSU Director": [],
  // "Senators": [],
  // "Director of Student Advocacy": [],
  // "Indigenous Representative": [],
  // "International Representative": [],
  // "Accessibility Representative": [],
  // "2SLGBTQIA+ Representative": [],
  // "Women's Representative": [],
  // "First Years' Representative": [],
  // "Racialized Representative": [],
  // "Black Students' Representative": [],
  // "Communications": [],
  // "Student Services": [],
  // "Special Events": [],
  // "Lounge Programmer": [],
  // "External Partnerships Programmer": [],
)

#let committee-reports = (
  "Executive Committee": [
    Example report.
  ],

  // "Selections Committee": [],
  // "Bylaws Committee": [],
)
