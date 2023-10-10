use chisel_decoders::Encoding;
use chisel_json::{parsers::sax::Parser, parsers::sax_events::Match};

/// Macro to tidy up the match arm
macro_rules! selected_event {
    () => {
        Match::StartObject
            | Match::StartArray
            | Match::String(_)
            | Match::Integer(_)
            | Match::Float(_)
            | Match::Boolean(_)
            | Match::Null
    };
}

/// Extract all the unique pointers from a given document, using the SAX parser and an appropriate set
/// of matching [Match] values
fn main() {
    let parser = Parser::with_encoding(Encoding::Utf8);
    let _result = parser.parse_file("fixtures/json/bench/schema.json", &mut |evt| {
        match evt.matched {
            selected_event!() => println!("{}", evt.pointer.unwrap()),
            _ => (),
        }
        Ok(())
    });
}
