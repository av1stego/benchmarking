use std::io::BufWriter;
use std::env;

use std::fs::File;
use mp4::{Mp4Config, Mp4Reader, Mp4Track, Mp4Writer, TrackConfig, Vp9Config, MediaType};
use mp4::{MediaConfig, HevcConfig, AvcConfig, AacConfig, TtxtConfig};
use std::io::{BufReader};

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();

    let input_file = File::open(&args[1]).unwrap();
    let output_file = File::create(&args[2]).expect("Unable to create file");                                                                                                          

    let size = input_file.metadata()?.len();

    let reader = BufReader::new(input_file);
    let writer = BufWriter::new(output_file);

    let mut mp4_reader = Mp4Reader::read_header(reader, size)?;
    let mut mp4_writer = Mp4Writer::write_start(
        writer,
        &Mp4Config {
            major_brand: mp4_reader.major_brand().clone(),
            minor_version: mp4_reader.minor_version(),
            compatible_brands: mp4_reader.compatible_brands().to_vec(),
            timescale: mp4_reader.timescale(),
        },
    )?;

    for track_idx in 0..mp4_reader.tracks().len() {
        let track = mp4_reader.tracks().get(track_idx).unwrap();
        let track_conf = TrackConfig {
            track_type: track.track_type()?,
            timescale: track.timescale(),
            language: track.language().to_string(),
            media_conf: extract_media_conf(track)?,
        };

        mp4_writer.add_track(&track_conf)?;

        let track_id = track_idx as u32 + 1;
        let sample_count = mp4_reader.sample_count(track_id)?;
        for sample_idx in 0..sample_count {
            let sample_id = sample_idx + 1;
            let sample = mp4_reader.read_sample(track_id, sample_id)?.unwrap();
            mp4_writer.write_sample(track_id, &sample)?;
        }
    }

    mp4_writer.write_end()?;

    Ok(())
}

fn extract_media_conf(track: &Mp4Track) -> Result<MediaConfig> {
    let media_type = match track.media_type()? {
        MediaType::H264 => MediaConfig::AvcConfig(AvcConfig {
            width: track.width(),
            height: track.height(),
            seq_param_set: track.sequence_parameter_set()?.to_vec(),
            pic_param_set: track.picture_parameter_set()?.to_vec(),
        }),
        MediaType::H265 => MediaConfig::HevcConfig(HevcConfig {
            width: track.width(),
            height: track.height(),
        }),
        MediaType::VP9 => MediaConfig::Vp9Config(Vp9Config {
            width: track.width(),
            height: track.height(),
        }),
        MediaType::AAC => MediaConfig::AacConfig(AacConfig {
            bitrate: track.bitrate(),
            profile: track.audio_profile()?,
            freq_index: track.sample_freq_index()?,
            chan_conf: track.channel_config()?,
        }),
        MediaType::TTXT => MediaConfig::TtxtConfig(TtxtConfig {}),
    };

    Ok(media_type)
}