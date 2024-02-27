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

Source: https://github.com/Cyfrin/security-and-auditing-full-course-s23?tab=readme-ov-file
Challenge S5: https://sepolia.etherscan.io/address/0xdeb8d8efef7049e280af1d5fe3a380f3be93b648

// Run script for testing
forge script ./script/S5Script.sol

// Deploying S5_Challenge contract on Sepolia passing constructor param address of target Contract (S5)
WARNING: ADDRESS S5 is changing!!!
Here S5 address at the time of execution was: 0xdeB8d8eFeF7049E280Af1d5FE3a380F3BE93B648

- forge create --rpc-url $SEPOLIA_RPC_URL --constructor-args 0xdeB8d8eFeF7049E280Af1d5FE3a380F3BE93B648 --private-key $PRIVATE_KEY src/S5_Challenge/S5_Challenge.sol:S5_Challenge
deployed at: 0x4Bebc146d40742F0a9FEc056761C1AF63fE82145

// call function 
cast send 0xd1e84D941a4E947D4581AF757E105B93bEdFb31B --rpc-url $SEPOLIA_RPC_URL "solve()" --private-key $PRIVATE_KEY

https://sepolia.etherscan.io/token/0x31801c3e09708549c1b2c9e1cfbf001399a1b9fa?a=354



// ----------------------------- Challenge S6 -----------------------------

// Source: https://github.com/Cyfrin/security-and-auditing-full-course-s23?tab=readme-ov-file
// Challenge S6: https://sepolia.etherscan.io/address/0xcf4fba490197452bd414e16d563623253efb57d3#code
// contract S6 address in Sepolia: 0xcf4fbA490197452Bd414E16D563623253eFb57D3


Run command to test solution locally (test file /test/S6_ChallengeTest.t.sol): 
- forge test --match-test testFlashLoan -vvvv


// Deploying S6_Challenge contract on Sepolia passing constructor param address of target Contract (S6)
S6 address: 0xcf4fbA490197452Bd414E16D563623253eFb57D3

- forge create --rpc-url $SEPOLIA_RPC_URL --constructor-args 0xcf4fbA490197452Bd414E16D563623253eFb57D3 --private-key $PRIVATE_KEY src/S6_Challenge/S6_Challenge.sol:S6_Challenge
Deployer: 0x05E3Bd725678352E24d79D2266e12129EdB69474
Deployed to: 0xE50863854274FEDc678Be3A7dF4128Fb7c4F2bdF
Transaction hash: 0xa3eaf11ac19954a2c6641a929649e87678372a91f20c3de24656eca6136e0bf2

// call function 
cast send 0xE50863854274FEDc678Be3A7dF4128Fb7c4F2bdF --rpc-url $SEPOLIA_RPC_URL "flashLoan()" --private-key $PRIVATE_KEY

transactionHash: 0x9d842a3669104992b61be3c19c583f5acff8a745d0376cc195697b33bdbe419b