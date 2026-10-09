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
    - *Motion P100726A - UM Food Bank support fee:* A motion to provide \$250.00 to the University of Manitoba Food Bank was moved by Noah Crossman, seconded by April Quill, and carried without opposition.
    - *Motion P100726B - Purchasing grocery store gift cards:* A motion to purchase \$375.00 in grocery store gift cards was moved by Noah Crossman, seconded by Zaina Abazid, and carried without opposition.
  ],

  // "Treasurer": [],
  // "UMSU Director": [],
  // "Senators": [],
  // "Director of Student Advocacy": [],
  "Indigenous Representative": [
    - #who("quill") summarized the Report of the Indigenous Representative.
    - *Pumpkin Painting Funding Motion:* #fullname("quill") moved a motion to approve \$150.00 in funding for the Pumpkin Painting Hangout event to be held in collaboration with the University 1 Student Council and the University of Manitoba Indigenous Students' Association. #fullname("gislason") seconded the motion. The motion was carried without opposition.
  ],
  // "International Representative": [],
  // "Accessibility Representative": [],
  "2SLGBTQIA+ Representative": [
    - #who("gislason") summarized the Report of the 2SLGBTQIA+ Representative.
  ],
  "Women's Representative": [
    - #who("abazid") summarized the Report of the Women's Representative.
    - *Questions:*
      - #who("negi") asked if the planned Women in Science event on November 19 would conflict with the planned SSA Town Hall event.
        - #who("durojaiye") stated that the current planned date for the SSA Town Hall is November 20.
  ],
  // "First Years' Representative": [],
  // "Racialized Representative": [],
  // "Black Students' Representative": [],
  "Communications": [
    - In #who("ryu")'s absence, #who("kaur") summarized the Report of the Communications Team.
    - *Questions:*
      - #who("sarte") asked if the QR code to apply for SSA travel and sponsorship funds is out to date.
        - #who("kaur") stated that she will ask the Communications team.
    - *Comments:*
      - #who("crossman") stated that for the SSA Instagram posts displaying upcoming dates where the SSA Lounge is booked for events, it may be preferable to use the term "Lounge booking" opposed to "Lounge closure."
  ],
  "Student Services": [
    - #who("wong") and #who("lozano") summarized the Report of the Student Services Team.
    - *Discussion:* #who("wong") noted an email received from the Academic Advising office from the Faculty of Engineering asking if the office may recommend the SSA's tutoring program.
      - #who("wong") noted that the SSA tutoring program does not ask students being tutored their faculty or otherwise impose significant restrictions. The primary question to discuss is whether the office should advertise the program.
      - #who("crossman") asked whether the office indicated how many students would be interested in joining the tutoring program.
        - #who("wong") stated that the office asked only for permission to recommend the program to engineers.
      - #who("crossman") stated that the SSA pays a flat rate for access for the tutoring program, noting that cost would not be an issue, but the main concern would be engineering students occupying spots in the program that would otherwise have gone to science students.
      - #who("talukder") noted that the University of Manitoba Engineering Society (UMES) operates its own program which charges for tutoring.
        - #who("pereira") stated that while engineering students independently joining the SSA tutoring program is not an issue, it may be undesirable to actively advertise in engineering spaces, as it may encroach on the UMES tutoring program.
      - #who("pereira") asked if UMES offers tutors for science courses, noting that there is no risk of encroaching on the UMES program if there is no overlap in courses offered.
        - #who("negi") stated that UMES does offer tutors for science courses, such as MATH 1500.
      - #who("negi") stated that if the SSA chooses not to allow the office to advertise, it may be preferable to instead recommend the Academic Learning Centre's tutoring program.
      - #who("pereira") stated that it may be worth contacting UMES directly about the matter. #who("pereira") suggested responding to the office's email by stating that the SSA will contact UMES and provide an update upon resolution.
  ],
  "Special Events": [
    - #who("derksen") summarized the Report of the Special Events team.
    - *Comments:*
      - #who("lozano") stated that she is a member of the Psychology Students Association (PSA) and may assist in helping connect the SSA with the PSA.
  ],
  "Lounge Programmer": [
    - #who("delaney") summarized the Report of the Lounge Programmer.
    - *Lounge Pool Table Motion:* Danylo Kruk moved a motion to approve \$157.32 in funding to purchase six leather pool table pockets to repair the SSA Lounge's pool table. Nick Sarte, proxying on behalf of Hargun Uppal, seconded the motion. The motion was carried with one opposition vote by Caleb Pereira.
    - *SSA Office Snack Purchase Motion:* #fullname("gislason") moved a motion to approve \$240.00 in funding for snacks for the SSA office. #fullname("pereira") seconded the motion. The motion was carried without opposition.
    - *Discussion:* Councillors briefly discussed preferences for snacks.
    - *Questions:*
      - #who("negi") asked whether Professor Daniel Rea's EDI office hours will be restricted to students in Computer Science or if they will be open to all students.
        - #who("delaney") stated that Rea did not specify, though the office hours will likely be available to all students.
  ],
  // "External Partnerships Programmer": [],
)

#let committee-reports = (
  "Executive Committee": [
    - #who("sarte") summarized the report of the Executive Committee.
    - #who("sarte") stated that fifteen groups have been admitted to the Board of Science Student Groups (BOSG) and some additional groups are interested in joining. However, the deadline is quickly approaching and the remaining groups have had issues communicating with UMSU, particularly with regard to club pre-approval and club constitutional amendments. #who("sarte") notes that a lack of UMSU pre-approval is an issue for admission.
    - *Discussion:* #who("sarte") asked Councillors if a strict deadline should be set for joining the BOSG, or if the SSA should work with groups on a case-by-case basis to potentially join the BOSG.
      - #who("negi") asked which of the remaining groups interested in joining the BOSG are departmental groups.
        - #who("sarte") stated that there are five student groups interested in applying to the BOSG who have not yet completed the process. Four are departmental groups: the Biology Undergraduate Students' Association (BUGS), University of Manitoba Statistics Students (UMs2),  EigenClub, and Chem Club. One (UMTI) is non-departmental.
      - #who("pereira") stated that it would be preferable to give grace to the groups who have made a meaningful effort to join the BOSG, but leniency should not be provided to groups who only begin the process of admission after the deadline has already passed.
      - #who("kruk") spoke in favour of a strict deadline, stating that he would prefer leniency in a first-time situation, but stated that in the previous academic year he gave significant effort in assisting clubs with UMSU approval and constitutional amendments, stating that clubs should follow the given deadlines.
      - #who("crossman") stated that while the remaining groups began the admission process later than what would be ideal, the groups must await a slow process to obtain approval by UMSU, and punishing clubs for this may be undesirable.
      - #who("crossman") stated that persistent deadline extensions will not solve the issue, and proposed an alternate arrangement in which the remaining groups could obtain tentative admission into the BOSG through completion of UMSU's required Sexual Violence Prevention Workshop, with a requirement to obtain full UMSU club approval by the end of the Fall semester. #who("crossman") stated that groups with tentative admission should be ineligible for SSA funds until they obtain full admission into the BOSG.

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
