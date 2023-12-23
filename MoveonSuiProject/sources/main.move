module MoveonSuiProject::MoveonSuiProject {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;


    resource struct Note {
        id: u64,
        title: vector<u8>,
        content: vector<u8>,
        category: vector<u8>,
        created_at: u64,
        updated_at: u64,
        owner: address,
    }

    public fun createNote(
        owner: &signer,
        title: vector<u8>,
        content: vector<u8>,
        category: vector<u8>
    ) {
        require(Signer::is_valid_signature(owner), 101, 0);

        let note_id = get_new_note_id();
        let created_at = current_timestamp();
        let updated_at = created_at;

        let note = Note{
            id: note_id,
            title: title,
            content: content,
            category: category,
            created_at: created_at,
            updated_at: updated_at,
            owner: Signer::address_of(owner),
        };

        move_to<T>(note, Signer::address_of(owner));
    }

    public fun updateNote(
        owner: &signer,
        note_id: u64,
        title: vector<u8>,
        content: vector<u8>,
        category: vector<u8>
    ) {
        require(Signer::is_valid_signature(owner), 101, 0);

        let mut note: Note;
        move_from<T>(note, Signer::address_of(owner));

        // update note
        note.title = title;
        note.content = content;
        note.category = category;
        note.updated_at = current_timestamp();

        move_to<T>(note, Signer::address_of(owner));
    }

    public fun deleteNote(
        owner: &signer,
        note_id: u64
    ) {
        require(Signer::is_valid_signature(owner), 101, 0);

        let mut note: Note;
        move_from<T>(note, Signer::address_of(owner));

        // delete note
        move_from<T>(note, Signer::address_of(owner));
    }

    public fun listNotes(owner: address): vector<Note> {
        let mut notes: vector<Note> = empty();
        
        // note list
        let notes_vector: vector<Note>;
        move_from<T>(notes_vector, owner);

    
        return notes_vector;
    }

    private fun get_new_note_id(): u64 {
        
        return 1;
    }

    private fun current_timestamp(): u64 {
   
        return 0;
    }
}