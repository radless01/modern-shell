use std::env;
use std::fs;
use std::path::Path;

fn copy_dir_all(src: impl AsRef<Path>, dst: impl AsRef<Path>) -> std::io::Result<()> {
    fs::create_dir_all(&dst)?;
    for entry in fs::read_dir(src)? {
        let entry = entry?;
        let ty = entry.file_type()?;
        if ty.is_dir() {
            copy_dir_all(entry.path(), dst.as_ref().join(entry.file_name()))?;
        } else {
            fs::copy(entry.path(), dst.as_ref().join(entry.file_name()))?;
        }
    }
    Ok(())
}

fn main() {
    println!("cargo:rerun-if-changed=src/assets");

    // Projenin ana dizinini al (Cargo.toml'un olduğu yer)
    let manifest_dir: String = env::var("CARGO_MANIFEST_DIR").unwrap();
    let profile: String = env::var("PROFILE").unwrap(); // debug veya release

    // Hedef dizin doğrudan: proje_kökü/target/debug (veya release)
    let target_dir: std::path::PathBuf = Path::new(&manifest_dir).join("target").join(profile);
    let dest_path: std::path::PathBuf = target_dir.join("assets");

    let src_path: std::path::PathBuf = Path::new(&manifest_dir).join("src/assets");

    if src_path.exists() {
        // Kopyalama işlemini yap ve hata alırsan doğrudan terminale yazdır
        copy_dir_all(&src_path, &dest_path).expect("Assets klasörü kopyalanamadı!");
        println!("cargo:warning=Assets basariyla kopyalandi: {:?}", dest_path);
    } else {
        println!("cargo:warning=src/assets bulunamadi!");
    }
}