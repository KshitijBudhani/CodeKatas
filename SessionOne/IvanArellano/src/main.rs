/*
    Runnable online at: https://play.rust-lang.org/?gist=9150fb5b5afe01183b38&version=stable
*/
use std::iter;

fn print_row(indent: usize) {
    // print newline then - per # of indent
    println!("");
    if indent > 1 {
        let hypens: String = iter::repeat("-").take(indent - 1).collect();
        print!("{} ", hypens);
    }
}

fn parse(source: &str) {
    let mut indent = 0;
    for character in source.chars() {
        match character {
            '(' => {
                indent += 1;
                print_row(indent);
            },
            ')' => indent -= 1,
            ',' => {
                print_row(indent);
            },
            ' ' => {},
            _ => {
                print!("{}", character);
            }
        }
    }
}

fn main() {
    let source = "(id,created,employee(id,firstname,employeeType(id), lastname),location)";
    let source2 = "(id,created,employee(id,firstname(mid),employeeType(id), lastname),location(lat,lon))";

    parse(source);
    print!("\n-----");
    parse(source2);
}
