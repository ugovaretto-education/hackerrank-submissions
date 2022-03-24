// parse:
// 7 3
// 1 2 5 6 7 8


use std::io;
use std::io::BufRead;

fn main() -> io::Result<()> {
    let stdin = io::stdin();
    let handle = stdin.lock();
    let mut lines = handle.lines();
    let l = match lines.next() {
        Some(Ok(line)) => line.split_whitespace().into_iter().map(|x| x.parse::<u32>()).collect(),
        _ => vec![]
    };
    assert_eq!(l.len(), 2);
    let l2 = match lines.next() {
        Some(Ok(line)) => line.split_whitespace().into_iter().map(|x| x.parse::<u32>()).collect(),
        _ => vec![]
    };
    assert!(!l2.is_empty());
    Ok(())
}
