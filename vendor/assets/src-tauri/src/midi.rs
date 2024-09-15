use midir::{MidiInput, Ignore};
use tauri::Emitter;  // Importer le trait Emitter nécessaire pour utiliser `emit`

pub fn start_midi_listener(app_handle: tauri::AppHandle) {
    let mut input = MidiInput::new("MIDI Input").expect("Failed to create MIDI input");
    input.ignore(Ignore::None);

    let in_ports = input.ports();
    if in_ports.is_empty() {
        println!("No available MIDI input ports.");
        return;
    }

    let in_port = &in_ports[0];
    let in_port_name = input.port_name(in_port).unwrap();

    println!("Opening connection to {}", in_port_name);
    let _conn_in = input.connect(in_port, "midir-read-input", move |_stamp, message, _| {
        println!("Received message: {:?}", message);
        app_handle.emit("midi-event", format!("{:?}", message)).unwrap();  // Utiliser `emit` avec `Emitter`
    }, ()).expect("Failed to connect to input port");

    // Keep the connection open
    std::thread::park();
}