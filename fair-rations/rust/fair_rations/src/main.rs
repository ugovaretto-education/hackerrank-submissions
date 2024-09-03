// use std::env;
// use std::fs::File;
use std::io::stdout;
use std::io::{self, BufRead, Write};

/*
 * Complete the 'fairRations' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts INTEGER_ARRAY B as parameter.
 */

fn odd(x: i32) -> bool {
    x % 2 != 0
}

fn fair_rations(mut v: Vec<i32>) -> i32 {
    let mut b: usize = 0;
    let mut e: usize = v.len();
    let mut cnt: i32 = 0;
    loop {
        while b < e && !odd(v[b]) {
            b += 1;
        }
        if b >= e {
            return cnt;
        }
        v[b] += 1;
        if b == e - 1 {
            if odd(v[b]) || b == 0 {
                return -1;
            }
            v[b - 1] += 1;
            e = b;
            b = 0;
            cnt += 2;
        } else {
            v[b + 1] += 1;
            cnt += 2;
        }
    }
}
fn main() {
    let stdin = io::stdin();
    let mut stdin_iterator = stdin.lock().lines();

    let mut fptr = stdout(); //File::create(env::var("OUTPUT_PATH").unwrap()).unwrap();

    let _ = stdin_iterator
        .next()
        .unwrap()
        .unwrap()
        .trim()
        .parse::<i32>()
        .unwrap();

    let b: Vec<i32> = stdin_iterator
        .next()
        .unwrap()
        .unwrap()
        .trim_end()
        .split(' ')
        .map(|s| s.to_string().parse::<i32>().unwrap())
        .collect();

    let result = {
        let r = fair_rations(b);
        if r < 0 {
            "NO".to_string()
        } else {
            r.to_string()
        }
    };

    writeln!(&mut fptr, "{}", result).ok();
}
