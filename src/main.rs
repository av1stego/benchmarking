use std::env;

use std::io::Error;
use std::io::Write;
use std::fs::File;

use std::io::Read;
use h264_reader::annexb::AnnexBReader;
use h264_reader::annexb::NalReader;
use h264_reader::Context;
use h264_reader::rbsp::RbspDecoder;
use h264_reader::nal::NalHandler;
use h264_reader::nal::NalHeader;

struct NullNalHandler {
}
impl NalHandler for NullNalHandler {
    type Ctx = ();

    fn start(&mut self, _ctx: &mut Context<Self::Ctx>, _header: NalHeader) {
        unimplemented!()
    }

    fn push(&mut self, _ctx: &mut Context<Self::Ctx>, _buf: &[u8]) {
        unimplemented!()
    }

    fn end(&mut self, _ctx: &mut Context<Self::Ctx>) {
        unimplemented!()
    }
}

struct NullNalReader {
    decoder: RbspDecoder<NullNalHandler>,
    start: u64,
    push: u64,
    end: u64,
}
impl NalReader for NullNalReader {
    type Ctx = ();

    fn start(&mut self, _ctx: &mut Context<Self::Ctx>) {
        self.start += 1;
    }
    fn push(&mut self, _ctx: &mut Context<Self::Ctx>, _buf: &[u8]) {
        self.push += 1;
    }
    fn end(&mut self, _ctx: &mut Context<Self::Ctx>) {
        self.end += 1;
    }
}

fn main() -> Result<(), Error> {
    let args: Vec<String> = env::args().collect();

    let mut input_file = File::open(&args[1]).unwrap();
    let mut output_file = File::create(&args[2]).expect("Unable to create file");   

    let size = input_file.metadata()?.len() as usize;

    let mut buf = vec![0; size];
    input_file.read(&mut buf[..]).unwrap();
    let mut ctx = Context::default();
    let nal_handler = NullNalHandler {};
    let nal_reader = NullNalReader {
        decoder: RbspDecoder::new(nal_handler),
        start: 0,
        push: 0,
        end: 0,
    };
    let mut annexb_reader = AnnexBReader::new(nal_reader);

    annexb_reader.start(&mut ctx);
    annexb_reader.push(&mut ctx, &buf[..]);
    annexb_reader.end_units(&mut ctx);

    output_file.write_all(&*buf)
}