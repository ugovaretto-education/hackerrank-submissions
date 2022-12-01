use std::io::{stdin, Read};
fn main() {
    let stdin = stdin();
    let mut lines = "".to_owned();
    stdin.lock().read_to_string(&mut lines).unwrap();
    let l = lines
        .split_whitespace()
        .map(|s| s.to_string().parse::<i32>().unwrap())
        .collect::<Vec<_>>();
    if let [_, k, arr @ ..] = l.as_slice() {
        println!("{}", workbook(*k, arr));
    }
}

fn workbook(k: i32, arr: &[i32]) -> i32 {
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
