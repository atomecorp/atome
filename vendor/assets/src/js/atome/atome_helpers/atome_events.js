function mouse_interaction(element, atome) {
    interact(element).dropzone({
        listeners: {
            dragenter(event) {

                atome.$enter_action_callback(Opal.hash({id: event.relatedTarget.id}));
                // console.log(event)
                // event.relatedTarget.textContent = 'Dropped'
            },
            dragleave(event) {
                atome.$leave_action_callback(Opal.hash({id: event.relatedTarget.id}));
                // event.relatedTarget.textContent = 'Dropped'
            },
            dropactivate: function (event) {
                // add active dropzone feedback
                // event.target.classList.add('drop-active')
            },
            drop(event) {
                // console.log(event)
                atome.$drop_action_callback(Opal.hash({id: event.relatedTarget.id}));
                // event.relatedTarget.textContent = 'Dropped'
            },
            dropdeactivate: function (event) {
                // remove active dropzone feedback
                // event.target.classList.remove('drop-active')
                // event.target.classList.remove('drop-target')
            }
            // dropdeactivate: function (event) {
            //     // remove active dropzone feedback
            //     // event.target.classList.remove('drop-active')
            //     // event.target.classList.remove('drop-target')
            // }
            // start(event) {
            //     console.log("satring")
            //     atome.$drag_action_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);
            // },
            // move(event) {
            //     console.log("0000")
            //     position.x += event.dx
            //     position.y += event.dy
            //     //  we feed the callback method below
            //     atome.$drag_action_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);
            //
            //     if (options === true) {
            //         event.target.style.transform =
            //             event.target.style.transform = 'translate(' + position.x + 'px, ' + position.y + 'px)'
            //     }
            //
            // },
            // end(event) {
            //     console.log("endinfring")
            //
            //     atome.$drag_action_callback(event.pageX, event.pageY, event.rect.left, event.rect.top);
            //
            //
            // },
        }
    })
}


function file_drop(atome_id, atome) {
    const dropzone = document.querySelector('#' + atome_id)
    dropzone.addEventListener('dragover', evt => evt.preventDefault())
    dropzone.addEventListener('drop', async evt => {
        evt.preventDefault()
        const files = await window.getFilesFromDataTransferItems(evt.dataTransfer.items)
        for (const file of files) {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onloadend = function () {
                const base64data = reader.result;
                let type_found = file.type.split('/')[0]
                atome.$drop_action_callback(Opal.hash({
                    path: file.filepath,
                    type: type_found,
                    size: file.size,
                    data: base64data
                }));
            }
        }
    })


    async function getFilesFromDataTransferItems(dataTransferItems, options = {raw: false}) {
        const checkErr = (err) => {
            if (getFilesFromDataTransferItems.didShowInfo) return
            if (err.name !== 'EncodingError') return
            getFilesFromDataTransferItems.didShowInfo = true
            const infoMsg = `${err.name} occured within datatransfer-files-promise module\n`
                + `Error message: "${err.message}"\n`
                + 'Try serving html over http if currently you are running it from the filesystem.'
            console.warn(infoMsg)
        }

        const readFile = (entry, path = '') => {
            return new Promise((resolve, reject) => {
                entry.file(file => {
                    if (!options.raw) file.filepath = path + file.name // save full path

                    resolve(file)
                }, (err) => {
                    checkErr(err)
                    reject(err)
                })
            })
        }

        const dirReadEntries = (dirReader, path) => {
            return new Promise((resolve, reject) => {
                dirReader.readEntries(async entries => {
                    let files = []
                    for (let entry of entries) {
                        const itemFiles = await getFilesFromEntry(entry, path)
                        // console.log(itemFiles)
                        files = files.concat(itemFiles)
                    }
                    resolve(files)
                }, (err) => {
                    checkErr(err)
                    reject(err)
                })
            })
        }

        const readDir = async (entry, path) => {
            const dirReader = entry.createReader()
            const newPath = path + entry.name + '/'
            let files = []
            let newFiles
            do {
                newFiles = await dirReadEntries(dirReader, newPath)
                files = files.concat(newFiles)
            } while (newFiles.length > 0)
            return files
        }

        const getFilesFromEntry = async (entry, path = '') => {
            if (entry.isFile) {
                const file = await readFile(entry, path)
                return [file]
            }
            if (entry.isDirectory) {
                const files = await readDir(entry, path)
                return files
            }
            // throw new Error('Entry not isFile and not isDirectory - unable to get files')
        }

        let files = []
        let entries = []

        // Pull out all entries before reading them
        for (let i = 0, ii = dataTransferItems.length; i < ii; i++) {
            entries.push(dataTransferItems[i].webkitGetAsEntry())
        }

        // Recursively read through all entries
        for (let entry of entries) {
            const newFiles = await getFilesFromEntry(entry)
            files = files.concat(newFiles)
        }

        return files
    }

    if (this.window && this === this.window) this.getFilesFromDataTransferItems = getFilesFromDataTransferItems
    else module.exports.getFilesFromDataTransferItems = getFilesFromDataTransferItems

}

