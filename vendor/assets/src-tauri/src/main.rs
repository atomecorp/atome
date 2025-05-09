use std::process::Command;
use std::str;
use std::fs;
use std::io::Write;
#[cfg(debug_assertions)]
use tauri::Manager; // Import Manager only in dev mode
// use tauri::Emitter; // Import mandatory to use window.emit

mod midi;

#[tauri::command]
fn execute_command(command: &str) -> Result<String, String> {
    match Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
    {
        Ok(output) => {
            if output.status.success() {
                Ok(str::from_utf8(&output.stdout).unwrap().to_string())
            } else {
                Err(str::from_utf8(&output.stderr).unwrap().to_string())
            }
        }
        Err(error) => Err(error.to_string()),
    }
}



#[tauri::command]
fn read_file(file_path: &str) -> Result<String, String> {
    let content = match fs::read_to_string(file_path) {
        Ok(content) => {
            content
        }
        Err(_) => {
            return Err("Failed to read file.".to_string());
        }
    };
    Ok(content)
}



#[tauri::command]
fn write_file(file_path: String, content: String) -> Result<String, String> {
    match fs::File::create(&file_path) {
        Ok(mut file) => {
            if file.write_all(content.as_bytes()).is_ok() {
                Ok("file recorded".to_string())
            } else {
                Err("error: file not recorded".to_string())
            }
        }
        Err(_) => Err("error: file not recorded".to_string()),
    }
}
#[tauri::command]
fn list_directory_content(directory_path: String) -> Result<Vec<String>, String> {
    let path = std::path::Path::new(&directory_path);
    match fs::read_dir(path) {
        Ok(entries) => {
            let entries: Vec<String> = entries
                .filter_map(|entry| {
                    entry.ok().and_then(|e| {
                        e.path().file_name().and_then(std::ffi::OsStr::to_str).map(|s| s.to_owned())
                    })
                })
                .collect();
            Ok(entries)
        }
        Err(_) => Err("Failed to read directory.".to_string()),
    }
}

#[tauri::command]
fn start_midi(app_handle: tauri::AppHandle) {
    std::thread::spawn(move || {
        midi::start_midi_listener(app_handle);
    });
}

fn main() {
    tauri::Builder::default()
        .setup(|_app| {
            #[cfg(debug_assertions)] // Only run this block in dev mode
            {
                if let Some(window) = _app.get_webview_window("main") {
                    window.open_devtools();
                }
            }
            Ok(())
        })
        .invoke_handler(tauri::generate_handler![
            execute_command,
            read_file,
            write_file,
            list_directory_content,
            start_midi
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}