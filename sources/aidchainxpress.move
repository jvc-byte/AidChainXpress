module AidChainXpress::AidChainXpress {

    // Struct to represent a donor
    public struct Donor has copy, drop, store {
        id: u64,
        name: vector<u8>,
        email: vector<u8>,
        donated_amount: u64,
    }
    Donor public donors;

    // Struct to represent a recipient
    public struct Recipient has copy, drop, store {
        id: u64,
        name: vector<u8>,
        email: vector<u64>,
        verified: bool,
    }
    Recipient public recipients;

    // Storage for donors and recipients
    public struct AidChainData has key, store {
        id: UID,
        donors: vector<Donor>,
        recipients: vector<Recipient>,
    }

    // Initialize the module with empty data
    public entry fun initialize(account: &signer) {
        let id = object::new<UID>(account);
        let donors = vector::empty<Donor>();
        let recipients = vector::empty<Recipient>();
        let aid_chain_data = AidChainData { id, donors, recipients };
        sui::object::share_object(account, aid_chain_data);
    }

    // Register a donor
    public entry fun register_donor(account: &signer, id: u64, name: vector<u8>, email: vector<u8>) {
        let aid_data: Donor = borrow_global_mut<AidChainData>(sui::address_of(account));
        let donor = Donor { id, name, email, donated_amount: 0 };
        vector::push_back(&mut aid_data.donors, donor);
    }

    // Register a recipient
    public entry fun register_recipient(account: &signer, id: u64, name: vector<u8>, verified: bool) {
        let aid_data = borrow_global_mut<AidChainData>(sui::address_of(account));
        let recipient = Recipient { id, name, verified };
        vector::push_back(&mut aid_data.recipients, recipient);
    }
}