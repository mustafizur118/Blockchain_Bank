'use strict'

/**
 * Account transfer transaction
 * @param {org.example.blockchainbank.AccountTransfer} accountTransfer
 * @transaction
 */
async function accountTransfer(accountTransfer) {

  if (accountTransfer.from.balance < accountTransfer.amount) {
    throw new Error('Insufficient funds!')
  }

  accountTransfer.from.balance -= accountTransfer.amount
  accountTransfer.to.balance += accountTransfer.amount

  return getAssetRegistry('org.example.blockchainbank.Account')
    .then(function (assetRegistry) {
      return assetRegistry.update(accountTransfer.from)
    })
    .then(function () {
      return getAssetRegistry('org.example.blockchainbank.Account')
    })
    .then(function (assetRegistry) {
      return assetRegistry.update(accountTransfer.to)
    })
}

/**
 * Add funds transaction
 * @param {org.example.blockchainbank.AddFunds} addFunds
 * @transaction
 */
async function addFunds(addFunds) {

  addFunds.account.balance += addFunds.amount

  return getAssetRegistry('org.example.blockchainbank.Account')
    .then(function (assetRegistry) {
      return assetRegistry.update(addFunds.account)
    })
}

/**
 * Withdrawal transaction
 * @param {org.example.blockchainbank.Withdrawal} withdrawal
 * @transaction
 */
async function withdrawal(withdrawal) {

  withdrawal.account.balance -= withdrawal.amount

  return getAssetRegistry('org.example.blockchainbank.Account')
    .then(function (assetRegistry) {
      return assetRegistry.update(withdrawal.account)
    })
}
