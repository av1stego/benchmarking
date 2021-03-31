use std::env;

use std::io::Error;
use std::io::Write;
use std::fs::File;

use std::io::Read;
use h264_reader::annexb::AnnexBReader;
use h264_reader::annexb::NalReader;
use h264_reader::Context;

struct EnhanceNalReader {
    output_file: File,
    enhanchment_buf: Vec<u8>,
    start: u64,
    push: u64,
    end: u64,
}

impl EnhanceNalReader {
    fn write_nal_break(&mut self) {
        self.output_file.write(&[0x00, 0x00, 0x01]).unwrap();
    }
}

impl NalReader for EnhanceNalReader {
    type Ctx = ();

    fn start(&mut self, _ctx: &mut Context<Self::Ctx>) {
        self.start += 1;
    }

    fn push(&mut self, _ctx: &mut Context<Self::Ctx>, buf: &[u8]) {
        self.write_nal_break();
        self.output_file.write_all(&*buf).unwrap(); 

        self.write_nal_break();
        self.output_file.write_all(&*self.enhanchment_buf).unwrap(); 

        self.push += 1;
    }

    fn end(&mut self, _ctx: &mut Context<Self::Ctx>) {
        self.end += 1;
    }
}

fn main() -> Result<(), Error> {
    let args: Vec<String> = env::args().collect();

    let mut input_file = File::open(&args[1]).unwrap();
    let output_file = File::create(&args[2]).expect("Unable to create file");   

    let size = input_file.metadata()?.len() as usize;

    let hidden_message = "test";
    let sei_prefix: [u8; 3] = [6, 5, hidden_message.len() as u8];
    let enhanchment_buf = [&sei_prefix, hidden_message.as_bytes()].concat();

    let mut buf = vec![0; size];
    input_file.read(&mut buf[..]).unwrap();
    let mut ctx = Context::default();
    let nal_reader = EnhanceNalReader {
        output_file: output_file,
        enhanchment_buf: enhanchment_buf,
        start: 0,
        push: 0,
        end: 0,
    };
    let mut annexb_reader = AnnexBReader::new(nal_reader);

    annexb_reader.start(&mut ctx);
    annexb_reader.push(&mut ctx, &buf[..]);
    annexb_reader.end_units(&mut ctx);

    Ok(())
}