use std::process::Command;
use std::str;
use std::fs;

// Learn more about Tauri commands at https://tauri.app/v1/guides/features/command
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

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
        Ok(content) => content,
        Err(_) => return Err("Failed to read file.".to_string()),
    };
    Ok(content)
}

#[tauri::command]
fn write_file(file_path: &str, content: &str) -> Result<(), String> {
    let path = std::path::Path::new(file_path);
    match fs::write(path, content) {
        Ok(_) => Ok(()),
        Err(_) => Err("Failed to write to the file.".to_string()),
    }
}

// Nouvelle commande pour lister le contenu du répertoire
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

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![greet, execute_command, read_file, write_file, list_directory_content])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
