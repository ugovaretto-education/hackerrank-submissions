use std::iter::FromIterator;
use std::io::{self, BufRead};

fn make_bigger(st: &String) -> String {
    let mut s: Vec<char> = st.as_str().chars().collect();
    let len = s.len();
    let mut i = len - 1;
    while i > 0 && s[i-1] >= s[i]     { 
        i -= 1; 
    }
    if i == 0 {return String::from("no answer");}
    let pivot = i - 1;
    i = len - 1;
    while s[i] <= s[pivot] && i > pivot { i -= 1; }
    s.swap(i, pivot);
    let r = &mut s[pivot+1..len];
    r.sort();
    String::from_iter(s.iter())   
}

fn main() {
    let stdin = io::stdin();
    let mut iterator = stdin.lock().lines();
    iterator.next();
    iterator.for_each(|l| {
        let s = l.unwrap();
        println!("{}", make_bigger(&s));
    });
}
