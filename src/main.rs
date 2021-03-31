use std::env;

use std::io::{Write, Result};
use std::fs::{File, read_dir};
use x264::{Colorspace, Encoder, Image};

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();

    let mut output_file = File::create(&args[2]).expect("Unable to create file");   

    let width: usize = 320;
    let height: usize = 240;
    let fps: usize = 15;

    let mut encoder =
        Encoder::builder()
            .fps(fps as u32, 1)
            .build(Colorspace::RGB, width as _, height as _)
            .unwrap();

    // Write headers
    let headers = encoder.headers().unwrap();
    output_file.write_all(headers.entirety()).unwrap();

    let mut paths = read_dir(&args[1])?
                .map(|res| res.map(|entry| entry.path()))
                .collect::<Result<Vec<_>>>()?;

    paths.sort();

    for i in 0..paths.len() {
        let path = &paths[i];
        println!("Writing frame {:?}...", &path);

        let frame = image::open(path).expect(&format!("Unable to open a frame"));

        let rgb_image = frame.as_rgb8().unwrap().as_raw().as_slice();

        let image = Image::rgb(width as _, height as _, &rgb_image);
        let (data, _) = encoder.encode((fps * i) as _, image).unwrap();
        output_file.write_all(data.entirety()).unwrap();
    }

    let mut flush = encoder.flush();
    while let Some(result) = flush.next() {
        let (data, _) = result.unwrap();
        output_file.write_all(data.entirety()).unwrap();
    }

    Ok(())
}
