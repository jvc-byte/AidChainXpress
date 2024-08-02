/// Module: aidchainxpress
module aidchainxpress::aidchainxpress {

    // Struct to represent a donor
    public struct Donor {
        id: u64,
        name: vector<u8>,
        email: vector<u8>,
        donated_amount: u64,
    }

    // Storage for donors
    public struct AidChainData {
        donors: vector<Donor>,
    }

    
}
