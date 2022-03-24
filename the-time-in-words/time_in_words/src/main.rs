use std::io;
use std::io::BufRead;
use std::collections::HashMap;

fn dech_map() -> HashMap<u32, String> {
    vec![(1, "one"),
         (2, "two"),
         (3, "three"),
         (4, "four"),
         (5, "five"),
         (6, "six"),
         (7, "seven"),
         (8, "eight"),
         (9, "nine"),
         (10, "ten"),
         (11, "eleven")].iter()
         .map(|(k,v)| (k.to_owned(), v.to_string()))
         .collect::<HashMap<_,_>>()
}

fn teen_map() -> HashMap<u32, String> {
    vec![(10, "ten"),
         (11, "eleven"),
         (12, "twelve"),
         (13, "thirteen"),
         (14, "fourteen"),
         (15, "fifteen"),
         (16, "sixteen"),
         (17, "seventeen"),
         (18, "eighteen"),
         (19, "nineteen")].iter()    
         .map(|(k,v)| (k.to_owned(), v.to_string()))
         .collect::<HashMap<_,_>>()
}

fn tenth_map() -> HashMap<u32, String> {
    vec![(20, "twenty"),
         (30, "thirty"),
         (40, "forty"),
         (50, "fifty")].iter()
         .map(|(k,v)| (k.to_owned(), v.to_string()))
         .collect::<HashMap<_,_>>()
}


fn time_in_words(h: u32, m: u32) -> String {
    let dec = dech_map();
    match m {
        0 => dec[&h].to_owned() + " o' clock",
        1 => String::from("one minute past ") + dec[&h].as_str(),
        15 => String::from("quarter past ") + dec[&h].as_str(),
        30 => String::from("half past ") + dec[&h].as_str(),
        45 => String::from("quarter to ") + dec[&(h+1)].as_str(),
        _ => if m < 30 { minutes(m) + " minutes past " + dec[&h].as_str()}
             else { minutes(60 - m) + " minutes to " + dec[&(h+1)].as_str()}
    }
}

fn minutes(m: u32) -> String {
    let dec = dech_map();
    let teen = teen_map();
    let tenths = tenth_map();
    match m {
        1..=9 => dec[&m].to_owned(),
        10..=19 => teen[&m].to_owned(),
        20 | 30 | 40 | 50 => tenths[&m].to_owned(),
        _ => tenths[&(10 * (m / 10))].to_owned() + " " + dec[&(m % 10)].as_str()
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
    let l2 = match lines.next() {
        Some(Ok(line)) => line.split_whitespace().into_iter().flat_map(|x| x.parse::<u32>()).collect(),
        _ => vec![]
    };
    assert_eq!(l2.len(), 1);
    println!("{}", time_in_words(l[0], l2[0]));
    Ok(())
}
