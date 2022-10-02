
use std::env;
use std::fs::File;
use std::io::{self, BufRead, Write};

/*
 * Complete the 'howManyGames' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts following parameters:
 *  1. INTEGER p
 *  2. INTEGER d
 *  3. INTEGER m
 *  4. INTEGER s
 */

fn howManyGames(mut p: i32, d: i32, m: i32, mut s: i32) -> i32 {
    // Return the number of games you can buy
    let mut g = 0;
    while (s >= p) {
        s -= p;
        g += 1;
        p -= d;
        p = i32::max(m, p);
    }
    g
}

fn main() {
    let stdin = io::stdin();
    let mut stdin_iterator = stdin.lock().lines();

    let mut fptr = File::create(env::var("OUTPUT_PATH").unwrap()).unwrap();

    let first_multiple_input: Vec<String> = stdin_iterator.next().unwrap().unwrap()
        .split(' ')
        .map(|s| s.to_string())
        .collect();

    let p = first_multiple_input[0].trim().parse::<i32>().unwrap();

    let d = first_multiple_input[1].trim().parse::<i32>().unwrap();

    let m = first_multiple_input[2].trim().parse::<i32>().unwrap();

    let s = first_multiple_input[3].trim().parse::<i32>().unwrap();

    let answer = howManyGames(p, d, m, s);

    writeln!(&mut fptr, "{}", answer).ok();
}
