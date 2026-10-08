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

#import "../template/minutes.typ": fullname, surname, who

#let council-reports = (
  "President and Vice President": [
    - #who("crossman") and #who("pereira") summarized the Report of the President and Vice President.
  ],

  // "Treasurer": [],
  // "UMSU Director": [],
  // "Senators": [],
  // "Director of Student Advocacy": [],
  "Indigenous Representative": [
    - #who("quill") summarized the Report of the Indigenous Representative.
  ],
  // "International Representative": [],
  // "Accessibility Representative": [],
  "2SLGBTQIA+ Representative": [
    - #who("gislason") summarized the Report of the Indigenous Representative.
  ],
  "Women's Representative": [
    - #who("abazid") summarized the Report of the Women's Representative.
  ],
  // "First Years' Representative": [],
  // "Racialized Representative": [],
  // "Black Students' Representative": [],
  "Communications": [
    - In #who("ryu")'s absence, #who("kaur") summarized the Report of the Communications Team.
  ],
  "Student Services": [
    - #who("wong") and #who("lozano") summarized the Report of the Student Services Team.
  ],
  // "Special Events": [],
  "Lounge Programmer": [
    - #who("delaney") summarized the Report of the Lounge Programmer.
    - *Lounge Pool Table Motion:* Danylo Kruk moved a motion to approve in \$157.32 in funding to purchase six leather pool table pockets to repair the SSA Lounge's pool table. Nick Sarte, proxying on behalf of Hargun Uppal, seconded the motion. The motion was carried with one opposition vote by Caleb Pereira.
    - *SSA Office Snack Purchase Motion:* #fullname("gislason") moved a motion to approve \$240.00 in funding for snacks for the SSA office. #fullname("pereira") seconded the motion. The motion was carried without opposition.
    - *Questions:*
      - #who("negi") asked whether Professor Daniel Rea's EDI office hours will be restricted to students in Computer Science or if they will be open to all students.
        - #who("delaney") stated that Rea did not specify, though the office hours will likely be available to all students.
  ],
  // "External Partnerships Programmer": [],
)

#let committee-reports = (
  "Executive Committee": [
    Example report.
  ],

  // "Selections Committee": [],
  // "Bylaws Committee": [],
)

#let other-business = (
  [
    - #who("pereira") provided a notice of motion for two upcoming motions to be moved by the Bylaws Committee. One motion will amend the committee itself, and the other well amend the section on running general elections.
    - *Council Meeting Pizza Motion:* #fullname("pereira") moved a motion to reimburse himself \$142.28 in pizzas purchased for the present Council meeting. #fullname("gislason") seconded the motion. #who("kruk") asked a question about the motion. The motion was carried with one opposition vote from #fullname("kruk").
  ]
)

#let final-considerations = (
  [
    - #who("pereira") stated that for the subsequent Council meeting, it may be desirable to set up the tables in the SSA Lounge further away from Colosimo and place Councillors giving reports closer to the center of the room, as the volume produced by the cafe's fridge made it difficult to hear reports.
    - #who("torres") stated that it is distracting to speak or have conversations when a Councillor is giving their report.
  ]
)
