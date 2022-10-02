
use std::env;
use std::fs::File;
use std::io::{self, BufRead, Write, Error, ErrorKind};

fn service_lane<'a>(width: &'a[i32], cases: &[(usize, usize)]) -> Vec<&'a i32> {
    let mut ret = Vec::<&'a i32>::new();
    for w in cases {
        ret.push(width[w.0..=w.1].iter().min().unwrap());
    }
    ret
}

fn main() -> Result<(), std::io::Error> {
    let stdin = io::stdin();
    let mut stdin_iterator = stdin.lock().lines();

    let mut fptr = File::create(env::var("OUTPUT_PATH").unwrap()).unwrap();

    let _ = stdin_iterator.next().unwrap().unwrap();

    let width: Vec<i32> = stdin_iterator
        .next().ok_or(Error::new(ErrorKind::Other,"Empty input"))??
        .split(' ')
        .map(|s| s.trim().parse::<i32>().unwrap())
        .collect();

    let mut cases = Vec::<(usize, usize)>::new();

    for l in stdin_iterator {
        let c = l?
            .split(' ')
            .map(|s| s.trim().parse::<usize>().unwrap())
            .collect::<Vec<usize>>();
        cases.push((c[0], c[1]));
    }

    let result = service_lane(&width, &cases);

    for i in 0..result.len() {
        write!(&mut fptr, "{}", result[i]).ok();

        if i != result.len() - 1 {
            writeln!(&mut fptr).ok();
        }
    }

    writeln!(&mut fptr).ok();
    Ok(())
}
