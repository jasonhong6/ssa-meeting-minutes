// =====================================================================
// people.typ — who's who on Council, for automatic name formatting
// =====================================================================
// Update this file when the roster changes (once per term, or when
// someone is replaced). Pass it to the template with:
//
//   #import "people.typ": people
//   #show: minutes.with(people: people, ...)
//
// Then, in reports and motions:
//
//   #who("crossman")       first mention in a report -> "President Crossman"
//                          later mentions in that report -> "Crossman"
//   #surname("crossman")   always "Crossman" (does not count as a first mention)
//   #fullname("crossman")  always "Noah Crossman" (does not count either)
//
// Each entry looks like:
//
//   key: (first: "...", last: "...", title: "...", intro: "...")
//
//   key    A short, unique, lowercase handle you type in `who("...")`.
//          Usually the surname; use something like `smith-j` if two
//          people share one.
//   title  Only shown by the two "title-..." intro styles, but worth
//          filling in for every entry as a record.
//   intro  How the person is introduced on first mention in a report:
//            "title-last" -> "President Crossman"        (unique titles; default)
//            "title-full" -> "Senator Jane Smith"        (several holders, short title)
//            "full"       -> "Jane Smith"                (long or shared titles)

#let people = (
  crossman: (first: "Noah", last: "Crossman", title: "President", intro: "title-last"),
  pereira: (first: "Caleb", last: "Pereira", title: "Vice President", intro: "title-last"),
  torres: (first: "Reyna", last: "Torres", title: "Chairperson", intro: "title-last"),
  hong: (first: "Jason", last: "Hong", title: "Secretary", intro: "title-last"),
  negi: (first: "Yashsavi", last: "Negi", title: "Senator", intro: "title-last"),
  uppal: (first: "Hargun", last: "Uppal", title: "Senator", intro: "title-last"),
  joshi: (first: "Kushal", last: "Joshi", title: "Senator", intro: "title-last"),
  kruk: (first: "Danylo", last: "Kruk", title: "UMSU Director", intro: "title-last"),
  brar: (first: "Roopak", last: "Brar", title: "Director of Student Advocacy", intro: "title-last"),
  singh: (first: "Gurminder", last: "Singh", title: "International Representative", intro: "title-last"),
  abazid: (first: "Zaina", last: "Abazid", title: "Women’s Representative", intro: "title-last"),
  fatunmbi: (first: "Seun", last: "Fatunmbi", title: "Black Students’ Representative", intro: "title-last"),
  gislason: (first: "Alice Miranda", last: "Gislason", title: "2SLGBTQIA+ Representative", intro: "title-last"),
  vong: (first: "Victoria", last: "Vong", title: "Accessibility Representative", intro: "title-last"),
  quill: (first: "April", last: "Quill", title: "Indigenous Representative", intro: "title-last"),
  sharma: (first: "Anshika", last: "Sharma", title: "Treasurer", intro: "title-last"),
  delaney: (first: "Sean", last: "Delaney", title: "Lounge Programmer", intro: "title-last"),
  sarte: (first: "Nick", last: "Sarte", title: "Executive Assistant", intro: "title-last"),
  haque: (first: "Hamza", last: "Haque", title: "External Partnerships Programmer", intro: "title-last"),
  ryu: (first: "Yeeun", last: "Ryu", title: "Director of Communications", intro: "title-last"),
  conia: (first: "Vincenzina", last: "Conia", title: "Communications Programmer (Marketing)", intro: "title-last"),
  dhaliwal: (first: "Imrose", last: "Dhaliwal", title: "Communications Programmer (Marketing)", intro: "title-last"),
  ganetsky: (first: "Alix", last: "Ganetsky", title: "Communications Programmer (Media)", intro: "title-last"),
  kaur: (first: "Hashmeen", last: "Kaur", title: "Communications Programmer (Productions)", intro: "title-last"),
  derksen: (first: "Quinn", last: "Derksen", title: "Director of Special Events", intro: "title-last"),
  gupta: (first: "Jayden", last: "Gupta", title: "Special Events Programmer (Social)", intro: "title-last"),
  large: (first: "Zenah", last: "Large", title: "Special Events Programmer (Social)", intro: "title-last"),
  talukder: (
    first: "Fatin Shadab",
    last: "Talukder",
    title: "Special Events Programmer (Research)",
    intro: "title-last",
  ),
  lehman: (first: "Benjamin", last: "Lehman", title: "Special Events Programmer (Research)", intro: "title-last"),
  ogweno: (first: "Ian", last: "Ogweno", title: "Director of Student Services", intro: "title-last"),
  wong: (first: "Erica", last: "Wong", title: "Student Services Programmer (Academics)", intro: "title-last"),
  lozano: (first: "Mary", last: "Lozano", title: "Student Services Programmer (Academics)", intro: "title-last"),
  kumar: (first: "Harsh", last: "Kumar", title: "Services Programmer (Operations)", intro: "title-last"),
  gray: (first: "Matthew", last: "Gray", title: "Services Programmer (Operations)", intro: "title-last"),
  durojaiye: (first: "Kay", last: "Durojaiye", title: "Student Services Programmer (Outreach)", intro: "title-last"),
)
