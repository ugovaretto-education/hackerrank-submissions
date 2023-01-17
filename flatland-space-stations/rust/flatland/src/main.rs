use std::io::{stdin, Read};
fn flatland(num_cities: i32, space_stations: &[i32]) -> i32 {
    let mut dist = vec![0i32; num_cities as usize];
    for i in 0..num_cities {
        dist[i as usize] = space_stations.iter().map(|x| (x - i).abs()).min().unwrap();
    }
    *dist.iter().max().unwrap()
}
fn main() {
    let stdin = stdin();
    let mut lines = "".to_owned();
    stdin.lock().read_to_string(&mut lines).unwrap();
    let l = lines
        .split_whitespace()
        .map(|s| s.to_string().parse::<i32>().unwrap())
        .collect::<Vec<_>>();
    if let [num_cities, _, arr @ ..] = l.as_slice() {
        println!("{}", flatland(*num_cities, arr));
    }
}
