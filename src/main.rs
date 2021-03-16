use std::env;

use std::fs::File;
use mp4::{Result, Mp4Config, Mp4Reader, Mp4Writer, TrackConfig, Vp9Config};
use mp4::TrackType;
use mp4::MediaConfig;
use std::io::{BufReader, Cursor, Write};

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();

    let f = File::open(&args[1]).unwrap();
    let size = f.metadata()?.len();

    let reader = BufReader::new(f);

    let mp4 = Mp4Reader::read_header(reader, size)?;

    let config = Mp4Config {
        major_brand: str::parse("isom").unwrap(),
        minor_version: 512,
        compatible_brands: vec![
            str::parse("isom").unwrap(),
            str::parse("iso2").unwrap(),
            str::parse("avc1").unwrap(),
            str::parse("mp41").unwrap(),
        ],
        timescale: 1000,
    };

    let input_data = Cursor::new(Vec::<u8>::new());
    let mut writer = Mp4Writer::write_start(input_data, &config)?;

    

    for track in mp4.tracks() {
        let track_config = TrackConfig {
            track_type: TrackType::Video,
            timescale: 1000,
            language: String::from("und"),
            media_conf: MediaConfig::Vp9Config(Vp9Config {
                width: track.width(), 
                height: track.height()
            }),
        };

        writer.add_track(&track_config)?;
    }

    let output_data: Vec<u8> = writer.into_writer().into_inner();
    println!("{:?}", output_data);

    let mut output_file = File::create(&args[2]).expect("Unable to create file");                                                                                                          
    output_file.write_all(output_data.as_slice()).expect("Unable to write data");                                                                                                                            

    Ok(())
}

