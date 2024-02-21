# About

> About the project in my own words
`sekectWinner` picks the winner, there is a raffle duration

# High 
- Found a DoS
  
  
# Informationl

`PuppyRaffle::entranceFee` is immitable and should be like `i_entranceFee` or `ENTRANCE_FEE`

Slither / Aderyn
Code Quality/Tests

- Competitive Audits
  - Submit a finding
- Write a puppy raffle audit report (including PoCs)

// Deploying S4_Challenge contract on Sepolia passing constructor param address of target Contract (S4)
- forge create --rpc-url $SEPOLIA_RPC_URL --constructor-args 0xf988Ebf9D801F4D3595592490D7fF029E438deCa --private-key $PRIVATE_KEY src/S4_Challenge.sol:S4_Challenge
deployed at: 0x1030CC401d97604802Ad402C9003873Ec484EB2A


// call function 
cast call $DEPLOYED_S4CHALLENGE --rpc-url $SEPOLIA_RPC_URL "descriptionAttack()"

example with function parameter ('address' and '0x6072...0320C1') and return (bytes):
cast call 0x60727B5776cA4C40d9f79c54F6b7D024760320C1 --rpc-url $SEPOLIA_RPC_URL "wtf(address) (bytes)" 0x60727B5776cA4C40d9f79c54F6b7D024760320C1


// This decodes answer to string
cast call 0x6178db8722B11f962dE69d999303D5679CE2363C --rpc-url $SEPOLIA_RPC_URL "description() (string)"


cast call 0xA674606AEEdfC0138727Cb4fD613aF1b7269Cb8E --rpc-url $SEPOLIA_RPC_URL "mySolution()"

cast call 0xA674606AEEdfC0138727Cb4fD613aF1b7269Cb8E --rpc-url $SEPOLIA_RPC_URL "transferNFT(address,address,uint256)" 0xA674606AEEdfC0138727Cb4fD613aF1b7269Cb8E 0x05E3Bd725678352E24d79D2266e12129EdB69474 291



// ----------------------------- Challenge S5 -----------------------------

// Deploying S5_Challenge contract on Sepolia passing constructor param address of target Contract (S5)
WARNING: ADDRESS S5 is changing!!!
Here S5 address at the time of execution was: 0xdeB8d8eFeF7049E280Af1d5FE3a380F3BE93B648

- forge create --rpc-url $SEPOLIA_RPC_URL --constructor-args 0xdeB8d8eFeF7049E280Af1d5FE3a380F3BE93B648 --private-key $PRIVATE_KEY src/S5_Challenge.sol:S5_Challenge
deployed at: 0x4Bebc146d40742F0a9FEc056761C1AF63fE82145

// call function 
cast send 0xd1e84D941a4E947D4581AF757E105B93bEdFb31B --rpc-url $SEPOLIA_RPC_URL "solve()" --private-key $PRIVATE_KEY

https://sepolia.etherscan.io/token/0x31801c3e09708549c1b2c9e1cfbf001399a1b9fa?a=354

