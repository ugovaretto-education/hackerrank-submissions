// parse:
// 7 3
// 1 2 5 6 7 8

use std::io;
use std::io::BufRead;

fn beautiful_triplets(v: &Vec<u32>, d: u32) -> u32 {
    if v.len() < 3 { return 0; }
    let mut t = 0_u32; 
    for i in 0..v.len()-2 {
        for j in (i + 1)..v.len() - 1 {
            if v[j] - v[i] != d { continue; }
            for k in (j + 1)..v.len() {
                if v[k] - v[j] == d {
                    t += 1;
                }
            }
        }
    }
    t
}


fn main() -> io::Result<()> {
    let stdin = io::stdin();
    let handle = stdin.lock();
    let mut lines = handle.lines();
    let l = match lines.next() {
        Some(Ok(line)) => line.split_whitespace().into_iter().flat_map(|x| x.parse::<u32>()).collect(),
        _ => vec![]
    };
    assert_eq!(l.len(), 2);
    let l2 = match lines.next() {
        Some(Ok(line)) => line.split_whitespace().into_iter().flat_map(|x| x.parse::<u32>()).collect(),
        _ => vec![]
    };
    assert!(!l2.is_empty());
    println!("{}", beautiful_triplets(&l2, l[1]));
    Ok(())
}
