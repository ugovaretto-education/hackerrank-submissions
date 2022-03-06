use std::io::{self, BufRead};

fn is_kaprekar(n: u32) -> bool {
    if n == 1 { return true; }
    let s = n.pow(2).to_string();
    let len = s.len();
    if len < 2 { return false; }
    for i in 1..len {
        let l = &s[0..i];
        let r = &s[i..len];
        let n1: u32 = l.parse().unwrap();
        let n2: u32 = r.parse().unwrap();
        if n1 != 0 && n2 != 0 && n1 + n2 == n { return true; }
    }
    return false;
}    

fn main() {
    let stdin = io::stdin();
    let mut iterator = stdin.lock().lines();
    let p: usize = iterator.next().unwrap().unwrap().parse().unwrap();
    let q: usize = iterator.next().unwrap().unwrap().parse().unwrap();
    let mut nums = String::new(); 
    for n in p..=q {
        let m: u32 = n as u32;
        if is_kaprekar(m) {
            nums.push_str(m.to_string().as_str());
            nums.push_str(" ");
        }
    }
    if nums.len() == 0 { println!("INVALID RANGE"); }
    else {
        println!("{}", nums);
    }
}
