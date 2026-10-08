
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

// ---------------------------------------------------------------
// 2. SETTINGS
// ---------------------------------------------------------------
// Headings at this level or higher (1 = top level) reset "first mention".
// With 2, both `=` and `==` headings reset; `===` and below do not.
#let reset-level = 3

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
