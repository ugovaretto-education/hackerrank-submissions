use std::env;
use std::fs::File;
use std::io::{self, BufRead, Write};

fn main() {
    let stdin = io::stdin();
    let mut stdin_iterator = stdin.lock().lines();
    let mut fptr = File::create(env::var("OUTPUT_PATH").unwrap()).unwrap();

    let first_multiple_input: Vec<String> = stdin_iterator
        .next()
        .unwrap()
        .unwrap()
        .split(' ')
        .map(|s| s.to_string())
        .collect();

    let n = first_multiple_input[0].trim().parse::<i32>().unwrap();
    let k = first_multiple_input[1].trim().parse::<i32>().unwrap();

    let arr: Vec<i32> = stdin_iterator
        .next()
        .unwrap()
        .unwrap()
        .trim_end()
        .split(' ')
        .map(|s| s.to_string().parse::<i32>().unwrap())
        .collect();
    let result = workbook(n, k, &arr);
    writeln!(&mut fptr, "{}", result).ok();
}

fn workbook(_n: i32, k: i32, arr: &[i32]) -> i32 {
    if k < 1 {
        return 0;
    }
    let mut e = 0_i32;
    let mut page = 1_i32;
    for i in arr {
        let num_pages = i / k;
        for p in 1..=num_pages {
            if page >= (p - 1) * k + 1 && page <= p * k {
                e += 1;
            }
            page += 1;
        }
        if i % k > 0 {
            if page >= num_pages * k + 1 && page <= num_pages * k + i % k {
                e += 1;
            }
            page += 1;
        }
    }
    e
}
