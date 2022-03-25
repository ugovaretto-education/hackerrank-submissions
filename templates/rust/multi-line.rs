use std::io;
use std::io::BufRead;
use tailcall::tailcall;
//fn chocfeast(n: u32, c: u32, m: u32) -> u32 {
//    fn rem(n: u32, m: u32, r: u32) -> u32 {
//        if m > (n+r) {return 0;}
//        (n+r)/m + rem((n + r)/m, m, ( n + r) % m)
//    }
//    n / c + rem(n / c, m, 0)
//}
// Add dependency tailcall = "0.1"
fn chocfeast_tail(n: u32, c: u32, m: u32) -> u32 {
    #[tailcall]
    fn rem_tail(acc: u32, n: u32, m: u32, r: u32) -> u32 {
        if m > (n+r) {return acc;}
        rem_tail(acc + (n+r)/m, (n + r)/m, m, ( n + r) % m)
    }
    rem_tail(n / c, n / c, m, 0)
}
fn main() {
    let stdin = io::stdin();
    let lines = stdin.lock().lines().skip(1);
    let v = lines.flat_map(|l| 
                            l.map(|x| x.trim()
                                        .split_whitespace()
                                        .into_iter()
                                        .flat_map(|x| x.parse::<u32>())
                                        .collect::<Vec<_>>()))
                 .collect::<Vec::<_>>();
    v.into_iter().for_each(|v| println!("{}", chocfeast_tail(v[0], v[1], v[2])));
}




