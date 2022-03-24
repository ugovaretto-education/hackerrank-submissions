use std::io;
use std::io::BufRead;
use std::collections::HashMap;
#[macro_use]
extern crate lazy_static;

lazy_static! {
    static ref DECH: HashMap<u32, &'static str> = 
    HashMap::from([(1, "one"),
         (2, "two"),
         (3, "three"),
         (4, "four"),
         (5, "five"),
         (6, "six"),
         (7, "seven"),
         (8, "eight"),
         (9, "nine"),
         (10, "ten"),
         (11, "eleven"),
         (12, "twelve")]);
    
    static ref TEEN: HashMap<u32, &'static str> = 
    HashMap::from([(10, "ten"),
         (11, "eleven"),
         (12, "twelve"),
         (13, "thirteen"),
         (14, "fourteen"),
         (15, "fifteen"),
         (16, "sixteen"),
         (17, "seventeen"),
         (18, "eighteen"),
         (19, "nineteen")]);   
          
    static ref TENTHS: HashMap<u32, &'static str> = 
    HashMap::from([(20, "twenty"),
         (30, "thirty"),
         (40, "forty"),
         (50, "fifty")]);
}

fn time_in_words(h: u32, m: u32) -> String {
    match m {
        0 => DECH[&h].to_owned() + " o' clock",
        1 => String::from("one minute past ") + DECH[&h],
        15 => String::from("quarter past ") + DECH[&h],
        30 => String::from("half past ") + DECH[&h],
        45 => String::from("quarter to ") + DECH[&(h+1)],
        _ => if m < 30 { minutes(m) + " minutes past " + DECH[&h]}
             else { minutes(60 - m) + " minutes to " + DECH[&(h+1)]}
    }
}

fn minutes(m: u32) -> String {
    match m {
        1..=9 => DECH[&m].to_owned(),
        10..=19 => TEEN[&m].to_owned(),
        20 | 30 | 40 | 50 => TENTHS[&m].to_owned(),
        _ => TENTHS[&(10 * (m / 10))].to_owned() + " " + DECH[&(m % 10)]
    }
}

fn main() -> io::Result<()> {
    let stdin = io::stdin();
    let handle = stdin.lock();
    let mut lines = handle.lines();
    let l = match lines.next() {
        Some(Ok(line)) => line.split_whitespace().into_iter().flat_map(|x| x.parse::<u32>()).collect(),
        _ => vec![]
    };
    assert_eq!(l.len(), 1);
    assert!(l[0] > 0 && l[0] <= 12);
    let l2 = match lines.next() {
        Some(Ok(line)) => line.split_whitespace().into_iter().flat_map(|x| x.parse::<u32>()).collect(),
        _ => vec![]
    };
    assert_eq!(l2.len(), 1);
    assert!(l2[0] < 60);
    println!("{}", time_in_words(l[0], l2[0]));
    Ok(())
}
