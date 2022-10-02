
use std::io::{self, BufRead};

/*
 * Complete the 'kaprekarNumbers' function below.
 *
 * The function accepts following parameters:
 *  1. INTEGER p
 *  2. INTEGER q
 */

fn isKaprekar(n: i64) -> Result<bool, std::num::ParseIntError> {
    if n == 1 {
        return Ok(true);
    }
    let d = n.to_string().len();
    let sq = (n * n).to_string();
    let r = sq.len() - d;
    let (b,e) = sq.split_at(r);
    if b.is_empty() {
        return Ok(false);
    }
    let l = b.parse::<i64>()?;
    let r = if e.is_empty() { 
                0_i64
            } else {
                e.parse::<i64>()?
            };
    if r == 0 {
        return Ok(false);
    }
    //println!("{n}/{sq}: {l} {r}");
    Ok(l + r == n)
}

fn kaprekarNumbers(p: i64, q: i64) {
    let mut found = false;
    for i in p..=q  {
        if isKaprekar(i).unwrap() {
           print!("{} ", i);
           found = true;
        }
    }
    if !found {
        print!("INVALID RANGE");
    }
    //println!("");
}
fn main() {
    let stdin = io::stdin();
    let mut stdin_iterator = stdin.lock().lines();

    let p = stdin_iterator.next().unwrap().unwrap().trim().parse::<i64>().unwrap();

    let q = stdin_iterator.next().unwrap().unwrap().trim().parse::<i64>().unwrap();

    kaprekarNumbers(p, q);
}
